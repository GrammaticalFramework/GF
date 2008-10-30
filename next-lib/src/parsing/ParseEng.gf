--# -path=.:alltenses

concrete ParseEng of ParseEngAbs = 
  NounEng, 
  VerbEng - [ComplVS], 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng - [UseCl, UseQCl, UseRCl],
  QuestionEng,
  RelativeEng - [IdRP],
  ConjunctionEng,
  PhraseEng - [UttImpSg, UttImpPl],
  TextX,
  StructuralEng - [everybody_NP, every_Det, only_Predet, somebody_NP],
  IdiomEng,

  LexiconEng,

  ExtraEng - [
   -- Don't include the uncontracted clauses. Instead
   -- use them as variants of the contracted ones.
   UncNegCl, UncNegQCl, UncNegRCl, UncNegImpSg, UncNegImpPl
  ]

  ** open ParadigmsEng, ResEng, MorphoEng, ParamX, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

--
-- * Overridden things from the common API
--

-- Allow both "hope that he runs" and "hope he runs".
lin ComplVS v s = variants { VerbEng.ComplVS v s; insertObj (\\_ => s.s) (predV v) } ;

-- Allow both contracted and uncontracted negated clauses.
lin UseCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseCl t p cl;
	Neg => variants { SentenceEng.UseCl t p cl; { s = p.s ++ (UncNegCl t cl).s } }
      } ;

lin UseQCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseQCl t p cl;
	Neg => variants { SentenceEng.UseQCl t p cl; { s = \\qf => p.s ++ (UncNegQCl t cl).s!qf } }
      } ;

lin UseRCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseRCl t p cl;
	Neg => variants { SentenceEng.UseRCl t p cl; 
                          let s = UncNegRCl t cl
			   in { s = \\agr => p.s ++ s.s!agr; c = s.c } }
      } ;

lin UttImpSg p i = 
      case p.p of {
	Pos => PhraseEng.UttImpSg p i;
	Neg => variants { PhraseEng.UttImpSg p i ; { s = p.s ++ (UncNegImpSg i).s } }
      } ;

lin UttImpPl p i = 
      case p.p of {
	Pos => PhraseEng.UttImpPl p i;
	Neg => variants { PhraseEng.UttImpPl p i ; { s = p.s ++ (UncNegImpPl i).s } }
      } ;

-- Allow both "who"/"which" and "that"
-- FIXME: allow both "who" and "which" for all genders
lin IdRP = variants { RelativeEng.IdRP; that_RP } ;

lin everybody_NP = variants { regNP "everybody" singular; regNP "everyone" singular } ;
lin somebody_NP = variants { regNP "somebody" singular; regNP "someone" singular } ;

lin every_Det = variants { mkDeterminer singular "every"; mkDeterminer singular "each" };

lin only_Predet = variants { ss "only"; ss "just" };


--
-- English-specific additions
--

-- Syntactic additions

lin
    VerbCN v cn = {s = \\n,c => v.s ! VPresPart ++ cn.s ! n ! c; g = cn.g};

    NumOfNP num np = {
      s = \\c => num.s ++ "of" ++ np.s ! c ; 
      a = agrP3 num.n
      } ;

-- Lexical additions

lin
    a8few_Det = mkDeterminer plural ["a few"];
    another_Predet = ss "another" ;
    any_Predet = ss "any" ;
    anybody_NP = variants { regNP "anybody" singular; regNP "anyone" singular };
    anything_NP = regNP "anything" singular;
    at8least_AdN = ss ["at least"] ;
    at8most_AdN = ss ["at most"] ;
    both_Det = mkDeterminer plural "both";
    either_Det = mkDeterminer singular "either" ;
    exactly_AdN = ss "exactly" ;
    most_Det = mkDeterminer plural "most";
    neither_Det = mkDeterminer singular "neither" ;
    no_Det = variants { mkDeterminer singular "no"; mkDeterminer plural "no" } ;
    nobody_NP = variants { regNP "nobody" singular; regNP "noone" singular; regNP ["no one"] singular };
    nothing_NP = regNP "nothing" singular;
    only_AdV = mkAdV "only" ;
    should_VV = {
      s = table {
	VVF VInf => ["ought to"] ;
	VVF VPres => "should" ;
	VVF VPPart => ["ought to"] ;
	VVF VPresPart => variants {} ; -- FIXME: "shoulding" ?
	VVF VPast => ["should have"] ;
	VVPastNeg => ["shouldn't have"] ;
	VVPresNeg => "shouldn't"
	} ;
      isAux = True
    } ;
    several_Det = mkDeterminer plural "several" ;


} ;
