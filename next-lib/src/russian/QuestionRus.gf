--# -path=.:../abstract:../common:../../prelude

concrete QuestionRus of Question = CatRus ** open ResRus, Prelude in {

  flags optimize=all_subs ; coding=utf8 ;

  lin

    QuestCl cl = {s = \\b,cf,_ => cl.s ! b ! cf  } ; 

    QuestVP kto spit =
    {s = \\b,clf,qf  => (predVerbPhrase kto spit).s!b!clf  } ;

    QuestSlash Kto yaGovoruO =
    let {  kom = Kto.s ! (mkPronForm yaGovoruO.c No NonPoss) ; o = yaGovoruO.s2 } in 
    {s =  \\b,clf,_ => o ++ kom ++ yaGovoruO.s ! b ! clf  
    } ;

    QuestIAdv kak tuPozhivaesh =
    {s = \\b,clf,q => kak.s ++ tuPozhivaesh.s!b!clf } ; 
 
    QuestIComp kak tuPozhivaesh =
    {s = \\b,clf,q => let ne = case b of {Neg => ""; Pos => []}
     in 
     kak.s ++ ne ++tuPozhivaesh.s! PF Nom No NonPoss } ; 


    PrepIP p ip = {s = p.s ++ ip.s ! PF Nom No NonPoss} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
       a = ip.a; anim=ip.anim
      } ;

    IdetCN kakoj okhotnik =
    {s = \\pf => case kakoj.c of {
       Nom => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gennum okhotnik.g kakoj.n) ++ 
         okhotnik.s ! NF kakoj.n (extCase pf) ; 
       _ => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gennum okhotnik.g kakoj.n) ++ 
        okhotnik.s ! NF kakoj.n kakoj.c };
     a = agrP3 kakoj.n kakoj.g ; 
     anim = okhotnik.anim 
    } ;

-- 1.4 additions 17/6/2008 by AR

    IdetIP kakoj = let anim = Inanimate in
    {s = \\pf => kakoj.s ! AF (extCase pf) anim (pgNum kakoj.g kakoj.n) ;
     a = agrP3 kakoj.n kakoj.g ; 
     anim = anim 
    } ;
 
    IdetQuant kakoj pyat = -- okhotnik =
    {s = \\af => 
           kakoj.s ! pyat.n ! af ++
           pyat.s ! caseAF af ! genAF af ;
     n = pyat.n ;
     g = kakoj.g ;
     c = kakoj.c 
    } ;

    CompIAdv a = a ;
    CompIP ip = {s = ip.s ! PF Nom No NonPoss} ;
}
