--# -path=.:../abstract:../common:../../prelude

concrete NounRus of Noun = CatRus ** open ResRus, Prelude, MorphoRus in {

  flags optimize=all_subs ; coding=utf8 ;

  lin
  
    DetCN kazhduj okhotnik = {
      s = \\c => case kazhduj.size of {
	nom =>
              kazhduj.s ! extCase c ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF Sg (extCase c) nom ++ okhotnik.relcl ! kazhduj.n ! (extCase c) ;
	nompl =>
              kazhduj.s ! extCase c ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF kazhduj.n (extCase c) nompl ++ okhotnik.relcl ! kazhduj.n ! (extCase c) ;
	sgg =>
	  case c of {
	    PF Nom _ _ => 
              kazhduj.s ! Nom ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF Sg Gen sgg ++ okhotnik.relcl ! kazhduj.n ! (extCase c) ; 
	    _ => 
              kazhduj.s ! extCase c ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF Pl (extCase c) sgg ++ okhotnik.relcl ! kazhduj.n ! (extCase c)} ;
	plg =>
	  case c of {
	    PF Nom _ _ => 
              kazhduj.s ! Nom ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF Pl Gen plg ++ okhotnik.relcl ! kazhduj.n ! (extCase c) ; 
	    _ => 
              kazhduj.s ! extCase c ! okhotnik.anim ! okhotnik.g ++ 
              okhotnik.nounpart ! NF Pl (extCase c) plg ++ okhotnik.relcl ! kazhduj.n ! (extCase c)}
	  };
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
      s = \\pf => pred.s! (AF (extCase pf) np.anim (gennum (pgen2gen np.g) np.n))++ np.s ! pf ;
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

-- 1.4 additions AR 17/6/2008

    DetNP kazhduj = 
     let
       g = Neut ; ----
       anim = Inanimate ;
     in {
      s = \\c => kazhduj.s ! extCase c ! anim ! g ;
      n = kazhduj.n ; 
      p = P3 ;
      pron = False;
      g = case kazhduj.g of { PNoGen => (PGen g); _ => kazhduj.g };
      anim = anim 
    } ;

{-
    DetArtOrd quant num ord = {
      s =  \\af => quant.s !af ++ num.s! (caseAF af) ! (genAF af)  ++ ord.s!af ; 
      n = num.n ;
      g = quant.g;
      c = quant.c
      } ;

    DetArtCard quant num = {
      s =  \\af => quant.s !af ++ num.s! (caseAF af) ! (genAF af) ;
      n = num.n ;
      g = quant.g;
      c = quant.c
      } ;
-}
--    MassDet = {s = \\_=>[] ; c = Nom; g = PNoGen; n = Sg} ;

    MassNP okhotnik = {
      s = \\c => okhotnik.nounpart ! NF Sg (extCase c) nom ++ okhotnik.relcl ! Sg ! extCase c ; 
      n = Sg ; 
      p = P3 ;
      pron = False;
      g = PGen okhotnik.g ;
      anim = okhotnik.anim 
    } ;
{-
    DetArtSg kazhduj okhotnik = {
      s = \\c =>  -- art case always Nom (AR 17/6/2008) 
          kazhduj.s ! AF (extCase c) okhotnik.anim (gennum okhotnik.g Sg) ++ 
          okhotnik.s ! Sg ! (extCase c) ; 
      n = Sg ; 
      p = P3 ;
      pron = False;
      g = case kazhduj.g of { PNoGen => (PGen okhotnik.g); _ => kazhduj.g};
      anim = okhotnik.anim 
    } ;

    DetArtPl kazhduj okhotnik = {
      s = \\c =>  -- art case always Nom (AR 17/6/2008) 
          kazhduj.s ! AF (extCase c) okhotnik.anim (gennum okhotnik.g Pl) ++ 
          okhotnik.s ! Pl ! (extCase c) ; 
      n = Pl ; 
      p = P3 ;
      pron = False;
      g = case kazhduj.g of { PNoGen => (PGen okhotnik.g); _ => kazhduj.g };
      anim = okhotnik.anim 
    } ;
-}
    PossPron p = {s = \\af => p.s ! mkPronForm (caseAF af) No (Poss (gennum (genAF af) (numAF af) )); c=Nom; g = PNoGen; size = nom} ;

   OrdNumeral numeral = variants {} ; ---- TODO; needed to compile Constructors
   OrdDigits numeral = variants {} ; ---- TODO; needed to compile Constructors
----   OrdDigits TODO
 --  {s = \\ af => (uy_j_EndDecl (numeral.s ! caseAF af ! genAF af)).s!af} ;

    NumNumeral n = n ;
    NumDigits n = {s = \\_,_,_ => n.s ; n = n.n ; size = n.size } ;

    AdNum adn num = {s = \\c,a,n => adn.s ++ num.s!c!a!n ; n = num.n ; size = num.size} ;

    OrdSuperl a = {s = a.s ! Posit} ;

    DefArt = {s = \\_=>[] ; c=Nom; g = PNoGen; size = nom };
    IndefArt = { s = \\_=>[] ; c=Nom; g = PNoGen; size = nom };
  
  UseN noun = {
    nounpart = \\nf => noun.s ! nf ;
    relcl = \\n,c => "" ;
    g = noun.g ; 
    anim = noun.anim 
    } ;

  UseN2 noun = {
    nounpart = noun.s ;
    relcl = \\n,c => "" ;
    g = noun.g ; 
    anim = noun.anim 
    } ;

-- The application of a function gives, in the first place, a common noun:
-- "ключ от дома". From this, other rules of the resource grammar 
-- give noun phrases, such as "ключи от дома", "ключи от дома
-- и от машины", and "ключ от дома и машины" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  ComplN2 f x = {
    nounpart = \\nf => case x.pron of {
                  True => x.s ! (case nf of {NF n c size => mkPronForm c No (Poss (gennum f.g n))}) ++ f.s ! nf ;
                  False => f.s ! nf ++ f.c2.s ++ 
                           x.s ! (case nf of {NF n c size => mkPronForm f.c2.c Yes (Poss (gennum f.g n))})
                } ;
    relcl = \\n,c => "" ;
    g = f.g ;
    anim = f.anim
    } ;

-- Two-place functions add one argument place.
-- There application starts by filling the first place.

  ComplN3 f x = {
    s  = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! (PF f.c2.c Yes NonPoss) ;
    g  = f.g ;
    anim = f.anim ;
    c2 = f.c3 ;
    } ;

  ---- AR 17/12/2008
  Use2N3 f = {
      s = f.s ;
      g = f.g ; 
      anim = f.anim ;
      c2 = f.c2
      } ;

  ---- AR 17/12/2008
  Use3N3 f = {
      s = f.s ;
      g = f.g ; 
      anim = f.anim ;
      c2 = f.c3
      } ;


-- The two main functions of adjective are in predication ("Иван - молод")
-- and in modification ("молодой человек"). Predication will be defined
-- later, in the chapter on verbs.

  AdjCN ap cn = {
    nounpart = \\nf => case ap.p of {
      False => ap.s ! case nf of {NF Sg Gen sgg => AF Nom cn.anim GPl ;
                                  NF n c size => AF c cn.anim (gennum cn.g n)} ++ cn.nounpart ! nf ;
      True => cn.nounpart ! nf ++ ap.s ! case nf of {NF Sg Gen sgg => AF Nom cn.anim GPl ;
                                                     NF n c size => AF c cn.anim (gennum cn.g n)} 
      } ;
    relcl = cn.relcl ;
    g = cn.g ;
    anim = cn.anim
    } ;

-- This is a source of the "man with a telescope" ambiguity, and may produce
-- strange things, like "машины всегда".
-- Semantics will have to make finer distinctions among adverbials.

  AdvCN cn adv = {
    nounpart = \\nf => cn.nounpart ! nf ++ adv.s ;
    relcl = cn.relcl ;
    g = cn.g ;
    anim = cn.anim 
    } ;

-- Constructions like "the idea that two is even" are formed at the
-- first place as common nouns, so that one can also have "a suggestion that...".

  SentCN idea x = {
    nounpart = \\nf => idea.nounpart ! nf ; 
    relcl = \\n,c => idea.relcl ! n ! c ++ x.s ;
    g = idea.g ;
    anim = idea.anim
    } ;

  RelCN idea x = {
    nounpart = \\nf => idea.nounpart ! nf; 
    relcl = \\n,c => idea.relcl ! n ! c ++ x.s ! (gennum idea.g n)! c ! idea.anim ;
    g = idea.g ;
    anim = idea.anim
    } ;
 
  ---- AR 17/12/2008
  ApposCN cn s = {
    nounpart = \\nf => cn.nounpart ! nf ++ s.s ! (case nf of {NF n c size => PF c No NonPoss}) ; 
    relcl = cn.relcl ;
    g = cn.g ;
    anim = cn.anim
    } ;

  RelNP np rel = {
      s = \\c => np.s ! c ++ rel.s ! (gennum (pgen2gen np.g) np.n) ! extCase c ! np.anim ; 
      n = np.n ;
      p = np.p ;
      pron = np.pron ;
      g = np.g ;
      anim = np.anim ;
      nComp = np.nComp
      } ;

---- Liza Zimina 04/2018
-- changed to make Ord agree in number with Num

  DetQuantOrd quant num ord = { 
    s =  \\c,a,gen => quant.s ! AF c a (gennum gen num.n) ++ num.s ! gen ! a ! c  ++ case num.n of {
      Sg => ord.s ! AF c a (GSg gen) ; 
      Pl => ord.s ! AF c a GPl 
      } ;
    n = num.n ;
    g = quant.g;
    c = quant.c;
    size = quant.size
    } ;

  DetQuant quant num = {
    s =  \\c,a,gen => quant.s ! AF c a (gennum gen num.n) ++ num.s ! gen ! a ! c ;
    n = num.n ;
    g = quant.g;
    c = quant.c;
    size = num.size
    } ;
    
  NumCard c = c ;
  NumSg = {s = \\_,_,_ => [] ; n = Sg ; size = nom} ;
  NumPl = {s = \\_,_,_ => [] ; n = Pl ; size = nompl} ;
}

