#!/usr/bin/env python

"""
"""

import argparse, re, string, sys, time;
from itertools import imap, count;
from operator import itemgetter;

import pgf;

def lexerI(sentence):
    return sentence.rstrip(string.whitespace+string.punctuation);

def lexerChi(sentence):
    sentence = sentence.decode('utf-8');
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
    return ' '.join(tokens).encode('utf-8');

def lexer(lang='translator'):
    if lang[-3:] == 'Eng':
	return lexerI;
    elif lang[-3:] == 'Chi':
	return lexerChi;
    elif lang == 'translator':
	import translation_pipeline;
	return translation_pipeline.pipeline_lexer;
    else:
	return lexerI;

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
	    parsesBlock.append( (float(parseprob.strip()), pgf.readExpr(parse.strip())) );
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
	transBlock.append( (map(float, tuple([val.strip() for val in fields[3].split()])), fields[1].strip()) );

def printJohnsonRerankerFormat(gfparsesList, sentid=count(1)):
    johnsonRepr = [];
    parseHash = {};
    for parse in sorted(gfparsesList, key=itemgetter(0)):
	if not parseHash.has_key(parse[1]):
	    johnsonRepr.append( str(-1*parse[0]) );
	    johnsonRepr.append( str(parse[1]) );
	parseHash.setdefault(parse[1], []).append(parse[0]);
    curid = sentid.next();
    if len(gfparsesList):
	johnsonRepr.insert(0, '%d %d' %(len(parseHash.values()), curid));
    duplicateInstances = len(filter(lambda X: len(parseHash[X]) > 1, parseHash.keys()));
    #if duplicateInstances: print >>sys.stderr, "%d duplicate parses found in K-best parsing" %(duplicateInstances);
    return '\n'.join(johnsonRepr)+'\n';

def printMosesNbestFormat(hypothesisList, sentid=count(1)):
    mosesRepr = [];
    sid = sentid.next();
    for hypScores, hypStr in hypothesisList:
	if not hasattr(hypScores, '__iter__'):
	    hypScores = (hypScores, );
	mosesRepr.append("%d ||| %s ||| NULL ||| %s" %(sid, hypStr, ' '.join(['%.6f'%score for score in hypScores])));
    return '\n'.join(mosesRepr);

def getKLinearizations(grammar, tgtlanguage, abstractParsesList, K=10):
    generator = grammar.languages[tgtlanguage].linearizeAll;
    for parsesBlock in abstractParsesList:
	kBestTrans = [];
	for parseprob, parse in parsesBlock:
	    for linstring in generator(parse, n=K):
		kBestTrans.append( ((parseprob,), postprocessor(linstring)) );
	yield kBestTrans;

def getKBestParses(grammar, language, K, callbacks=[], serializable=False, sentid=count(1), max_length=50):
    parser = grammar.languages[language].parse;
    def worker(sentence):
	sentence = sentence.strip();
	curid = sentid.next();
	tstart = time.time();
	kBestParses = [];
	parseScores = {};
	if len(sentence.split()) > max_length:
	    tend, err = time.time(), "Sentence too long (%d tokens). Might potentially run out of memory" %(len(sentence.split()));
	    print >>sys.stderr, '%d\t%.4f\t%s' %(curid, tend-tstart, err);
	    return tend-tstart, kBestParses; # temporary hack to make sure parser does not get killed for very long sentences;
	try:
	    for parseidx, parse in enumerate( parser(sentence, heuristics=0, callbacks=callbacks) ):
		parseScores[parse[0]] = True;
		kBestParses.append( (parse[0], str(parse[1]) if serializable else parse[1]) );
		if parseidx == K-1: break;
		#if len(parseScores) >= K: break;
	    tend = time.time();
	    print >>sys.stderr, '%d\t%.4f' %(curid, tend-tstart);
	    return tend-tstart, kBestParses;
	except pgf.ParseError, err:
	    tend = time.time();
	    print >>sys.stderr, '%d\t%.4f\t%s' %(curid, tend-tstart, err);
	    return tend-tstart, kBestParses;
	except UnicodeEncodeError, err:
	    tend = time.time();
	    print >>sys.stderr, '%d\t%.4f\t%s' %(curid, tend-tstart, err);
	    return tend-tstart, kBestParses;
    return worker;

def pgf_parse(args):
    grammar  = pgf.readPGF(args.pgfgrammar);
    import translation_pipeline;

    preprocessor = lexer();
    inputSet = translation_pipeline.web_lexer(grammar, args.srclang, imap(preprocessor, args.inputstream) );
    outputPrinter = lambda X: "%f\t%s" %(X[0], str(X[1])); #operator.itemgetter(1);
    callbacks = [('PN', translation_pipeline.parseNames(grammar, args.srclang)), ('Symb', translation_pipeline.parseUnknown(grammar, args.srclang))];
    parser = getKBestParses(grammar, args.srclang, 1, callbacks);
    
    sentidx = 0;
    for time, parsesBlock in imap(parser, inputSet):
	sentidx += 1;
	print >>args.outputstream, "%d\t%f\t%s" %(sentidx, time, str(outputPrinter(parsesBlock[0])) if len(parsesBlock) else '');
    return;

