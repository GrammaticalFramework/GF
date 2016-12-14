resource ParadigmsSlv = open CatSlv, ResSlv, Prelude, Predef in {

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

  singular : Number = Sg ;
  dual : Number = Dl ;
  plural : Number = Pl ;

  definite : Species = Def ;
  indefinite : Species = Indef ; 

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
        oceto : Str
              = case ocet of {
                  _ + ("c"|"j"|"ž"|"š"|"č") => ocet+"e" ;
                  _                         => ocet+"o"
                } ;
    in
    worstN oce          (ocet + "a")  (ocet + "u")   accsg        (ocet + "u")  (oceto + "m")  -- Singular
           (ocet + "a") (oceto + "v") (oceto + "ma") (ocet + "a") (ocet + "ih") (oceto + "ma") -- Dual
           (ocet + "i") (oceto + "v") (oceto + "m")  (ocet + "e") (ocet + "ih") (ocet + "i")   -- Plural
           (AMasc anim) ;

--All neuter forms are formed here, long or normal. 
--It takes the baseform + the genitive singular form. 
--In case the genitive singular has an extra vowel in the end, it is dropped before coming here. 

  neutAll : (_,_,_ : Str) -> N = \drevo,dreves,dreves2 ->
    let dreveso = dreves + last drevo ;
    in worstN drevo          (dreves + "a") (dreves + "u")   drevo            (dreves + "u")  (dreveso + "m")  -- Singular
              (dreves + "i") dreves2        (dreveso + "ma") (dreves + "i")   (dreves + "ih") (dreveso + "ma") -- Dual
              (dreves + "a") dreves2        (dreveso + "m")  (dreves + "a")   (dreves + "ih") (dreves + "i")   -- Plural
              neuter ;

--Regular feminine nouns are formed from the baseform. Always inanimate. 

  regFem_a : (_ : Str) -> N = \punca -> 
      let punc = init punca
      in irregFem punca (punc+"e") punc ;

  regFem_st : (_ : Str) -> N = \posevnost -> 
      worstN posevnost         (posevnost + "i")  (posevnost + "i")   posevnost        (posevnost + "i")  (posevnost + "jo") -- Singular
             (posevnost + "i") (posevnost + "i")  (posevnost + "ma") (posevnost + "i") (posevnost + "ih") (posevnost + "ma") -- Dual
             (posevnost + "i") (posevnost + "i")  (posevnost + "im") (posevnost + "i") (posevnost + "ih") (posevnost + "mi") -- Plural
             feminine ;

  regFem_ev : (_ : Str) -> N = \vsaditev -> 
      let vsaditv = tk 2 vsaditev + "v"
      in
      worstN vsaditev       (vsaditv + "e") (vsaditv + "i")   vsaditev        (vsaditv + "i")  (vsaditv + "ijo") -- Singular
             (vsaditv + "i") vsaditev       (vsaditv + "ama") (vsaditv + "i") (vsaditv + "ah") (vsaditv + "ama") -- Dual
             (vsaditv + "e") vsaditev       (vsaditv + "am")  (vsaditv + "e") (vsaditv + "ah") (vsaditv + "ami") -- Plural
             feminine ;

  iFem : (_ : Str) -> N = \stran -> 
      let stran'  = looseVowel stran ;
          stran'' : Str
                  = case stran' of {
                      _ + "n" => stran'+"i" ;
                      _       => stran'
                    }
      in
      worstN stran          (stran' + "i") (stran' + "i")   stran          (stran' + "i")  (stran'' + "jo")  -- Singular
             (stran' + "i") (stran' + "i") (stran' + "ema") (stran' + "i") (stran' + "eh") (stran' + "ema")  -- Dual
             (stran' + "i") (stran' + "i") (stran' + "em")  (stran' + "i") (stran' + "eh") (stran' + "mi")   -- Plural
             feminine ;

--This is a smart paradigm for regular nouns. 

  smartN : (noun: Str) -> N =
    \noun -> case noun of {
      _ + "a" => regFem_a noun ;
      _ + ("o"| "e") + "st" => regFem_st noun ;
      _ + "ev"  => regFem_ev noun ;
      _ + ("o"| "e") => let nou = init noun in neutAll noun nou nou ;
      _ + #consonant => mascAll noun noun Inanimate; --Base form used in the rest of the paradigm. 
      _ => let nou = init noun in mascAll noun nou Inanimate -- Drops the last vowel for the rest of the paradigm. 
  } ;

--Send the masculine and neutral nouns with long stem off to the right paradigm. 

  irregNouns : (noun,longform : Str) -> AGender -> N = \noun,longform,gen ->
    case gen of {
      AMasc anim => let longfor = init longform in mascAll noun longfor anim ;
      ANeut      => let longfor = init longform in neutAll noun longfor longfor ;
      AFem       => regFem_a noun --There are actually no feminine nouns with long stem. 
      } ;

--Regular masculine nouns that do not end with a consonant, drops the vowel in all conjugated forms. 
--Takes the baseform + animacy. 

  regNouns : (noun : Str) -> AGender -> N = \noun,gen ->
    case gen of {
      AMasc anim => case noun of {
                      _ + #consonant => mascAll noun noun anim ;
                      _ + #vowel     => let nou = init noun in mascAll noun nou anim ;
                      _              => mascAll noun noun anim  -- KA: catch all
                    };
      ANeut      => let nou = init noun in neutAll noun nou nou ;
      AFem       => case noun of {
                      _ + "a"  => regFem_a noun ;
                      _ + ("o"| "e") + "st" => regFem_st noun ;
                      _ + "ev" => regFem_ev noun ;
                      _        => regFem_a noun
                    }
      } ;

--Irregular masculine nouns with long stem has no special ending in genitive dual and plural, so need a special paradigm. 
--Takes the baseform + the genitive singular form + the nominative plural form + animacy.  

  irregMasc : (noun,gensg,plstem : Str) -> N = \bog,boga,bogovi ->
      let bogov = init bogovi in
      worstN bog           boga  (bog + "u")     bog           (bog + "u")    (bog + "om")     -- Singular
             (bogov + "a") bogov (bogov + "oma") (bogov + "a") (bogov + "ih") (bogov + "oma")  -- Dual
             bogovi        bogov (bogov + "om")  (bogov + "e") (bogov + "ih") (bogov + "i")    -- Plural
             masculine ;

  irregFem : (noun,gensg,genpl : Str) -> N = \noun,gensg,genpl ->
      let nou = init gensg
      in
      worstN noun        gensg (nou + "i")   (nou + "o") (nou + "i")  (nou + "o")   -- Singular
             (nou + "i") genpl (nou + "ama") (nou + "i") (nou + "ah") (nou + "ama") -- Dual
             (nou + "e") genpl (nou + "am")  (nou + "e") (nou + "ah") (nou + "ami") -- Plural
             feminine ;

  irregNeut : (noun,gensg,plstem : Str) -> N = \cislo,cisla,cisel ->
      neutAll cislo (init cisla) cisel ;

  worstN : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> AGender -> N =
      \nomsg,gensg,datsg,accsg,locsg,instrsg,nomdl,gendl,datdl,accdl,locdl,instrdl,nompl,genpl,datpl,accpl,locpl,instrpl,g -> lin N {
       s = table {
             Nom   => table {Sg=>nomsg; Dl=>nomdl; Pl=>nompl};
             Gen   => table {Sg=>gensg; Dl=>gendl; Pl=>genpl};
             Dat   => table {Sg=>datsg; Dl=>datdl; Pl=>datpl};
             Acc   => table {Sg=>accsg; Dl=>accdl; Pl=>accpl};
             Loc   => table {Sg=>locsg; Dl=>locdl; Pl=>locpl};
             Instr => table {Sg=>instrsg; Dl=>instrdl; Pl=>instrpl}
           };
       g = g
    };

  mkPN = overload {
    mkPN : N -> PN = \noun -> lin PN {
      s = \\c => noun.s ! c ! Sg ;
      g = noun.g ;
      n = Sg
    };
    mkPN : N -> Number -> PN = \noun,nr -> lin PN {
      s = \\c => noun.s ! c ! nr ;
      g = noun.g ;
      n = nr
    }; 
    mkPN : Str -> AGender -> Number -> PN =
      \s,g,n -> lin PN {
         s = \\_ => s ;
         g = g ;
         n = n
      };
    mkPN : (_,_,_,_,_,_ : Str) -> AGender -> Number -> PN =
      \nom,gen,dat,acc,loc,instr,g,n -> lin PN {
         s = table {
               Nom   => nom;
               Gen   => gen;
               Dat   => dat;
               Acc   => acc;
               Loc   => loc;
               Instr => instr
             };
         g = g ;
         n = n
      };
    } ;

  mkV = overload {
    mkV : (inf,stem : Str) -> V = regV ; 
    mkV : (inf,stem,lstem : Str) -> V = irregVa ; 
    mkV : (inf,stem,lstem,imp : Str) -> V = irregVb ; 
    mkV : (inf,stem,lstem,femstem,imp : Str) -> V = irregVc ; 
    mkV : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x25 : Str) -> V = worstV ;
    } ;

  mkReflV : V -> Case -> V = \v,c -> v ** {refl = reflexive ! c} ;

  particleV : V -> Str -> V = \v,p -> v ** {p = p} ;

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

