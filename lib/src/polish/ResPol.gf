--# -path=.:../abstract:../common:../prelude
--# -coding=utf8

-- Ilona Nowak Wintersemester 2007/08  

-- Adam Slaski, 2009, 2010 <adam.slaski@gmail.com>

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
    Gender     = Masc Animacy | Fem | NeutGr | Neut | Plur ; 
    Animacy    = Animate | Inanimate | Personal ;
    Case       = Nom | Gen | Dat | Acc | Instr | Loc | VocP ;   

-- Nouns are declined according to number and case.
-- For the sake of shorter description, these parameters are 
-- combined in the type SubstForm.

	param SubstForm = SF Number Case ;


    -- oper used in NounMorphoPol.gf
    -- type of N, _not_ CN
  oper CommNoun = {s : SubstForm => Str; g : Gender};
  oper CommNoun2 = CommNoun ** { c : Complement } ;
  oper CommNoun3 = CommNoun2 ** { c2 : Complement } ;


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
	 ppartp : adj11table; --AForm=>Str;
	 pparti : adj11table  --AForm=>Str
  };
    	 
  oper VerbPhrase : Type = {
    prefix : Str;
    sufix : Polarity => GenNum => Str;
    verb : Verb;
    imienne : Bool;-- formed with 'to be' (she was nice, he is a man, etc.)
	exp : Bool -- expanded 
  };
  
  oper VerbPhraseSlash : Type = 
    VerbPhrase ** { c : Complement; postfix : Polarity => GenNum => Str };

--3 Adjectives

----------------------- Parameter for adjectives ----------------------------------

-- Description and explanation in AdjectiveMorphoPol.gf

  oper adj11forms : Type = { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 : Str };
  
  oper empty11forms : adj11forms = { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "" };
  
  
  -- this is because of the bug (undocumented feature) in GF. only two levels of nested records are possible, on the third level compiler throw a strange error about more than 6664 fields demanded. tables on second level are accepted, so adj11forms is translated into table and back.
  
  param param11 = X1 | X2 | X3 | X4 | X5 | X6 | X7 | X8 | X9 | X10 | X11 ;
  
  oper adj11table : Type = param11 => Str;
  
  oper table2record : adj11table -> adj11forms = \a -> { s1 = a!X1;s2 = a!X2;s3 = a!X3;s4 = a!X4;s5 = a!X5;s6 = a!X6;s7 = a!X7;s8 = a!X8;s9 = a!X9;s10 = a!X10;s11 = a!X11 };
  
  oper record2table : adj11forms -> adj11table = \a -> table { X1 => a.s1;X2 => a.s2;X3 => a.s3;X4 => a.s4;X5 => a.s5;X6 => a.s6;X7 => a.s7;X8 => a.s8;X9 => a.s9;X10 => a.s10;X11 => a.s11 };
  
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

  oper AdjPhrase = { s : AForm => Str; adv:Str ; isPost : Bool };

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
    AccPrep | AccNoPrep | InstrC | LocPrep ;
  
  oper 
  Complement : Type = {s : Str; c : ComplCase} ;
  
  mkCompl : Str -> Case -> Complement;
  mkCompl s c = { 
    s=s; 
    c = case s of { 
      "" => case c of { Gen => GenNoPrep; Dat => DatNoPrep; Instr => InstrC; _ => AccNoPrep }; 
      _  => case c of { Gen => GenPrep; Dat => DatPrep; Acc => AccPrep; Instr => InstrC; _ => LocPrep }
    }
  };
        
  extract_case = table {GenPrep => Gen; GenNoPrep => Gen; DatPrep => Dat;
        DatNoPrep => Dat; AccPrep => Acc; AccNoPrep => Acc; InstrC => Instr; 
        LocPrep => Loc};

