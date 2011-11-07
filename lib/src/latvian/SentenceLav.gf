concrete SentenceLav of Sentence = CatLav ** open Prelude, ResLav, VerbLav in {
  flags optimize=all_subs ;

lin
  PredVP np vp = mkClause np vp;
	  
  ImpVP vp = {
	s = \\pol, n => vp.v.s ! pol ! (Imperative n) ++ vp.s2 ! (AgP2 n)
  } ;
  
  SlashVP np vp = 
      mkClause np vp ** {p = vp.p} ;
  AdvSlash slash adv = {
      s  = \\m,p => slash.s ! m ! p ++ adv.s ;
      p = slash.p
  } ;
  SlashPrep cl prep = cl ** {p = prep};  
  SlashVS np vs slash = mkClause np (lin VP {v = vs; s2 = \\_ => "," ++ vs.subj.s ++ slash.s}) ** {p = slash.p};	
		
  ComplVS v s  = {v = v; s2 = \\_ => "," ++ v.subj.s ++ s.s};		
  
  EmbedS  s  = {s = "ka" ++ s.s} ; --TODO - noèekot kâpçc te ir tieði 'ka'
  EmbedQS qs = {s = qs.s } ;
  EmbedVP vp = {s = build_VP vp Pos Infinitive (AgP3 Pl Masc)} ;  --FIXME - neesmu lîdz galam droðs vai agreement ir tieði (AgPr Pl)

  UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p} ;
  UseQCl t p cl = {s = t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p} ;
  UseRCl t p cl = 
	{ s = \\ag => t.s ++ p.s ++ cl.s ! (Ind t.a t.t) ! p.p ! ag } |
	{ s = \\ag => t.s ++ p.s ++ cl.s ! (Rel t.a t.t) ! p.p ! ag };
  UseSlash t p slash = {s = t.s ++ p.s ++ slash.s ! (Ind t.a t.t) ! p.p;  p = slash.p};
  
  --FIXME placeholder
  AdvS a s = { s = NON_EXISTENT } ;
  
oper
    mkClause : NP -> VP -> Cl = \np,vp -> lin Cl {
      s = \\mood,pol =>
        case mood of {		-- Subject 
          Deb _ _ => np.s ! Dat ; -- FIXME jâèeko valences, reizçm arî îstenîbas izteiksmç - 'man patîk kaut kas'
          _ => np.s ! Nom
        } ++ 
		buildVerb vp.v mood pol np.a ++ -- Verb
        vp.s2 ! np.a					-- Object(s), complements, adverbial modifiers; 
    } ;
	
{-  
    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;


    AdvS a s = {s = a.s ++ "," ++ s.s} ;

    SSubjS a s b = {s = a.s ++ s.s ++ b.s} ;

    RelS s r = {s = s.s ++ "," ++ r.s ! agrP3 Sg} ;

  oper
    ctr = contrNeg True ;  -- contracted negations
-}
}

