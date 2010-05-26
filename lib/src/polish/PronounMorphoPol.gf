--# -path=.:../../prelude:../common
--# -coding=utf8

--1 A polish Resource Morphology 
--
-- Ilona Nowak, Wintersemester 2007/08
--
-- Adam Slaski, 2009 <adam.slaski@gmail.com>
--

resource PronounMorphoPol = ResPol ** open Prelude, (Predef=Predef) in {

     flags  coding=utf8; 
     
--4 Pronouns   

--4.1 General

--4.2 Personal pronouns and their possessive forms  

-- for "I", "my", "mine"
  oper pronJa: Pron = pronJaFoo PNoGen;
  oper pronJaFoo: PronGen -> Pron = \gender ->
	 { nom = "ja";
	   voc = "ja";
	   dep = table {
	     (GenNoPrep|GenPrep) => "mnie";
	     DatNoPrep => "mi";
	     DatPrep => "mnie";
	     (AccNoPrep|AccPrep) => "mnie"; 
	     InstrC => "mną";
	     LocPrep => "mnie"
	     };
	   sp = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "mój"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "mojego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "mojemu"; 
	     AF MascInaniSg Acc => "mój"; -- widzę mój stół
	     AF (MascPersSg|MascAniSg|MascInaniSg) Acc => "mojego"; -- widzę mojego psa / przyjaciela
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "moim";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "moim"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "mój";
	     
	     AF FemSg Nom => "moja" ; 
	     AF FemSg Gen => "mojej";
	     AF FemSg Dat => "mojej"; 
	     AF FemSg Acc => "moją"; 
	     AF FemSg Instr => "moją";
	     AF FemSg Loc => "mojej";
	     AF FemSg VocP => "moja";   
	         
	     AF NeutSg Nom => "moje" ; 
	     AF NeutSg Gen => "mojego";
	     AF NeutSg Dat  => "mojemu"; 
	     AF NeutSg Acc => "moje"; 
	     AF NeutSg Instr => "moim";
	     AF NeutSg Loc => "moim";
	     AF NeutSg VocP => "moje"; 
	
     	 AF MascPersPl Nom => "moi"; 
	     AF (MascPersPl|OthersPl) Nom => "moje"; 
	     AF (MascPersPl|OthersPl) Gen => "moich";
	     AF (MascPersPl|OthersPl) Dat => "moim"; 
	     AF MascPersPl Acc => "moich"; 
	     AF (MascPersPl|OthersPl) Acc => "moje"; 
	     AF (MascPersPl|OthersPl) Instr => "moimi";
	     AF (MascPersPl|OthersPl) Loc => "moich";
	     AF MascPersPl VocP => "moi"; 
	     AF (MascPersPl|OthersPl) VocP=> "moje"
	   };
	   n = Sg;
	   p = P1 ;
	   g = gender
	 };
       

