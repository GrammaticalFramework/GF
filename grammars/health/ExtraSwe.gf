-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude:../swedish

--1 Functions that are not in the API, but common in Russian 
--
-- Aarne Ranta, Janna Khegai 2003

resource ExtraSwe = open PredicationSwe, ResourceSwe, Prelude, SyntaxSwe in {

oper 
  patientNPCategory : Type = {s : NPForm => Str ; 
           g : Gender ; n : Number; p : Person }** {lock_NP : {}} ;

  mkPronPatient : ProPN -> patientNPCategory = \jag ->
   {s = jag.s ; g = jag.h1 ; n = jag.h2 ; p = jag.h3;
    lock_NP = <>
 } ; 

  nullDet : Det = { s = table {_ => table {_ => ""}} ; 
            n = Sg ; b = IndefP; lock_Det =<> } ;

  injuredBody: patientNPCategory -> CN -> S = 
    \Jag, head -> 
    let {
      jag  = Jag.s ! PNom ; 
      harSkadat  = ["har skadat"] ;
      mig = case Jag.p of 
            {
              P1 => case Jag.n of 
                    { Sg => "mig" ;
                      Pl => "oss" 
                    }  ;
              P2 => case Jag.n of 
                    { Sg => "dig" ;
                      Pl => "er" 
                    }   ;
              P3 => "sig"
            } ;
      iBenet  = "i" ++ (defNounPhrase Jag.n head).s ! PNom
    } in
    {s = table {
       _ => jag ++ harSkadat ++ mig++ iBenet 
       };
    lock_S = <>

    } ;

 sFeber : Str -> Subst = \feb -> 
 {s = table {
    SF Sg Indef Nom => feb + "er" ;
    SF Sg Indef Gen => feb + "ers" ;
    SF Sg Def Nom => feb + "ern" ;
    SF Sg Def Gen => feb + "erns" ;
    SF Pl Indef Nom => feb + "rar" ;
    SF Pl Indef Gen => feb + "rars" ;
    SF Pl Def Nom => feb + "rar" ;
    SF Pl Def Gen => feb + "rars"
    } ;
  h1 = Utr
  } ;

  verbTa = {s = table {VPres Infinit _ => "ta" ; VPres Indicat _ => "tar" ; VPres Imperat _ => "ta"}; s1 =""} ;
  verbBehova = {s = table {VPres Infinit _ => "behöva" ; VPres Indicat _ => "behöver" ; VPres Imperat _ => 
            "behöv"}; s1 =""} ;

-- almost from Predication:
--  predV2: TV -> patientNPCategory -> NP -> S = \F, x, y -> 
--     predVerbPhrase x ((predVerbGroup True) (complTransVerb F y)) ** { lock_S = <>} ;

};


