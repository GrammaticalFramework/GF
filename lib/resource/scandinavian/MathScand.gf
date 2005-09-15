--# -path=.:../abstract:../../prelude

incomplete concrete MathScand of Math = CategoriesScand ** 
  open Prelude, SyntaxScand in {

lin
  SymbPN i = {s = \\_ => i.s ; g = NNeutr} ; --- cannot know gender
  IntPN i  = {s = \\_ => i.s ; g = NNeutr} ;
  IntNP cn i = nameNounPhrase {
    s = \\c => cn.s ! Sg ! DefP Def ! Nom ++ i.s ;
    g = cn.g
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
  SymbTwo  = infixSS conjEt ;
  SymbMore = infixSS "," ;


  LetCN x cn = {
    s = \\_ => letImp ++ x.s ++ verbVara.s ! VI (Inf Act) ++ (indefNounPhrase singular cn).s !
    PNom
    } ;
  LetNumCN x nu cn = {
    s = \\_ => letImp ++ x.s ++ verbVara.s ! VI (Inf Act) ++
    (indefNounPhraseNum plural nu cn).s
    ! PNom
    } ;

--- to be replaced by "det existerar", etc.

  ExistNP np = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   np) ;

-- Moved from $RulesScand$.

  SymbCN cn s =
    {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
     g = cn.g ;
     p = cn.p
     } ;
  IntCN cn s =
    {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
     g = cn.g ;
     p = cn.p
     } ;

}