-- for "you", "yours"
  oper pronTy: Pron = pronTyFoo PNoGen;
  oper pronTyFoo: PronGen -> Pron = \gender ->
	 { sp = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "twój";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "twojego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "twojemu"; -- zróbmy to po twojemu
	     AF MascInaniSg Acc => "twój"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Acc => "twojego"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "twoim";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "twoim"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "twój";
	     
	     AF FemSg Nom  => "twoja" ; 
	     AF FemSg Gen => "twojej";
	     AF FemSg Dat => "twojej"; 
	     AF FemSg Acc => "twoją"; 
	     AF FemSg Instr => "twoją";
	     AF FemSg Loc => "twojej";
	     AF FemSg VocP => "twoja";   
	     
	     AF NeutSg Nom => "twoje" ; 
	     AF NeutSg Gen => "twojego";
	     AF NeutSg Dat  => "twojemu"; 
	     AF NeutSg Acc => "twoje"; 
	     AF NeutSg Instr => "twoim";
	     AF NeutSg Loc => "twoim";
	     AF NeutSg VocP => "twoje"; 
	     
	     AF MascPersPl Nom => "twoi"; 
	     AF (MascPersPl|OthersPl) Nom => "twoje"; 
	     AF (MascPersPl|OthersPl) Gen => "twoich";
	     AF (MascPersPl|OthersPl)  Dat   => "twoim"; 
	     AF MascPersPl Acc => "twoich"; 
	     AF (MascPersPl|OthersPl) Acc => "twoje"; 
	     AF (MascPersPl|OthersPl) Instr => "twoimi";
	     AF (MascPersPl|OthersPl) Loc => "twoich";
	     AF MascPersPl VocP => "twoi"; 
	     AF (MascPersPl|OthersPl)  VocP => "twoje"
	     };
	   nom = "ty" ; 
	   voc = "ty" ;
	   dep = table {  --  it is simplyfied to avoid variants
	     GenNoPrep => "cię";
	     GenPrep => "ciebie";
	     DatNoPrep => "tobie";
	     DatPrep => "ci";
	     AccNoPrep => "cię";
	     AccPrep => "ciebie";
	     InstrC => "tobą";
	     LocPrep => "tobie"
	     };
	   n = Sg;
	   p = P2 ;
	   g = gender
	 };
       
-- for "you polite" (very idiomatic: pron you = 'sir') male version
  oper pronPan: Pron = 
	 { nom = "pan" ;
	   voc = "panie" ;
	   dep = table {
	     GenNoPrep => "pana"; --"go"};
	     GenPrep => "pana";
	     DatNoPrep => "panu"; --"mu"};
	     DatPrep => "panu";
	     AccNoPrep => "pana"; --"go" };
	     AccPrep => "pana"; 
	     InstrC => "panem";
	     LocPrep => "panu"
	     };
	   sp = \\_ => "pana";
	   n = Sg;
	   p = P3 ;
	   g = PGen (Masc Personal)
	 };

-- for "you polite" (very idiomatic: pron you = 'madam') female version
  oper pronPani: Pron = 
	 { nom = "pani" ;
	   voc = "pani" ;
	   dep = table {
	     GenNoPrep => "pani"; --"go"};
	     GenPrep => "pani";
	     DatNoPrep => "pani"; --"mu"};
	     DatPrep => "pani";
	     AccNoPrep => "panią"; --"go" };
	     AccPrep => "panią"; 
	     InstrC => "panią";
	     LocPrep => "pani"
	     };
	   sp = \\_ => "pani";
	   n = Sg;
	   p = P3 ;
	   g = PGen (Fem)
	 };

-- for "he", "his" 
  oper pronOn: Pron = 
	 { nom = "on" ;
	   voc = "on" ;
	   dep = table {
	     GenNoPrep => "jego"; --"go"};
	     GenPrep => "niego";
	     DatNoPrep => "jemu"; --"mu"};
	     DatPrep => "niemu";
	     AccNoPrep => "jego"; --"go" };
	     AccPrep => "niego"; 
	     InstrC => "nim";
	     LocPrep => "nim"
	     };
	   sp = \\_ => "jego";
	   n = Sg;
	   p = P3 ;
	   g = PGen (Masc Personal)
	 };


-- for "she", "her", "hers"
  oper pronOna: Pron = 
	 { nom = "ona" ;
	   voc = "ona" ;
	   dep = table {
	     GenNoPrep => "jej";
	     GenPrep  => "niej";
	     DatNoPrep => "jej";
	     DatPrep => "niej";
	     AccNoPrep => "ją";
	     AccPrep => "nią"; 
	     InstrC => "nią";
	     LocPrep => "niej"
	     };
	   sp = \\_ => "jej";
	   n = Sg;
	   p = P3 ;
	   g = PGen Fem;
	 };
       

