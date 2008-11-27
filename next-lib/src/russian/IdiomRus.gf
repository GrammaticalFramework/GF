--# -path=.:../abstract:../common:../../prelude

concrete IdiomRus of Idiom = CatRus ** open Prelude, ResRus, MorphoRus in {

  flags optimize=all_subs ;  coding=utf8 ;

  lin
    ExistNP = \bar ->
    {s =\\b,clf => case b of 
        {Pos =>  verbSuchestvovat.s ! (getActVerbForm clf (pgen2gen bar.a.g) Sg P3) 
           ++ bar.s ! PF Nom No NonPoss;
        Neg => "не" ++ verbSuchestvovat.s ! (getActVerbForm clf (pgen2gen bar.a.g) Sg P3) 
           ++ bar.s ! PF Nom No NonPoss
       }
} ;

    ExistIP Kto =
    let {  kto = Kto.s ! (PF Nom No NonPoss) } in 
       {s =  \\b,clf,_ => case b of 
        {Pos =>  kto ++ verbSuchestvovat.s ! (getActVerbForm clf (pgen2gen Kto.a.g) Sg P3) ;
        Neg => kto ++ "не" ++ verbSuchestvovat.s ! (getActVerbForm clf (pgen2gen Kto.a.g) Sg P3) 
       }
    } ;

    CleftAdv adv sen = {s= \\ b, clf =>  let ne= case b of {Pos =>[]; Neg =>"не"}
      in 
      "это" ++ ne ++ adv.s  ++ [", "]++ sen.s }; 

    CleftNP np rs = {s= \\ b, clf =>  
       let 
         ne= case b of {Pos =>[]; Neg =>"не"};
         gn = case np.a.n of {Pl => GPl; _=> GSg (pgen2gen np.a.g)}
      in 
      "это" ++ ne ++ np.s ! (PF Nom No NonPoss)  ++ 
        rs.s ! gn !Nom!Animate  }; 

    ImpPl1 vp = {s= "давайте" ++ vp.s! (ClIndic Future Simul)! GPl ! P1}; 

    ImpersCl vp = {s= \\ b, clf =>  let ne= case b of {Pos =>[]; Neg =>"не"}
      in 
      ne ++ vp.s! clf! (GSg Neut) ! P3  }; 

-- No direct correspondance in Russian. Usually expressed by infinitive:
-- "Если очень захотеть, можно в космос улететь" 
-- (If one really wants one can fly into the space).
-- Note that the modal verb "can" is trasferred into adverb 
-- "можно" (it is possible) in Russian
-- The closest subject is "ты" (you), which is omitted in the final sentence:
-- "Если очень захочешь, можешь в космос улететь"

    GenericCl vp = {s= \\ b, clf =>  let ne= case b of {Pos =>[]; Neg =>"не"}
      in 
      "ты" ++ ne ++ vp.s! clf! (GSg Masc) ! P2  }; 

    ProgrVP vp = vp ;

}

