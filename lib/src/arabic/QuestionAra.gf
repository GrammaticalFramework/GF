concrete QuestionAra of Question = CatAra ** open ResAra, ParamX, Prelude in {

  flags optimize=all_subs ; coding = utf8 ;

  lin

    QuestCl cl = {
      s = \\t,p => 
        table {
          QIndir => "إِذا" ++ cl.s ! t ! p ! Verbal ;
          QDir => cl.s ! t ! p ! Verbal 
        }
      };


-- AR copied from PredVP
    QuestVP qp vp = 
      { s =\\t,p,_ => 
          let {
----            o = Verbal ; ---- AR 
            np = {s = table Case {_ => qp.s} ; a ={pgn = Per3 Masc qp.n ; isPron = False}} ;
            pgn = np.a.pgn ;
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
              }         ;
            
          } in
---          case o of { 
----            _ => 
              case <False, np.a.isPron> of {
---- AR workaround 18/12/2008  case <vp.obj.a.isPron, np.a.isPron> of {
                -- ya2kuluhu
                <False,True> => (vStr t p) ++ vp.obj.s  ++ vp.s2 ++ (pred t p);
                -- ya2kuluhu al-waladu, yakuluhu al-2awlaadu 
                <False,False> => (vStr t p) ++ np.s ! Nom ++ vp.obj.s  ++ vp.s2 ++ (pred t p);
                <True,False>  => (vStr t p) ++ vp.obj.s ++ np.s ! Nom ++ vp.s2 ++ (pred t p);
                <True,True>  => (vStr t p) ++ vp.obj.s ++ vp.s2 ++ (pred t p)
              };
     ----       Nominal =>
     ----         np.s ! Nom ++ (vStr t p) ++ vp.obj.s ++ vp.s2 ++ (pred t p)
         } 
   ; ----  };


--    QuestSlash ip slash = {
--      s = \\t,a,p => 
--            let 
--              cls = slash.s ! t ! a ! p ;
--              who = slash.c2 ++ ip.s ! Acc --- stranding in ExtAra 
--            in table {
--              QDir   => who ++ cls ! OQuest ;
--              QIndir => who ++ cls ! ODir
--              }
--      } ;
--

---- AR guessed
    QuestIAdv iadv cl = {s = \\t,p,_ => iadv.s ++ cl.s ! t ! p ! Verbal} ;

--      s = \\t,a,p => 
--            let 
--              cls = cl.s ! t ! a ! p ;
--              why = iadv.s
--            in table {
--              QDir   => why ++ cls ! OQuest ;
--              QIndir => why ++ cls ! ODir
--              }
--      } ;
--
--    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;
--
--    AdvIP ip adv = {
--      s = \\c => ip.s ! c ++ adv.s ;
--      n = ip.n
--      } ;
-- 

---- AR guesses
    IdetCN idet cn = {
      s = idet.s ! Nom ++ cn.s ! idet.n ! Indef ! Nom ; 
      n = idet.n
      } ;
    IdetQuant idet num = {
      s = \\c => idet.s ++ num.s ! Masc ! Indef ! c; 
      n = ResAra.Sg ---- size of Num
      } ;
--
}
