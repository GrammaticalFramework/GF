
--# -path=.:../abstract:../common:../../prelude

concrete VerbRus of Verb = CatRus ** open ResRus, Prelude in {

  flags optimize=all_subs ;  coding=utf8 ;
  lin
  CompNP masha =
 { s=\\clf,gn,p => case clf of 
   {
        (ClIndic Present _) =>  masha.s ! (mkPronForm Nom No NonPoss) ;
        (ClIndic Past _) => case  gn of 
    {   (ASg Fem)  =>"была"++masha.s ! (mkPronForm Inst No NonPoss);
      (ASg Masc)  =>"был" ++ masha.s!(mkPronForm Inst No NonPoss);
     (ASg Neut)  =>"было" ++ masha.s!(mkPronForm Inst No NonPoss);
      APl => "были" ++ masha.s ! (mkPronForm Inst No NonPoss)
   };
    (ClIndic Future _) => case gn of 
   {    APl => case p of
      { P3 => "будут"++masha.s ! (mkPronForm Inst No NonPoss);
        P2 => "будете"++masha.s !(mkPronForm Inst No NonPoss);
        P1 => "будем"++masha.s ! (mkPronForm Inst No NonPoss)
      };
      (ASg _) => case p of
      {  P3=>"будет"++masha.s!(mkPronForm Inst No NonPoss) ;
         P2 => "будешь"++ masha.s ! (mkPronForm Inst No NonPoss) ;
         P1=> "буду"++ masha.s ! (mkPronForm Inst No NonPoss)      
      } --case p
    }; --case gn
      ClCondit => "" ;        
      ClImper  => case (numGNum gn) of 
        {Sg  => "будь" ++ masha.s ! (mkPronForm Inst No NonPoss);
         Pl => "будьте" ++  masha.s ! (mkPronForm Inst No NonPoss) 
       };
       ClInfin => "быть" ++   masha.s ! (mkPronForm Inst No NonPoss)
};  -- case clf     
      asp = Imperfective ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n => ""
   } ;

  CompAP zloj ={
 s= \\clf,gn,p => case clf of { 
-- person is ignored !
       ClInfinit => "быть" ++ zloj.s ! AF Inst Animate (ASg Masc) ; 
        ClImper => case gn of 
          {  (ASg _) => "будь" ++ zloj.s ! AF Inst Animate (ASg Masc);
             APl => "будьте" ++ zloj.s ! AF Inst Animate APl  
          };  
-- infinitive does not save GenNum, 
-- but indicative does for the sake of adjectival predication !
        ClIndic Present _ =>  zloj.s ! AF Nom Animate gn ;
        ClIndic Past _ => case gn of
       { (ASg Fem)   => "была" ++ zloj.s! AF Nom Animate (ASg Fem);
          (ASg Masc)  => "был" ++ zloj.s! AF Nom Animate (ASg Masc);
          (ASg Neut)   => "был" ++ zloj.s! AF Nom Animate (ASg Neut);
           APl => "были" ++ zloj.s! AF Nom Animate APl
       };
       ClIndic Future _ => case gn of 
       { APl => case p of 
          { P3 => "будут" ++ zloj.s! AF Nom Animate APl;
            P2 => "будете" ++ zloj.s! AF Nom Animate APl;
            P1 => "будем" ++ zloj.s! AF Nom Animate APl
          } ;
         (ASg _) => case p of 
         {P3 => "будет" ++ zloj.s! AF Nom Animate (ASg (genGNum gn));
          P2 => "будешь"++ zloj.s! AF Nom Animate (ASg (genGNum gn));
          P1=> "буду" ++ zloj.s! AF Nom Animate (ASg (genGNum gn))
        }
      };
       ClCondit => ""
      } ;        

      asp = Imperfective ;      
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
    } ;


-- Verb phrases can also be formed from adjectives (" молод"),
-- common nouns (" человек"), and noun phrases (" самый молодой").
-- The third rule is overgenerating: " каждый человек" has to be ruled out
-- on semantic grounds.
-- Note: we omit a dash "-" because it will cause problems with negation word order:
-- "Я не - волшебник". Alternatively, we can consider verb-based VP and
-- all the rest.

  CompAdv zloj =
    { s= \\clf,gn,p => case clf of {
        ClImper => case gn of 
     { ASg _ => "будь" ++ zloj.s;    -- person is ignored !
       APl => "будьте" ++ zloj.s
     };
     ClInfinit => "быть" ++ zloj.s;
        ClIndic Present  _ => zloj.s ;
        ClIndic Past _ => case gn of 
       { (ASg Fem)  => "была" ++ zloj.s;
         (ASg Masc) => "был" ++ zloj.s;
          (ASg Neut) => "было" ++ zloj.s;
         APl => "были" ++ zloj.s
       };
        ClIndic Future _ => case gn of 
       { (ASg _) => "будет" ++ zloj.s;
         APl => "будут" ++ zloj.s
        };
        ClCondit => ""
        } ;        
      asp = Imperfective ;
      w = Act;
      s2 = "";
      negBefore = True;
      s3 = \\g,n => ""
    } ;



   UseComp comp = comp ;
   UseVS, UseVQ = \vv -> {s = vv.s ; asp = vv.asp; s2 = [] ; c = Acc} ; 

--    CompAP ap = ap ;
--    CompNP np = {s = \\_ => np.s ! Acc} ;
--    CompAdv a = {s = \\_ => a.s} ;


-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "inte" are not grammatical.

    UseV se = 
    {s=\\clf,gn,p =>  se.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ; 
      asp = se.asp ;
     w=Act;      
    s2 = "";
      negBefore = True;
      s3 = table{_=> table{_ => ""}}
    } ;

-- The rule for using transitive verbs is the complementization rule:
  ComplV2 se tu =
    {s =\\clf,gn,p =>  se.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p)
     ++ se.s2 ++ tu.s ! (mkPronForm se.c No NonPoss) ; 
      asp = se.asp ; 
      w = Act;
      s2 = "";
      s3 = \\g,n => ""; 
      negBefore = True
    } ;

  ComplV3 dat tu pivo =
      let
        tebepivo = dat.s2 ++
         tu.s ! PF dat.c No NonPoss ++ dat.s4 ++ pivo.s ! PF dat.c2 Yes NonPoss 
      in
      {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ++ tebepivo ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
    } ;

  ReflV2 v = 
    { s  = \\clf,gn,p => v.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ++ v.s2 ++ sebya!v.c; 
      asp = v.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
 } ;