def pgf_kparse(args):
    grammar = pgf.readPGF(args.pgfgrammar);
    import translation_pipeline;
    
    preprocessor = lexer();
    inputSet = translation_pipeline.web_lexer(grammar, args.srclang, imap(preprocessor, args.inputstream) );
    outputPrinter = printJohnsonRerankerFormat;
    callbacks = [('PN', translation_pipeline.parseNames(grammar, args.srclang)), ('Symb', translation_pipeline.parseUnknown(grammar, args.srclang))];
    parser = getKBestParses(grammar, args.srclang, args.K, callbacks=callbacks);

    sentidx = 0;
    for time, parsesBlock in imap(parser, inputSet):
	sentidx += 1;
	strParses = str(outputPrinter(parsesBlock));
	if not (strParses == '\n'):
	    print >>args.outputstream, strParses;
    return;

def pgf_linearize(args):
    grammar = pgf.readPGF(args.pgfgrammar);
    outputPrinter = postprocessor;
    inputSet = [];
    for line in args.inputstream:
	try:
	    sentid, parsetime, parserepr = line.strip('\n').split('\t', 2);
	except ValueError:
	    print line.strip();
	parseprob, abstree = parserepr.split('\t') if parserepr.strip() else (0, '');
	inputSet.append( (int(sentid), float(parsetime), float(parseprob), pgf.readExpr(abstree) if abstree else None) );
    linearizer = grammar.languages[args.tgtlang].linearize;
    for sentid, _, _, abstree in inputSet:
	if abstree:
	    print >>args.outputstream, str(outputPrinter(linearizer(abstree)));
	else:
	    print >>args.outputstream, "";
    return;

def pgf_klinearize(args):
    grammar = pgf.readPGF(args.pgfgrammar);
    outputPrinter = printMosesNbestFormat;
    inputSet = [(sentid, parsesBlock) for sentid, parsesBlock in readJohnsonRerankerTrees(args.inputstream)];
    sentIdsList = imap(itemgetter(0), inputSet);
    parsesBlocks = map(itemgetter(1), inputSet);

    for transBlock in getKLinearizations(grammar, args.tgtlang, parsesBlocks, args.K):
	strTrans = str(outputPrinter(transBlock, sentIdsList));
	if strTrans:
	    print >>args.outputstream, strTrans;
    return;

def cmdLineParser():
    argparser = argparse.ArgumentParser(prog='gf_utils.py',  description='Examples for carrying out (K-best) parsing, translation and linearization using GF C runtime.');
    
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
    parser.add_argument('-i', '--input',     dest='inputstream',  nargs='?', type=argparse.FileType(mode='r'), default=sys.stdin,  \
	    help='Input file') ;
    parser.add_argument('-o', '--output',    dest='outputstream', nargs='?', type=argparse.FileType(mode='w'), default=sys.stdout, \
	    help='Output file');

    kparser.set_defaults(func=pgf_kparse);
    kparser.add_argument('-g', '--pgf',       dest='pgfgrammar',   required=True, \
	    help='PGF Grammar file');
    kparser.add_argument('-p', '--start-sym', dest='startcat',     required=False, \
	    help='Start symbol in the grammar');
    kparser.add_argument('-s', '--src-lang',  dest='srclang',      required=True, \
	    help='Source language');
    kparser.add_argument('-K',                dest='K',            required=True, type=int, \
	    help='K value for multiple parses');
    kparser.add_argument('-i', '--input',     dest='inputstream',  nargs='?', type=argparse.FileType(mode='r'), default=sys.stdin, \
	    help='Input file');
    kparser.add_argument('-o', '--output',    dest='outputstream', nargs='?', type=argparse.FileType(mode='w'), default=sys.stdout, \
	    help='Output file');
    
    linearizer.set_defaults(func=pgf_linearize);
    linearizer.add_argument('-g', '--pgf',      dest='pgfgrammar',   required=True, \
	    help='PGF Grammar file');
    linearizer.add_argument('-t', '--tgt-lang', dest='tgtlang',      required=True, \
	    help='Target language');
    linearizer.add_argument('-i', '--input',    dest='inputstream',  nargs='?', type=argparse.FileType(mode='r'), default=sys.stdin,  \
	    help='Input file');
    linearizer.add_argument('-o', '--output',   dest='outputstream', nargs='?', type=argparse.FileType(mode='w'), default=sys.stdout, \
	    help='Output file'); 

    klinearizer.set_defaults(func=pgf_klinearize);
    klinearizer.add_argument('-g', '--pgf',      dest='pgfgrammar',   required=True, \
	    help='PGF Grammar file');
    klinearizer.add_argument('-t', '--tgt-lang', dest='tgtlang',      required=True, \
	    help='Target language');
    klinearizer.add_argument('-K',               dest='K',            required=True, type=int, \
	    help='K value for multiple linearizations');
    klinearizer.add_argument('-i', '--input',    dest='inputstream',  nargs='?', type=argparse.FileType(mode='r'), default=sys.stdin,  \
	    help='Input file');
    klinearizer.add_argument('-o', '--output',   dest='outputstream', nargs='?', type=argparse.FileType(mode='w'), default=sys.stdout, \
	    help='Output file');

    return argparser;

if __name__ == '__main__':
    args = cmdLineParser().parse_args(sys.argv[1:]);
    args.func(args);
