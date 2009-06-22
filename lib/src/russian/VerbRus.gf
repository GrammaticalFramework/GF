
--# -path=.:../abstract:../common:../../prelude

concrete VerbRus of Verb = CatRus ** open ResRus, Prelude in {

-- 1.4 additions by AR 17/6/2008

  flags optimize=all_subs ;  coding=utf8 ;
  lin
  CompNP masha =
 { s=\\clf,gn,p => case clf of 
   {
        (ClIndic Present _) =>  masha.s ! (mkPronForm Nom No NonPoss) ;
        (ClIndic PastRus _) => case  gn of 
    {   (GSg Fem)  =>"была"++masha.s ! (mkPronForm Inst No NonPoss);
      (GSg Masc)  =>"был" ++ masha.s!(mkPronForm Inst No NonPoss);
     (GSg Neut)  =>"было" ++ masha.s!(mkPronForm Inst No NonPoss);
      GPl => "были" ++ masha.s ! (mkPronForm Inst No NonPoss)
   };
    (ClIndic Future _) => case gn of 
   {    GPl => case p of
      { P3 => "будут"++masha.s ! (mkPronForm Inst No NonPoss);
        P2 => "будете"++masha.s !(mkPronForm Inst No NonPoss);
        P1 => "будем"++masha.s ! (mkPronForm Inst No NonPoss)
      };
      (GSg _) => case p of
      {  P3=>"будет"++masha.s!(mkPronForm Inst No NonPoss) ;
         P2 => "будешь"++ masha.s ! (mkPronForm Inst No NonPoss) ;
         P1=> "буду"++ masha.s ! (mkPronForm Inst No NonPoss)      
      } --case p
    }; --case gn
      ClCondit => "" ;        
      ClImper  => case (numGenNum gn) of 
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
       ClInfinit => "быть" ++ zloj.s ! AF Inst Animate (GSg Masc) ; 
        ClImper => case gn of 
          {  (GSg _) => "будь" ++ zloj.s ! AF Inst Animate (GSg Masc);
             GPl => "будьте" ++ zloj.s ! AF Inst Animate GPl  
          };  
-- infinitive does not save GenNum, 
-- but indicative does for the sake of adjectival predication !
        ClIndic Present _ =>  zloj.s ! AF Nom Animate gn ;
        ClIndic PastRus _ => case gn of
       { (GSg Fem)   => "была" ++ zloj.s! AF Nom Animate (GSg Fem);
          (GSg Masc)  => "был" ++ zloj.s! AF Nom Animate (GSg Masc);
          (GSg Neut)   => "был" ++ zloj.s! AF Nom Animate (GSg Neut);
           GPl => "были" ++ zloj.s! AF Nom Animate GPl
       };
       ClIndic Future _ => case gn of 
       { GPl => case p of 
          { P3 => "будут" ++ zloj.s! AF Nom Animate GPl;
            P2 => "будете" ++ zloj.s! AF Nom Animate GPl;
            P1 => "будем" ++ zloj.s! AF Nom Animate GPl
          } ;
         (GSg _) => case p of 
         {P3 => "будет" ++ zloj.s! AF Nom Animate (GSg (genGNum gn));
          P2 => "будешь"++ zloj.s! AF Nom Animate (GSg (genGNum gn));
          P1=> "буду" ++ zloj.s! AF Nom Animate (GSg (genGNum gn))
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
     { GSg _ => "будь" ++ zloj.s;    -- person is ignored !
       GPl => "будьте" ++ zloj.s
     };
     ClInfinit => "быть" ++ zloj.s;
        ClIndic Present  _ => zloj.s ;
        ClIndic PastRus _ => case gn of 
       { (GSg Fem)  => "была" ++ zloj.s;
         (GSg Masc) => "был" ++ zloj.s;
          (GSg Neut) => "было" ++ zloj.s;
         GPl => "были" ++ zloj.s
       };
        ClIndic Future _ => case gn of 
       { (GSg _) => "будет" ++ zloj.s;
         GPl => "будут" ++ zloj.s
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

--    CompAP ap = ap ;
--    CompNP np = {s = \\_ => np.s ! Acc} ;
--    CompAdv a = {s = \\_ => a.s} ;


-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "inte" are not grammatical.

    UseV se = 
    {s=\\clf,gn,p =>  se.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ; 
      asp = se.asp ;
     w=Act;      
    s2 = "";
      negBefore = True;
      s3 = table{_=> table{_ => ""}}
    } ;

-- The rule for using transitive verbs is the complementization rule:
  SlashV2a se =
    {s = \\clf,gn,p =>  se.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ;
      asp = se.asp ; 
      w = Act;
      s2 = "";
      s3 = \\g,n => ""; 
      negBefore = True ;
      sc = se.c2.s ;
      c = se.c2.c
    } ;

  ComplSlash se tu =
    {s = \\clf,gn,p =>  se.s ! clf ! gn ! p
     ++ se.sc ++ tu.s ! (mkPronForm se.c No NonPoss) ; 
      asp = se.asp ; 
      w = se.w;
      s2 = se.s2;
      s3 = se.s3; 
      negBefore = se.negBefore
    } ;

  Slash2V3 dat tu =
      let
        tebepivo = dat.c2.s ++ tu.s ! PF dat.c2.c No NonPoss ++ dat.c3.s ;
      in
      {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++ tebepivo ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> "" ;
      sc = dat.c3.s ;
      c = dat.c3.c
    } ;

  Slash3V3 dat pivo =
      let
        tebepivo = dat.c3.s ++ pivo.s ! PF dat.c3.c Yes NonPoss 
      in
      {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++ tebepivo ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> "" ;
      sc = dat.c2.s ;
      c = dat.c2.c
    } ;

  ---- AR 17/12/2008
  SlashV2Q dat esliOnPridet =
       {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++ esliOnPridet.s ! QDir ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> "" ;
      sc = dat.c2.s ;
      c = dat.c2.c
    } ;

  ---- AR 17/12/2008
  SlashV2S   vidit tuUlubaeshsya =
    {s = \\clf,gn,p => vidit.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p)
     ++ [", что"] ++ tuUlubaeshsya.s ;
     asp = vidit.asp;
     w = Act;
     s2="";
      negBefore = True;
      s3 = \\g,n => "" ;
      sc = vidit.c2.s ;
      c = vidit.c2.c
   } ;

  ---- AR 17/12/2008
  SlashV2V putatsya bezhat =
  { s =  \\clf,gn,p => putatsya.s ! (getActVerbForm clf (genGNum gn) 
       (numGenNum gn) p) ++ bezhat.s!ClInfinit !gn!p ; 
      asp = putatsya.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 =\\g,n => "" ;
      sc = putatsya.c2.s ;
      c = putatsya.c2.c
  } ;

  ---- AR 17/12/2008
  ReflVP vp = 
    { s  = \\clf,gn,p => vp.s ! clf ! gn ! p ++ vp.s2 ++ sebya ! vp.c; 
      asp = vp.asp ;
      w = Act ;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
 } ;

  ---- AR 17/12/2008
  SlashVV putatsya bezhat =
  { s =  \\clf,gn,p => putatsya.s ! (getActVerbForm clf (genGNum gn) 
       (numGenNum gn) p) ++ bezhat.s!ClInfinit !gn!p ; 
      asp = putatsya.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 =\\g,n => "" ;
      sc = bezhat.s2 ;
      c = bezhat.c
  } ;

  ---- AR 17/12/2008
  SlashV2VNP putatsya np bezhat =
  { s =  \\clf,gn,p => 
        putatsya.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++ 
        np.s ! (mkPronForm putatsya.c2.c No NonPoss) ++ ---- ? 
        bezhat.s!ClInfinit !gn!p ;
      asp = putatsya.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 =\\g,n => "" ;
      sc = bezhat.s2 ; ---- ?
      c = bezhat.c
  } ;


-- To generate "сказал, что Иван гуляет" / "не сказал, что Иван гуляет":
  ComplVS   vidit tuUlubaeshsya =
    {s = \\clf,gn,p => vidit.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p)
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
  { s =  \\clf,gn,p => putatsya.s ! (getActVerbForm clf (genGNum gn) 
       (numGenNum gn) p) ++ bezhat.s!ClInfinit !gn!p ; 
      asp = putatsya.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 =\\g,n => ""
  } ;
  ComplVQ dat esliOnPridet =
       {s  = \\clf,gn,p => dat.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++ esliOnPridet.s ! QDir ; 
      asp = dat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n=> ""
    } ;
  ComplVA vuglyadet molodoj =
      {s  = \\clf,gn,p => vuglyadet.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ; 
      asp = vuglyadet.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n => molodoj.s!(AF Inst Animate (gennum g n))  
    } ;

  SlashV2A  obechat molodoj =
    {s  = \\clf,gn,p => 
          obechat.s ! (getActVerbForm clf (genGNum gn) (numGenNum gn) p) ++  
          molodoj.s ! AF Inst Inanimate (GSg Neut) ;
                      ---- AR 17/6; AF Inst tu.anim (pgNum tu.g tu.n) ; 
      asp = obechat.asp ;
      w = Act;
      negBefore = True;
      s2 = "";
      s3 = \\g,n =>"" ;
      sc = obechat.c2.s ;
      c = obechat.c2.c
    } ;

  AdvVP poet khorosho =
    {s = \\clf,gn,p => poet.s ! clf!gn!p; s2 = poet.s2 ++ khorosho.s; s3 = poet.s3;
     asp = poet.asp; w = poet.w; t = poet.t ; negBefore = poet.negBefore } ;

  AdVVP khorosho poet =
    {s = \\clf,gn,p => poet.s ! clf!gn!p; s2 = khorosho.s ++ poet.s2; s3 = poet.s3;
     asp = poet.asp; w = poet.w; t = poet.t ; negBefore = poet.negBefore } ;

PassV2  se =
    {s=\\clf,gn,p =>  se.s ! (getPassVerbForm clf (genGNum gn) (numGenNum gn) p) ; 
    asp=se.asp; w=Pass;      s2 = se.c2.s;
      negBefore = True;
      s3 = table{_=> table{_ => ""}}
};

}