-- To generate "сказал, что Иван гуляет" / "не сказал, что Иван гуляет":
  ComplVS   vidit tuUlubaeshsya =
    {s = \\clf,gn,p => vidit.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p)
     ++ [", что"] ++ tuUlubaeshsya.s ;
     asp = vidit.asp;
     w = Act;
     s2="";
      negBefore = True;
      s3 = \\g,n => ""
 } ;
-- To generate "can walk"/"can't walk"; "tries to walk"/"does not try to walk":
-- The contraction of "not" is not provided, since it would require changing
-- the verb parameter type.

  ComplVV putatsya bezhat =
  { s =  \\clf,gn,p => putatsya.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p)  ++ bezhat.s!clf!gn!p ; 
      asp = putatsya.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 =\\g,n => ""
  } ;
  ComplVQ dat esliOnPridet =
       {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ++ esliOnPridet.s ! QDir ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
    } ;
  ComplVA vuglyadet molodoj =
      {s  = \\clf,gn,p => vuglyadet.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ; 
      asp = vuglyadet.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n => molodoj.s!(AF Inst Animate (gNum g n))  
    } ;

  ComplV2A  obechat tu molodoj =
         {s  = \\clf,gn,p => obechat.s2++obechat.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ++  tu.s ! PF obechat.c No NonPoss ++molodoj.s!AF Inst tu.anim (pgNum tu.g tu.n) ; 
      asp = obechat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n =>""
    } ;
  AdvVP poet khorosho =
    {s = \\clf,gn,p => poet.s ! clf!gn!p; s2 = poet.s2 ++ khorosho.s; s3 = poet.s3;
     asp = poet.asp; w = poet.w; t = poet.t ; negBefore = poet.negBefore } ;

  AdVVP khorosho poet =
    {s = \\clf,gn,p => poet.s ! clf!gn!p; s2 = poet.s2 ++ khorosho.s; s3 = poet.s3;
     asp = poet.asp; w = poet.w; t = poet.t ; negBefore = poet.negBefore } ;

PassV2  se =
    {s=\\clf,gn,p =>  se.s ! (getActVerbForm clf (genGNum gn) (numGNum gn) p) ; 
    asp=se.asp; w=Pass;      s2 = se.s2;
      negBefore = True;
      s3 = table{_=> table{_ => ""}}
};

}

