--# -path=.:alltenses

concrete ParseEng of ParseEngAbs = 
  NounEng, 
  VerbEng - [ComplVS], 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng - [UseCl, UseQCl, UseRCl],
  QuestionEng,
  RelativeEng - [IdRP, RelSlash],
  ConjunctionEng,
  PhraseEng - [UttImpSg, UttImpPl],
  TextX,
  StructuralEng - [everybody_NP, every_Det, only_Predet, somebody_NP],
  IdiomEng,

  ExtraEng - [
   UncNegCl, UncNegQCl, UncNegRCl, UncNegImpSg, UncNegImpPl,
   StrandRelSlash,
   that_RP
  ],

  LexiconEng [N3, distance_N3, 
	      VQ, wonder_VQ, 
	      V2A, paint_V2A, 
	      V2Q, ask_V2Q,
	      V2V, beg_V2V,
	      V2S, answer_V2S,
	      VA, become_VA],
  BigLexEng

  ** open ParadigmsEng, ResEng, MorphoEng, ParamX, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

--
-- * Overridden things from the common API
--

-- Allow both "hope that he runs" and "hope he runs".
lin ComplVS v s = variants { VerbEng.ComplVS v s; ComplBareVS v s } ;

-- Allow both contracted and uncontracted negated clauses.
lin UseCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseCl t p cl;
	Neg => variants { SentenceEng.UseCl t p cl; UncNegCl t p cl }
      } ;

lin UseQCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseQCl t p cl;
	Neg => variants { SentenceEng.UseQCl t p cl; UncNegQCl t p cl }
      } ;

lin UseRCl t p cl = 
      case p.p of {
	Pos => SentenceEng.UseRCl t p cl;
	Neg => variants { SentenceEng.UseRCl t p cl; UncNegRCl t p cl }
      } ;

lin UttImpSg p i = 
      case p.p of {
	Pos => PhraseEng.UttImpSg p i;
	Neg => variants { PhraseEng.UttImpSg p i ; UncNegImpSg p i }
      } ;

lin UttImpPl p i = 
      case p.p of {
	Pos => PhraseEng.UttImpPl p i;
	Neg => variants { PhraseEng.UttImpPl p i ; UncNegImpPl p i }
      } ;

-- Two different forms of relative clauses:
-- Pied piping: "at which we are looking". 
-- Stranding: "that he looks at"
-- EmptyRelSlash is not used here, since it would give 
-- a meta-variable for the RP.

lin RelSlash rp slash = variants { RelativeEng.RelSlash rp slash; StrandRelSlash rp slash } ;


-- Allow both "who"/"which" and "that"
lin IdRP = 
     { s = table {
        RC _ Gen    => "whose" ; 
        RC Neutr _  => variants { "which"; "that"; {- for dictionary entries with the wrong gender -} "who" } ;
        RC _ Acc    => variants { "whom"; "that"; {- incorrect but common -} "who" } ;
        RC _ Nom    => variants { "who" ; "that" } ;
        RPrep _     => variants { "which"; "whom"; {- incorrect but common -}  "who" }
        } ;
      a = RNoAg
      } ;

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
    both_Det = mkDeterminer plural "both";
    either_Det = mkDeterminer singular "either" ;
    exactly_AdN = ss "exactly" ;
    most_Det = mkDeterminer plural "most";
    neither_Det = mkDeterminer singular "neither" ;
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
