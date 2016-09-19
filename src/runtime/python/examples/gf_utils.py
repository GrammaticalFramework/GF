#!/usr/bin/env python

# Python 2 and 3 compatible
from __future__ import print_function

"""
"""

import argparse, codecs, re, string, sys, time;
try:
  from itertools import imap as map;
  from itertools import count;
except ImportError:
  from itertools import count;
  pass;
from operator import itemgetter;

import pgf;

class Lexer(object):
  def __init__(self, lang='None', grammar=None, gflang=None):
    import translation_pipeline;
    lexers = {'None': self.lexerI, \
        'Eng': self.lexerI, \
        'Chi': self.lexerChi, \
        'Translator': translation_pipeline.pipeline_lexer, \
        'Web': self.lexerWeb
        };
    if grammar:
      self._pgf  = grammar;
      self._lang = gflang;

    self.tokenize = lexers[lang];
    return;

  def lexerI(self, sentence):
    #return sentence.decode('utf-8').rstrip(string.whitespace+string.punctuation).encode('utf-8');
    return sentence.rstrip(string.whitespace+string.punctuation);
  
  def lexerChi(self, sentence):
    #sentence = sentence.decode('utf-8');
    tokens, idx, n = [], 0, len(sentence);
    prev = True;
    while idx < n:
      if sentence[idx] in string.whitespace:
        prev = True;
        idx += 1;
        continue;
      if 0 < ord(sentence[idx]) < 128:
        if sentence[idx] in string.punctuation:
          prev = True;
        if prev:
          tokens.append( sentence[idx] );
          prev = False;
        else:
          tokens[-1] = tokens[-1]+sentence[idx];
      else:
        prev = True;
        tokens.append( sentence[idx] );
      idx += 1;
    return ' '.join(tokens);#.encode('utf-8');

  def lexerWeb(self, sentence):
    tokensList = re.split('\s+?', sentence.strip());
    for idx, token in enumerate(tokensList):
      if not token[0].isupper():
        continue;
      lowertoken = tokensList[idx].lower();
      count = 0;
      for analysis in self._pgf.languages[self._lang].lookupMorpho(lowertoken):
        count += 1;
      tokensList[idx] = lowertoken if count else token;
    for idx, token in enumerate(tokensList):
      if token.find('-') == -1:
        continue;
      count = 0;
      for analysis in self._pgf.languages[self._lang].lookupMorpho(token):
        count += 1;
      if count: 
        continue;
      token = tokensList[idx].replace('-', '');
      for analysis in self._pgf.languages[self._lang].lookupMorpho(token):
        count += 1;
      if count:
        tokensList[idx] = token;
        continue;
      token = tokensList[idx].replace('-', ' ');
    return ' '.join(tokensList);

def postprocessor(sentence):
  if sentence == None:
    return '';
  if sentence.startswith('* ') or sentence.startswith('% '):
    sentence = sentence[2:];
  sentence = sentence.replace(' &+ ', '');
  sentence = sentence.replace('<+>', ' ');
  return sentence;

def readJohnsonRerankerTrees(inputStream):
  endOfParse = False;
  while True:
    sentheader = inputStream.next();
    if sentheader == '':
      break;
    parsescount, sentidx = map(int, sentheader.strip().split());
    parsesBlock = [];
    for i in xrange(parsescount):
      parseprob = inputStream.next();
      if parseprob.strip() == '':
        endOfParse = True;
        break;
      parse = inputStream.next();
      parsesBlock.append((float(parseprob.strip()), pgf.readExpr(parse.strip())));
    yield sentidx, parsesBlock;
    if not endOfParse:
      _ = inputStream.next();
      endOfParse = False;

def readMosesNbestFormat(inputStream):
  transBlock = [];
  currentHypothesisId = 0;
  while True:
    line = inputStream.next();
    if line == '':
      break;
    fields = line.strip().split('|||');
    if str(fields[0].strip()) != str(currentHypothesisId):
      yield currentHypothesisId, transBlock;
      transBlock = [];
    currentHypothesisId = int(fields[0]);
    transBlock.append( (map(float, \
        tuple([val.strip() for val in fields[3].split()])), \
        fields[1].strip()) );

def printJohnsonRerankerFormat(gfparsesList, sentids=count(1)):
  johnsonRepr = [];
  parseHash = {};
  for parse in sorted(gfparsesList, key=itemgetter(0)):
    if parse[1] not in parseHash:
      johnsonRepr.append( str(-1*parse[0]) );
      johnsonRepr.append( str(parse[1]) );
    parseHash.setdefault(parse[1], []).append(parse[0]);
  curid = next(sentids);
  if len(gfparsesList):
    johnsonRepr.insert(0, '%d %d' %(len(parseHash.values()), curid));
  duplicateInstances = len(list(filter(lambda X: len(parseHash[X]) > 1, \
      parseHash.keys())));
  return '\n'.join(johnsonRepr)+'\n';

