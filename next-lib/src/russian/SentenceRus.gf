
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
         khorosho = tebyaNeVizhu.s2 ;
         tebya = tebyaNeVizhu.s3 ! (pgen2gen Ya.g) ! Ya.n 
       }
       in
       if_then_else Str tebyaNeVizhu.negBefore  
        (ya ++ ne ++ vizhu ++ tebya ++ khorosho)
        (ya ++ vizhu ++ ne ++ tebya ++ khorosho)
    } ;


    PredSCVP sc vp = { s = \\b,clf => 
       let  { 
         ne = case b of {Pos=>""; Neg=>"не"};
         vizhu = vp.s ! clf ! (GSg Neut)! P3;
         tebya = vp.s3 ! Neut ! Sg 
       }
       in
       if_then_else Str vp.negBefore  
        (sc.s ++ ne ++ vizhu ++ tebya)
        (sc.s ++ vizhu ++ ne ++ tebya)
    } ;


    ---- AR 17/12/2008
    SlashVP Ya tebyaNeVizhu = { 
      s = \\b,clf =>
       let  { 
          ya = Ya.s ! (case clf of {
              ClInfinit => (mkPronForm Acc No NonPoss); 
               _ => (mkPronForm Nom No NonPoss)
               });
         ne = case b of {Pos=>""; Neg=>"не"};
         vizhu = tebyaNeVizhu.s ! clf ! (pgNum Ya.g Ya.n)! Ya.p;
         khorosho = tebyaNeVizhu.s2 ;
         tebya = tebyaNeVizhu.s3 ! (pgen2gen Ya.g) ! Ya.n 
       }
       in
       if_then_else Str tebyaNeVizhu.negBefore  
        (ya ++ ne ++ vizhu ++ tebya ++ khorosho)
        (ya ++ vizhu ++ ne ++ tebya ++ khorosho) ;
      s2=tebyaNeVizhu.s2 ; 
      c=tebyaNeVizhu.c 
    } ;

    AdvSlash slash adv = {
      s  = \\b,clf => slash.s ! b ! clf ++ adv.s ;
      c = slash.c;
      s2 = slash.s2;
    } ;

    SlashPrep cl p =  {s=cl.s; s2=p.s; c=p.c} ;     

    --- AR 3/11/2007
    SlashVS ivan vidit tuUlubaeshsya = { 
      s=\\b,clf => ivan.s ! PF Nom No NonPoss ++ 
         vidit.s! (getActVerbForm clf (pgen2gen ivan.g) ivan.n ivan.p) ++
         [", что"] ++ tuUlubaeshsya.s ;
      s2=tuUlubaeshsya.s2; 
      c=tuUlubaeshsya.c 
    } ;



    ImpVP inf = {s = \\pol, g,n =>          
        let 
          dont  = case pol of {
            Neg => "не" ;
            _ => []
            }
        in
        dont ++ inf.s ! ClImper ! gennum g n ! P2 ++ 
        inf.s2++inf.s3!g!n
    } ;

    EmbedS  s  = {s = "что" ++ s.s} ;
 -- In Russian "Whether you go" transformed in "go whether you":
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = vp.s2  ++ vp.s!ClInfinit!(GSg Masc) !P3 ++ vp.s3!Masc!Sg} ;

    UseCl t p cl = {s = case t.t of { 
      Cond => cl.s! p.p ! ClCondit ; --# notpresent
      Pres => cl.s! p.p ! ClIndic Present t.a   ---- AR work-around 13/12/2007
        ; --# notpresent
      _ => cl.s! p.p ! ClIndic (getTense t.t) t.a --# notpresent
      }
    };

    UseQCl t p qcl= {s = case t.t of { 
      Cond => qcl.s! p.p ! ClCondit ; --# notpresent
      Pres => qcl.s! p.p ! ClIndic Present t.a 
       ; --# notpresent
      _ => qcl.s!p.p! ClIndic (getTense t.t) t.a --# notpresent
      }};

    UseRCl t p rcl ={s = \\gn,c,anim => case t.t of { 
      Cond => [", "] ++ rcl.s! p.p ! ClCondit ! gn !c !anim ; --# notpresent
      Pres => [", "] ++ rcl.s! p.p ! ClIndic Present t.a !gn !c !anim
      ; --# notpresent
      _ => [", "] ++ rcl.s! p.p ! ClIndic (getTense t.t) t.a !gn !c !anim --# notpresent
      }};

    UseSlash  t p cl = {
      s = case t.t of { 
        Cond => cl.s! p.p ! ClCondit ; --# notpresent
        Pres => cl.s! p.p ! ClIndic Present t.a 
        ; --# notpresent
        _ => cl.s! p.p ! ClIndic (getTense t.t) t.a --# notpresent
        } ;
      s2 = cl.s2 ;
      c = cl.c
    };


    AdvS a s = {s = a.s ++ "," ++ s.s} ; ---- AR 19/6/2007

    ---- AR 17/12/2008
    RelS s r = {s = s.s ++ "," ++ r.s ! gennum Neut Sg ! Nom ! Inanimate} ; ---- ?

}

