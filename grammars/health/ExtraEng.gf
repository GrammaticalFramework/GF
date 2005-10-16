-- use this path to read the grammar from the same directory
--# -path=.:../../lib/resource-0.6/abstract:../../lib/prelude:../../lib/resource-0.6/english

--1 Functions that are not in the API, but common in Russian 
--
-- Aarne Ranta, Janna Khegai 2003

resource ExtraEng = open PredicationEng, ResourceEng, Prelude, SyntaxEng in {

oper 
  BodyCNCategory : Type =   
     { s : Bool => Number => Case => Str ; painInType : Bool} ;

  mkPain: BodyCNCategory -> CN = \body ->
     cnNoHum({ s = \\_,_ => body.s ! body.painInType ! Sg ! Nom  })** {lock_CN = <>} ;       

  mkBody: BodyCNCategory -> CN = \body ->
     cnNoHum({ s = \\n,_ => body.s ! True ! n ! Nom })** {lock_CN = <>} ;       

  injuredBody: TV -> NP -> BodyCNCategory -> S = 
    \haveInjured, patient, head -> 
    predV2 haveInjured patient (hisHead patient (mkBody head) **{lock_NP = <>}) ;

  nullDet : Det = mkDeterminer Sg [] ** {lock_Det = <>};

  hisHead: NP -> CN -> NP =\patient, head ->
    { s =\\c => patient.s ! GenP ++ head.s ! patient.n ! Nom ; 
      n = patient.n ; p = P3 ; lock_NP = <>} ;

  tvHave: TV = mkTransVerbDir verbP3Have ** {lock_TV = <>};


  painInPatientsBody: CN -> NP -> BodyCNCategory -> S = 
    \pain, patient, head -> case head.painInType of { 
      False => predV2 tvHave patient (DetNP (aDet** {lock_Det = <>}) ( mkPain head));
      True => predV2 tvHave patient (DetNP nullDet 
       (
        cnNoHum(appFunComm (pain ** {s2 = "in"}) 
        (hisHead patient (mkBody head)))** {lock_CN = <>}
       )
      )   
   } ;

  painInPatientsBodyMode: CN -> NP -> BodyCNCategory -> AP -> S = 
   \pain, patient, head, degree -> case head.painInType of { 
     False => predV2 tvHave patient (DetNP (aDet** {lock_Det = <>}) 
        (
           modCommNounPhrase degree (mkPain head) ** {lock_CN = <>}
        ));
     True =>  predV2 tvHave patient (DetNP nullDet 
        (
          modCommNounPhrase degree 
          (
             cnNoHum 
            (
              appFunComm (pain ** {s2 = "in"}) 
              (hisHead patient (mkBody head))
            )
          ) ** {lock_CN = <>}
       ))
   } ;

};