def printMosesNbestFormat(hypothesisList, sentids=count(1)):
  mosesRepr = [];
  sid = next(sentids);
  for hypScores, hypStr in hypothesisList:
    if not hasattr(hypScores, '__iter__'):
      hypScores = (hypScores, );
    mosesRepr.append("%d ||| %s ||| NULL ||| %s" \
        %(sid, hypStr, ' '.join('%.6f'%score for score in hypScores)) );
  return '\n'.join(mosesRepr);

def getKLinearizations(grammar, tgtlanguage, abstractParsesList, K=10):
  generator = grammar.languages[tgtlanguage].linearizeAll;
  for parsesBlock in abstractParsesList:
    kBestTrans = [];
    for parseprob, parse in parsesBlock:
      for linstring in generator(parse, n=K):
        kBestTrans.append( ((parseprob,), postprocessor(linstring)) );
    yield kBestTrans;

def getKBestParses(grammar, language, K, callbacks=[], \
    serializable=False, sentids=count(1), max_length=50):
  parser = grammar.languages[language].parse;
  import translation_pipeline;
  callbacks_PN = translation_pipeline.parseNames;
  callbacks_Symb = translation_pipeline.parseUnknown;
  def worker(sentence):
    sentence = sentence.strip();
    curid = next(sentids);
    tstart = time.time();
    kBestParses = [];
    parseScores = {};
    if len(sentence.split()) > max_length:
      # temporary hack to make sure parser does not get
      # killed for very long sentences;
      tend, err = time.time(), \
          "Sentence too long (%d tokens). Might potentially run out of memory" \
          %(len(sentence.split()));
      print('%d\t%.4f\t%s' %(curid, tend-tstart, err), file=sys.stderr);
      return tend-tstart, kBestParses;
    
    # with modified API for callbacks, each callback function has to
    # be freshly created for each sentence; otherwise, they do not 
    # work. 
    try:
      callbacks = [('PN', callbacks_PN(grammar, language, sentence)),\
          ('Symb', callbacks_Symb(grammar, language, sentence))];
      for parseidx, parse in enumerate(parser(sentence, \
          heuristics=0, callbacks=callbacks)):
        parseScores[parse[0]] = True;
        kBestParses.append((parse[0], str(parse[1]) if serializable \
            else parse[1]));
        if parseidx == K-1:
          break;
      tend = time.time();
      print('%d\t%.4f' %(curid, tend-tstart), file=sys.stderr);
      return tend-tstart, kBestParses;
    except pgf.ParseError as err:
      tend = time.time();
      print('%d\t%.4f\t%s' %(curid, tend-tstart, err), file=sys.stderr);
      return tend-tstart, kBestParses;
    except UnicodeEncodeError as err:
      tend = time.time();
      print('%d\t%.4f\t%s' %(curid, tend-tstart, err), file=sys.stderr);
      return tend-tstart, kBestParses;
  return worker;

def pgf_parse(args):
  grammar  = pgf.readPGF(args.pgfgrammar);
  preprocessor = Lexer().tokenize;
  #if sys.version_info < (3, 0):
  #  args.inputstream = codecs.getreader('utf-8')(args.inputstream);
  inputSet = map(preprocessor, args.inputstream);
  web_preprocessor = Lexer('Web', grammar, args.srclang).tokenize;
  inputSet = map(web_preprocessor, inputSet);
  outputPrinter = lambda X: "%f\t%s" %(X[0], str(X[1]));
  parser = getKBestParses(grammar, args.srclang, 1);
  
  sentidx = 0;
  for time, parsesBlock in map(parser, inputSet):
    sentidx += 1;
    print("%d\t%f\t%s" %(sentidx, time, \
        str(outputPrinter(parsesBlock[0])) if len(parsesBlock) else ''), \
        file=args.outputstream);
  return;

def pgf_kparse(args):
  grammar = pgf.readPGF(args.pgfgrammar);
  preprocessor = Lexer().tokenize;
  #if sys.version_info < (3, 0):
  #  args.inputstream = codecs.getreader('utf-8')(args.inputstream);
  inputSet = map(preprocessor, args.inputstream);
  web_preprocessor = Lexer('Web', grammar, args.srclang).tokenize;
  inputSet = map(web_preprocessor, inputSet);
  outputPrinter = printJohnsonRerankerFormat;
  parser = getKBestParses(grammar, args.srclang, args.K);
  
  sentidx = 0;
  for time, parsesBlock in map(parser, inputSet):
    sentidx += 1;
    strParses = str(outputPrinter(parsesBlock));
    if not (strParses == '\n'):
      print(strParses, file=args.outputstream);
  return;

def pgf_linearize(args):
  grammar = pgf.readPGF(args.pgfgrammar);
  def parse_line(line):
    try:
      sentid, parsetime, parserepr = line.strip('\n').split('\t', 2);
    except ValueError:
      print("Line not in proper format: %s" %(line), file=stderr);
    parseprob, abstree = parserepr.split('\t') if parserepr.strip() \
        else (0, '');
    return ((int(sentid), float(parsetime), float(parseprob), \
        pgf.readExpr(abstree) if abstree else None));

  #if sys.version_info < (3, 0):
  #  args.inputstream = codecs.getreader('utf-8')(args.inputstream);
  inputSet = map(parse_line, (line for line in args.inputstream));
  outputPrinter = postprocessor;
  linearizer = grammar.languages[args.tgtlang].linearize;
  for sentid, _, _, abstree in inputSet:
    if abstree:
      print(str(outputPrinter(linearizer(abstree))), \
          file=args.outputstream);
    else:
      print("", file=args.outputstream);
  return;

