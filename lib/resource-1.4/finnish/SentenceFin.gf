concrete SentenceFin of Sentence = CatFin ** open Prelude, ResFin in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (subjForm np vp.sc) np.a vp ;

    PredSCVP sc vp = mkClause (\_ -> sc.s) (agrP3 Sg) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = {n = n ; p = P2} ;
          verb  = vp.s ! VIImper ! Simul ! pol ! agr ;
          compl = vp.s2 ! False ! pol ! agr ++ vp.ext  --- False = like inf (osta auto)
        in
        verb.fin ++ verb.inf ++ compl ;
    } ;

-- The object case is formed at the use site of $c2$, in $Relative$ and $Question$.

{-
    SlashV2 np v2 = { 
      s = \\t,a,p => (mkClause (subjForm np v2.sc) np.a (predV v2)).s ! t ! a ! p ! SDecl ;
      c2 = v2.c2
      } ;

    SlashVVV2 np vv v2 =
      let
        sc = case v2.sc of {
          NPCase Nom => vv.sc ;   -- joka minun täytyy pestä
          c => c                  -- joka minulla täytyy olla
          } 
      in
      {s = \\t,ag,p => 
         (mkClause 
            (subjForm np sc) np.a 
            (insertObj 
              (\\_,b,a => infVP vv.sc b a (predV v2)) 
              (predV vv)
            )
         ).s ! t ! ag ! p ! SDecl ;
      c2 = v2.c2
      } ;
-}
    AdvSlash slash adv = {
      s  = \\t,a,b => slash.s ! t ! a ! b ++ adv.s ;
      c2 = slash.c2
      } ;

    SlashPrep cl prep = {
      s = \\t,a,p => cl.s ! t ! a ! p ! SDecl ; 
      c2 = prep
      } ;

    SlashVS np vs slash = { 
      s = \\t,a,p => 
        (mkClause (subjForm np vs.sc) np.a 
          (insertExtrapos ("että" ++ slash.s) 
             (predV vs))
        ).s ! t ! a ! p ! SDecl ;
      c2 = slash.c2
      } ;


    EmbedS  s  = {s = "että" ++ s.s} ;
    EmbedQS qs = {s = qs.s} ;
    EmbedVP vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp} ; --- case,pol,agr

    UseCl  t a p cl = {s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! SDecl} ;
    UseQCl t a p cl = {s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p} ;
    UseRCl t a p cl = {
      s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ;
      c = cl.c
      } ;
    UseSlash t a p cl = {
      s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;

}
