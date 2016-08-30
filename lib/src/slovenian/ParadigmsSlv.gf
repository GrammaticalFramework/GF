resource ParadigmsSlv = open CatSlv, ResSlv, Prelude in {

oper
  nominative : Case = Nom ;
  genitive   : Case = Gen ;
  dative     : Case = Dat ;
  accusative : Case = Acc ;
  locative   : Case = Loc ;
  instrumental:Case = Instr ;

  mkPrep : Str -> Case -> Prep =
    \s,c -> lin Prep {s=s; c=c};

  animate   = AMasc Animate;
  masculine = AMasc Inanimate;
  feminine  = AFem;
  neuter    = ANeut;

  mkN = overload {
    mkN : (noun : Str) -> N = smartN ;
    mkN : (noun : Str) -> AGender -> N = regNouns ;
    mkN : (noun,gensg : Str) -> AGender -> N = irregNouns ;
    mkN : (noun,gensg,nompl : Str) -> N = irregMasc ;
    mkN : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> AGender -> N = worstN ;
    } ;

--All masculine forms (except those with long pluralstem) are formed here. 
--Takes the baseform + the genitive singular form + animacy. 
--In case the genitive singular has an extra vowel in the end, it is dropped before coming here.  

  mascAll : (_,_ : Str) -> Animacy -> N = \oce,ocet,anim ->
    let accsg = case anim of {Animate => ocet + "a"; _ => oce}; --Special case: Masc Sg Acc Animate
    in
    worstN oce          (ocet + "a")  (ocet + "u")   accsg        (ocet + "u")  (ocet + "om")  -- Singular
           (ocet + "a") (ocet + "ov") (ocet + "oma") (ocet + "a") (ocet + "ih") (ocet + "oma") -- Dual
           (ocet + "i") (ocet + "ov") (ocet + "om")  (ocet + "e") (ocet + "ih") (ocet + "i")   -- Plural
           (AMasc anim) ;

--All neuter forms are formed here, long or normal. 
--It takes the baseform + the genitive singular form. 
--In case the genitive singular has an extra vowel in the end, it is dropped before coming here. 

  neutAll : (_,_ : Str) -> N = \drevo,dreves ->
    worstN drevo          (dreves + "a") (dreves + "u")   drevo            (dreves + "u")  (dreves + "om")  -- Singular
           (dreves + "i") dreves         (dreves + "oma") (dreves + "i")   (dreves + "ih") (dreves + "oma") -- Dual
           (dreves + "a") dreves         (dreves + "om")  (dreves + "a")   (dreves + "ih") (dreves + "i")   -- Plural
           neuter ;

--Regular feminine nouns are formed from the baseform. Always inanimate. 

  regFem : (_ : Str) -> N = \punca -> 
      let punc = init punca 
      in
      worstN punca        (punc + "e") (punc + "i")   (punc + "o") (punc + "i")  (punc + "o")   -- Singular
             (punc + "i") punc         (punc + "ama") (punc + "i") (punc + "am") (punc + "ama") -- Dual
             (punc + "e") punc         (punc + "am")  (punc + "e") (punc + "am") (punc + "ami") -- Plural
             feminine ;

--This is a smart paradigm for regular nouns. 

  smartN : (noun: Str) -> N =
    \noun -> case noun of {
      _ + "a" => regFem noun ;
      _ + ("ev" | "ost") => regFem noun ;
      _ + ("o"| "e") => let nou = init noun in neutAll noun nou ;
      _ + #consonant => mascAll noun noun Inanimate; --Base form used in the rest of the paradigm. 
      _ => let nou = init noun in mascAll noun nou Inanimate -- Drops the last vowel for the rest of the paradigm. 
  } ;

--Send the masculine and neutral nouns with long stem off to the right paradigm. 

  irregNouns : (noun,longform : Str) -> AGender -> N = \noun,longform,gen ->
    case gen of {
      AMasc anim => let longfor = init longform in mascAll noun longfor anim ;
      ANeut      => let longfor = init longform in neutAll noun longfor ;
      AFem       => regFem noun --There are actually no feminine nouns with long stem. 
      } ;

--Regular masculine nouns that do not end with a consonant, drops the vowel in all conjugated forms. 
--Takes the baseform + animacy. 

  regNouns : (noun : Str) -> AGender -> N = \noun,gen ->
    case gen of {
      AMasc anim => case noun of {
                      _ + #consonant => mascAll noun noun anim ;
                      _ + #vowel => let nou = init noun in mascAll noun nou anim
                    };
      ANeut      => let nou = init noun in neutAll noun nou ;
      AFem       => regFem noun --There are actually no feminine nouns with long stem. 
      } ;

--Irregular masculine nouns with long stem has no special ending in genitive dual and plural, so need a special paradigm. 
--Takes the baseform + the genitive singular form + the nominative plural form + animacy.  

  irregMasc : (noun,gensg,plstem : Str) -> N = \bog,boga,bogovi ->
      let bogov = init bogovi in
      worstN bog           boga  (bog + "u")     bog           (bog + "u")    (bog + "om")     -- Singular
             (bogov + "a") bogov (bogov + "oma") (bogov + "a") (bogov + "ih") (bogov + "oma")  -- Dual
             bogovi        bogov (bogov + "om")  (bogov + "e") (bogov + "ih") (bogov + "i")    -- Plural
             masculine ;

  worstN : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> AGender -> N =
      \nomsg,gensg,datsg,accsg,locsg,instrsg,nomdl,gendl,datdl,accdl,locdl,instrdl,nompl,genpl,datpl,accpl,locpl,instrpl,g -> lin N {
       s = table {
             Nom   => table {Sg=>nomsg; Dl=>nomdl; Pl=>nompl};
             Gen   => table {Sg=>gensg; Dl=>gendl; Pl=>genpl};
             Dat   => table {Sg=>datsg; Dl=>datdl; Pl=>datpl};
             Acc   => table {Sg=>accsg; Dl=>accdl; Pl=>accpl};
             Loc   => table {Sg=>locsg; Dl=>nomdl; Pl=>locpl};
             Instr => table {Sg=>instrsg; Dl=>instrdl; Pl=>instrpl}
           };
       g = g
    };

  mkPN = overload {
    mkPN : N -> PN = \noun -> lin PN {
      s = \\c => noun.s ! c ! Sg ;
      g = noun.g
    };
    mkPN : (_,_,_,_,_,_ : Str) -> AGender -> PN =
      \nom,gen,dat,acc,loc,instr,g -> lin PN {
         s = table {
               Nom   => nom;
               Gen   => gen;
               Dat   => dat;
               Acc   => acc;
               Loc   => loc;
               Instr => instr
             };
         g = g
      };
    } ;

  mkV = overload {
    mkV : (inf,stem : Str) -> V = regV ; 
    mkV : (inf,stem,lstem : Str) -> V = irregVa ; 
    mkV : (inf,stem,lstem,imp : Str) -> V = irregVb ; 
    mkV : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x25 : Str) -> V = worstV ;
    } ;