--7 Various types
-- possible problem: dzieci ,ktorych piecioro bawilo sie... / okna, ktorych piec stalo opartych o sciane...
  param GenNum = MascPersSg | MascAniSg | MascInaniSg | FemSg | NeutSg | MascPersPl | OthersPl;

  --- AR 7/12/2010 for VerbPol.CompCN
  oper numGenNum : GenNum -> Number = \n -> case n of {
    MascPersPl | OthersPl => Pl ;
    _ => Sg
    } ;
  --- AR 6/2/2018 
  oper genGenNum : GenNum -> Gender = \n -> case n of {
    MascPersSg => Masc Personal ;
    MascAniSg => Masc Animate ;
    MascInaniSg => Masc Inanimate ;
    FemSg => Fem ;
    NeutSg => Neut ; ---- NeutGr ?
    _ => Plur
    } ;

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
    <Plur, Sg> => OthersPl; --plurale tantum
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
    accom_case : Accom * Case * Gender => Case = 
    table {
      <DwaA,    Nom|VocP,     Masc Personal> => Gen;
      <DwaA,    _,           NeutGr| Plur>   => Gen;
      <PiecA,   Nom|VocP,     Masc Personal> => Gen;
      <PiecA,   _,           NeutGr| Plur>   => Gen;
      <PiecA,   Nom|VocP|Acc, Masc (Animate|Inanimate)|Neut|Fem> => Gen;
      <StoA,    Nom|VocP,     Masc Personal> => Gen;
      <StoA,    Acc,          Masc Personal> => Acc;
      <StoA,    Nom|VocP|Acc, _>             => Gen;
      <TysiacA, _,            _>             => Gen;
      x                                      => x.p2
    };

    accom_gennum : Accom * Gender * Number => GenNum = 
      table {
        <DwaA,    Masc Personal | NeutGr | Plur, _> => NeutSg;
        <PiecA,   _,                      _> => NeutSg;
        <StoA,    _,                      _> => NeutSg;
        <TysiacA, _,                      _> => NeutSg;
        <_,       g,                      n> => cast_gennum!<g,n>      
      };


  -- ktory : AForm => Str = table {
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "który"; 
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "którego";
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "któremu"; 
  -- 	     AF MascInaniSg Acc => "który"; -- który stół widzę
  -- 	     AF (MascPersSg|MascAniSg) Acc => "którego"; -- którego psa / przyjaciela widzę
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "którym";
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "którym"; 
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "który";
	     
  -- 	     AF FemSg Nom => "która" ; 
  -- 	     AF FemSg Gen => "której";
  -- 	     AF FemSg Dat => "której"; 
  -- 	     AF FemSg Acc => "którą"; 
  -- 	     AF FemSg Instr => "którą";
  -- 	     AF FemSg Loc => "której";
  -- 	     AF FemSg VocP => "która";   
	         
  -- 	     AF NeutSg Nom => "które" ; 
  -- 	     AF NeutSg Gen => "którego";
  -- 	     AF NeutSg Dat  => "któremu"; 
  -- 	     AF NeutSg Acc => "które"; 
  -- 	     AF NeutSg Instr => "którym";
  -- 	     AF NeutSg Loc => "którym";
  -- 	     AF NeutSg VocP => "które"; 
	
  --    	 AF MascPersPl Nom => "którzy"; 
  -- 	     AF (MascPersPl|OthersPl) Nom => "które"; 
  -- 	     AF (MascPersPl|OthersPl) Gen => "których";
  -- 	     AF (MascPersPl|OthersPl) Dat => "którym"; 
  -- 	     AF MascPersPl Acc => "których"; 
  -- 	     AF (MascPersPl|OthersPl) Acc => "które"; 
  -- 	     AF (MascPersPl|OthersPl) Instr => "którymi";
  -- 	     AF (MascPersPl|OthersPl) Loc => "których";
  -- 	     AF MascPersPl VocP => "którzy"; 
  -- 	     AF (MascPersPl|OthersPl) VocP=> "które"
  -- 	   };
	   
  -- jaki : AForm => Str = table {
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "jaki"; 
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "jakiego";
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "jakiemu"; 
  -- 	     AF MascInaniSg Acc => "jaki"; -- jakiy stół widzę
  -- 	     AF (MascPersSg|MascAniSg) Acc => "jakiego"; -- jakiego psa / przyjaciela widzę
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "jakim";
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "jakim"; 
  -- 	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "jaki";
	     
  -- 	     AF FemSg Nom => "jaka" ; 
  -- 	     AF FemSg Gen => "jakiej";
  -- 	     AF FemSg Dat => "jakiej"; 
  -- 	     AF FemSg Acc => "jaką"; 
  -- 	     AF FemSg Instr => "jaką";
  -- 	     AF FemSg Loc => "jakej";
  -- 	     AF FemSg VocP => "jaka";   
	         
  -- 	     AF NeutSg Nom => "jakie" ; 
  -- 	     AF NeutSg Gen => "jakiego";
  -- 	     AF NeutSg Dat  => "jakiemu"; 
  -- 	     AF NeutSg Acc => "jakie"; 
  -- 	     AF NeutSg Instr => "jakim";
  -- 	     AF NeutSg Loc => "jakim";
  -- 	     AF NeutSg VocP => "jakie"; 
	
  --    	 AF MascPersPl Nom => "jacy"; 
  -- 	     AF (MascPersPl|OthersPl) Nom => "jakie"; 
  -- 	     AF (MascPersPl|OthersPl) Gen => "jakich";
  -- 	     AF (MascPersPl|OthersPl) Dat => "jakim"; 
  -- 	     AF MascPersPl Acc => "jakich"; 
  -- 	     AF (MascPersPl|OthersPl) Acc => "jakie"; 
  -- 	     AF (MascPersPl|OthersPl) Instr => "jakimi";
  -- 	     AF (MascPersPl|OthersPl) Loc => "jakich";
  -- 	     AF MascPersPl VocP => "jacy"; 
  -- 	     AF (MascPersPl|OthersPl) VocP=> "jakie"
  -- 	   };
 
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