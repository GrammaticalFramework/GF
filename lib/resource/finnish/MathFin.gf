--# -path=.:../abstract:../../prelude

concrete MathFin of Math = CategoriesFin **  open Prelude, SyntaxFin, ParadigmsFin in {

lin
  SymbPN i = {s = \\c => i.s} ;  --- case endings often needed
  IntPN i  = {s = \\c => i.s} ;
  IntNP cn i = nameNounPhrase {
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


  LetCN x cn = {
    s = \\_ => "olkoon" ++ x.s ++ (indefNounPhrase singular cn).s !
    NPCase Nom
    } ;
  LetNumCN x nu cn = {
    s = \\_ => "olkoot" ++ x.s ++ (nounPhraseNum False nu cn).s
    ! NPCase Part
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