def pgf_klinearize(args):
  grammar = pgf.readPGF(args.pgfgrammar);
  #if sys.version_info < (3, 0):
  #  args.inputstream = codecs.getreader('utf-8')(args.inputstream);
  inputSet = [(sentid, parsesBlock) \
      for sentid, parsesBlock in readJohnsonRerankerTrees(args.inputstream)];
  outputPrinter = printMosesNbestFormat;
  sentIdsList  = map(itemgetter(0), inputSet);
  parsesBlocks = map(itemgetter(1), inputSet);
  
  for transBlock in getKLinearizations(grammar, args.tgtlang, parsesBlocks, args.K):
    strTrans = str(outputPrinter(transBlock, sentIdsList));
    if strTrans:
      print(strTrans, file=args.outputstream);
  return;

def cmdLineParser():
  argparser = argparse.ArgumentParser(prog='gf_utils.py',  \
      description='Examples for carrying out (K-best) parsing, \
      translation and linearization using GF C runtime.');
  
  subparsers  = argparser.add_subparsers();
  parser      = subparsers.add_parser('parse',      help='GF parsing of sentences');
  kparser     = subparsers.add_parser('kparse',     help='K-best GF parsing of sentences');
  linearizer  = subparsers.add_parser('linearize',  help='Linearize GF abstract syntax treess');
  klinearizer = subparsers.add_parser('klinearize', help='Linearize K-variants of GF abstract syntax trees');
  
  parser.set_defaults(func=pgf_parse);
  parser.add_argument('-g', '--pgf',       dest='pgfgrammar',   required=True, \
      help='PGF Grammar file');
  parser.add_argument('-p', '--start-sym', dest='startcat',     required=False, \
      help='Start symbol in the grammar');
  parser.add_argument('-s', '--src-lang',  dest='srclang',      required=True, \
      help='Source language');
  parser.add_argument('-i', '--input',     dest='inputstream',  nargs='?', \
      type=argparse.FileType(mode='r'), default=sys.stdin, \
      help='Input file') ;
  parser.add_argument('-o', '--output',    dest='outputstream', nargs='?', \
      type=argparse.FileType(mode='w'), default=sys.stdout, \
      help='Output file');
  
  kparser.set_defaults(func=pgf_kparse);
  kparser.add_argument('-g', '--pgf',       dest='pgfgrammar',   required=True, \
      help='PGF Grammar file');
  kparser.add_argument('-p', '--start-sym', dest='startcat',     required=False, \
      help='Start symbol in the grammar');
  kparser.add_argument('-s', '--src-lang',  dest='srclang',      required=True, \
      help='Source language');
  kparser.add_argument('-K',                dest='K',            required=True, \
      type=int, \
      help='K value for multiple parses');
  kparser.add_argument('-i', '--input',     dest='inputstream',  nargs='?', \
      type=argparse.FileType(mode='r'), default=sys.stdin, \
      help='Input file');
  kparser.add_argument('-o', '--output',    dest='outputstream', nargs='?', \
      type=argparse.FileType(mode='w'), default=sys.stdout, \
      help='Output file');
  
  linearizer.set_defaults(func=pgf_linearize);
  linearizer.add_argument('-g', '--pgf',      dest='pgfgrammar',   required=True, \
      help='PGF Grammar file');
  linearizer.add_argument('-t', '--tgt-lang', dest='tgtlang',      required=True, \
      help='Target language');
  linearizer.add_argument('-i', '--input',    dest='inputstream',  nargs='?', \
      type=argparse.FileType(mode='r'), default=sys.stdin,  \
      help='Input file');
  linearizer.add_argument('-o', '--output',   dest='outputstream', nargs='?', \
      type=argparse.FileType(mode='w'), default=sys.stdout, \
      help='Output file'); 
  
  klinearizer.set_defaults(func=pgf_klinearize);
  klinearizer.add_argument('-g', '--pgf', dest='pgfgrammar', required=True, \
      help='PGF Grammar file');
  klinearizer.add_argument('-t', '--tgt-lang', dest='tgtlang', required=True, \
      help='Target language');
  klinearizer.add_argument('-K', '--kbest', dest='K', required=True, \
      type=int, \
      help='K value for multiple linearizations');
  klinearizer.add_argument('-i', '--input', dest='inputstream', nargs='?', \
      type=argparse.FileType(mode='r'), default=sys.stdin,  \
      help='Input file');
  klinearizer.add_argument('-o', '--output', dest='outputstream', nargs='?', \
      type=argparse.FileType(mode='w'), default=sys.stdout, \
      help='Output file');
  
  return argparser;


if __name__ == '__main__':
  args = cmdLineParser().parse_args(sys.argv[1:]);
  args.func(args);
