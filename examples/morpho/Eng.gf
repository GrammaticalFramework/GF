-- Abstract syntax for a top-level grammar for morphological analysis and synthesis
-- AR 15/8/2008
-- Use this as a template to port other morphologies to javascript, etc.

-- First import a lexicon.

abstract Eng = IrregEngAbs ** { 

cat 
  Display ;  -- what is shown: word form, analysis, or full table
  Word ;     -- lexical unit
  Form ;     -- form description

flags startcat = Display ;

fun
  DAll : Word -> Display ;            -- to show full table
  DForm : Word -> Form -> Display ;   -- to show one form

-- Here are the possible forms; this is really a copy of ResEng.VForm
-- and should be generated automatically.

  VInf, VPres, VPast, VPPart, VPresPart : Form ; 

  WVerb : V -> Word ;   -- use category V from IrregEngAbs

}
