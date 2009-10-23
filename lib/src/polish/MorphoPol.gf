--# -path=.:../prelude:../common:../abstract
--# -coding=utf8

--1 A polish Resource Morphology 
--
-- Ilona Nowak, Wintersemester 2007/08
--
-- Adam Slaski, 2009 <adam.slaski@gmail.com>
--
-- This resource morphology contains definitions 
-- of the lexical entries needed in the resource syntax. 
-- It moreover contains copies of the most usual inflectional patterns.

-- I use the parameter types and word classes defined for morphology.

resource MorphoPol = 
    ResPol, 
    VerbMorphoPol, 
    PronounMorphoPol,
    AdjectiveMorphoPol,
    NounMorphoPol ** open Prelude, (Predef=Predef) in {

     flags  coding=utf8; 

-- definitions for structural objects

  oper
    wszyscy : NounPhrase = {
      nom = "wszyscy" ;
      voc = "wszyscy" ;
      dep = table {
        (GenNoPrep|GenPrep) => "wszystkich";
        (DatNoPrep|DatPrep) => "wszystkim";
        (AccNoPrep|AccPrep) => "wszystkich";
        (InstrNoPrep|InstrPrep) => "wszystkimi";
        LocPrep => "wszystkich"
      };
      p = P3 ;
      gn = MascPersPl -- in fact it is plurale tantum ver. 3
    };
    
    wszystko : NounPhrase = {
      nom = "wszystko" ;
      voc = "wszystko" ;
      dep = table {
        (GenNoPrep|GenPrep) => "wszystkiego";
        (DatNoPrep|DatPrep) => "wszystkiemu";
        (AccNoPrep|AccPrep) => "wszystko";
        (InstrNoPrep|InstrPrep) => "wszystkim";
        LocPrep => "wszystkim"
      };
      p = P3;
      gn = NeutSg -- in fact it is plurale tantum ver. 3
    };
    
    ktos : NounPhrase = { 
      nom = "ktoś" ;
      voc = "ktosiu" ;
      dep = table {
	     (GenNoPrep|GenPrep) => "kogoś";
	     (DatNoPrep|DatPrep) => "komuś";
	     (AccNoPrep|AccPrep) => "kogoś";
	     (InstrNoPrep|InstrPrep) => "kimś";
	     LocPrep => "kimś"
	     };
	   p = P3 ;
	   gn = MascPersSg
	};
    
    cos : NounPhrase = {
      nom = "coś" ;
      voc = "coś" ;
      dep = table {
	     (GenNoPrep|GenPrep) => "czegoś";
	     (DatNoPrep|DatPrep) => "czemuś";
	     (AccNoPrep|AccPrep) => "coś";
	     (InstrNoPrep|InstrPrep) => "czymś";
	     LocPrep => "czymś"
	     };
	   p = P3 ;
	   gn = NeutSg
	};
	 

    kto : NounPhrase = { 
      nom = "kto" ;
      voc = "kto" ;
      dep = table {
	     (GenNoPrep|GenPrep) => "kogo";
	     (DatNoPrep|DatPrep) => "komu";
	     (AccNoPrep|AccPrep) => "kogo";
	     (InstrNoPrep|InstrPrep) => "kim";
	     LocPrep => "kim"
	     };
	   p = P3 ;
	   gn = MascPersSg
	};
	
    co : NounPhrase = {
      nom = "co" ;
      voc = "co" ;
      dep = table {
	     (GenNoPrep|GenPrep) => "czego";
	     (DatNoPrep|DatPrep) => "czemu";
	     (AccNoPrep|AccPrep) => "co";
	     (InstrNoPrep|InstrPrep) => "czym";
	     LocPrep => "czym"
	     };
	   p = P3 ;
	   gn = NeutSg
	};

	kazdyDet : Determiner = {
	  s,sp = table {
	    Nom => table {Masc _ => "każdy"; Fem => "każda"; (Neut|NeutGr) => "każde" };
        Gen => table {Masc _ => "każdego"; Fem => "każdą"; (Neut|NeutGr) => "każdego" };
        Dat => table {Masc _ => "każdemu"; Fem => "każdej"; (Neut|NeutGr) => "każdemu" };
        Acc => table {Masc (Personal|Animate) => "każdego"; Masc Inanimate => "każdy"; Fem => "każdą"; (Neut|NeutGr) => "każde" };
        Instr => table {Masc _ => "każdym"; Fem => "każdą"; (Neut|NeutGr) => "każdym" };
        Loc => table {Masc _ => "każdym"; Fem => "każdej"; (Neut|NeutGr) => "każdym" };
        VocP => table {Masc _ => "każdy"; Fem => "każda"; (Neut|NeutGr) => "każde" }
      };
	  n = Sg;
	  a = NoA;
	};
	
	pareDet : Determiner = {
	  s,sp = table {
	    Nom => table {Masc Personal => "paru"; _ => "parę" };
	    Gen => table { _ => "paru" };
	    Dat => table { _ => "paru" };
	    Acc => table {Masc Personal => "paru"; _ => "parę" };
	    Instr => table { _ => "paroma" };
	    Loc => table { _ => "paru" };
	    VocP => table {Masc Personal => "paru"; _ => "parę" }
	  };
	  n = Pl;
	  a = StoA
	};
	
	wieleDet : Determiner = {
	  s,sp = table {
	    Nom => table {Masc Personal => "wielu"; _ => "wiele" };
	    Gen => table { _ => "wielu" };
	    Dat => table { _ => "wielu" };
	    Acc => table {Masc Personal => "wielu"; _ => "wiele" };
	    Instr => table { _ => "wieloma" };
	    Loc => table { _ => "wielu" };
	    VocP => table {Masc Personal => "wielu"; _ => "wiele" }
	  };
	  n = Pl;
	  a = StoA
	};

	duzoDet : Determiner = {
	  s,sp = \\_,_=>"dużo";{-	  
	  table {
	    Nom => table { _ => "dużo" };
	    Gen => table { _ => "dużo" };
	    Dat => table { _ => variants {} };
	    Acc => table { _ => "dużo" };
	    Instr => table { _ => variants {} };
	    Loc => table { _ => variants {} };
	    VocP => table {_ => "dużo" }
	  };-}
	  n = Pl;
	  a = StoA
	};

	ileDet : IDeterminer = {
	  s = table {
	    Nom => table {Masc Personal => "ilu"; _ => "ile" };
	    Gen => table { _ => "ilu" };
	    Dat => table { _ => "ilu" };
	    Acc => table {Masc Personal => "ilu"; _ => "ile" };
	    Instr => table { _ => "ilu" };
	    Loc => table { _ => "ilu" };
	    VocP => table {Masc Personal => "ilu"; _ => "ile" }
	  };
	  n = Pl;
	  a = StoA
	};
	
	-- for "nobody", "noone", "none"
  oper niktNP : NounPhrase =
	 { voc,nom="nikt";
	   dep = table {
	     (GenNoPrep|GenPrep) => "nikogo";
	     (DatNoPrep|DatPrep) => "nikomu";
	     (AccNoPrep|AccPrep) => "nikogo";
	     (InstrNoPrep|InstrPrep) => "nikim";
	     LocPrep => "nikim"
	     };
	   p=P3;
	   gn= MascPersSg
	 };

-- for "nothing"
  oper nicNP : NounPhrase =
	 { voc,nom="nic";
	   dep = table {
	     (GenNoPrep|GenPrep) => "niczego";
	     (DatNoPrep|DatPrep) => "niczemu";
	     (AccNoPrep|AccPrep) => "niczego";
	     (InstrNoPrep|InstrPrep) => "niczym";
	     LocPrep => "niczym"
	     };
	   p=P3;
	   gn= NeutSg
	 };
	 
  zadenQuant : { s,sp:AForm=>Str } = {s,sp=table {
	     AF (MascPersSg|MascAniSg|MascInaniSg) Nom => "żaden"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) Gen => "żadnego";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Dat => "żadnemu"; 
	     AF MascInaniSg Acc => "żaden"; -- który stół widzę
	     AF (MascPersSg|MascAniSg) Acc => "żadnego"; -- którego psa / przyjaciela widzę
	     AF (MascPersSg|MascAniSg|MascInaniSg) Instr => "żadnym";
	     AF (MascPersSg|MascAniSg|MascInaniSg) Loc => "żadnym"; 
	     AF (MascPersSg|MascAniSg|MascInaniSg) VocP => "żadny";
	     
	     AF FemSg Nom => "żadna" ; 
	     AF FemSg Gen => "żadnej";
	     AF FemSg Dat => "żadnej"; 
	     AF FemSg Acc => "żadną"; 
	     AF FemSg Instr => "żadną";
	     AF FemSg Loc => "żadnej";
	     AF FemSg VocP => "żadna";   
	         
	     AF NeutSg Nom => "żadne" ; 
	     AF NeutSg Gen => "żadnego";
	     AF NeutSg Dat  => "żadnemu"; 
	     AF NeutSg Acc => "żadne"; 
	     AF NeutSg Instr => "żadnym";
	     AF NeutSg Loc => "żadnym";
	     AF NeutSg VocP => "żadne"; 
	
     	 AF MascPersPl Nom => "żadni"; 
	     AF (MascPersPl|OthersPl) Nom => "żadne"; 
	     AF (MascPersPl|OthersPl) Gen => "żadnych";
	     AF (MascPersPl|OthersPl) Dat => "żadnym"; 
	     AF MascPersPl Acc => "żadnych"; 
	     AF (MascPersPl|OthersPl) Acc => "żadne"; 
	     AF (MascPersPl|OthersPl) Instr => "żadnymi";
	     AF (MascPersPl|OthersPl) Loc => "żadnych";
	     AF MascPersPl VocP => "żadni"; 
	     AF (MascPersPl|OthersPl) VocP=> "żadne"
	   }};
	
	pewienDet : Determiner = {
	  s,sp = table {
	    Nom => table {Masc _ => "pewien"; Fem=>"pewna"; _ => "pewne" };
	    Gen => table { Fem=>"pewnej"; _ => "pewnego" };
	    Dat => table { Fem=>"pewnej"; _ => "pewnemu" };
	    Acc => table { Masc Inanimate => "pewien"; Masc _ => "pewnego"; Fem=>"pewną"; _ => "pewne" };
	    Instr => table { Fem=>"pewną"; _=> "pewnym" };
	    Loc => table { Fem=>"pewnej"; _=> "pewnym" };
	    VocP => table {Masc _ => "pewny"; Fem=>"pewna"; _ => "pewne" }
	  };
	  n = Sg;
	  a = NoA
	};

	pewniDet : Determiner = {
	  s,sp = table {
	    Nom => table {Masc Personal => "pewni"; _ => "pewne" };
	    Gen => table { _ => "pewnych" };
	    Dat => table { _ => "pewnym" };
	    Acc => table {Masc Personal => "pewnych"; _ => "pewne" };
	    Instr => table { _ => "pewnymi" };
	    Loc => table { _ => "pewnych" };
	    VocP => table {Masc Personal => "pewni"; _ => "pewne" }
	  };
	  n = Pl;
	  a = NoA
	};

}