-- for "it", "its"
  oper pronOno: Pron = 
	 { nom = "ono" ;
	   voc = "ono" ;
	   dep= table {
	     GenNoPrep  => "jego"; --"go"};
	     GenPrep  => "niego";
	     DatNoPrep  => "jemu"; --"mu"};
	     DatPrep  => "niemu";
	     AccNoPrep  => "je";
	     AccPrep  => "nie"; 
	     InstrC  => "nim"; 
	     LocPrep  => "nim"
	     };
	   sp = \\_ => "jej";
	   n = Sg;
	   p = P3 ;
	   g = PGen Neut
	 };


-- for "we", "our", "us", "ours"
  oper pronMy: Pron = 
	 { nom = "my"; 
	   voc = "my";
	   dep = table {
	     (GenNoPrep|GenPrep)  => "nas";
	     (DatNoPrep|DatPrep)  => "nam"; 
	     (AccNoPrep|AccPrep)  => "nas";
	     InstrC  => "nami";
	     LocPrep  => "nas"
	     };
       sp = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Nom   => "nasz";
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Gen   => "naszego";
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Dat   => "naszemu"; -- zróbmy to po naszemu
	     AF MascInaniSg Acc => "nasz"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Acc   => "naszego"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Instr   => "naszym";
	     AF (MascPersSg|MascAniSg|MascInaniSg)  Loc   => "naszym"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg)  VocP   => "nasz";
	     
	     AF FemSg Nom   => "nasza" ; 
	     AF FemSg Gen   => "naszej";
	     AF FemSg Dat   => "naszej"; 
	     AF FemSg Acc   => "naszą"; 
	     AF FemSg Instr   => "naszą";
	     AF FemSg Loc   => "naszej";
	     AF FemSg VocP   => "nasza";   
	     
	     AF NeutSg Nom   => "nasze" ; 
	     AF NeutSg Gen   => "naszego";
	     AF NeutSg Dat    => "naszemu"; 
	     AF NeutSg Acc   => "nasze"; 
	     AF NeutSg Instr   => "naszym";
	     AF NeutSg Loc   => "naszym";
	     AF NeutSg VocP   => "nasze"; 
	     
	     AF MascPersPl Nom => "nasi"; 
	     AF (MascPersPl|OthersPl)  Nom   => "nasze"; 
	     AF (MascPersPl|OthersPl)  Gen  => "naszych";
	     AF (MascPersPl|OthersPl)  Dat     => "naszym"; 
	     AF MascPersPl Acc => "naszych"; 
	     AF (MascPersPl|OthersPl)  Acc   => "nasze"; 
	     AF (MascPersPl|OthersPl)  Instr   => "naszymi";
	     AF (MascPersPl|OthersPl)  Loc   => "naszych";
	     AF MascPersPl VocP => "nasi"; 
	     AF (MascPersPl|OthersPl)  VocP   => "nasze"
	   };
	   n = Pl;
	   p = P1 ;
	   g = PNoGen
	 };
      

-- for "you", "yours", "your"
  oper pronWy: Pron = 
	 { nom = "wy" ;
	   voc = "wy" ;
	   dep = table {
	     (GenNoPrep|GenPrep) => "was";
	     (DatNoPrep|DatPrep) => "wam"; 
	     (AccNoPrep|AccPrep) => "was";
	     InstrC => "wami";
	     LocPrep => "was"
	     };
	   sp = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom  => "wasz";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen  => "waszego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat  => "waszemu"; -- zróbmy to po waszemu
	     AF MascInaniSg Acc  => "wasz"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Acc  => "waszego"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr  => "waszym";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc  => "waszym"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP  => "wasz";
	     
	     AF FemSg Nom => "wasza" ; 
	     AF FemSg Gen => "waszej";
	     AF FemSg Dat => "waszej"; 
	     AF FemSg Acc => "waszą"; 
	     AF FemSg Instr => "waszą";
	     AF FemSg Loc => "waszej";
	     AF FemSg VocP => "wasza";   
	     
	     AF NeutSg Nom => "wasze" ; 
	     AF NeutSg Gen => "waszego";
	     AF NeutSg Dat => "waszemu"; 
	     AF NeutSg Acc => "wasze"; 
	     AF NeutSg Instr => "waszym";
	     AF NeutSg Loc => "waszym";
	     AF NeutSg VocP => "wasze"; 
	     
	     AF MascPersPl Nom => "wasi"; 
	     AF (MascPersPl|OthersPl)  Nom => "wasze"; 
	     AF (MascPersPl|OthersPl)  Gen => "waszych";
	     AF (MascPersPl|OthersPl)  Dat => "waszym"; 
	     AF MascPersPl  Acc => "waszych"; 
	     AF (MascPersPl|OthersPl) Acc => "wasze"; 
	     AF (MascPersPl|OthersPl)  Instr => "waszymi";
	     AF (MascPersPl|OthersPl)  Loc => "waszych";
	     AF MascPersPl VocP => "wasi"; 
	     AF (MascPersPl|OthersPl)  VocP => "wasze"
	     };
	   n = Pl;
	   p = P2 ;
	   g = PNoGen
	 };