-- Regular verbs are formed from two forms. Infinitive and 3rd person singular presens. 

  regV : (_,_ : Str) -> V = \hoditi,hodi ->  
        let 
          imp = mkImp hodi
        in
        mkAllV hoditi hodi (hodi +"l") (hodi +"l") imp ;

-- Verbs with irregular l-forms are formed from three forms: 
---The infinitive, 3rd person singular presens, and the l-form for Masc Sg. 
-- L-form with that ends with "el" drops the e in all other conjugations. 

  irregVa : (_,_,_ : Str) -> V = \pisati,pise,pisal ->  
        let 
          imp = mkImp pise ; 
          pisl = looseVowel pisal
        in
        mkAllV pisati pise pisal pisl imp ;

--Verbs with irregular imperative-form takes the imperative base form as a final argument. 

  irregVb : (_,_,_,_ : Str) -> V = \gledati,gleda,gledal,glej -> 
        let 
          lfem = looseVowel gledal
        in 
        mkAllV gledati gleda gledal lfem glej;

--The final paradigm-generator for all verbforms. Takes the infinitive,thirdpersonsingular in present tense,
--masculine l-form, feminine l-form and the imperative base form. 

  mkAllV : (_,_,_,_,_ : Str) -> V = \infinitive,thirdpsg,lformmasc,lformfem,imp ->  
            let 
              sup = init infinitive  --Supine is formed by dropping the last letter of the infinitive
            in
            worstV  infinitive sup --VInf, Sup
                    lformmasc (lformfem + "a") (lformfem + "i") --VPastPart Masc Sg,Dl,Pl
                    (lformfem + "a") (lformfem + "i") (lformfem + "e") --VPastPart Fem Sg,Dl,Pl
                    (lformfem + "o") (lformfem + "i") (lformfem + "a") --VPastPart Neut Sg,Dl,Pl
                    (thirdpsg + "m") (thirdpsg + "š") thirdpsg             --VPres Sg P1, P2, P3
                    (thirdpsg + "va") (thirdpsg + "ta") (thirdpsg + "ta")  --VPres Dl P1, P2, P3
                    (thirdpsg + "mo") (thirdpsg + "te") (thirdpsg + "jo")  --VPres Pl P1, P2, P3
                    (imp + "va") (imp+"mo") imp (imp +"ta") (imp + "te"); --Imper P1 Dl Pl + P2 Sg Dl Pl

  worstV : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> V =
    \inf,sup,partsgm,partdlm,partplm,partsgf,partdlf,partplf,partsgn,partdln,partpln,pres1sg,pres2sg,pres3sg,pres1dl,pres2dl,pres3dl,pres1pl,pres2pl,pres3pl,imp1dl,imp1pl,imp2sg,imp2dl,imp2pl -> lin V {
       s = table {
             VInf              => inf;
             VSup              => sup;
             VPastPart Masc Sg => partsgm;
             VPastPart Masc Dl => partdlm;
             VPastPart Masc Pl => partplm;
             VPastPart Fem  Sg => partsgf;
             VPastPart Fem  Dl => partdlf;
             VPastPart Fem  Pl => partplf;
             VPastPart Neut Sg => partsgn;
             VPastPart Neut Dl => partdln;
             VPastPart Neut Pl => partpln;
             VPres Sg P1       => pres1sg;
             VPres Sg P2       => pres2sg;
             VPres Sg P3       => pres3sg;
             VPres Dl P1       => pres1dl;
             VPres Dl P2       => pres2dl;
             VPres Dl P3       => pres3dl;
             VPres Pl P1       => pres1pl;
             VPres Pl P2       => pres2pl;
             VPres Pl P3       => pres3pl;
             VImper1Sg         => imp1dl;
             VImper1Dl         => imp1pl;
             VImper2 Sg        => imp2sg;
             VImper2 Dl        => imp2dl;
             VImper2 Pl        => imp2pl
           }
    };

