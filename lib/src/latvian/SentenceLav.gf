--# -path=.:../abstract:../common:../prelude

concrete SentenceLav of Sentence = CatLav ** open
  ResLav,
  VerbLav,
  Prelude
in {

flags
    optimize = all_subs ;
    coding = utf8 ;

lin
  -- NP -> VP -> Cl
  PredVP np vp = mkClause np vp ;

  PredSCVP sc vp = mkClauseSC sc vp ;

  ImpVP vp = { s = \\pol,n => vp.v.s ! pol ! (VImp n) ++ vp.compl ! (AgP2 n Masc) } ;

  SlashVP np vp = mkClause np vp ** { p = vp.p } ;

  AdvSlash slash adv = {
    s  = \\m,p => slash.s ! m ! p ++ adv.s ;
    p = slash.p
  } ;

  SlashPrep cl prep = cl ** { p = prep } ;

  SlashVS np vs sslash =
    mkClause np (lin VP {
      v = vs ;
      compl = \\_ => "," ++ vs.subj.s ++ sslash.s ;
      val = toVal_Reg vs.topic ;
      objNeg = Pos ;
      voice = Act
    }) ** { p = sslash.p } ;

  ComplVS v s  = { v = v ; compl = \\_ => "," ++ v.subj.s ++ s.s } ;

  -- TODO: nočekot kāpēc te ir tieši 'ka'
  EmbedS s = { s = "ka" ++ s.s } ;

  EmbedQS qs = { s = qs.s } ;

  -- FIXME: vai agr ir Pl?
  EmbedVP vp = { s = build_VP vp Pos VInf (AgP3 Pl Masc Pos) } ;

  UseCl t p cl = { s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p } ;
  UseQCl t p cl = { s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p } ;

  UseRCl t p cl =
	  { s = \\ag => t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p ! ag }
	| { s = \\ag => t.s ++ p.s ++ cl.s ! (Rel t.a t.t) ! p.p ! ag }		--# notpresent
	;

  UseSlash t p slash = { s = t.s ++ p.s ++ slash.s ! (Ind t.a t.t) ! p.p ; p = slash.p } ;

  -- FIXME: placeholder
  AdvS a s = { s = NON_EXISTENT } ;

oper
  -- TODO: PassV2 verbs jāsaskaņo ar objektu, nevis subjektu (by8means_Prep: AgP3 Sg Masc)
  mkClause : NP -> CatLav.VP -> Cl = \np,vp ->  
    let subj : Case = case vp.voice of {
      Act  => vp.val.subj ;
      Pass => vp.val.obj
    } in lin Cl {
      s = \\mood,pol =>
        case mood of {  -- Subject
          Deb _ _ => np.s ! Dat ;  --# notpresent
          _       => np.s ! vp.val.subj
        } ++
        case subj of {  -- Verb
          -- TODO: vai np.a un np.a.pol argumentus nevar apvienot?
          Nom => buildVerb vp.v mood pol np.a (fromAgr np.a).pol vp.objNeg ;
          _   => buildVerb vp.v mood pol vp.val.agr (fromAgr np.a).pol vp.objNeg -- TESTME
        } ++
        vp.compl ! np.a  -- Object(s), complements, adverbial modifiers
    } ;

  -- FIXME: quick&dirty - lai kompilētos pret RGL API
  -- Eng: PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp
  -- Ar SC nav iespējams neko saskaņot (sk. Cat.gf un Common.gf)
  mkClauseSC : SC -> CatLav.VP -> Cl = \sc,vp -> lin Cl {
    s = \\mood,pol => sc.s ++ buildVerb vp.v mood pol (AgP3 Sg Masc Pos) Pos vp.objNeg ++ vp.compl ! (AgP3 Sg Masc Pos)
  } ;

}
