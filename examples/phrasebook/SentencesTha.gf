concrete SentencesTha of Sentences = NumeralTha ** SentencesI - [
    PGreetingMale, PGreetingFemale,
    GObjectPlease,
    ACitizen, WherePlace, WherePerson
  ] with 
  (Syntax = SyntaxTha),
  (Symbolic = SymbolicTha),
  (Lexicon = LexiconTha) ** open SyntaxTha, (P = ParadigmsTha), (R = ResTha) in {

flags coding=utf8 ;
lin
  PGreetingMale g   = mkText (lin Text g) (lin Text (ss "ครับ")) | g ;
  PGreetingFemale g = mkText (lin Text g) (lin Text (ss "ค่ะ")) | g ;

  GObjectPlease o = 
    lin Text (mkPhr (lin PConj (ss "ขอ")) (mkUtt o) (lin Voc (ss "หน่อย"))) | lin Text (mkUtt o) ;

  ACitizen p n = mkCl p.name (mkVP (mkCN n (P.personN R.khon_s))) ;

  WherePlace place = mkQS (mkQCl where_IAdv (mkCl place.name yuu_V)) ;
  WherePerson person = mkQS (mkQCl where_IAdv (mkCl person.name yuu_V)) ;

oper
  yuu_V : V = R.regV "อยู่" ;

  thpron = R.thpron ;
}
