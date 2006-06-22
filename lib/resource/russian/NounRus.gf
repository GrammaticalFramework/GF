--# -path=.:../abstract:../common:../../prelude

concrete NounRus of Noun = CatRus ** open ResRus, Prelude, MorphoRus in {

  flags optimize=all_subs ;

  lin
    DetCN kazhduj okhotnik = {
      s = \\c => case kazhduj.c of {
       Nom => 
        kazhduj.s ! AF (extCase c) okhotnik.anim (gNum okhotnik.g kazhduj.n) ++ 
         okhotnik.s ! kazhduj.n ! (extCase c) ; 
       _ => 
        kazhduj.s ! AF (extCase c) okhotnik.anim (gNum okhotnik.g kazhduj.n) ++ 
         okhotnik.s ! kazhduj.n ! kazhduj.c };
      n = kazhduj.n ; 
      p = P3 ;
      pron = False;
      g = case kazhduj.g of { PNoGen => (PGen okhotnik.g); _ => kazhduj.g };
      anim = okhotnik.anim 
    } ;

    UsePN masha = {
      s = \\c => masha.s ! (extCase c) ; 
      p = P3; g = PGen masha.g ; anim = masha.anim ; 
      n = Sg; nComp = Sg; pron = False} ;

    UsePron p = p ** {anim = Inanimate};

    PredetNP pred np = {
      s = \\pf => pred.s! (AF (extCase pf) np.anim (gNum (pgen2gen np.g) np.n))++ np.s ! pf ;
      n = np.n;
      p = np.p;
      g = np.g;
      anim = np.anim;
      pron = np.pron
      } ;

    PPartNP np v2 = {
      s = \\pf => np.s ! pf ++ v2.s ! VFORM Act VINF ; 
      -- no participles in the Verbum type as they behave as adjectives
      n = np.n;
      p = np.p;
      g = np.g;
      anim = np.anim;
      pron = np.pron
      } ;

    AdvNP np adv = {
      s = \\pf => np.s ! pf ++ adv.s ;
      n = np.n;
      p = np.p;
      g = np.g;
      anim = np.anim;
      pron = np.pron
      } ;


    DetSg quant ord = {
      s = \\af => quant.s!af ++ ord.s!af ; 
      n = quant.n;
      g = quant.g;
      c = quant.c
      } ;

    DetPl quant num ord = {
      s =  \\af => quant.s !af ++ num.s! (caseAF af) ! (genAF af)  ++ ord.s!af ; 
      n = Pl;
      g = quant.g;
      c = quant.c
      } ;

    SgQuant quant = {s = quant.s; c=quant.c; g=quant.g; n= Sg} ;
    PlQuant quant = {s = quant.s ; c=quant.c; g=quant.g; n= Pl} ;

    PossPron p = {s = \\af => p.s ! mkPronForm (caseAF af) No (Poss (gNum (genAF af) (numAF af) )); c=Nom; g = PNoGen} ;

      NoNum = {s = \\_,_ => []} ; -- cardinal numeral
      NoOrd = {s = \\_ => []} ;   -- adjective

-- unclear how to tell apart the numbers from their string representation,
-- so just leave a decimal representation, without case-suffixes:
    NumInt i =  {s = table { _ => table {_ => i.s } } } ;

 --   OrdInt n = case n of {
 --      0|2|6 => (uy_oj_EndDecl n.s) ; 
 --      3 => (ti_j_EndDecl n.s) ; 
 --      _ => uy_j_EndDecl n.s }  ;

 -- OrdNumeral numeral = 
 --  {s = \\ af => (uy_j_EndDecl (numeral.s ! caseAF af ! genAF af)).s!af} ;

    NumNumeral n = n ;

    AdNum adn num = {s = \\c,n => adn.s ++ num.s!c!n} ;

    OrdSuperl a = {s = a.s!Posit};

    DefArt = {s = \\_=>[] ; c=Nom; g = PNoGen };
    IndefArt = { s = \\_=>[] ; c=Nom; g = PNoGen };
    MassDet = {s = \\_=>[] ; c=Nom; g = PNoGen; n = Sg} ;

  UseN  sb =
    {s = \\n,c => sb.s ! SF n c ; 
     g = sb.g ; 
     anim = sb.anim
    } ;

-- It is possible to use a function word as a common noun; the semantics is
-- often existential or indexical.
  UseN2 x = x ;
  UseN3 x = x ;

-- The application of a function gives, in the first place, a common noun:
-- "ключ от дома". From this, other rules of the resource grammar 
-- give noun phrases, such as "ключи от дома", "ключи от дома
-- и от машины", and "ключ от дома и машины" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  ComplN2 mama ivan =
     {s = \\n, cas =>  case ivan.pron of 
       { True => ivan.s ! (mkPronForm cas No (Poss (gNum mama.g n))) ++ mama.s ! n ! cas;
         False => mama.s ! n ! cas ++ mama.s2 ++ 
         ivan.s ! (mkPronForm mama.c Yes (Poss (gNum mama.g n)))
       };
       g = mama.g ;
       anim = mama.anim
      } ;

-- Two-place functions add one argument place.
-- There application starts by filling the first place.

  ComplN3 poezd paris =
    {s  = \\n,c => poezd.s ! n ! c ++ poezd.s2 ++ paris.s ! (PF poezd.c Yes NonPoss) ;
     g  = poezd.g ; anim = poezd.anim;
     s2 = poezd.s3; c = poezd.c2 
    } ;


-- The two main functions of adjective are in predication ("Иван - молод")
-- and in modification ("молодой человек"). Predication will be defined
-- later, in the chapter on verbs.

  AdjCN khoroshij novayaMashina =
    {s = \\n, c => 
         khoroshij.s ! AF c novayaMashina.anim (gNum novayaMashina.g n) ++ 
         novayaMashina.s ! n ! c ;
         g = novayaMashina.g ; 
         anim = novayaMashina.anim
     } ;                          

-- This is a source of the "man with a telescope" ambiguity, and may produce
-- strange things, like "машины всегда".
-- Semantics will have to make finer distinctions among adverbials.

  AdvCN chelovek uTelevizora =
    {s = \\n,c => chelovek.s ! n ! c ++ uTelevizora.s ;
     g = chelovek.g ;
     anim = chelovek.anim 
    } ;

-- Constructions like "the idea that two is even" are formed at the
-- first place as common nouns, so that one can also have "a suggestion that...".

  SentCN idea x =
    {s = \\n,c => idea.s ! n ! c ++ x.s ; 
     g = idea.g; anim = idea.anim
    } ;

  RelCN idea x =
    {s = \\n,c => idea.s ! n ! c ++ x.s !(gNum idea.g n)!c!idea.anim ; 
     g = idea.g; anim = idea.anim
    } ;

  ApposCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s! PF c No NonPoss ; 
     g = cn.g ;
     anim = cn.anim
    } ;

  
}

