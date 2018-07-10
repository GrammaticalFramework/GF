--# -coding=cp1251
concrete VerbBul of Verb = CatBul ** open Prelude, ResBul, ParadigmsBul in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = slashV v v.c2 False ;

    Slash2V3 v np =
      let arg : {obj,clitics : Str}
              = case <v.c2.c,np.p> of {
                  <c,  NounP3 _> => {obj=np.s ! RObj c; clitics=[];            } ;
                  <Acc,_       > => {obj=[];            clitics=np.s ! RObj Acc} ;
                  <Dat,_       > => {obj=[];            clitics=np.s ! RObj Dat} ;
                  <c,  _       > => {obj=np.s ! RObj c; clitics=[];            }
                }
      in insertSlashObj1 (\\_ => v.c2.s ++ arg.obj) (personPol np.p) (slashV v v.c3 False)
            ** {clitics = arg.clitics};

    Slash3V3 v np = 
      let arg : {obj,clitics : Str}
              = case <v.c3.c,np.p> of {
                  <c,  NounP3 _> => {obj=np.s ! RObj c; clitics=[];            } ;
                  <Acc,_       > => {obj=[];            clitics=np.s ! RObj Acc} ;
                  <Dat,_       > => {obj=[];            clitics=np.s ! RObj Dat} ;
                  <c,  _       > => {obj=np.s ! RObj c; clitics=[];            }
                }
      in insertSlashObj2 (\\_ => v.c3.s ++ arg.obj) (personPol np.p) (slashV v v.c2 False)
            ** {clitics = arg.clitics};

    ComplVV vv vp =
      insertObj (case vv.typ of {
                   VVInf asp => daComplex Simul vp.p vp ! asp;
                   VVGerund  => gerund vp ! Imperf
                 }) vp.p
                (predV vv) ;

    ComplVS v s  = insertObj (\\_ => bindComma ++ "��" ++ s.s) Pos (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QDir) Pos (predV v) ;

    ComplVA v ap = 
      insertObj (\\agr => ap.s ! aform agr.gn Indef (RObj Acc) ! agr.p) Pos (predV v) ;


    SlashV2A v ap = 
      insertSlashObj2 (\\a => v.c3.s ++ ap.s ! aform a.gn Indef (RObj Acc) ! a.p) Pos (slashV v v.c2 v.subjCtrl) ;

    -- test: I saw a boy to whom she said that they are here
    SlashV2S v s  = insertSlashObj2 (\\_ => bindComma ++ "��" ++ s.s) Pos (slashV v v.c2 False) ;

    -- test: I saw a boy whom she asked who is here
    SlashV2Q v q  = insertSlashObj2 (\\_ => q.s ! QDir) Pos (slashV v v.c2 False) ;

    -- test: I saw a boy whom she begged to walk 
    SlashV2V vv vp =
      insertSlashObj2 (\\agr => vv.c3.s ++ daComplex Simul vp.p vp ! Perf ! agr) Pos (slashV vv vv.c2 vv.subjCtrl) ;

    -- test: I saw a car whom she wanted to buy
    SlashVV vv slash = {
      s = vv.s ;
      ad = {isEmpty=True; s=[]};
      clitics = [] ;
      compl1 = daComplex Simul Pos {s=slash.s; ad=slash.ad; clitics=slash.clitics; compl=slash.compl1; vtype=slash.vtype; p = Pos; isSimple = slash.isSimple} ! Perf ;
      compl2 = slash.compl2 ;
      vtype  = vv.vtype ;
      p  = slash.p ;
      c2 = slash.c2 ;
      isSimple = False ;
      subjCtrl = slash.subjCtrl
      } ;

    -- test: I saw a car whom she begged me to buy
    SlashV2VNP vv np slash = {
      s = vv.s ;
      ad = {isEmpty=True; s=[]};
      clitics = [] ;
      compl1 = \\agr => vv.c2.s ++ np.s ! RObj vv.c2.c ++ 
                        daComplex Simul (personPol np.p) {s=slash.s; ad=slash.ad; clitics=slash.clitics; compl=slash.compl1; vtype=slash.vtype; p=Pos; isSimple = slash.isSimple} ! Perf ! (personAgr np.gn np.p) ;
      compl2 = slash.compl2 ;
      vtype = vv.vtype ;
      p  = Pos ;
      c2 = slash.c2 ;
      isSimple = False ;
      subjCtrl = slash.subjCtrl
      } ;

    ComplSlash slash np = 
      let arg : {obj,acc,dat : Str}
              = case <slash.c2.c,np.p> of {
                  <c,  NounP3 _> => {obj=np.s ! RObj c; acc=[];              dat=[]             } ;
                  <Acc,_       > => {obj=[];            acc=np.s ! RObj Acc; dat=[]             } ;
                  <Dat,_       > => {obj=[];            acc=[];              dat=np.s ! RObj Dat} ;
                  <c,  _       > => {obj=np.s ! RObj c; acc=[];              dat=[]             }
                }
      in {s   = slash.s ;
          ad  = slash.ad ;
          clitics = arg.dat++slash.clitics++arg.acc ;
          compl = \\a => let a2 = case slash.subjCtrl of {True => a; False => personAgr np.gn np.p}
                         in slash.compl1 ! a ++ slash.c2.s ++ arg.obj ++ slash.compl2 ! a2 ;
          vtype = slash.vtype ;
          p   = orPol (personPol np.p) slash.p ;
          isSimple = False
         } ;

    UseComp comp = insertObj comp.s comp.p (predV verbBe) ;

    UseCopula = predV verbBe ;

    AdvVP vp adv = insertObj (\\_ => adv.s) Pos vp ;
    ExtAdvVP vp adv = insertObj (\\_ => embedInCommas adv.s) Pos vp ;

    AdvVPSlash vp adv = insertSlashObj1 (\\_ => adv.s) Pos vp ;

    AdVVP adv vp = {
      s   = vp.s ;
      ad  = {isEmpty=False; s=vp.ad.s ++ adv.s} ;
      clitics = vp.clitics ;
      compl = vp.compl ;
      vtype = vp.vtype ;
      p = orPol adv.p vp.p ;
      isSimple = vp.isSimple
      } ;
    AdVVPSlash adv vp = {
      s   = vp.s ;
      ad  = {isEmpty=False; s=vp.ad.s ++ adv.s} ;
      clitics = vp.clitics ;
      compl1 = vp.compl1 ;
      compl2 = vp.compl2 ;
      vtype = vp.vtype ;
      p = vp.p ;
      c2 = vp.c2 ;
      isSimple = vp.isSimple ;
      subjCtrl = vp.subjCtrl
      } ;

    ReflVP slash = {
      s = slash.s ;
      ad = slash.ad ;
      clitics = slash.clitics ;
      compl = \\agr => slash.compl1 ! agr ++ slash.compl2 ! agr ;
      vtype = VMedial slash.c2.c ;
      p = slash.p ;
      isSimple = slash.isSimple
      } ;

    PassV2 v = insertObj (\\a => v.s ! Perf ! VPassive (aform a.gn Indef (RObj Acc))) Pos (predV verbBe) ;

    CompAP ap = {s = \\agr => ap.s ! aform agr.gn Indef (RObj Acc) ! agr.p; p = Pos} ;
    CompNP np = {s = \\_ => np.s ! RObj CPrep; p = personPol np.p} ;
    CompAdv a = {s = \\_ => a.s; p = Pos} ;
    CompCN cn = {s = \\agr => cn.s ! (NF (numGenNum agr.gn) Indef); p = Pos} ;

    VPSlashPrep vp prep = vp ** {c2 = prep ; compl1 = vp.compl ; compl2 = \\_ => []; subjCtrl = False} ;

}
