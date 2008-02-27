--# -path=.:../abstract:../common:../../prelude

--1 Bulgarian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResBul = ParamX ** open Prelude in {

  flags optimize=all ;

-- Some parameters, such as $Number$, are inherited from $ParamX$.

--2 For $Noun$

-- This is the worst-case $Case$ needed for pronouns.

  param
    Role = RSubj | RObj Case ;
    Case = Acc | Dat;

    NForm = 
        NF Number Species
      | NFSgDefNom
      | NFPlCount
      | NFVocative
      ;

    GenNum = GSg Gender | GPl ;

-- Agreement of $NP$ is a record. We'll add $Gender$ later.

  oper
    Agr = {gn : GenNum ; p : Person} ;

  param
    Gender = Masc | Fem | Neut ;
    
    Species = Indef | Def ;
 
-- The plural never makes a gender distinction.

--2 For $Verb$

    VForm = 
       VPres      Number Person
     | VAorist    Number Person
     | VImperfect Number Person
     | VPerfect    AForm
     | VPluPerfect AForm
     | VPassive    AForm
     | VPresPart   AForm
     | VImperative Number
     | VGerund
     ;
     
    VType =
       VNormal
     | VMedial  Case
     | VPhrasal Case
     ;

-- The order of sentence is needed already in $VP$.

    Order = Main | Inv | Quest ;

--2 For $Adjective$

    AForm = 
       ASg Gender Species
     | ASgMascDefNom
     | APl Species
     ;

--2 For $Numeral$

    DGender =
       DMasc
     | DMascPersonal
     | DFem
     | DNeut
     ;
    
    DGenderSpecies = 
       DMascIndef
     | DMascDef
     | DMascDefNom
     | DMascPersonalIndef
     | DMascPersonalDef
     | DMascPersonalDefNom
     | DFemIndef
     | DFemDef
     | DNeutIndef
     | DNeutDef
     ;

    CardOrd = NCard DGenderSpecies | NOrd AForm ;
    DForm = unit | teen | ten | hundred ;

--2 Transformations between parameter types

  oper
    gennum : DGender -> Number -> GenNum = \g,n ->
      case n of {
        Sg => GSg (case g of {
                     DMasc         => Masc ;
                     DMascPersonal => Masc ;
                     DFem          => Fem ;
                     DNeut         => Neut
                   }) ;
        Pl => GPl
        } ;

    numGenNum : GenNum -> Number = \gn -> 
      case gn of {
        GSg _  => Sg ;
        GPl    => Pl
      } ;

    aform : GenNum -> Species -> Role -> AForm = \gn,spec,role -> 
      case gn of {
        GSg g  => case <g,spec,role> of {
                    <Masc,Def,RSubj> => ASgMascDefNom ;
                    _                => ASg g spec
                  } ;
        GPl    => APl spec
      } ;

    dgenderSpecies : DGender -> Species -> Role -> DGenderSpecies =
      \g,spec,role -> case <g,spec> of {
                        <DMasc,Indef> => DMascIndef ;
                        <DMasc,Def>   => case role of {
                                           RSubj => DMascDefNom ;
                                           _     => DMascDef
                                         } ;
                        <DMascPersonal,Indef> => DMascPersonalIndef ;
                        <DMascPersonal,Def>   => case role of {
                                                   RSubj => DMascPersonalDefNom ;
                                                   _     => DMascPersonalDef
                                                 } ;
                        <DFem ,Indef> => DFemIndef ;
                        <DFem ,Def>   => DFemDef ;
                        <DNeut,Indef> => DNeutIndef ;
                        <DNeut,Def>   => DNeutDef
                      } ;

    nform2aform : NForm -> DGender -> AForm
      = \nf,g -> case nf of {
                   NF n spec  => aform (gennum g n) spec (RObj Acc) ;
                   NFSgDefNom => aform (gennum g Sg) Def RSubj ;
                   NFPlCount  => APl Indef ;
                   NFVocative => aform (gennum g Sg) Indef (RObj Acc)
                 } ;

    indefNForm : NForm -> NForm
      = \nf -> case nf of {
                 NF n spec  => NF n  Indef ;
                 NFSgDefNom => NF Sg Indef ;
                 NFPlCount  => NFPlCount ;
                 NFVocative => NFVocative
               } ;

    numNForm : NForm -> Number
      = \nf -> case nf of {
                 NF n spec  => n ;
                 NFSgDefNom => Sg ;
                 NFPlCount  => Pl ;
                 NFVocative => Sg
               } ;
      
  oper
-- For $Verb$.
    Verb : Type = {
      s  : VForm => Str ;
      vtype : VType
    } ;

    VP : Type = {
      s   : Tense => Anteriority => Polarity => Agr => Bool => Str ;
      imp : Polarity => Number => Str ;
      s2  : Agr => Str ;
      subjRole : Role
    } ;

    predV : Verb -> VP =
      \verb -> 
        { s = \\t,a,p,agr,q => let 
                                 clitic = case verb.vtype of {
                                               VNormal    => {s=[]; agr=agr} ;
                                               VMedial c  => {s=reflClitics ! c; agr=agr} ;
                                               VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                                             } ;

                                 present = verb.s ! (VPres   (numGenNum clitic.agr.gn) clitic.agr.p) ;
                                 aorist  = verb.s ! (VAorist (numGenNum clitic.agr.gn) clitic.agr.p) ;
                                 perfect = verb.s ! (VPerfect (aform clitic.agr.gn Indef (RObj Acc))) ;
                                 
                                 auxPres    = auxBe clitic.s ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ;
                                 auxAorist  = auxBe clitic.s ! VAorist (numGenNum clitic.agr.gn) clitic.agr.p ;
                                 auxPerfect = auxBe clitic.s ! VPerfect (aform clitic.agr.gn Indef (RObj Acc)) ;
                                 auxCondS   = auxWould clitic.s ! VAorist (numGenNum clitic.agr.gn) clitic.agr.p ;
                                 auxCondA   = auxCondS ++
                                              auxBe [] ! VPerfect (aform clitic.agr.gn Indef (RObj Acc)) ;

                                 verbs : {aux:Str; main:Str}
                                       = case <t,a> of {
                                           <Pres,Simul> => {aux=clitic.s; main=present} ;
                                           <Pres,Anter> => {aux=auxPres; main=perfect} ;
                                           <Past,Simul> => {aux=clitic.s; main=aorist} ;
                                           <Past,Anter> => {aux=auxAorist; main=perfect} ;
                                           <Fut, Simul> => {aux=clitic.s; main=present} ;
                                           <Fut, Anter> => {aux=auxPres; main=perfect} ;
                                           <Cond,Simul> => {aux=auxCondS; main=perfect} ;
                                           <Cond,Anter> => {aux=auxCondA; main=perfect}
                                         } ;

                                 li = case q of {True => "ли"; False => []} ;
                                 aux = case p of {
                                         Pos => case t of {
                                                  Fut => {s1="ще"++verbs.aux; s2=li} ;
                                                  _   => case q of {True  => {s1=[]; s2="ли"++verbs.aux};
                                                                    False => {s1=verbs.aux; s2=[]}}
                                                } ;
                                         Neg => case t of {
                                                  Fut => {s1="не"++"ще"++verbs.aux; s2=li} ;
                                                  _   => case q of {True  => {s1="не"++verbs.aux; s2="ли"};
                                                                    False => {s1="не"++verbs.aux; s2=[]}}
                                                }
                                       }

                             in aux.s1 ++ verbs.main ++ aux.s2;
             imp = \\p,n => let ne = case p of {Pos => []; Neg => "не"} ;
                            in ne ++ verb.s ! VImperative n ;
             s2 = \\_ => [] ;
             subjRole = case verb.vtype of {
                          VNormal    => RSubj ;
                          VMedial  _ => RSubj ;
                          VPhrasal c => RObj c
                        }
           } ;

    insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
      s   = vp.s ;
      imp = vp.imp ;
      s2 = \\a => vp.s2 ! a ++ obj ! a ;
      subjRole = vp.subjRole
      } ;

    auxBe : Str -> VForm => Str = \se ->
      table {
        VPres      Sg P1  => "съм" ++ se ; 
        VPres      Sg P2  => "си" ++ se ;
        VPres      Sg P3  => se ++ "е" ;
        VPres      Pl P1  => "сме" ++ se ; 
        VPres      Pl P2  => "сте" ++ se ;
        VPres      Pl P3  => "са" ++ se ;
        VAorist    Sg P1  => "бях" ++ se ; 
        VAorist    Sg P2  => "беше" ++ se ;
        VAorist    Sg P3  => se ++ "беше" ;
        VAorist    Pl P1  => "бяхме" ++ se ; 
        VAorist    Pl P2  => "бяхте" ++ se ;
        VAorist    Pl P3  => "бяха" ++ se ;
        VImperfect Sg P1  => "бях" ++ se ; 
        VImperfect Sg _   => "беше" ++ se ;
        VImperfect Pl P1  => "бяхме" ++ se ; 
        VImperfect Pl P2  => "бяхте" ++ se ;
        VImperfect Pl P3  => "бяха" ++ se ;
        VPerfect    aform => (regAdjective "бил").s ! aform ++ se ;
        VPluPerfect aform => (regAdjective "бил").s ! aform ++ se ;
        VPassive    aform => (regAdjective "бъден").s ! aform ++ se ;
        VPresPart   aform => (regAdjective "бъдещ").s ! aform ++ se ;
        VImperative Sg    => "бъди" ++ se ;
        VImperative Pl    => "бъдете" ++ se ;
        VGerund           => "бидейки" ++ se
      } ;

    auxWould : Str -> VForm => Str = \se ->
      table {
        VPres      Sg P1  => "бъда" ++ se ; 
        VPres      Sg P2  => "бъдеш" ++ se ;
        VPres      Sg P3  => se ++ "бъде" ; 
        VPres      Pl P1  => "бъдем" ++ se ; 
        VPres      Pl P2  => "бъдете" ++ se ;
        VPres      Pl P3  => "бъдат" ++ se ;
        VAorist    Sg P1  => "бих" ++ se ; 
        VAorist    Sg _   => "би" ++ se ;
        VAorist    Pl P1  => "бихме" ++ se ; 
        VAorist    Pl P2  => "бихте" ++ se ;
        VAorist    Pl P3  => "биха" ++ se ;
        VImperfect Sg P1  => "бъдех" ++ se ; 
        VImperfect Sg _   => "бъдеше" ++ se ;
        VImperfect Pl P1  => "бъдехме" ++ se ; 
        VImperfect Pl P2  => "бъдехте" ++ se ;
        VImperfect Pl P3  => "бъдеха" ++ se ;
        VPerfect    aform => (regAdjective "бил").s ! aform ++ se ;
        VPluPerfect aform => (regAdjective "бъдел").s ! aform ++ se ;
        VPassive    aform => (regAdjective "бъден").s ! aform ++ se ;
        VPresPart   aform => (regAdjective "бъдещ").s ! aform ++ se ;
        VImperative Sg    => "бъди" ++ se ;
        VImperative Pl    => "бъдете" ++ se ;
        VGerund           => "бъдейки" ++ se
      } ;

    verbBe : Verb = {s=auxBe []; vtype=VNormal} ;

    reflClitics : Case => Str = table {Acc => "се"; Dat => "си"} ;

    personalClitics : Case => GenNum => Person => Str =
      table {
        Acc => table {
                 GSg g => table {
                            P1 => "ме" ;
                            P2 => "те" ;
                            P3 => case g of {
                                    Masc => "го" ;
                                    Fem  => "я" ;
                                    Neut => "го"
                                  }
                          } ;
                 GPl   => table {
                            P1 => "ни" ;
                            P2 => "ви" ;
                            P3 => "ги"
                          }
               } ;
        Dat => table {
                 GSg g => table {
                            P1 => "ми" ;
                            P2 => "ти" ;
                            P3 => case g of {
                                    Masc => "му" ;
                                    Fem  => "й" ;
                                    Neut => "му"
                                  }
                          } ;
                 GPl   => table {
                            P1     => "ни" ;
                            P2     => "ви" ;
                            P3     => "им"
                          }
               }
      } ;

    ia2e : Str -> Str =           -- to be used when the next syllable has vowel different from "а","ъ","о" or "у"
      \s -> case s of {
              x@(_*+_) + "я" + y@(("б"|"в"|"г"|"д"|"ж"|"з"|"к"|"л"|"м"|"н"|"п"|"р"|"с"|"т"|"ф"|"х"|"ц"|"ч"|"ш"|"щ")*)
                => x+"e"+y;
              _ => s
            };

    mkAdjective : (_,_,_,_,_,_,_,_,_ : Str) -> {s : AForm => Str} = 
      \dobyr,dobria,dobriat,dobra,dobrata,dobro,dobroto,dobri,dobrite -> {
      s = table {
        ASg Masc Indef => dobyr ;
        ASg Masc Def   => dobria ;
        ASgMascDefNom  => dobriat ;
        ASg Fem  Indef => dobra ;
        ASg Fem  Def   => dobrata ;
        ASg Neut Indef => dobro ;
        ASg Neut Def   => dobroto ;
        APl Indef      => dobri ;
        APl Def        => dobrite
        }
      } ;

    regAdjective : Str -> {s : AForm => Str} = 
      \base -> mkAdjective base 
                           (base+"ия")
                           (base+"ият")
                           (base+"a")
                           (base+"ата")
                           (base+"о")
                           (base+"ото")
                           (ia2e base+"и")
                           (ia2e base+"ите") ;

    mkVerb : (_,_,_,_,_,_,_,_,_:Str) -> Verb = 
      \cheta,chete,chetoh,chetqh,chel,chetql,cheten,chetqst,cheti -> {
      s = table {
            VPres      Sg P1 => cheta;
            VPres      Sg P2 => chete + "ш";
            VPres      Sg P3 => chete;
            VPres      Pl P1 => case chete of {
                                  _ + ("а"|"я") => chete + "ме";
                                  _             => chete + "м"
                                };
            VPres      Pl P2 => chete + "те";
            VPres      Pl P3 => case cheta of {
                                  vika + "м" => case chete of {
                                                  dad + "е" => dad + "ат";
                                                  vika      => vika + "т"
                                                };
                                  _          => cheta + "т"
                                };
            VAorist    Sg P1 => chetoh;
            VAorist    Sg _  => case chetoh of {
                                  chet+"ох" => chete;
                                  zova+ "х" => zova
                                };
            VAorist    Pl P1 => chetoh + "ме";
            VAorist    Pl P2 => chetoh + "те";
            VAorist    Pl P3 => chetoh + "а";
            VImperfect Sg P1 => chetqh;
            VImperfect Sg _  => case chete of {
	                          rabot + "и" => rabot + "eше";
	                          _           => chete + "ше"
                                };
            VImperfect Pl P1 => chetqh + "ме";
            VImperfect Pl P2 => chetqh + "те";
            VImperfect Pl P3 => chetqh + "а";
            VPerfect aform   =>let chel1 : Str =
                                     case chel of {
                                       pas+"ъл" => pas+"л";
                                       _        => chel
                                     }
                               in (mkAdjective chel
                                               (chel+"ия")
                                               (chel+"ият")
                                               (chel1+"a")
                                               (chel1+"ата")
                                               (chel1+"о")
                                               (chel1+"ото")
                                               (ia2e chel1+"и")
                                               (ia2e chel1+"ите")).s ! aform ;
            VPluPerfect aform => (regAdjective chetql ).s ! aform ;
            VPassive    aform => (regAdjective cheten ).s ! aform ;
            VPresPart   aform => (regAdjective chetqst).s ! aform ;
            VImperative Sg => cheti;
            VImperative Pl => case cheti of {
	                        chet + "и" => chet + "ете";
	                        ela        => ela  + "те"
                              };
            VGerund => case chete of {
                         rabot + "и" => rabot + "ейки";
                         _           => chete + "йки"
                       }
          } ;
      vtype = VNormal
    } ;
    
