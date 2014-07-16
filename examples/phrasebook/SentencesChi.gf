concrete SentencesChi of Sentences = NumeralChi ** SentencesI - [QWhereModVerbPhrase, APlace,ThePlace, PropCit, CitiNat, ACitizen, Nationality, CitizenShip, ByTransp,  GObjectPlease, AKnowPerson,  QDoHave , QWhereDoVerbPhrase, SHaveNo, AHaveCurr]
  with 
  (Syntax = SyntaxChi),
  (Symbolic = SymbolicChi),
  (Lexicon = LexiconChi) ** open SyntaxChi, (P =  ParadigmsChi) in {

flags coding=utf8 ;
lincat
   Citizenship = N ;
   Nationality = {lang : NP ; country : NP; prop : A }; 
lin
  ThePlace kind =
    let name : NP = lin NP (Syntax.mkNP theSg_Det kind.name) in {
      name = lin NP name ;
      at = mkAdv kind.at (lin NP name) ;
      to = mkAdv kind.to (lin NP name)
    } ;
  APlace kind =
    let name : NP = lin NP (Syntax.mkNP aSg_Det kind.name) in {
      name = lin NP name ;
      at = mkAdv kind.at (lin NP name) ;
      to = mkAdv kind.to (lin NP name)
    } ;

  ACitizen p n = mkCl p.name (lin N {s = n.s ++ "人" } ) ; --  to get 俄罗斯人, not 俄罗斯（人）的 ;  
  CitiNat n = n.prop ; -- lin A { s = n.prop.s ++ "人" ; lock_A = <> ; monoSyl = False} ;

  PropCit c  =  lin A { s = c.s ; lock_A = <>; monoSyl = True     }  ;

  ByTransp t = t.by ;

  QWhereModVerbPhrase m p vp = mkQS (mkQCl  zai_where_IAdv (mkCl p.name (mkVP m vp))) ;

  GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o) please_shang_Voc) | lin Text (mkUtt o) ;

  AKnowPerson p q = mkCl p.name (P.mkV2 "认识") q.name ;


  QDoHave p obj = mkQS (mkQCl (mkCl p.name have_V2 obj)) ;

  QWhereDoVerbPhrase p vp = mkQS (mkQCl qu_where_IAdv (mkCl p.name vp)) ;

  SHaveNo p k = mkS negativePol (mkCl p.name have_V2 (mkNP k)) ;

  AHaveCurr p curr = mkCl p.name have_V2 (mkNP curr) ;

  MCan = can_VV ;
  MWant = want_VV ;
  MMust = must_VV ;


 oper
   qu_where_IAdv = mkIAdvL "去哪里" ;
   zai_where_IAdv = mkIAdvL "在哪里" ;
   where_m_IAdv : VV -> SS  = \m -> mkIAdvL m.s ; -- ( "想在哪里" ) ;

   have_or_not_V2 = P.mkV2 (P.mkV "有没有" "了" "着" "在" "过" "没") ;

   please_shang_Voc : SS = ss "请上" ;


}
