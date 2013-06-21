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

  ImpVP vp = { s = \\pol,num => vp.v.s ! pol ! (VImp num) ++ vp.compl ! (AgrP2 num Masc) } ;

  SlashVP np vp = mkClause np vp ** { prep = vp.rightVal } ;

  AdvSlash slash adv = {
    s  = \\m,p => slash.s ! m ! p ++ adv.s ;
    prep = slash.prep
  } ;

  SlashPrep cl prep = cl ** { prep = prep } ;

  -- NP -> VS -> SSlash -> ClSlash
  -- e.g. '(whom) she says that he loves'
  SlashVS np vs sslash = mkClause
    np
    (lin VP {
      v = vs ;
      compl = \\_ => "," ++ vs.conj.s ++ sslash.s ;
      voice = Act ;
      leftVal = vs.leftVal ;
      rightAgr = AgrP3 Sg Masc ;
      rightPol = Pos ;
    }) ** { prep = sslash.prep } ;

  -- ComplVS v s  = { v = v ; compl = \\_ => "," ++ v.subj.s ++ s.s } ;

  -- TODO: nočekot kāpēc te ir tieši 'ka'
  EmbedS s = { s = "ka" ++ s.s } ;

  EmbedQS qs = { s = qs.s } ;

  -- FIXME: vai agr ir Pl?
  EmbedVP vp = { s = buildVP vp Pos VInf (AgrP3 Pl Masc) } ;

  UseCl t p cl = { s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p } ;
  UseQCl t p cl = { s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p } ;

  UseRCl t p cl =
	  { s = \\ag => t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p ! ag }
	| { s = \\ag => t.s ++ p.s ++ cl.s ! (Rel t.a t.t) ! p.p ! ag }		--# notpresent
	;

  UseSlash t p slash = { s = t.s ++ p.s ++ slash.s ! (Ind t.a t.t) ! p.p ; prep = slash.prep } ;

  -- FIXME: placeholder
  AdvS a s = { s = NON_EXISTENT } ;

oper
  -- TODO: PassV2 verbs jāsaskaņo ar objektu, nevis subjektu (by8means_Prep: AgP3 Sg Masc)
  mkClause : NP -> CatLav.VP -> Cl = \np,vp ->  
    let agr : Agreement = case <vp.voice, vp.leftVal> of {
      <Act,  Nom> => np.agr ;
      <Act,  _  > => vp.rightAgr ;
      <Pass, Acc> => vp.rightAgr ;
      <Pass, _  > => np.agr
    }
    in lin Cl {
      s = \\mood,pol =>
        case mood of {                                     -- subject
          Deb _ _ => np.s ! Dat ;  --# notpresent
          _       => np.s ! vp.leftVal
        } ++
        buildVerb vp.v mood pol agr np.pol vp.rightPol ++  -- verb
        vp.compl ! np.agr                                  -- object(s), complements, adverbial modifiers
    } ;

  -- FIXME: quick&dirty - lai kompilētos pret RGL API
  -- Eng: PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp
  -- Ar SC nav iespējams neko saskaņot (sk. Cat.gf un Common.gf)
  mkClauseSC : SC -> CatLav.VP -> Cl = \sc,vp -> lin Cl {
    s = \\mood,pol => sc.s ++ buildVerb vp.v mood pol (AgrP3 Sg Masc) Pos vp.rightPol ++ vp.compl ! (AgrP3 Sg Masc)
  } ;

}
