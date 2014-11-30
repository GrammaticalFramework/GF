incomplete concrete SentenceRomance of Sentence = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;
    coding=utf8 ;

  lin
    PredVP np vp = mkClausePol np.isNeg (np.s ! Nom).comp np.hasClit np.isPol np.a vp ;

    PredSCVP sc vp = mkClause (sc.s ! Nom) False False (agrP3 Masc Sg) vp ;

    ImpVP vp = {
      s = \\p,i,g => case i of {
        ImpF n b => mkImperative b P2 vp ! p ! g ! n ---- AgPol ?
        }
      } ;

{-
    SlashVP np vps = 
      -- agreement decided afterwards: la fille qu'il a trouvée
      {s = \\agr => 
          let 
            vp = case <vps.c2.c, vps.c2.isDir> of {
              <Acc,True> => insertAgr agr vps ;                         -- la fille qu'il a trouvée decided here
              _ => vps
              }
          in (mkClausePol np.isNeg (np.s ! Nom).comp np.hasClit np.isPol np.a vp).s ;  -- à qui montre-t-il sa maison 
       c2 = vps.c2                                                                      -- np.hasClit decides inversion
      } ;
-}

--- inlined mkClausePol to make compilation possible AR 21/11/2013
---- one shortcut left: polarity change from negative elements ("rien" etc) ignored
---- thus we get "la fille que personne ne voit pas"

    SlashVP np vps = 
      let
          isNeg = np.isNeg ;
          subj = (np.s ! Nom).comp ;
          hasClit = np.hasClit ;
          isPol = np.isPol ;
          agr = np.a ;

      in {

      c2 = vps.c2 ;

      s = \\agr0,d,te,a,b,m => 
        let

          vp : ResRomance.VP = case <vps.c2.c, vps.c2.isDir> of {
              <Acc,True> => insertAgr agr0 vps ;    -- la fille qu'il a trouvée is decided here
              _ => vps
              } ;

{- slow to compile
          pol : RPolarity = case <isNeg, vp.isNeg, b, d> of {
            <_,True,RPos,_>    => RNeg True ; 
            <True,_,RPos,DInv> => RNeg True ; 
            <True,_,RPos,_>    => polNegDirSubj ;
            _ => b
            } ;
-} --pol = b ; ----

          neg = vp.neg ! b ;

{- also too slow
          neg : Str * Str = case b of {
            RNeg _ => vp.neg ! b ;
            RPos => case vp.isNeg of {
              True  => vp.neg ! RNeg True ; 
              False => case isNeg of {
                True => case d of {
                   DInv => vp.neg ! RNeg True ;
                   _    => vp.neg ! polNegDirSubj
                   } ;
                False => vp.neg ! b
                }
              }
            } ;
-}

          gen = agr.g ;
          num = agr.n ;
          per = agr.p ;

          vtyp  = vp.s.vtyp ;
          verb = vp.s.s ;
          vaux = auxVerb vp.s.vtyp ;

          refl  = case isVRefl vtyp of {
            True => reflPron num per Acc ; ---- case ?
            _ => [] 
            } ;

          clit = refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3.s ; ---- refl first?


          compl = case isPol of {
            True => vp.comp ! {g = gen ; n = Sg ; p = per} ;
            _ => vp.comp ! agr
            } ;

          ext = vp.ext ! b ;

---- VPAgr : this is where it really matters
          part = case vp.agr.p2 of {
            False => vp.agr.p1 ;
            True => verb ! VPart agr.g agr.n
            } ;
----          part = case vp.agr of {
----            VPAgrSubj     => verb ! VPart agr.g agr.n ;
----            VPAgrClit g n => verb ! VPart g n  
----            } ;

          vpss : Str * Str = case <te,a> of {

            <RPast,Simul> => <verb ! VFin (VImperf m) num per, []> ; --# notpresent
            <RPast,Anter> => <vaux ! VFin (VImperf m) num per, part> ; --# notpresent
            <RFut,Simul>  => <verb ! VFin (VFut) num per, []> ; --# notpresent
            <RFut,Anter>  => <vaux ! VFin (VFut) num per, part> ; --# notpresent
            <RCond,Simul> => <verb ! VFin (VCondit) num per, []> ; --# notpresent
            <RCond,Anter> => <vaux ! VFin (VCondit) num per, part> ; --# notpresent
            <RPasse,Simul> => <verb ! VFin (VPasse) num per, []> ; --# notpresent
            <RPasse,Anter> => <vaux ! VFin (VPasse) num per, part> ; --# notpresent
            <RPres,Anter> => <vaux ! VFin (VPres m) num per, part> ; --# notpresent
            <RPres,Simul> => <verb ! VFin (VPres m) num per, []> 
            } ;
          fin = vpss.p1 ;
          inf = vpss.p2 ;
          hypt = verbHyphen vp.s ; -- in French, -t- in some cases, otherwise - ; empty in other langs
        in

        case d of {
          DDir => 
            subj ++ neg.p1 ++ clit ++ fin ++ neg.p2 ++ inf ++ compl ++ ext ;
          DInv => 
            invertedClause vp.s.vtyp <te, a, num, per> hasClit neg hypt clit fin inf compl subj ext
          }
    } ;



    AdvSlash slash adv = {
      s  = \\ag,d,t,a,b,m => slash.s ! ag ! d ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;

    SlashPrep cl prep = {
      s  = \\_ => cl.s ; 
      c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;

    SlashVS np vs slash = 
      {s = \\ag =>
        (mkClausePol np.isNeg
          (np.s ! Nom).comp False np.isPol np.a
          (insertExtrapos (\\b => conjThat ++ slash.s ! ag ! (vs.m ! b))
            (predV vs))
        ).s ;
       c2 = slash.c2
      } ;

    EmbedS  s  = {s = \\_ => conjThat ++ s.s ! Indic} ; --- mood
    EmbedQS qs = {s = \\_ => qs.s ! QIndir} ;
    EmbedVP vp = {s = \\c => prepCase c ++ infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t p cl = {
      s = \\o => t.s ++ p.s ++ cl.s ! DDir ! t.t ! t.a ! p.p ! o
    } ;
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
    } ;
    UseRCl t p cl = {
      s = \\r,ag => t.s ++ p.s ++ cl.s ! ag ! t.t ! t.a ! p.p ! r ; 
      c = cl.c
      } ;
    UseSlash t p cl = {
      s = \\ag,mo => 
          t.s ++ p.s ++ cl.s ! ag ! DDir ! t.t ! t.a ! p.p ! mo ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! o} ;
    ExtAdvS a s = {s = \\o => a.s ++ "," ++ s.s ! o} ;

    SSubjS a s b = {s = \\m => a.s ! m ++ s.s ++ b.s ! s.m} ;

    RelS s r = {
      s = \\o => s.s ! o ++ "," ++ partQIndir ++ r.s ! Indic ! agrP3 Masc Sg
      } ;

}