-- for "they", "their", "theirs" (Sg he)= Masculinum 
 oper pronOni: Pron = 
	 { nom = "oni" ;
	   voc = "oni" ;
	   dep = table {
	     GenNoPrep => "ich";
	     GenPrep => "nich";
	     DatNoPrep => "im";
	     DatPrep => "nim";
	     AccNoPrep => "ich";
	     AccPrep => "nich"; 
	     InstrC => "nimi"; 
	     LocPrep => "nich"
	     };
	   sp = \\_ => "ich";
	   n = Pl;
	   p = P3 ;
	   g = PGen (Masc Personal)
	 };


-- for "they", "their", "theirs" (Sg she, it)= Fem), Neut)
  oper pronOneFem: Pron = 
	 { nom = "one" ;
	   voc = "one" ;
	   dep = table {
	     GenNoPrep => "ich";
	     GenPrep => "nich";
	     DatNoPrep => "im";
	     DatPrep => "nim";
	     AccNoPrep => "je";
	     AccPrep => "nie"; 
	     InstrC => "nimi"; 
	     LocPrep => "nich"
	     };
	   sp = \\_ => "ich";
	   n = Pl;
	   p = P3 ;
	   g = PGen Fem
	 };
  
  oper pronOneNeut: Pron = 
	 { nom = "one" ;
	   voc = "one" ;
	   dep = table {
	     GenNoPrep => "ich";
	     GenPrep => "nich";
	     DatNoPrep => "im";
	     DatPrep => "nim";
	     AccNoPrep => "je";
	     AccPrep => "nie"; 
	     InstrC => "nimi"; 
	     LocPrep => "nich"
	     };
	   sp = \\_ => "ich";
	   n = Pl;
	   p = P3 ;
	   g = PGen Neut
	 };
