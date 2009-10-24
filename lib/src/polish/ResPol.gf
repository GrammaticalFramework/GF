--# -path=.:../abstract:../common:../prelude
--# -coding=utf8

-- Ilona Nowak Wintersemester 2007/08  

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

-- 1 Polish auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. 

  resource ResPol = ParamX ** open Prelude in {

  flags  coding=utf8 ; optimize=all_subs ;

---------------------- Parameter types definition --------------------------
-- Their parameter values are atomic.
-- Some parameters, such as $Number$ or $Person$, are inherited from $ParamX$.
-- So it must not to be defined here again.
-- Masculine Gender gets the 'Animacy' as an argument, 
-- because in polish language animacy is important only
-- in declension of masculine nouns.
-- So masculine gender isn't atomic, but feminine and neute are.
-- Read about it in ParadigmsPol.gf, where the genders are defined. 


--1 Nouns   

----------------------- Parameter for nouns ----------------------------------

  param 
    Gender     = Masc Animacy | Fem | NeutGr | Neut ; 
	Animacy    = Animate | Inanimate | Personal ;
	Case       = Nom | Gen | Dat | Acc | Instr | Loc | VocP ;   

-- Nouns are declined according to number and case.
-- For the sake of shorter description, these parameters are 
-- combined in the type SubstForm.

	param SubstForm = SF Number Case ;


    oper CommNoun = {s : SubstForm => Str; g : Gender};  


--2 Verbs   

----------------------- Parameter for verbs ----------------------------------

-- General information

-- Polish verb has two indicative tenses called pseudoparticiple (with meaning of the past) 
-- and finitive. Meaning ofthe second one depends on aspect: if verb is perfective then finitive 
-- form has meaning of the future, otherwise of the present. Future tense of imperfective 
-- verb is constructed with proper form of 'być' ('to be') and variantively 
-- the infinitive or the past form.  

-- So on morphological level verbs inflection looks as follow:

  param VFormM =
       VInfM 
	  |VImperSg2M
	  |VImperPl1M
	  |VImperPl2M
	  |VFinM Number Person
	  |VPraetM GenNum Person
	  |VCondM GenNum Person;


-- Presence of voices in Polish is a matter of controversion. 
-- In this work I treat voice as syntax (not morphological) phenomenon.
-- Passive voice will be constructed from passive participle.
-- Reflexive voice will be constructed from active forms.

-- Aspect tells, if the action is already done or it is still taking place
-- at the time of speaking.

  param 
    Aspect = Dual | Imperfective | Perfective ;  
  
  oper Verb : Type = {
	 si : VFormM => Str;
	 sp : VFormM => Str;
	 refl : Str;
	 asp : Aspect;
	 ppart : AForm=>Str
  };
  
-- and on syntax level:
{-  param  
    TenseP = Present | PastP | Future ;
    PolarityP = PosP | DirNeg | InDirNeg; -- for the indirect object of negation
  
  param VForm =
	   VInf Gender Number               --byc zjedzonym / zjedzoną (?)
	  |VInd Gender Number Person TenseP Anteriority
	  |VImp Gender Number Person;       --niech zostane zjedzony / zjedzona-}
  	 
  oper VerbPhrase : Type = {
    prefix, sufix, postfix : Polarity => GenNum => Str;
    verb : Verb;
    imienne : Bool;-- formed with 'to be' (she was nice, he is a man, etc.)
	exp : Bool -- expanded 
  };

{-  oper AccToGen : Complement -> Case = \c -> 
    case c.s of {
      "" => case c.c of {Acc => Gen; _ => c.c };
      _  => c.c
    };-}
  
-- Anteriority is defined in ../common/ParamX.gf. 
-- So it isn't needed to be defined here again.

--	     Anteriority = Simul | Anter ; -- predefined 
 
--3 Adjectives

----------------------- Parameter for adjectives ----------------------------------

-- Description and explanation in AdjectiveMorphoPol.gf

  oper adj11forms : Type = { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 : Str };
  
  oper Adj : Type = {
    pos : adj11forms;
    comp : adj11forms;
    super : adj11forms;
    advpos : Str;
    advcomp : Str;
    advsuper : Str;
  };
      
  oper mkAtable : adj11forms -> AForm => Str = \f ->
    table {
    AF (MascPersSg|MascAniSg | MascInaniSg) Nom    => f.s1;
    AF (MascPersSg|MascAniSg | MascInaniSg) Gen    => f.s2;
    AF (MascPersSg|MascAniSg | MascInaniSg) Dat    => f.s3; 
    AF MascInaniSg               Acc    => f.s1; 
    AF (MascPersSg|MascAniSg)    Acc    => f.s2; 
    AF (MascPersSg|MascAniSg | MascInaniSg) Instr  => f.s4;
    AF (MascPersSg|MascAniSg | MascInaniSg) Loc    => f.s4; 
    AF (MascPersSg|MascAniSg | MascInaniSg) VocP   => f.s1;
    
    AF FemSg Nom   => f.s6 ; 
    AF FemSg Gen   => f.s7;
    AF FemSg Dat   => f.s7; 
    AF FemSg Acc   => f.s8; 
    AF FemSg Instr => f.s8;
    AF FemSg Loc   => f.s7;
    AF FemSg VocP  => f.s6;   
    
    AF NeutSg Nom   => f.s5 ; 
    AF NeutSg Gen   => f.s2;
    AF NeutSg Dat   => f.s3; 
    AF NeutSg Acc   => f.s5; 
    AF NeutSg Instr => f.s4;
    AF NeutSg Loc   => f.s4;
    AF NeutSg VocP  => f.s5; 
    
    AF MascPersPl  Nom   => f.s9; 
    AF OthersPl    Nom   => f.s5; 
    AF _           Gen   => f.s10;
    AF _           Dat   => f.s4; 
    AF MascPersPl  Acc   => f.s10; 
    AF OthersPl    Acc   => f.s5; 
    AF _           Instr => f.s11;
    AF _           Loc   => f.s10;
    AF MascPersPl  VocP  => f.s9; 
    AF OthersPl    VocP  => f.s5
    };

  param AForm = AF GenNum Case;

  oper AdjPhrase = { s : AForm => Str; adv:Str };

--4 Pronoun

----------------------- Parameter for pronouns -------------------------

-- Gender is not morphologically determined for first
-- and second person pronouns in Sg. and Pl.
-- (for Sg: "ja", "ty", Pl: "my", "wy").
-- Therefore some pronouns don't have gender or it is not 
-- possible to decline them. (-> PNoGen)

  param PronGen = PGen Gender | PNoGen ;
  
-- The AfterPrep parameter is introduced in order to describe --FIXME
-- the variations of the third person personal pronoun forms
-- depending on whether they come after a preposition or not. 

--   param AfterPrep = Pre | Post ; --removed

-- The sp field stands for the possesive variant of the pronoun.

  oper Pron = { nom: Str; voc:Str; dep: ComplCase => Str ; sp: AForm => Str ; n : Number ; p : Person ;
		   g: PronGen } ;

--6 Complement definition
  
  param ComplCase = GenPrep | GenNoPrep | DatPrep | DatNoPrep |
    AccPrep | AccNoPrep | InstrPrep | InstrNoPrep | LocPrep ;
  
  oper 
  Complement : Type = {s : Str; c : ComplCase} ;
  
  mkCompl : Str -> Case -> Complement;
  mkCompl s c = { 
    s=s; 
    c = case s of { 
      "" => case c of { Gen => GenNoPrep; Dat => DatNoPrep; Instr => InstrNoPrep; _ => AccNoPrep }; 
      _  => case c of { Gen => GenPrep; Dat => DatPrep; Acc => AccPrep; Instr => InstrPrep; _ => LocPrep }
    }
  };
        
  extract_case = table {GenPrep => Gen; GenNoPrep => Gen; DatPrep => Dat;
        DatNoPrep => Dat; AccPrep => Acc; AccNoPrep => Acc; InstrPrep => Instr; 
        InstrNoPrep => Instr; LocPrep => Loc};

--7 Various types
-- possible problem: dzieci ,ktorych piecioro bawilo sie... / okna, ktorych piec stalo opartych o sciane...
  param GenNum = MascPersSg | MascAniSg | MascInaniSg | FemSg | NeutSg | MascPersPl | OthersPl;

  param MaybeGenNum = NoGenNum | JustGenNum GenNum;

  oper
  NounPhrase : Type = { 
    nom: Str; voc: Str; dep: ComplCase => Str; -- dep = dependent cases
    gn: GenNum; p : Person };
    
  cast_gennum = table { 
    <Masc Personal,Sg> => MascPersSg; 
    <Masc Animate,Sg> => MascAniSg; 
    <Masc _,Sg> => MascInaniSg; 
    <Fem, Sg> => FemSg;
    <Neut, Sg> => NeutSg;
    <NeutGr, Sg> => NeutSg;
    <Masc Personal, Pl> => MascPersPl;
    _ => OthersPl
  };
  
  extract_num = table { (MascPersSg|MascAniSg|MascInaniSg|FemSg|NeutSg) => Sg; _ => Pl } ;

-- dopelniacz negacji
    npcase : Polarity * ComplCase => ComplCase = 
        table { 
            <Neg, AccNoPrep> => GenNoPrep;
            <_, c>           => c
          };

-- Determiners 

  param Accom = NoA | DwaA | PiecA | StoA | TysiacA; -- Accomodation of cases
  
  
  oper
  IDeterminer : Type = { s:    Case => Gender => Str; n: Number; a: Accom};
  Determiner  : Type = { s,sp: Case => Gender => Str; n: Number; a: Accom};

  oper 
    accom_case = table {
      <DwaA,    Nom,     Masc Personal> => Gen;
      <DwaA,    _,       NeutGr>        => Gen;
      <PiecA,   Nom,     Masc Personal> => Gen;
      <PiecA,   _,       NeutGr>        => Gen;
      <PiecA,   Nom|Acc, Masc (Animate|Inanimate)|Neut|Fem> => Gen;
      <StoA,    Nom,     Masc Personal> => Gen;
      <StoA,    Nom|Acc, Masc (Animate|Inanimate)|Neut|Fem> => Gen;
      <TysiacA, _,       _>             => Gen;
      x                                 => x.p2
    };

    accom_gennum : Accom * Gender * Number => GenNum = 
      table {
        <DwaA,    Masc Personal | NeutGr, _> => NeutSg;
        <PiecA,   _,                      _> => NeutSg;
        <StoA,    _,                      _> => NeutSg;
        <TysiacA, _,                      _> => NeutSg;
        <_,       g,                      n> => cast_gennum!<g,n>      
      };


  ktory : AForm => Str = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "który"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "którego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "któremu"; 
	     AF MascInaniSg Acc => "który"; -- który stół widzę
	     AF (MascPersSg|MascAniSg) Acc => "którego"; -- którego psa / przyjaciela widzę
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "którym";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "którym"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "który";
	     
	     AF FemSg Nom => "która" ; 
	     AF FemSg Gen => "której";
	     AF FemSg Dat => "której"; 
	     AF FemSg Acc => "którą"; 
	     AF FemSg Instr => "którą";
	     AF FemSg Loc => "której";
	     AF FemSg VocP => "która";   
	         
	     AF NeutSg Nom => "które" ; 
	     AF NeutSg Gen => "którego";
	     AF NeutSg Dat  => "któremu"; 
	     AF NeutSg Acc => "które"; 
	     AF NeutSg Instr => "którym";
	     AF NeutSg Loc => "którym";
	     AF NeutSg VocP => "które"; 
	
     	 AF MascPersPl Nom => "którzy"; 
	     AF (MascPersPl|OthersPl) Nom => "które"; 
	     AF (MascPersPl|OthersPl) Gen => "których";
	     AF (MascPersPl|OthersPl) Dat => "którym"; 
	     AF MascPersPl Acc => "których"; 
	     AF (MascPersPl|OthersPl) Acc => "które"; 
	     AF (MascPersPl|OthersPl) Instr => "którymi";
	     AF (MascPersPl|OthersPl) Loc => "których";
	     AF MascPersPl VocP => "którzy"; 
	     AF (MascPersPl|OthersPl) VocP=> "które"
	   };
	   
  jaki : AForm => Str = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "jaki"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "jakiego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "jakiemu"; 
	     AF MascInaniSg Acc => "jaki"; -- jakiy stół widzę
	     AF (MascPersSg|MascAniSg) Acc => "jakiego"; -- jakiego psa / przyjaciela widzę
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "jakim";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "jakim"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "jaki";
	     
	     AF FemSg Nom => "jaka" ; 
	     AF FemSg Gen => "jakiej";
	     AF FemSg Dat => "jakiej"; 
	     AF FemSg Acc => "jaką"; 
	     AF FemSg Instr => "jaką";
	     AF FemSg Loc => "jakej";
	     AF FemSg VocP => "jaka";   
	         
	     AF NeutSg Nom => "jakie" ; 
	     AF NeutSg Gen => "jakiego";
	     AF NeutSg Dat  => "jakiemu"; 
	     AF NeutSg Acc => "jakie"; 
	     AF NeutSg Instr => "jakim";
	     AF NeutSg Loc => "jakim";
	     AF NeutSg VocP => "jakie"; 
	
     	 AF MascPersPl Nom => "jacy"; 
	     AF (MascPersPl|OthersPl) Nom => "jakie"; 
	     AF (MascPersPl|OthersPl) Gen => "jakich";
	     AF (MascPersPl|OthersPl) Dat => "jakim"; 
	     AF MascPersPl Acc => "jakich"; 
	     AF (MascPersPl|OthersPl) Acc => "jakie"; 
	     AF (MascPersPl|OthersPl) Instr => "jakimi";
	     AF (MascPersPl|OthersPl) Loc => "jakich";
	     AF MascPersPl VocP => "jacy"; 
	     AF (MascPersPl|OthersPl) VocP=> "jakie"
	   };
 
  siebie : Case => Str = table {
    Nom => "się";
    Gen => "siebie";
    Dat => "sobie";
    Acc => "siebie";
    Instr => "sobą";
    Loc => "sobie";
    VocP => ["[siebie: the vocative form does not exist]"]
  };

} ; 