--Imperative forms are formed separetely. Pattern matching performed on thirdpersonsingular verbform. 

  mkImp : Str -> Str = \caka ->
        case caka of {
        _ + "a"         => (caka+"j") ;
        _ + ("je"|"ji") => let cak = init caka in cak ;
        _ + "e"         => let cak = init caka in (cak+"i") ; 
        _ + "i"         => caka ; 
        _               => caka --this dummy is not grammatically correct. It's just a wild guess. 
                  };

  mkV2 = overload {
    mkV2 : V -> V2 = \v -> lin V2 (v ** {c2 = lin Prep {s=""; c=Acc}}) ;
    mkV2 : V -> Case -> V2 = \v,c -> lin V2 (v ** {c2 = lin Prep {s=""; c=c}}) ;
    mkV2 : V -> Prep -> V2 = \v,p -> lin V2 (v ** {c2 = p}) ;
  } ;

  mkVS : V -> VS ;
  mkVS v = lin VS v ;

  mkVQ : V -> VQ ;
  mkVQ v = lin VQ v ;

  mkVV : V -> VV ;
  mkVV v = lin VV v ;

-- Adjectives

  mkA = overload {
    mkA : (_,_:Str) -> A = regA ;
    mkA : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x166 : Str) -> A = worstA ;
    } ;

  regA : (_,_ :Str) -> A = \star,starejsi -> lin A {
    s = let starejs = init starejsi
        in table {
             APosit  gen num c => mkAdjForm star ! c ! gen ! num ;
             ACompar gen num c => mkAdjForm starejs ! c ! gen ! num ;
             ASuperl gen num c => mkAdjForm ("naj" + starejs) ! c ! gen ! num ;
             APositDefNom      => mkAdjForm star ! Nom ! Masc ! Pl ;
             APositIndefAcc    => mkAdjForm star ! Nom ! Masc ! Sg ;
             APositDefAcc      => mkAdjForm star ! Nom ! Masc ! Pl ;
             AComparDefAcc     => mkAdjForm starejs ! Nom ! Masc ! Sg ;
             ASuperlDefAcc     => mkAdjForm ("naj" + starejs) ! Nom ! Masc ! Sg
           }
    } ;

  mkAdjForm : Str -> Case => Gender => Number => Str = \lep ->
    let 
      lp = looseVowel lep --checks for loosewovel in the stem. if there is none, the string comes back the same. 
    in
      table {
        Nom   => table {
                   Fem  => table {Sg=> (lp + "a"); Dl=>(lp + "i"); Pl=>(lp +"e")}; 
                   Masc => table {Sg=> lep;        Dl=>(lp + "a"); Pl=>(lp +"i")}; 
                   Neut => table {Sg=>(lp + "o");  Dl=>(lp + "i"); Pl=>(lp + "a")} 
                 };
        Acc   => table {
                   Fem  => table {Sg=>(lp + "o");  Dl=>(lp + "i"); Pl=>(lp + "e")}; 
                   Masc => table {Sg=>lep;         Dl=>(lp + "a"); Pl=>(lp + "e")}; 
                   Neut => table {Sg=>(lp + "o");  Dl=>(lp + "i"); Pl=>(lp +"a")}
                 };
        Gen   => table {
                   Fem  => table {Sg=>(lp + "e");   Dl=>(lp +"ih"); Pl=>(lp +"ih")}; 
                   Masc => table {Sg=>(lp + "ega"); Dl=>(lp +"ih"); Pl=>(lp +"ih")}; 
                   Neut => table {Sg=>(lp + "ega"); Dl=>(lp +"ih"); Pl=>(lp +"ih")} 
                 };
        Loc   => table {
                   Fem  => table {Sg=>(lp + "i");  Dl=>(lp +"ih"); Pl=>(lp +"ih")}; 
                   Masc => table {Sg=>(lp + "em"); Dl=>(lp +"ih"); Pl=>(lp +"ih")}; 
                   Neut => table {Sg=>(lp + "em"); Dl=>(lp +"ih"); Pl=>(lp +"ih")} 
                 };
        Dat   => table {
                   Fem  => table {Sg=>(lp + "i");   Dl=>(lp +"ima"); Pl=>(lp +"im")}; 
                   Masc => table {Sg=>(lp + "emu"); Dl=>(lp +"ima"); Pl=>(lp +"im")}; 
                   Neut => table {Sg=>(lp + "emu"); Dl=>(lp +"ima"); Pl=>(lp +"im")} 
                 };
        Instr => table {
                   Fem  => table {Sg=>(lp + "o");  Dl=>(lp +"ima"); Pl=>(lp +"imi")}; 
                   Masc => table {Sg=>(lp + "im"); Dl=>(lp +"ima"); Pl=>(lp +"imi")}; 
                   Neut => table {Sg=>(lp + "im"); Dl=>(lp +"ima"); Pl=>(lp +"imi")} 
                 }
      } ;

  worstA : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> A =
    \positMSgNom,positMSgNomDef,positMSgGen,positMSgDat,positMSgAcc,positMSgAccIndef,positMSgAccDef,positMSgLoc,positMSgInstr,
     positMDlNom,positMDlGen,positMDlDat,positMDlAcc,positMDlLoc,positMDlInstr,
     positMPlNom,positMPlGen,positMPlDat,positMPlAcc,positMPlLoc,positMPlInstr,
     positFSgNom,positFSgGen,positFSgDat,positFSgAcc,positFSgLoc,positFSgInstr,
     positFDlNom,positFDlGen,positFDlDat,positFDlAcc,positFDlLoc,positFDlInstr,
     positFPlNom,positFPlGen,positFPlDat,positFPlAcc,positFPlLoc,positFPlInstr,
     positNSgNom,positNSgGen,positNSgDat,positNSgAcc,positNSgLoc,positNSgInstr,
     positNDlNom,positNDlGen,positNDlDat,positNDlAcc,positNDlLoc,positNDlInstr,
     positNPlNom,positNPlGen,positNPlDat,positNPlAcc,positNPlLoc,positNPlInstr,
     comparMSgNom,comparMSgGen,comparMSgDat,comparMSgAcc,comparMSgAccDef,comparMSgLoc,comparMSgInstr,
     comparMDlNom,comparMDlGen,comparMDlDat,comparMDlAcc,comparMDlLoc,comparMDlInstr,
     comparMPlNom,comparMPlGen,comparMPlDat,comparMPlAcc,comparMPlLoc,comparMPlInstr,
     comparFSgNom,comparFSgGen,comparFSgDat,comparFSgAcc,comparFSgLoc,comparFSgInstr,
     comparFDlNom,comparFDlGen,comparFDlDat,comparFDlAcc,comparFDlLoc,comparFDlInstr,
     comparFPlNom,comparFPlGen,comparFPlDat,comparFPlAcc,comparFPlLoc,comparFPlInstr,
     comparNSgNom,comparNSgGen,comparNSgDat,comparNSgAcc,comparNSgLoc,comparNSgInstr,
     comparNDlNom,comparNDlGen,comparNDlDat,comparNDlAcc,comparNDlLoc,comparNDlInstr,
     comparNPlNom,comparNPlGen,comparNPlDat,comparNPlAcc,comparNPlLoc,comparNPlInstr,
     superlMSgNom,superlMSgGen,superlMSgDat,superlMSgAcc,superlMSgAccDef,superlMSgLoc,superlMSgInstr,
     superlMDlNom,superlMDlGen,superlMDlDat,superlMDlAcc,superlMDlLoc,superlMDlInstr,
     superlMPlNom,superlMPlGen,superlMPlDat,superlMPlAcc,superlMPlLoc,superlMPlInstr,
     superlFSgNom,superlFSgGen,superlFSgDat,superlFSgAcc,superlFSgLoc,superlFSgInstr,
     superlFDlNom,superlFDlGen,superlFDlDat,superlFDlAcc,superlFDlLoc,superlFDlInstr,
     superlFPlNom,superlFPlGen,superlFPlDat,superlFPlAcc,superlFPlLoc,superlFPlInstr,
     superlNSgNom,superlNSgGen,superlNSgDat,superlNSgAcc,superlNSgLoc,superlNSgInstr,
     superlNDlNom,superlNDlGen,superlNDlDat,superlNDlAcc,superlNDlLoc,superlNDlInstr,
     superlNPlNom,superlNPlGen,superlNPlDat,superlNPlAcc,superlNPlLoc,superlNPlInstr  -> lin A {
       s = table {
             APosit  Masc Sg Nom   => positMSgNom;
             APositDefNom          => positMSgNomDef;
             APosit  Masc Sg Gen   => positMSgGen;
             APosit  Masc Sg Dat   => positMSgDat;
             APosit  Masc Sg Acc   => positMSgAcc;
             APositIndefAcc        => positMSgAccIndef;
             APositDefAcc          => positMSgAccDef;
             APosit  Masc Sg Loc   => positMSgLoc;
             APosit  Masc Sg Instr => positMSgInstr;
             APosit  Masc Dl Nom   => positMDlNom;
             APosit  Masc Dl Gen   => positMDlGen;
             APosit  Masc Dl Dat   => positMDlDat;
             APosit  Masc Dl Acc   => positMDlAcc;
             APosit  Masc Dl Loc   => positMDlLoc;
             APosit  Masc Dl Instr => positMDlInstr;
             APosit  Masc Pl Nom   => positMPlNom;
             APosit  Masc Pl Gen   => positMPlGen;
             APosit  Masc Pl Dat   => positMPlDat;
             APosit  Masc Pl Acc   => positMPlAcc;
             APosit  Masc Pl Loc   => positMPlLoc;
             APosit  Masc Pl Instr => positMPlInstr;
             APosit  Fem  Sg Nom   => positFSgNom;
             APosit  Fem  Sg Gen   => positFSgGen;
             APosit  Fem  Sg Dat   => positFSgDat;
             APosit  Fem  Sg Acc   => positFSgAcc;
             APosit  Fem  Sg Loc   => positFSgLoc;
             APosit  Fem  Sg Instr => positFSgInstr;
             APosit  Fem  Dl Nom   => positFDlNom;
             APosit  Fem  Dl Gen   => positFDlGen;
             APosit  Fem  Dl Dat   => positFDlDat;
             APosit  Fem  Dl Acc   => positFDlAcc;
             APosit  Fem  Dl Loc   => positFDlLoc;
             APosit  Fem  Dl Instr => positFDlInstr;
             APosit  Fem  Pl Nom   => positFPlNom;
             APosit  Fem  Pl Gen   => positFPlGen;
             APosit  Fem  Pl Dat   => positFPlDat;
             APosit  Fem  Pl Acc   => positFPlAcc;
             APosit  Fem  Pl Loc   => positFPlLoc;
             APosit  Fem  Pl Instr => positFPlInstr;
             APosit  Neut Sg Nom   => positNSgNom;
             APosit  Neut Sg Gen   => positNSgGen;
             APosit  Neut Sg Dat   => positNSgDat;
             APosit  Neut Sg Acc   => positNSgAcc;
             APosit  Neut Sg Loc   => positNSgLoc;
             APosit  Neut Sg Instr => positNSgInstr;
             APosit  Neut Dl Nom   => positNDlNom;
             APosit  Neut Dl Gen   => positNDlGen;
             APosit  Neut Dl Dat   => positNDlDat;
             APosit  Neut Dl Acc   => positNDlAcc;
             APosit  Neut Dl Loc   => positNDlLoc;
             APosit  Neut Dl Instr => positNDlInstr;
             APosit  Neut Pl Nom   => positNPlNom;
             APosit  Neut Pl Gen   => positNPlGen;
             APosit  Neut Pl Dat   => positNPlDat;
             APosit  Neut Pl Acc   => positNPlAcc;
             APosit  Neut Pl Loc   => positNPlLoc;
             APosit  Neut Pl Instr => positNPlInstr;

             ACompar Masc Sg Nom   => comparMSgNom;
             ACompar Masc Sg Gen   => comparMSgGen;
             ACompar Masc Sg Dat   => comparMSgDat;
             ACompar Masc Sg Acc   => comparMSgAcc;
             AComparDefAcc         => comparMSgAccDef;
             ACompar Masc Sg Loc   => comparMSgLoc;
             ACompar Masc Sg Instr => comparMSgInstr;
             ACompar Masc Dl Nom   => comparMDlNom;
             ACompar Masc Dl Gen   => comparMDlGen;
             ACompar Masc Dl Dat   => comparMDlDat;
             ACompar Masc Dl Acc   => comparMDlAcc;
             ACompar Masc Dl Loc   => comparMDlLoc;
             ACompar Masc Dl Instr => comparMDlInstr;
             ACompar Masc Pl Nom   => comparMPlNom;
             ACompar Masc Pl Gen   => comparMPlGen;
             ACompar Masc Pl Dat   => comparMPlDat;
             ACompar Masc Pl Acc   => comparMPlAcc;
             ACompar Masc Pl Loc   => comparMPlLoc;
             ACompar Masc Pl Instr => comparMPlInstr;
             ACompar Fem  Sg Nom   => comparFSgNom;
             ACompar Fem  Sg Gen   => comparFSgGen;
             ACompar Fem  Sg Dat   => comparFSgDat;
             ACompar Fem  Sg Acc   => comparFSgAcc;
             ACompar Fem  Sg Loc   => comparFSgLoc;
             ACompar Fem  Sg Instr => comparFSgInstr;
             ACompar Fem  Dl Nom   => comparFDlNom;
             ACompar Fem  Dl Gen   => comparFDlGen;
             ACompar Fem  Dl Dat   => comparFDlDat;
             ACompar Fem  Dl Acc   => comparFDlAcc;
             ACompar Fem  Dl Loc   => comparFDlLoc;
             ACompar Fem  Dl Instr => comparFDlInstr;
             ACompar Fem  Pl Nom   => comparFPlNom;
             ACompar Fem  Pl Gen   => comparFPlGen;
             ACompar Fem  Pl Dat   => comparFPlDat;
             ACompar Fem  Pl Acc   => comparFPlAcc;
             ACompar Fem  Pl Loc   => comparFPlLoc;
             ACompar Fem  Pl Instr => comparFPlInstr;
             ACompar Neut Sg Nom   => comparNSgNom;
             ACompar Neut Sg Gen   => comparNSgGen;
             ACompar Neut Sg Dat   => comparNSgDat;
             ACompar Neut Sg Acc   => comparNSgAcc;
             ACompar Neut Sg Loc   => comparNSgLoc;
             ACompar Neut Sg Instr => comparNSgInstr;
             ACompar Neut Dl Nom   => comparNDlNom;
             ACompar Neut Dl Gen   => comparNDlGen;
             ACompar Neut Dl Dat   => comparNDlDat;
             ACompar Neut Dl Acc   => comparNDlAcc;
             ACompar Neut Dl Loc   => comparNDlLoc;
             ACompar Neut Dl Instr => comparNDlInstr;
             ACompar Neut Pl Nom   => comparNPlNom;
             ACompar Neut Pl Gen   => comparNPlGen;
             ACompar Neut Pl Dat   => comparNPlDat;
             ACompar Neut Pl Acc   => comparNPlAcc;
             ACompar Neut Pl Loc   => comparNPlLoc;
             ACompar Neut Pl Instr => comparNPlInstr;

             ASuperl Masc Sg Nom   => superlMSgNom;
             ASuperl Masc Sg Gen   => superlMSgGen;
             ASuperl Masc Sg Dat   => superlMSgDat;
             ASuperl Masc Sg Acc   => superlMSgAcc;
             ASuperl Masc Sg Loc   => superlMSgLoc;
             ASuperl Masc Sg Instr => superlMSgInstr;
             ASuperl Masc Dl Nom   => superlMDlNom;
             ASuperl Masc Dl Gen   => superlMDlGen;
             ASuperl Masc Dl Dat   => superlMDlDat;
             ASuperl Masc Dl Acc   => superlMDlAcc;
             ASuperlDefAcc         => superlMSgAccDef;
             ASuperl Masc Dl Loc   => superlMDlLoc;
             ASuperl Masc Dl Instr => superlMDlInstr;
             ASuperl Masc Pl Nom   => superlMPlNom;
             ASuperl Masc Pl Gen   => superlMPlGen;
             ASuperl Masc Pl Dat   => superlMPlDat;
             ASuperl Masc Pl Acc   => superlMPlAcc;
             ASuperl Masc Pl Loc   => superlMPlLoc;
             ASuperl Masc Pl Instr => superlMPlInstr;
             ASuperl Fem  Sg Nom   => superlFSgNom;
             ASuperl Fem  Sg Gen   => superlFSgGen;
             ASuperl Fem  Sg Dat   => superlFSgDat;
             ASuperl Fem  Sg Acc   => superlFSgAcc;
             ASuperl Fem  Sg Loc   => superlFSgLoc;
             ASuperl Fem  Sg Instr => superlFSgInstr;
             ASuperl Fem  Dl Nom   => superlFDlNom;
             ASuperl Fem  Dl Gen   => superlFDlGen;
             ASuperl Fem  Dl Dat   => superlFDlDat;
             ASuperl Fem  Dl Acc   => superlFDlAcc;
             ASuperl Fem  Dl Loc   => superlFDlLoc;
             ASuperl Fem  Dl Instr => superlFDlInstr;
             ASuperl Fem  Pl Nom   => superlFPlNom;
             ASuperl Fem  Pl Gen   => superlFPlGen;
             ASuperl Fem  Pl Dat   => superlFPlDat;
             ASuperl Fem  Pl Acc   => superlFPlAcc;
             ASuperl Fem  Pl Loc   => superlFPlLoc;
             ASuperl Fem  Pl Instr => superlFPlInstr;
             ASuperl Neut Sg Nom   => superlNSgNom;
             ASuperl Neut Sg Gen   => superlNSgGen;
             ASuperl Neut Sg Dat   => superlNSgDat;
             ASuperl Neut Sg Acc   => superlNSgAcc;
             ASuperl Neut Sg Loc   => superlNSgLoc;
             ASuperl Neut Sg Instr => superlNSgInstr;
             ASuperl Neut Dl Nom   => superlNDlNom;
             ASuperl Neut Dl Gen   => superlNDlGen;
             ASuperl Neut Dl Dat   => superlNDlDat;
             ASuperl Neut Dl Acc   => superlNDlAcc;
             ASuperl Neut Dl Loc   => superlNDlLoc;
             ASuperl Neut Dl Instr => superlNDlInstr;
             ASuperl Neut Pl Nom   => superlNPlNom;
             ASuperl Neut Pl Gen   => superlNPlGen;
             ASuperl Neut Pl Dat   => superlNPlDat;
             ASuperl Neut Pl Acc   => superlNPlAcc;
             ASuperl Neut Pl Loc   => superlNPlLoc;
             ASuperl Neut Pl Instr => superlNPlInstr
           }
    };

  mkAdv : Str -> Adv = \s -> lin Adv {s=s} ;

  mkAdV : Str -> AdV = \s -> lin AdV {s=s} ;

  mkAdA : Str -> AdA = \s -> lin AdA {s=s} ;

  mkPron : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Gender -> Number -> Person -> Pron =
    \nom,acc,gen,dat,loc,instr,
     mSgNom,mSgGen,mSgDat,mSgAcc,mSgLoc,mSgInstr,
     mDlNom,mDlGen,mDlDat,mDlAcc,mDlLoc,mDlInstr,
     mPlNom,mPlGen,mPlDat,mPlAcc,mPlLoc,mPlInstr,
     fSgNom,fSgGen,fSgDat,fSgAcc,fSgLoc,fSgInstr,
     fDlNom,fDlGen,fDlDat,fDlAcc,fDlLoc,fDlInstr,
     fPlNom,fPlGen,fPlDat,fPlAcc,fPlLoc,fPlInstr,
     nSgNom,nSgGen,nSgDat,nSgAcc,nSgLoc,nSgInstr,
     nDlNom,nDlGen,nDlDat,nDlAcc,nDlLoc,nDlInstr,
     nPlNom,nPlGen,nPlDat,nPlAcc,nPlLoc,nPlInstr,g,n,p -> lin Pron {
       s = table {  Nom => nom;
                    Acc => acc;
                    Gen => gen;
                    Dat => dat;
                    Loc => loc;
                    Instr=>instr
                  } ;
       poss = table {
             Masc => table {Nom   => table Number [mSgNom;   mDlNom;   mPlNom];
                            Gen   => table Number [mSgGen;   mDlGen;   mPlGen];
                            Dat   => table Number [mSgDat;   mDlDat;   mPlDat];
                            Acc   => table Number [mSgAcc;   mDlAcc;   mPlAcc];
                            Loc   => table Number [mSgLoc;   mDlLoc;   mPlLoc];
                            Instr => table Number [mSgInstr; mDlInstr; mPlInstr]
                           };
             Fem  => table {Nom   => table Number [fSgNom;   fDlNom;   fPlNom];
                            Gen   => table Number [fSgGen;   fDlGen;   fPlGen];
                            Dat   => table Number [fSgDat;   fDlDat;   fPlDat];
                            Acc   => table Number [fSgAcc;   fDlAcc;   fPlAcc];
                            Loc   => table Number [fSgLoc;   fDlLoc;   fPlLoc];
                            Instr => table Number [fSgInstr; fDlInstr; fPlInstr]
                           };
             Neut => table {Nom   => table Number [nSgNom;   nDlNom;   nPlNom];
                            Gen   => table Number [nSgGen;   nDlGen;   nPlGen];
                            Dat   => table Number [nSgDat;   nDlDat;   nPlDat];
                            Acc   => table Number [nSgAcc;   nDlAcc;   nPlAcc];
                            Loc   => table Number [nSgLoc;   nDlLoc;   nPlLoc];
                            Instr => table Number [nSgInstr; nDlInstr; nPlInstr]
                           }
           } ;
       a = {g=g; n=n; p=p}
     } ;

  mkQuant : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Species -> Quant =
    \mSgNom,mSgGen,mSgDat,mSgAcc,mSgLoc,mSgInstr,
     mDlNom,mDlGen,mDlDat,mDlAcc,mDlLoc,mDlInstr,
     mPlNom,mPlGen,mPlDat,mPlAcc,mPlLoc,mPlInstr,
     fSgNom,fSgGen,fSgDat,fSgAcc,fSgLoc,fSgInstr,
     fDlNom,fDlGen,fDlDat,fDlAcc,fDlLoc,fDlInstr,
     fPlNom,fPlGen,fPlDat,fPlAcc,fPlLoc,fPlInstr,
     nSgNom,nSgGen,nSgDat,nSgAcc,nSgLoc,nSgInstr,
     nDlNom,nDlGen,nDlDat,nDlAcc,nDlLoc,nDlInstr,
     nPlNom,nPlGen,nPlDat,nPlAcc,nPlLoc,nPlInstr,spec  -> lin Quant {
       s = table {
             Masc => table {Nom   => table Number [mSgNom;   mDlNom;   mPlNom];
                            Gen   => table Number [mSgGen;   mDlGen;   mPlGen];
                            Dat   => table Number [mSgDat;   mDlDat;   mPlDat];
                            Acc   => table Number [mSgAcc;   mDlAcc;   mPlAcc];
                            Loc   => table Number [mSgLoc;   mDlLoc;   mPlLoc];
                            Instr => table Number [mSgInstr; mDlInstr; mPlInstr]
                           };
             Fem  => table {Nom   => table Number [fSgNom;   fDlNom;   fPlNom];
                            Gen   => table Number [fSgGen;   fDlGen;   fPlGen];
                            Dat   => table Number [fSgDat;   fDlDat;   fPlDat];
                            Acc   => table Number [fSgAcc;   fDlAcc;   fPlAcc];
                            Loc   => table Number [fSgLoc;   fDlLoc;   fPlLoc];
                            Instr => table Number [fSgInstr; fDlInstr; fPlInstr]
                           };
             Neut => table {Nom   => table Number [nSgNom;   nDlNom;   nPlNom];
                            Gen   => table Number [nSgGen;   nDlGen;   nPlGen];
                            Dat   => table Number [nSgDat;   nDlDat;   nPlDat];
                            Acc   => table Number [nSgAcc;   nDlAcc;   nPlAcc];
                            Loc   => table Number [nSgLoc;   nDlLoc;   nPlLoc];
                            Instr => table Number [nSgInstr; nDlInstr; nPlInstr]
                           }
           } ;
       spec = spec
     };

  mkNP : (_,_,_,_,_,_ : Str) -> Gender -> Number -> NP =
    \nom,acc,gen,dat,loc,instr,g,n ->
    lin NP {s = table {
                    Nom => nom;
                    Acc => acc;
                    Gen => gen;
                    Dat => dat;
                    Loc => loc;
                    Instr=>instr
                  } ;
            a = {g=Neut; n=n; p=P3} ;
            isPron = False
           } ;

  mkInterj : Str -> Interj =
    \s -> lin Interj {s=s} ;
    
  mkConj : Str -> Number -> Conj =
    \s,n -> lin Conj {s=s; n=n} ;

--Helper function that drops the loose vowel that has to go in many conjugations. 

  looseVowel : (_:Str) -> Str = \vowel ->
    case vowel of {
        _ + "sak" => vowel ;
        _ + "er" => Predef.tk 2 vowel + "r" ;
        _ + "an" => Predef.tk 2 vowel + "n" ;
        --_ + "en" => Predef.tk 2 vowel + "n" ; --this is wrong, right?
        _ + "el" => Predef.tk 2 vowel + "l" ;
        _ + "ek" => Predef.tk 2 vowel + "k" ;
        _ + "ak" => Predef.tk 2 vowel + "k" ;
        _ + #vowel  => init vowel ;
        _        => vowel
    } ;
    
  vowel : pattern Str = #("a"|"e"|"i"|"o"|"u") ;
  consonant : pattern Str = #("b"|"d"|"g"|"m"|"n"|"p"|"t") ;
}
