--# -path=.:../abstract:../common:../prelude

concrete QuestionMon of Question = CatMon ** open ResMon, (P=ParadigmsMon), Prelude in {

 flags optimize=all_subs ; coding=utf8 ;

lin
 QuestCl cl = {
    s = \\t,ant,pol =>
    let
     cls = cl.s ! t ! ant ! pol 
    in 
    table {
        QDir => cls ! (Quest yesNoQuest) ;
        QIndir => cls ! (Quest yesNoQuest) ++ "гэж"
        } 
    } ;
     
 QuestVP ip vp = 
    let 
     cl = mkClause ip.s Sg vp.vt Nom vp 
    in {
    s = \\t,ant,pol,_ => cl.s ! t ! ant ! pol ! Quest wQuest
    } ; 
    
 QuestSlash ip slash = {
    s = \\t,ant,pol,_ => 
      slash.c2.s ++ ip.s ! slash.c2.rc ++ slash.s ! t ! ant ! pol ! Quest wQuest
    } ;
 
 QuestIAdv iadv cl = {
    s = \\t,ant,pol,_ => 
    let 
     cls = cl.s ! t ! ant ! pol ! Quest wQuest ;
     wh = iadv.s 
    in 
    wh ++ cls  
    } ;
    
 QuestIComp icomp np = {
    s = \\t,ant,pol,_ => 
    let
     vp = predV (P.auxToVerb P.auxBe) ;    
     cls = (mkClause np.s np.n vp.vt Nom vp).s ! t ! ant ! pol ! Quest wQuest
    in 
    icomp.s ++ cls 
    } ;
    
 PrepIP p ip = {
    s = appCompl p ip.s
    } ;

 AdvIP ip adv = {
    s = \\rc => adv.s ++ ip.s ! rc 
    } ;

 AdvIAdv iadv adv = {
    s = iadv.s ++ adv.s
    } ;   
   
 IdetCN idet cn = {
    s = \\rc => idet.s ! Nom ++ cn.s ! Sg ! toNCase rc Definite
    } ; 
 
 IdetIP idet = {
    s = \\rc => idet.s ! rc 
    } ;

 IdetQuant iquant num = { 
    s = \\rc => iquant.s ! Nom ++ num.sp ! rc ;
    n = num.n
    } ;
   
 CompIAdv a = a ;
 
 CompIP ip = {
    s = ip.s ! Nom
    } ;
  
lincat 
 QVP = ResMon.VerbPhrase ;     

lin 
 ComplSlashIP vp ip = insertObj (\\_ => vp.c2.s ++ ip.s ! Acc) vp ; 
 
 AdvQVP vp adv = insertObjPost (\\_ => adv.s) vp ; 

 AddAdvQVP vp adv = insertObjPost (\\_ => adv.s) vp ;  

 QuestQVP ip vp = {
    s = \\t,ant,pol,_ => (mkClause ip.s Sg vp.vt Nom vp).s ! t ! ant ! pol ! Quest yesNoQuest
    } ; 

}