--This one was added as a workaround the special case of "videti" where the feminine stem is equal to the masculine lform.

  irregVc : (_,_,_,_,_ : Str) -> V = \videti,vidi,videl,videla,vidimp -> 
        let 
          femvidel = init videla
        in 
        mkAllV videti vidi videl femvidel vidimp;

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
    \inf,sup,partsgm,partdlm,partplm,partsgf,partdlf,partplf,partsgn,partdln,partpln,pres1sg,pres2sg,pres3sg,pres1dl,pres2dl,pres3dl,pres1pl,pres2pl,pres3pl,imp1pl,imp1sg,imp2sg,imp2dl,imp2pl -> lin V {
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
             VImper1Sg         => imp1sg;
             VImper1Dl         => imp1pl;
             VImper2 Sg        => imp2sg;
             VImper2 Dl        => imp2dl;
             VImper2 Pl        => imp2pl
           } ;
	   p = [] ;  ----AR: +p
     refl = [] ;   
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

  mkV3 = overload {
    mkV3 : V -> V3 = \v -> lin V2 (v ** {c2 = lin Prep {s=""; c=Acc}; c3 = lin Prep {s=""; c=Acc}}) ;
    mkV3 : V -> Case -> Case -> V3 = \v,c2,c3 -> lin V2 (v ** {c2 = lin Prep {s=""; c=c2}; c3 = lin Prep {s=""; c=c3}}) ;
    mkV3 : V -> Case -> Prep -> V3 = \v,c2,p3 -> lin V2 (v ** {c2 = lin Prep {s=""; c=c2}; c3 = p3}) ;
    mkV3 : V -> Prep -> Case -> V3 = \v,p2,c3 -> lin V2 (v ** {c2 = p2 ; c3 = lin Prep {s=""; c=c3}}) ;
    mkV3 : V -> Prep -> Prep -> V3 = \v,p2,p3 -> lin V2 (v ** {c2 = p2 ; c3 = p3}) ;
  } ; 

  mkVS : V -> VS ;
  mkVS v = lin VS v ;

  mkVQ : V -> VQ ;
  mkVQ v = lin VQ v ;

  mkVV : V -> VV ;
  mkVV v = lin VV v ;

