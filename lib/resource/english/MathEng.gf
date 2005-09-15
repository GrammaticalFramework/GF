--# -path=.:../abstract:../../prelude

concrete MathEng of Math = CategoriesEng **  open Prelude, SyntaxEng, ParadigmsEng in {

lin
  SymbPN i = {s = \\c => caseSymb c i.s ; g = Neutr} ;
  IntPN i  = {s = \\c => caseSymb c i.s ; g = Neutr} ;
  IntNP cn i = nameNounPhrase {
    s = \\c => (cn.s ! Sg ! Nom ++ caseSymb c i.s) ; 
    g = Neutr
    } ;

  IndefSymbNumNP nu cn xs = 
    addSymbNounPhrase (indefNounPhraseNum plural nu cn) xs.s ;
  DefSymbNumNP nu cn xs = 
    addSymbNounPhrase (defNounPhraseNum plural nu cn) xs.s ;
  NDetSymbNP det nu cn xs = 
    addSymbNounPhrase (numDetNounPhrase det nu cn) xs.s ;

lincat 
  SymbList = SS ;

lin
  SymbTwo  = infixSS "and" ;
  SymbMore = infixSS "," ;


  LetCN x cn = {
    s = \\_ => "let" ++ x.s ++ "be" ++ (indefNounPhrase singular cn).s ! NomP
    } ;
  LetNumCN x nu cn = {
    s = \\_ => "let" ++ x.s ++ "be" ++ (indefNounPhraseNum plural nu cn).s ! NomP
    } ;
  ExistNP np = predVerbClause
                 (nameNounPhraseN (fromAgr np.a).n (nameReg "there" Neutr))
                 (regV "exist")
                 (complNounPhrase np) ;

-- Moved from $RulesEng$.

  SymbCN cn s =
    {s = \\n,c => cn.s ! n ! Nom ++ caseSymb c s.s ; 
     g = cn.g} ;
  IntCN cn s =
    {s = \\n,c => cn.s ! n ! Nom ++ caseSymb c s.s ; 
     g = cn.g} ;


}
