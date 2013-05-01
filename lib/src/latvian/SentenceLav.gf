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

  ImpVP vp = { s = \\pol,n => vp.v.s ! pol ! (Imperative n) ++ vp.compl ! (AgP2 n Masc) } ;

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
      agr = toClAgr_Reg vs.topic ;
      objNeg = False
    }) ** { p = sslash.p } ;

  ComplVS v s  = { v = v ; compl = \\_ => "," ++ v.subj.s ++ s.s } ;

  -- TODO: nočekot kāpēc te ir tieši 'ka'
  EmbedS s = { s = "ka" ++ s.s } ;

  EmbedQS qs = { s = qs.s } ;

  -- FIXME: neesmu līdz galam drošs vai agreement ir tieši (AgPr Pl)
  EmbedVP vp = { s = build_VP vp Pos Infinitive (AgP3 Pl Masc) } ;

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
    let subj : Case = case vp.agr.voice of {
      Act  => vp.agr.c_topic ;
      Pass => vp.agr.c_focus
    } in lin Cl {
      s = \\mood,pol =>
        case mood of {  -- Subject
          Deb _ _ => np.s ! Dat ;  --# notpresent
          _       => np.s ! vp.agr.c_topic
          {-
          _       => case vp.agr.voice of {
            Act  => np.s ! vp.agr.c_topic ;
            Pass => np.s ! vp.agr.c_focus
          }
          -}
          {-
          _       => case vp.agr of {
            Topic      c     _ => np.s ! c ;
            TopicFocus c _ _ _ => np.s ! c
          }
          -}
        } ++
        case subj of {  -- Verb
          Nom => buildVerb vp.v mood pol np.a np.isNeg vp.objNeg ;
          _   => buildVerb vp.v mood pol vp.agr.agr np.isNeg vp.objNeg -- TODO: test me
        } ++
        {-
        case vp.agr of {  -- Verb
          Topic      Nom       _ => buildVerb vp.v mood pol np.a np.isNeg vp.objNeg ;
          Topic      _         _ => buildVerb vp.v mood pol (AgP3 Sg Masc) np.isNeg vp.objNeg ;  -- TODO: test me
          TopicFocus Nom _ _   _ => buildVerb vp.v mood pol np.a np.isNeg vp.objNeg ;
          TopicFocus _   _ agr _ => buildVerb vp.v mood pol agr np.isNeg vp.objNeg
        } ++
        -}
        vp.compl ! np.a  -- Object(s), complements, adverbial modifiers
    } ;

  -- FIXME: quick&dirty - lai kompilētos pret RGL API
  -- Eng: PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp
  -- Ar SC nav iespējams neko saskaņot (sk. Cat.gf un Common.gf)
  mkClauseSC : SC -> CatLav.VP -> Cl = \sc,vp -> lin Cl {
    s = \\mood,pol => sc.s ++ buildVerb vp.v mood pol (AgP3 Sg Masc) False vp.objNeg ++ vp.compl ! (AgP3 Sg Masc)
  } ;

}
