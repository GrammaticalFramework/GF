
--# -path=.:../abstract:../common:../../prelude


concrete SentenceRus of Sentence = CatRus ** open Prelude, ResRus in {

  flags optimize=all_subs ; coding=utf8 ;

  lin

    PredVP Ya tebyaNeVizhu = { s = \\b,clf =>
       let  { 
          ya = Ya.s ! (case clf of {
              ClInfinit => (mkPronForm Acc No NonPoss); 
               _ => (mkPronForm Nom No NonPoss)
               });
         ne = case b of {Pos=>""; Neg=>"не"};
         vizhu = tebyaNeVizhu.s ! clf ! (pgNum Ya.g Ya.n)! Ya.p;
         tebya = tebyaNeVizhu.s3 ! (pgen2gen Ya.g) ! Ya.n 
       }
       in
       if_then_else Str tebyaNeVizhu.negBefore  
        (ya ++ ne ++ vizhu ++ tebya)
        (ya ++ vizhu ++ ne ++ tebya)
    } ;


    PredSCVP sc vp = { s = \\b,clf => 
       let  { 
         ne = case b of {Pos=>""; Neg=>"не"};
         vizhu = vp.s ! clf ! (ASg Neut)! P3;
         tebya = vp.s3 ! Neut ! Sg 
       }
       in
       if_then_else Str vp.negBefore  
        (sc.s ++ ne ++ vizhu ++ tebya)
        (sc.s ++ vizhu ++ ne ++ tebya)
    } ;

    SlashV2 ivan lubit = { s=\\b,clf => ivan.s ! PF Nom No NonPoss ++ 
         lubit.s! (getActVerbForm clf (pgen2gen ivan.g) ivan.n ivan.p) ;
         s2=lubit.s2; c=lubit.c };

    SlashVVV2 ivan khotet lubit =
   { s=\\b,clf => ivan.s ! PF Nom No NonPoss ++ khotet.s! (getActVerbForm clf (pgen2gen ivan.g) ivan.n ivan.p) ++ lubit.s! VFORM Act VINF ;
    s2=lubit.s2; 
    c=lubit.c                    };

    AdvSlash slash adv = {
      s  = \\b,clf => slash.s ! b ! clf ++ adv.s ;
      c = slash.c;
      s2 = slash.s2;
    } ;

    SlashPrep cl p =  {s=cl.s; s2=p.s; c=p.c} ;     

    ImpVP inf = {s = \\pol, g,n =>          
        let 
          dont  = case pol of {
            Neg => "don't" ;
            _ => []
            }
        in
        dont ++ inf.s ! ClImper ! (gNum g n )!P3++ 
        inf.s2++inf.s3!g!n
    } ;

    EmbedS  s  = {s = "что" ++ s.s} ;
 -- In Russian "Whether you go" transformed in "go whether you":
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = vp.s!ClInfinit!(ASg Masc) !P3} ;

    UseCl  t a p cl = {s = cl.s! p.p ! ClIndic t.t a.a};

    UseQCl t a p qcl= {s = qcl.s!p.p! ClIndic t.t a.a };
    UseRCl t a p rcl ={s = rcl.s! p.p ! ClIndic t.t a.a };

}