--4.3 Interrogative pronouns  
{-
-- for "who", "whose"
   oper pronKto : Pron =
	 { s = table {
	     PF Nom _ NonPoss => "kto" ;
	     (GenNoPrep|GenPrep) NonPoss => "kogo";
	     (DatNoPrep|DatPrep) NonPoss => "komu";
	     (AccNoPrep|AccPrep) NonPoss => "kogo";
	     InstrC NonPoss => "kim";
	     LocPrep NonPoss => "kim";
	     PF VocP _ NonPoss => nonExist;
	     PF _ _ (Poss _ _) => nonExist -- exists in my opinion [asl] : czyje
	     };
	   n = Sg;
	   p = P3 ;
	   g = PGen (Masc Personal);
	   pron = False
	 };


-- for "what"
  oper pronCo : Pron =
	 { s = table {
	     PF Nom _ NonPoss => "co";
	     (GenNoPrep|GenPrep) NonPoss => "czego";
	     (DatNoPrep|DatPrep) NonPoss => "czemu";
	     (AccNoPrep|AccPrep) NonPoss => "co";
	     InstrC NonPoss => "czym";
	     LocPrep NonPoss => "czym";
	     PF VocP _ NonPoss => nonExist;
	     PF _ _ (Poss _ _) => nonExist 
	     };
	   n = Sg;
	   p = P3 ;
	   g = PGen (Masc Personal);
	   pron = False
	 };



--4.4 Indefinite pronouns  

-- for "somebody", "someone", "someone's"
-- in negative sentence, question for "anybody", "anyone"

-- ktoś

-- for "someone", "somebody", "someone's", "somebody's"
-- in question for "anyone", "anybody", "anyone's", "anybody's"
  oper pronKtokolwiek : Pron =
	 { s = table {
	     PF Nom _ NonPoss => "ktokolwiek";
	     (GenNoPrep|GenPrep) NonPoss => "kogokolwiek";
	     (DatNoPrep|DatPrep) NonPoss => "komukolwiek";
	     (AccNoPrep|AccPrep) NonPoss => "kogokolwiek";
	     InstrC NonPoss => "kimkolwiek";
	     LocPrep NonPoss => "kimkolwiek";
	     PF VocP _ NonPoss => nonExist;
	     PF _ _ (Poss _ _) => nonExist 
	     };
	   n = Sg;
	   p = P3 ;
	   g = PGen (Masc Personal);
	   pron = False
	 };



-- for "something", "its"
-- in negativ sentence, question or if-sentence for "anything"

-- coś

-- for "something", "its"
-- in question for "anything"

-- doesn't seam to true, doesn't seam to be necessary

--   oper pronCokolwiek : Pron =
-- 	 { s = table {
-- 	     PF Nom _ NonPoss => "cokolwiek";
-- 	     (GenNoPrep|GenPrep) NonPoss => "czegokolwiek";
-- 	     (DatNoPrep|DatPrep) NonPoss => "czemukolwiek";
-- 	     (AccNoPrep|AccPrep) NonPoss => "cokolwiek";
-- 	     InstrC NonPoss => "czymkolwiek";
-- 	     LocPrep NonPoss => "czymkolwiek";
-- 	     PF VocP _ NonPoss => nonExist;
-- 	     PF _ _ (Poss _ _) => nonExist 
-- 	     };
-- 	   n = Sg;
-- 	   p = P3 ;
-- 	   g = PGen (Neut));
-- 	   pron = False
-- 	 };




--4.5 Negation pronouns 



-- for "nobody". Sg and Pl forms given. It is used like 
-- an adjective before a noun. So the end product of this 
-- oper is an adjectiv and no pronoun.
--   oper pronZaden :  Str -> Adjective = \zaden ->
-- 	 let   x = fleetingEminus zaden 
-- 	 in 
-- 	 table {
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) Nom => zaden;
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) Gen => x +"ego";
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) Dat => x +"emu";
-- 		AF MascInaniSg Acc => zaden;
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) Acc => x +"ego";
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) VocP => zaden;
-- 		AF (MascPersSg|MascAniSg|MascInaniSg) _ => x + "ym";
--          ---------------------------
-- 		AF FemSg Nom => x +"a";
-- 		AF FemSg Acc => x +"ą";
-- 		AF FemSg Instr => x + "ą";
-- 		AF FemSg VocP => x + "a";
-- 		AF FemSg _ => x + "ej";
--          ---------------------------
-- 		AF NeutSg Gen => x +"ego"; 
-- 		AF NeutSg Dat => x +"emu"; 
-- 		AF NeutSg Instr => x + "ym"; 
-- 		AF NeutSg Loc => x + "ym";
-- 		AF NeutSg _ => x + "e";
--         -----------------------------
-- 		AF MascPersPl Nom => x;
-- 		AF MascPersPl Dat => x + "ym";
-- 		AF MascPersPl Instr => x + "ymi";
-- 		AF MascPersPl VocP => x; 
-- 		AF MascPersPl _ => x + "ych";
--           ---------------------------
-- 		AF (MascPersPl|OthersPl) Nom => x + "e";
-- 		AF (MascPersPl|OthersPl) Dat => x +"ym";
-- 		AF (MascPersPl|OthersPl) Acc => x + "e";
-- 		AF (MascPersPl|OthersPl) Instr => x + "mi"; 
-- 		AF (MascPersPl|OthersPl) VocP => x + "e";
-- 		AF (MascPersPl|OthersPl) _ => x + "ych"
-- 	        };
-- 
-- 
-}
--4.6 Demonstrativ pronouns  

