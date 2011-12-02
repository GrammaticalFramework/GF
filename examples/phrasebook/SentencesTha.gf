concrete SentencesTha of Sentences = NumeralTha ** SentencesI - [
    GObjectPlease,
    ACitizen, WherePlace, WherePerson
  ] with 
  (Syntax = SyntaxTha),
  (Symbolic = SymbolicTha),
  (Lexicon = LexiconTha) ** open SyntaxTha, (P = ParadigmsTha), (R = ResTha) in {

flags coding=utf8 ;
lin
  GObjectPlease o = lin Text (mkPhr (lin PConj (ss "ขอ")) (mkUtt o) (lin Voc (ss "หน่อย"))) | lin Text (mkUtt o) ;

  ACitizen p n = mkCl p.name (mkVP (mkCN n (P.personN R.khon_s))) ;

  WherePlace place = mkQS (mkQCl where_IAdv (mkCl place.name yuu_V)) ;
  WherePerson person = mkQS (mkQCl where_IAdv (mkCl person.name yuu_V)) ;

oper
  yuu_V : V = R.regV "อยู่" ;

}
