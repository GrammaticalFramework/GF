--# -path=.:abstract:common:prelude

concrete SentenceAra of Sentence = CatAra ** open 
  ResAra,
  Prelude, 
  ResAra,
  ParamX,
  CommonX in {


  flags optimize=all_subs ; coding=utf8 ;
        
  lin
{-
    PredVP np vp = 
      { s = \\t,p,o => 
          case o of { 
            Verbal => 
              case vp.comp.a.isPron of {
                False => vp.s ! t ! p ! Verbal ! np.a ++ np.s ! Nom ++ vp.comp.s ! Acc ;
                True  => vp.s ! t ! p ! Verbal ! np.a ++ vp.comp.s ! Acc ++ np.s ! Nom  
              };
            Nominal =>
              np.s ! Nom ++ vp.s ! t ! p ! Nominal ! np.a ++ vp.comp.s ! Acc 
          }
      };
-}
    PredVP np vp =
      { s =\\t,p,o => 
          let {
            pgn = 
              case <o,np.a.isPron> of {
                <Verbal, False> => verbalAgr np.a.pgn;
                _               => np.a.pgn
              };
            gn = pgn2gn pgn;
            kataba  = vp.s ! pgn ! VPPerf ;
            yaktubu = vp.s ! pgn ! VPImpf Ind ;
            yaktuba = vp.s ! pgn ! VPImpf Cnj ;
            yaktub  = vp.s ! pgn ! VPImpf Jus ;
            vStr : ResAra.Tense -> Polarity -> Str = 
              \tn,pl -> case<vp.isPred,tn,pl> of {
              <False, ResAra.Pres, Pos> => yaktubu ;
              <False, ResAra.Pres, Neg> => "لَا" ++ yaktubu ;
              <True, ResAra.Pres, Pos> => "" ;      --no verb "to be" in present 
              <True, ResAra.Pres, Neg> => "لَيسَ" ;--same here, just add negation particle
              <_, ResAra.Past, Pos> => kataba ;
              <_, ResAra.Past, Neg> => "لَمْ" ++ yaktub ;
              <_, ResAra.Fut,  Pos> => "سَ" ++ yaktubu ; 
              <_, ResAra.Fut,  Neg> => "لَنْ" ++ yaktuba 
              };
            pred : ResAra.Tense -> Polarity -> Str = 
              \tn,pl -> case <vp.isPred,tn,pl>  of {
              <True, ResAra.Pres, Pos> => vp.pred.s ! gn ! Nom; --xabar marfooc
              _ => vp.pred.s ! gn ! Acc --xabar kaana wa laysa manSoob
              };
            
          } in
          case o of { 
            Verbal => 
              case <False, np.a.isPron> of {
---- AR workaround 18/12/2008              case <vp.obj.a.isPron, np.a.isPron> of {
                -- ya2kuluhu
                <False,True> => (vStr t p) ++ vp.obj.s  ++ vp.s2 ++ (pred t p);
                -- ya2kuluhu al-waladu, yakuluhu al-2awlaadu 
                <False,False> => (vStr t p) ++ np.s ! Nom ++ vp.obj.s  ++ vp.s2 ++ (pred t p);
                <True,False>  => (vStr t p) ++ vp.obj.s ++ np.s ! Nom ++ vp.s2 ++ (pred t p);
                <True,True>  => (vStr t p) ++ vp.obj.s ++ vp.s2 ++ (pred t p)
              };
            Nominal =>
              np.s ! Nom ++ (vStr t p) ++ vp.obj.s ++ vp.s2 ++ (pred t p)
          } 
      };
    --    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

--    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = {
      s = \\p,g,n =>
        case p of {
          Pos => vp.s ! (Per2 g n) ! VPImp  ++ vp.obj.s  ++ vp.s2 ;
          Neg => "لا" ++ vp.s ! (Per2 g n) ! (VPImpf Jus) ++ vp.obj.s ++ vp.s2
        }
      };

--
--    SlashV2 np v2 = 
--      mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2} ;
--
--    SlashVVV2 np vv v2 = 
--      mkClause (np.s ! Nom) np.a 
--        (insertObj (\\a => infVP vv.isAux (predV v2) a) (predVV vv))  **
--        {c2 = v2.c2} ;
--
--    AdvSlash slash adv = {
--      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
--      c2 = slash.c2
--    } ;
--
--    SlashPrep cl prep = cl ** {c2 = prep.s} ;
--
--    EmbedS  s  = {s = conjThat ++ s.s} ;
--    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP False vp (agrP3 Sg)} ; --- agr
--

    --FIXME, all tenses
    UseCl  t ap cl = 
      {s =  cl.s ! ResAra.Pres ! ap.p ! Verbal 
{-         case t of {
           TPres => cl.s ! ResAra.Pres ! p.p ! Verbal ;
           TCond => cl.s ! ResAra.Pres ! p.p ! Verbal ;
           TPast => cl.s ! ResAra.Past ! p.p ! Verbal ;
           TFut => cl.s ! ResAra.Fut ! p.p ! Verbal 
         } 
-}      };

    --FIXME, all tenses
    UseQCl t ap qcl = --{s = cl.s ! t ! p ! Verbal } ;
      {s = 
         table {
           QDir => "هَل" ++ qcl.s ! ResAra.Pres ! ap.p ! QDir;
           QIndir =>  qcl.s ! ResAra.Pres ! ap.p ! QIndir
         }
{-         case t of {
           TPres => "هَل" ++ qcl.s ! ResAra.Pres ! p.p ! q ;
           TCond => "هَل" ++ qcl.s ! ResAra.Pres ! p.p ! q ;
           TPast => "هَل" ++ qcl.s ! ResAra.Past ! p.p ! q ;
           TFut  => "هَل" ++ qcl.s ! ResAra.Fut ! p.p ! q 
         } 
-}      };

--    UseRCl t a p cl = {s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r} ;

}
