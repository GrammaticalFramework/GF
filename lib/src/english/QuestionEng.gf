concrete QuestionEng of Question = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! OQuest ;
              QIndir => "if" ++ cls ! oDir ----
              } ---- "whether" in ExtEng
      } ;

    QuestVP qp vp = 
      let cl = mkClause (qp.s ! npNom) (agrP3 qp.n) vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! oDir} ; ----

    QuestSlash ip slash = 
      {s = \\t,a,b,q => 
         (mkQuestion (ss (ip.s ! NPAcc)) slash).s ! t ! a ! b ! q ++ slash.c2
      } ;
      --- changed AR 5/6/2016: uses stranding; pied-piping in ExtraEng
      
    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! npNom) np.a (predAux auxBe)) ;


    PrepIP p ip = {s = p.s ++ ip.s ! NPAcc} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;
 
    IdetCN idet cn = {
      s = \\c => idet.s ++ cn.s ! idet.n ! npcase2case c ; 
      n = idet.n
      } ;

    IdetIP idet = {
      s = \\c => idet.s ; 
      n = idet.n
      } ;

    IdetQuant idet num = {
      s = idet.s ! num.n ++ num.s ! False ! Nom ; 
      n = num.n
      } ;

    AdvIAdv i a = ss (i.s ++ a.s) ;

    CompIAdv a = a ;
    CompIP p = ss (p.s ! npNom) ;

  lincat 
    QVP = ResEng.VP ;
  lin
    ComplSlashIP vp np = insertObjPre (\\_ => vp.c2 ++ np.s ! NPAcc) vp ;
    AdvQVP vp adv = insertObj (\\_ => adv.s) vp ;
    AddAdvQVP vp adv = insertObj (\\_ => adv.s) vp ;

    QuestQVP qp vp = 
      let cl = mkClause (qp.s ! npNom) (agrP3 qp.n) vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! oDir} ; ----


}