-- For $Sentence$.

    Clause : Type = {
      s : Tense => Anteriority => Polarity => Order => Str
      } ;

    mkClause : Str -> Agr -> VP -> Clause =
      \subj,agr,vp -> {
        s = \\t,a,b,o => 
          let 
            verb  = vp.s ! t ! a ! b ! agr ! False ;
            verbq = vp.s ! t ! a ! b ! agr ! True ;
            compl = vp.s2 ! agr
          in case o of {
              Main  => subj ++ verb ++ compl ;
              Inv   => verb ++ compl ++ subj ;
              Quest => subj ++ verbq ++ compl
             }
      } ;
      
-- For $Numeral$.

    mkDigit : Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} =
      \dva, dvama, dve, vtori, dvesta ->
      {s = table {
             unit                  => mkCardOrd dva dvama dve vtori ;
             teen                  => mkCardOrd (dva+"надесет") (dva+"надесетима") (dva+"надесет") (dva+"надесети") ;
             ten                   => mkCardOrd (dva+"десет")   (dva+"десетима")   (dva+"десет")   (dva+"десети") ;
             hundred               => let dvesten : Str
                                                  = case dvesta of {
                                                      dvest+"а"        => dvest+"ен" ;
                                                      chetiristot+"ин" => chetiristot+"ен"
                                                    }
                                      in mkCardOrd dvesta dvesta dvesta dvesten
           }
      } ;

    mkCardOrd : Str -> Str -> Str -> Str -> CardOrd => Str =
      \dva, dvama, dve, vtori ->
               table {
                 NCard dg   => digitGenderSpecies dva dvama dve ! dg ;
                 NOrd aform => let vtora = init vtori + "а" ;
                                   vtoro = init vtori + "о"
                               in (mkAdjective vtori
                                               (vtori+"я")
                                               (vtori+"ят")
                                               vtora
                                               (vtora+"та")
                                               vtoro
                                               (vtoro+"то")
                                               vtori
                                               (vtori+"те")).s ! aform
               } ;

    digitGenderSpecies : Str -> Str -> Str -> DGenderSpecies => Str =
      \dva, dvama, dve
            -> let addDef : Str -> Str =
                     \s -> case s of {
		             dves+"та" => dves+"тате" ;
		             dv+"а"    => dv+"ата" ;
		             x         => x+"те"
                           }
               in table {
                    DMascIndef          => dva ;
                    DMascDef            => addDef dva ;
                    DMascDefNom         => addDef dva ;
                    DMascPersonalIndef  => dvama ;
                    DMascPersonalDef    => addDef dvama ;
                    DMascPersonalDefNom => addDef dvama ;
                    DFemIndef           => dve ;
                    DFemDef             => addDef dve ;
                    DNeutIndef          => dve ;
                    DNeutDef            => addDef dve
                  } ;

    mkIP : Str -> Str -> GenNum -> {s : Role => Str ; gn : GenNum} =
      \koi,kogo,gn -> {
      s = table {
            RSubj    => koi ;
            RObj Acc => kogo ;
            RObj Dat => "на" ++ kogo
          } ;
      gn = gn
      } ;

    mkPron : (az,men,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite : Str) -> GenNum -> Person -> {s : Role => Str; gen : AForm => Str; a : Agr} =
      \az,men,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite,gn,p -> {
      s = table {
            RSubj    => az ;
            RObj Acc => men ;
            RObj Dat => mi
          } ;
      gen = (mkAdjective moj moia moiat moia_ moiata moe moeto moi moite).s ;
      a = {
           gn = gn ;
           p = p
          }
      } ;

    mkNP : Str -> GenNum -> Person -> {s : Role => Str; a : Agr} =
      \s,gn,p -> {
      s = table {
            RSubj    => s ;
            RObj Acc => s ;
            RObj Dat => "на" ++ s
          } ;
      a = {
           gn = gn ;
           p = p
          }
      } ;
      
    Preposition : Type = {s : Str; c : Case};

    mkQuestion : 
      {s1,s2 : Str} -> Clause -> 
      {s : Tense => Anteriority => Polarity => QForm => Str} = \wh,cl ->
      {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p ;
            in table {
                 QDir   => wh.s1 ++ cls ! Inv ;
                 QIndir => wh.s2 ++ cls ! Main
               }
      } ;

    whichRP : GenNum => Str
            = table {
                GSg Masc => "който" ;
                GSg Fem  => "която" ;
                GSg Neut => "което" ;
                GPl      => "които"
              } ;
}
