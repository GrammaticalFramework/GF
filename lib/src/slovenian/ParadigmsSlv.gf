resource ParadigmsSlv = open CatSlv, ResSlv, Prelude in {

oper
  nominative : Case = Nom ;
  dative     : Case = Dat ;
  accusative : Case = Acc ;
  locative   : Case = Loc ;
  instrumental:Case = Instr ;

  mkPrep : Str -> Case -> Prep =
    \s,c -> lin Prep {s=s; c=c};

  masculine = Masc;
  feminine  = Fem;
  neuter    = Neut;

  mkN : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Gender -> N =
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

  mkPN : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Gender -> PN =
    \nomsg,nomdl,nompl,gensg,gendl,genpl,datsg,datdl,datpl,accsg,accdl,accpl,locsg,locdl,locpl,instrsg,instrdl,instrpl,g -> lin PN {
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
    
  mkV : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> V =
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

  mkV2 = overload {
    mkV2 : V -> V2 = \v -> v ** {c2 = lin Prep {s=""; c=Acc}} ;
    mkV2 : V -> Case -> V2 = \v,c -> v ** {c2 = lin Prep {s=""; c=c}} ;
  } ;

  mkVQ : V -> VQ ;
  mkVQ v = v ;

  mkVV : V -> VV ;
  mkVV v = v ;

  mkA : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> A =
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

  mkPron : (_,_,_,_,_,_,_ : Str) -> Gender -> Number -> Person -> Pron =
    \nom,acc,gen,dat,loc,instr,poss,g,n,p ->
    lin Pron {s = table {
                    Nom => nom;
                    Acc => acc;
                    Gen => gen;
                    Dat => dat;
                    Loc => loc;
                    Instr=>instr
                  } ;
              poss = poss ;
              a = {g=g; n=n; p=p}
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
            a = {g=Neut; n=n; p=P3}
           } ;

  mkInterj : Str -> Interj =
    \s -> lin Interj {s=s} ;
    
  mkConj : Str -> Conj =
    \s -> lin Conj {s=s} ;
}
