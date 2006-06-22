--# -path=.:../romance:../abstract:../../prelude

incomplete concrete MathRomance of Math = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

lin
  SymbPN i = {s = i.s ; g = Masc} ; --- cannot know gender
  IntPN i  = {s = i.s ; g = Masc} ;
  IntNP cn i = nameNounPhrase {
    s = cn.s ! Sg ++ i.s ;
    g = cn.g
    } ;

  IndefSymbNumNP nu cn xs = 
    addSymbNounPhrase (indefNounPhraseNum nu cn) xs.s ;
  DefSymbNumNP nu cn xs = 
    addSymbNounPhrase (defNounPhraseNum nu cn) xs.s ;
  NDetSymbNP det nu cn xs = 
    addSymbNounPhrase (numDetNounPhrase det nu cn) xs.s ;

lincat 
  SymbList = SS ;

lin
  SymbTwo  = infixSS etConj.s ;
  SymbMore = infixSS "," ;


  LetImp x cn = {
    s = \\_,_ => copula.s ! VFin (VPres Con) x.n P3 ++ 
    x.s ! unstressed nominative ++ cn.s ! unstressed nominative
    } ;

--- to be replaced by "il existe", "esiste", etc.

  ExistNP np = existNounPhrase np ;

-- Moved from $RulesRomance$.

  SymbCN cn s =
    {s = \\n => cn.s ! n ++ s.s ; 
     g = cn.g} ;
  IntCN cn i =
    {s = \\n => cn.s ! n ++ i.s ; 
     g = cn.g} ;

}
