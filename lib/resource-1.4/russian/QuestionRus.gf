--# -path=.:../abstract:../common:../../prelude

concrete QuestionRus of Question = CatRus ** open ResRus, Prelude in {

  flags optimize=all_subs ;

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
       n = ip.n; p=ip.p; g=ip.g; anim=ip.anim; pron=ip.pron 
      } ;

    IdetCN kakoj okhotnik =
    {s = \\pf => case kakoj.c of {
       Nom => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n) ++ 
         okhotnik.s ! kakoj.n ! (extCase pf) ; 
       _ => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n) ++ 
        okhotnik.s ! kakoj.n ! kakoj.c };
     n = kakoj.n ; 
     p = P3 ;
     pron = False;
     g = kakoj.g ;
     anim = okhotnik.anim 
    } ;

{- 
    IDetCN kakoj pyat umeluj okhotnik =
    {s = \\pf => case kakoj.c of {
       Nom => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n) ++ 
         pyat.s! (extCase pf) ! okhotnik.g ++ 
         umeluj.s!AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n)++
         okhotnik.s ! kakoj.n ! (extCase pf) ; 
       _ => 
        kakoj.s ! AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n) ++ 
        pyat.s! (extCase pf) ! okhotnik.g ++ 
        umeluj.s!AF (extCase pf) okhotnik.anim (gNum okhotnik.g kakoj.n)++  
        okhotnik.s ! kakoj.n ! kakoj.c };
     n = kakoj.n ; 
     p = P3 ;
     pron = False;
     g = kakoj.g ;
     anim = okhotnik.anim 
    } ;
-}

    CompIAdv a = a ;
}
