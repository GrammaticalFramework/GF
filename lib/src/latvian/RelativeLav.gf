--# -path=.:../abstract:../common:../prelude

concrete RelativeLav of Relative = CatLav ** open
  ResLav,
  VerbLav,
  Prelude
in {

flags
  optimize = all_subs ;
  coding = utf8 ;

lin
  RelCl cl = { s = \\m,p,_ => "ka" ++ cl.s ! m ! p } ;

  -- RP -> VP -> RCl
  RelVP rp vp = mkRelClause rp vp ;

oper
  -- TODO: PassV2 verbs jāsaskaņo ar objektu, nevis subjektu (by8means_Prep: AgP3 Sg Masc)
  mkRelClause : RP -> CatLav.VP -> RCl = \rp,vp ->  
    let subj : Case = case vp.agr.voice of {
      Act  => vp.agr.c_topic ;
      Pass => vp.agr.c_focus
    } in lin RCl {
      s = \\mood,pol,agr =>
        case mood of {  -- Subject
          Deb _ _ => rp.s ! Masc ! Dat ;  --# notpresent
          _       => rp.s ! Masc ! vp.agr.c_topic
        } ++
        case subj of {  -- Verb
          Nom => buildVerb vp.v mood pol (toAgr (fromAgr agr).num P3 (fromAgr agr).gend) False vp.objNeg ; -- TODO: kāpēc P3 nevis agr, kāds tas ir?
          _   => buildVerb vp.v mood pol vp.agr.agr False vp.objNeg -- TODO: test me
        } ++
        vp.compl ! agr  -- Object(s), complements, adverbial modifiers
    } ;

lin
  -- FIXME: vārdu secība - nevis 'kas mīl viņu' bet 'kas viņu mīl' (?)
  -- FIXME: Masc varētu nebūt labi
  RelSlash rp slash = {
    s = \\m,p,ag => slash.p.s ++ rp.s ! Masc ! (slash.p.c ! Sg) ++  slash.s ! m ! p
  } ;

  -- FIXME: placeholder
  -- TODO: jātestē, kautkas nav labi ar testpiemēru
  FunRP p np rp = {
    s = \\g,c => p.s ++ rp.s ! g ! c ++ np.s ! (p.c ! (fromAgr np.a).num)
  } ;

  IdRP = {
    s = \\_ => table {
      Nom => "kas" ;
      Gen => "kā" ;
      Dat => "kam" ;
      Acc => "ko" ;
      Loc => "kur" ;
      ResLav.Voc => NON_EXISTENT
    }
  } ;

}