-- for "ten" ("this") and "tamten" ("that")
  oper demPronTen:  Str -> { s,sp : AForm => Str } = \s ->   
	 let
	   x = Predef.tk 3 s
	 in
	  { s,sp = table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => x + "ten";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => x + "tego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => x + "temu";
	     AF MascInaniSg Acc => x + "ten";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Acc => x + "tego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "[" ++ x +"ten" ++ [": the vocative form does not exist]"];
	     AF (MascPersSg|MascAniSg|MascInaniSg) _ => x + "tym";
  ---------------------------
	     AF FemSg Nom => x + "ta";
	     AF FemSg Acc => x + "tę";
	     AF FemSg Instr => x + "tą";
	     AF FemSg VocP => "["+x + "ten"++[": the vocative form does not exist]"];
	     AF FemSg _ => x + "tej";
  ---------------------------
	     AF NeutSg Nom => x + "to"; 
	     AF NeutSg Gen => x + "tego"; 
	     AF NeutSg Dat => x + "temu"; 
	     AF NeutSg Acc => x + "to";
	     AF NeutSg VocP => "["+x + "ten"++[": the vocative form does not exist]"];
	     AF NeutSg _ => x + "tym"; 
  ----------------------------
	     AF MascPersPl Nom => x + "ci";
	     AF MascPersPl Dat => x + "tym";
	     AF MascPersPl Instr => x + "tymi";
	     AF MascPersPl VocP => "["+x + "ten"++[": the vocative form does not exist]"];
	     AF MascPersPl _ => x + "tych";
  ---------------------------
	     AF (MascPersPl|OthersPl) Nom => x + "te";
	     AF (MascPersPl|OthersPl) Dat => x + "tym";
	     AF (MascPersPl|OthersPl) Acc => x + "te";
	     AF (MascPersPl|OthersPl) Instr => x + "tymi"; 
	     AF (MascPersPl|OthersPl) VocP => "["+x + "ten"++[": the vocative form does not exist]"];
	     AF (MascPersPl|OthersPl) _ => x + "tych"
	 } } ;

  oper wszystek : AForm => Str = 
	 table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "wszystek"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "wszystkiego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "wszystkiemu"; 
	     AF MascInaniSg Acc => "wszystek"; -- wszystky stół widzę
	     AF (MascPersSg|MascAniSg) Acc => "wszystkiego"; -- wszystkego psa / przyjaciela widzę
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "wszystkim";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "wszystkim"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "wszystek";
	     
	     AF FemSg Nom => "wszystka"; 
	     AF FemSg Gen => "wszystkiej";
	     AF FemSg Dat => "wszystkiej"; 
	     AF FemSg Acc => "wszystką"; 
	     AF FemSg Instr => "wszystką";
	     AF FemSg Loc => "wszystkiej";
	     AF FemSg VocP => "wszystka";   
	         
	     AF NeutSg Nom => "wszystkie" ; 
	     AF NeutSg Gen => "wszystkiego";
	     AF NeutSg Dat  => "wszystkiemu"; 
	     AF NeutSg Acc => "wszystkie"; 
	     AF NeutSg Instr => "wszystkim";
	     AF NeutSg Loc => "wszystkim";
	     AF NeutSg VocP => "wszystkie"; 
	
     	 AF MascPersPl Nom => "wszyscy"; 
	     AF OthersPl Nom => "wszystkie"; 
	     AF (MascPersPl|OthersPl) Gen => "wszystkich";
	     AF (MascPersPl|OthersPl) Dat => "wszystkim"; 
	     AF MascPersPl Acc => "wszystkich"; 
	     AF (MascPersPl|OthersPl) Acc => "wszystkie"; 
	     AF (MascPersPl|OthersPl) Instr => "wszystkimi";
	     AF (MascPersPl|OthersPl) Loc => "wszystkich";
	     AF MascPersPl VocP => "wszyscy"; 
	     AF OthersPl VocP => "wszystkie"
	     };