-- Adjectives

  mkA = overload {
    mkA : (_:Str) -> A = \s -> irregA s (looseVowel s+"a") (looseVowel s+"o") ("bolj"++s) ("bolj"++looseVowel s+"a") ("bolj"++looseVowel s+"o") ;
    mkA : (_,_:Str) -> A = \star,starejsi -> irregA star (looseVowel star+"a") (looseVowel star+"o") starejsi (looseVowel starejsi+"a") (looseVowel starejsi+"e") ;
    mkA : (_,_,_:Str) -> A = \m,f,n -> irregA m f n ("bolj"++m) ("bolj"++f) ("bolj"++n);
    mkA : (_,_,_,_,_,_:Str) -> A = irregA ;
    mkA : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x57 : Str) -> A = positA ;
    mkA : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x166 : Str) -> A = worstA ;
    } ;

  irregA : (_,_,_,_,_,_ :Str) -> A = \masc,fem,neut,mascC,femC,neutC -> lin A {
    s = table {
          APosit  gen num c => mkAdjForm masc fem neut ! c ! gen ! num ;
          ACompar gen num c => mkAdjForm mascC femC neutC ! c ! gen ! num ;
          ASuperl gen num c => mkAdjForm ("naj" + mascC) ("naj" + femC) ("naj" + neutC) ! c ! gen ! num ;
          APositDefNom      => mkAdjForm masc fem neut ! Nom ! Masc ! Pl ;
          APositIndefAcc    => mkAdjForm masc fem neut ! Nom ! Masc ! Sg ;
          APositDefAcc      => mkAdjForm masc fem neut ! Nom ! Masc ! Pl ;
          AComparDefAcc     => mkAdjForm mascC femC neutC ! Nom ! Masc ! Pl ;
          ASuperlDefAcc     => mkAdjForm ("naj" + mascC) ("naj" + femC) ("naj" + neutC) ! Nom ! Masc ! Pl
        }
    } ;

  mkAdjForm : (_,_,_ : Str) -> Case => Gender => Number => Str = \lep,lpa,lpo ->
    let lp = init lpa
    in
      table {
        Nom   => table {
                   Masc => table {Sg=> lep;       Dl=>(lp + "a"); Pl=>(lp +"i")};
                   Fem  => table {Sg=> lpa;       Dl=>(lp + "i"); Pl=>(lp +"e")};
                   Neut => table {Sg=> lpo;       Dl=>(lp + "i"); Pl=>(lp + "a")} 
                 };
        Acc   => table {
                   Masc => table {Sg=>lp+"ega";   Dl=>(lp + "a"); Pl=>(lp + "e")};
                   Fem  => table {Sg=>(lp + "o"); Dl=>(lp + "i"); Pl=>(lp + "e")};
                   Neut => table {Sg=>lpo;        Dl=>(lp + "i"); Pl=>(lp +"a")}
                 };
        Gen   => table {
                   Masc => table {Sg=>(lp + "ega"); Dl=>(lp +"ih"); Pl=>(lp +"ih")}; 
                   Fem  => table {Sg=>(lp + "e");   Dl=>(lp +"ih"); Pl=>(lp +"ih")};
                   Neut => table {Sg=>(lp + "ega"); Dl=>(lp +"ih"); Pl=>(lp +"ih")}
                 };
        Loc   => table {
                   Masc => table {Sg=>(lp + "em"); Dl=>(lp +"ih"); Pl=>(lp +"ih")};
                   Fem  => table {Sg=>(lp + "i");  Dl=>(lp +"ih"); Pl=>(lp +"ih")};
                   Neut => table {Sg=>(lp + "em"); Dl=>(lp +"ih"); Pl=>(lp +"ih")} 
                 };
        Dat   => table {
                   Masc => table {Sg=>(lp + "emu"); Dl=>(lp +"ima"); Pl=>(lp +"im")};
                   Fem  => table {Sg=>(lp + "i");   Dl=>(lp +"ima"); Pl=>(lp +"im")};
                   Neut => table {Sg=>(lp + "emu"); Dl=>(lp +"ima"); Pl=>(lp +"im")} 
                 };
        Instr => table {
                   Masc => table {Sg=>(lp + "im"); Dl=>(lp +"ima"); Pl=>(lp +"imi")};
                   Fem  => table {Sg=>(lp + "o");  Dl=>(lp +"ima"); Pl=>(lp +"imi")};
                   Neut => table {Sg=>(lp + "im"); Dl=>(lp +"ima"); Pl=>(lp +"imi")}
                 }
      } ;

  positA : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> A =
    \positMSgNom,positMSgNomDef,positMSgGen,positMSgDat,positMSgAcc,positMSgAccIndef,positMSgAccDef,positMSgLoc,positMSgInstr,
     positMDlNom,positMDlGen,positMDlDat,positMDlAcc,positMDlLoc,positMDlInstr,
     positMPlNom,positMPlGen,positMPlDat,positMPlAcc,positMPlLoc,positMPlInstr,
     positFSgNom,positFSgGen,positFSgDat,positFSgAcc,positFSgLoc,positFSgInstr,
     positFDlNom,positFDlGen,positFDlDat,positFDlAcc,positFDlLoc,positFDlInstr,
     positFPlNom,positFPlGen,positFPlDat,positFPlAcc,positFPlLoc,positFPlInstr,
     positNSgNom,positNSgGen,positNSgDat,positNSgAcc,positNSgLoc,positNSgInstr,
     positNDlNom,positNDlGen,positNDlDat,positNDlAcc,positNDlLoc,positNDlInstr,
     positNPlNom,positNPlGen,positNPlDat,positNPlAcc,positNPlLoc,positNPlInstr ->
       worstA positMSgNom positMSgNomDef positMSgGen positMSgDat positMSgAcc positMSgAccIndef positMSgAccDef positMSgLoc positMSgInstr
              positMDlNom positMDlGen positMDlDat positMDlAcc positMDlLoc positMDlInstr
              positMPlNom positMPlGen positMPlDat positMPlAcc positMPlLoc positMPlInstr
              positFSgNom positFSgGen positFSgDat positFSgAcc positFSgLoc positFSgInstr
              positFDlNom positFDlGen positFDlDat positFDlAcc positFDlLoc positFDlInstr
              positFPlNom positFPlGen positFPlDat positFPlAcc positFPlLoc positFPlInstr
              positNSgNom positNSgGen positNSgDat positNSgAcc positNSgLoc positNSgInstr
              positNDlNom positNDlGen positNDlDat positNDlAcc positNDlLoc positNDlInstr
              positNPlNom positNPlGen positNPlDat positNPlAcc positNPlLoc positNPlInstr
              ("boli"++positMSgNom) ("boli"++positMSgGen) ("boli"++positMSgDat) ("boli"++positMSgAcc) ("boli"++positMSgAccDef) ("boli"++positMSgLoc) ("boli"++positMSgInstr)
              ("boli"++positMDlNom) ("boli"++positMDlGen) ("boli"++positMDlDat) ("boli"++positMDlAcc) ("boli"++positMDlLoc) ("boli"++positMDlInstr)
              ("boli"++positMPlNom) ("boli"++positMPlGen) ("boli"++positMPlDat) ("boli"++positMPlAcc) ("boli"++positMPlLoc) ("boli"++positMPlInstr)
              ("boli"++positFSgNom) ("boli"++positFSgGen) ("boli"++positFSgDat) ("boli"++positFSgAcc) ("boli"++positFSgLoc) ("boli"++positFSgInstr)
              ("boli"++positFDlNom) ("boli"++positFDlGen) ("boli"++positFDlDat) ("boli"++positFDlAcc) ("boli"++positFDlLoc) ("boli"++positFDlInstr)
              ("boli"++positFPlNom) ("boli"++positFPlGen) ("boli"++positFPlDat) ("boli"++positFPlAcc) ("boli"++positFPlLoc) ("boli"++positFPlInstr)
              ("boli"++positNSgNom) ("boli"++positNSgGen) ("boli"++positNSgDat) ("boli"++positNSgAcc) ("boli"++positNSgLoc) ("boli"++positNSgInstr)
              ("boli"++positNDlNom) ("boli"++positNDlGen) ("boli"++positNDlDat) ("boli"++positNDlAcc) ("boli"++positNDlLoc) ("boli"++positNDlInstr)
              ("boli"++positNPlNom) ("boli"++positNPlGen) ("boli"++positNPlDat) ("boli"++positNPlAcc) ("boli"++positNPlLoc) ("boli"++positNPlInstr)
              ("najboli"++positMSgNom) ("najboli"++positMSgGen) ("najboli"++positMSgDat) ("najboli"++positMSgAcc) ("najboli"++positMSgAccDef) ("najboli"++positMSgLoc) ("najboli"++positMSgInstr)
              ("najboli"++positMDlNom) ("najboli"++positMDlGen) ("najboli"++positMDlDat) ("najboli"++positMDlAcc) ("najboli"++positMDlLoc) ("najboli"++positMDlInstr)
              ("najboli"++positMPlNom) ("najboli"++positMPlGen) ("najboli"++positMPlDat) ("najboli"++positMPlAcc) ("najboli"++positMPlLoc) ("najboli"++positMPlInstr)
              ("najboli"++positFSgNom) ("najboli"++positFSgGen) ("najboli"++positFSgDat) ("najboli"++positFSgAcc) ("najboli"++positFSgLoc) ("najboli"++positFSgInstr)
              ("najboli"++positFDlNom) ("najboli"++positFDlGen) ("najboli"++positFDlDat) ("najboli"++positFDlAcc) ("najboli"++positFDlLoc) ("najboli"++positFDlInstr)
              ("najboli"++positFPlNom) ("najboli"++positFPlGen) ("najboli"++positFPlDat) ("najboli"++positFPlAcc) ("najboli"++positFPlLoc) ("najboli"++positFPlInstr)
              ("najboli"++positNSgNom) ("najboli"++positNSgGen) ("najboli"++positNSgDat) ("najboli"++positNSgAcc) ("najboli"++positNSgLoc) ("najboli"++positNSgInstr)
              ("najboli"++positNDlNom) ("najboli"++positNDlGen) ("najboli"++positNDlDat) ("najboli"++positNDlAcc) ("najboli"++positNDlLoc) ("najboli"++positNDlInstr)
              ("najboli"++positNPlNom) ("najboli"++positNPlGen) ("najboli"++positNPlDat) ("najboli"++positNPlAcc) ("najboli"++positNPlLoc) ("najboli"++positNPlInstr) ;

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


  regPron: (x1,_,_,_,_,_,x7:Str) -> Gender -> Number -> Person -> Pron = \nom,acc,gen,dat,loc,inst,poss,g,n,p -> lin Pron {
       s = table {  Nom => nom;
                    Acc => acc;
                    Gen => gen;
                    Dat => dat;
                    Loc => loc;
                    Instr=>inst
                  } ;
      poss = \\g,c,nr => mkAdjForm poss (looseVowel poss+"a") (looseVowel poss+"o") ! c ! g ! nr ; 
      a = {g=g; n=n; p=p}
    };

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

  adjDet : Str -> Number -> Species -> Det = 
    \en,nr,sp -> lin Det {
      s = \\g,c => mkAdjForm en (looseVowel en+"a") (looseVowel en+"o") ! c ! g ! nr ; 
      spec = sp ;
      n = (UseNum nr)
    } ;


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

  --  Comp = {s : Agr => Str} ; 

  mkComp : Str -> Comp = 
    \str -> lin Comp { 
      s = \\agr => mkAdjForm str (looseVowel str+"a") (looseVowel str+"o") ! Nom ! agr.g ! agr.n 
        } ; 

