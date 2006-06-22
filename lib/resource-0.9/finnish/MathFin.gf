--# -path=.:../abstract:../../prelude

concrete MathFin of Math = CategoriesFin **  open Prelude, SyntaxFin, ParadigmsFin in {

lin
  SymbPN i = symbProperName i.s ;  --- case ending not always correct
  IntPN i  = symbProperName i.s ;  --- case ending not always correct
  IntNP cn i = nameNounPhrase {    --  here the CN gets the (correct) ending
    s = \\c => cn.s ! False ! Sg ! c ++ i.s
    } ;

  IndefSymbNumNP nu cn xs = 
    addSymbNounPhrase (nounPhraseNum False nu cn) xs.s ;
  DefSymbNumNP nu cn xs = 
    addSymbNounPhrase (nounPhraseNum True nu cn) xs.s ;
  NDetSymbNP det nu cn xs = 
    addSymbNounPhrase (numDetNounPhrase det nu cn) xs.s ;

lincat 
  SymbList = SS ;

lin
  SymbTwo  = infixSS "ja" ;
  SymbMore = infixSS "," ;

  LetImp x np = {
    s = \\_ => 
        verbOlla.s ! ImperP3 x.n ++ x.s ! NPCase Nom ++ np.s ! NPCase Nom
    } ;

  ExistNP np = 
    sats2clause (
      mkSatsCopula impersNounPhrase ("olemassa" ++ np.s ! NPCase Nom)
      ) ;

-- Moved from $RulesFin$.

  SymbCN cn s =
    {s = \\f,n,c => cn.s ! f ! n ! c ++ s.s ; 
     g = cn.g} ;
  IntCN cn s =
    {s = \\f,n,c => cn.s ! f ! n ! c ++ s.s ; 
     g = cn.g} ;

}