{-
-- 
-- -- oper for "a"
--   oper jedenDet:  Str -> Adjective = \s ->   
-- 	 table {
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "jeden";
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "jednego";
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "jednemu";
-- 	     AF MascInaniSg Acc => "jeden";
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) Acc => "jednego";
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => nonExist;
-- 	     AF (MascPersSg|MascAniSg|MascInaniSg) _ => "jednym";
--   ---------------------------
-- 	     AF FemSg Nom => "jedna";
-- 	     AF FemSg Acc => "jedną";
-- 	     AF FemSg Instr => "jedną";
-- 	     AF FemSg VocP => nonExist;
-- 	     AF FemSg _ => "jednej";
--   ---------------------------
-- 	     AF NeutSg Nom => "jedno"; 
-- 	     AF NeutSg Gen => "jedno"; 
-- 	     AF NeutSg Dat => "jednemu"; 
-- 	     AF NeutSg Acc => "jedno";
-- 	     AF NeutSg VocP => nonExist;
-- 	     AF NeutSg _ => "jednym"; 
--   ----------------------------
-- 	     AF MascPersPl Nom => "jedni";
-- 	     AF MascPersPl Dat => "jednym";
-- 	     AF MascPersPl Instr => "jednymi";
-- 	     AF MascPersPl VocP => nonExist; 
-- 	     AF MascPersPl _ => "jednych";
--   ---------------------------
-- 	     AF (MascPersPl|OthersPl) Nom => "jedne";
-- 	     AF (MascPersPl|OthersPl) Dat => "jednym";
-- 	     AF (MascPersPl|OthersPl) Acc => "jedne";
-- 	     AF (MascPersPl|OthersPl) Instr => "jednymi"; 
-- 	     AF (MascPersPl|OthersPl) VocP => nonExist;
-- 	     AF (MascPersPl|OthersPl) _ => "jednych"
-- 	 };
-- 
-- 
-- 
-- --4.7 Generalized pronouns ?????????????????
-- 
-- --???????????????????????????? english
-- -- pronoun "all"
-- 

--4.8 Pronouns used in funtion of DET, PREDET 

-- Here, I have to define "wszystek" again, but only for the plural.
-- I need it in declension of pronKazdy, because "każdy" has only 
-- sg forms. In pl they are used forms of "wszyscy".

--   oper pronWszystekDet : Str -> Adjective = \wszyscy ->
-- 	 table {
-- 	   AF MascPersPl Nom => "wszyscy";
-- 	   AF (MascPersPl|OthersPl) _) Nom => "wszystkie";
-- 	   AF (MascPersPl|OthersPl) _) Gen => "wszystkich";
-- 	   AF (MascPersPl|OthersPl) _) Dat => "wszystkim";
-- 	   AF MascPersPl Acc => "wszystkich";
-- 	   AF (MascPersPl|OthersPl) _) Acc => "wszystkie";
-- 	   AF (MascPersPl|OthersPl) _) Instr => "wszystkimi";
-- 	   AF (MascPersPl|OthersPl) _) Loc => "wszystkich";
-- 	   _ => nonExist 
-- 	 };


-- I need this oper for building of pronouns like "każdy". 
-- This pronoun has not any plural forms. For plural it is used
-- the pronoun "wszyscy" ( Pl form of "wszystek")

--   oper pronKazdy : (x : Str ) -> {s : Number => Adjective} = \x ->
-- 	 {s = table {
-- 	    Sg => table {af => ((AdjectivDeclension "każdy") ! af)}; 
-- 	    Pl => table {af => ((pronWszystekDet "wszyscy") ! af)} 
-- 	    	 }};
-}
}