--Helper function that drops the loose vowel that has to go in many conjugations. 

  looseVowel : (_:Str) -> Str = \vowel ->
    case vowel of {
        _ + "sak" => vowel ;
        _ + "er" => Predef.tk 2 vowel + "r" ;
        _ + "čan" => Predef.tk 2 vowel + "n" ;
        _ + "ten" => Predef.tk 2 vowel + "n" ;
        --_ + "len" => Predef.tk 2 vowel + "n" ;
        --_ + "čen" => Predef.tk 2 vowel + "n" ;
        --_ + "zen" => Predef.tk 2 vowel + "n" ;
        _ + "stven" => vowel ;
        --_ + "den" => Predef.tk 2 vowel + "n" ;
        --_ + "šen" => Predef.tk 2 vowel + "n" ;
        _ + "en" => Predef.tk 2 vowel + "n" ; --not yet tested for overgeneration
        --_ + "ec" => Predef.tk 2 vowel + "c" ; --not yet tested for overgeneration
        _ + "el" => Predef.tk 2 vowel + "l" ;
        _ + "ek" => Predef.tk 2 vowel + "k" ;
        _ + "ak" => Predef.tk 2 vowel + "k" ;
        _ + #vowel  => init vowel ;
        _        => vowel
    } ;
    
  vowel : pattern Str = #("a"|"e"|"i"|"o"|"u") ;
  consonant : pattern Str = #("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"r"|"s"|"t"|"v"|"x"|"z") ;
}
