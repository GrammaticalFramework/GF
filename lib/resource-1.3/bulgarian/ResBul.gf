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
    Role = RSubj | RObj Case | RVoc ;
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

    Aspect = Imperf | Perf ;

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
    agrP3 : GenNum -> Agr = \gn -> 
      {gn = gn; p = P3} ;

    conjGenNum : GenNum -> GenNum -> GenNum = \a,b ->
      case <a,b> of {
        <GSg _,GSg g> => GSg g ;
        _             => GPl
    } ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      gn = conjGenNum a.gn b.gn ;
      p  = conjPerson a.p b.p
      } ;

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
    VTable = VForm => Str ;

    Verb : Type = {
      s      : Aspect => VTable ;
      vtype  : VType
    } ;

    VP : Type = {
      s   : Tense => Anteriority => Polarity => Agr => Bool => Aspect => Str ;
      imp : Polarity => Number => Aspect => Str ;
      ad  : Bool => Str ;          -- sentential adverb
      s2  : Agr => Str ;
      subjRole : Role
    } ;

    predV : Verb -> VP =
      \verb -> 
        { s = \\t,a,p,agr,q,asp =>
                             let clitic = case verb.vtype of {
                                            VNormal    => {s=[]; agr=agr} ;
                                            VMedial c  => {s=reflClitics ! c; agr=agr} ;
                                            VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                                          } ;

                                 present = verb.s ! asp ! (VPres   (numGenNum clitic.agr.gn) clitic.agr.p) ;
                                 presentImperf = verb.s ! Imperf ! (VPres   (numGenNum clitic.agr.gn) clitic.agr.p) ;
                                 aorist = verb.s ! asp ! (VAorist (numGenNum clitic.agr.gn) clitic.agr.p) ;
                                 perfect = verb.s ! asp ! (VPerfect (aform clitic.agr.gn Indef (RObj Acc))) ;

                                 auxPres   = auxBe ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ;
                                 auxAorist = auxBe ! VAorist (numGenNum clitic.agr.gn) clitic.agr.p ;
                                 auxCond   = auxWould ! VAorist (numGenNum clitic.agr.gn) clitic.agr.p ;

                                 apc : Str -> Str = \s ->
                                   case <numGenNum clitic.agr.gn, clitic.agr.p> of {
                                     <Sg, P3> => clitic.s++s++auxPres ;
                                     _        => auxPres++s++clitic.s
                                   } ;
                                 
                                 li = case q of {True => "ли"; False => []} ;

                                 vf1 : Str -> {s1 : Str; s2 : Str} = \s ->
                                       case p of {
                                         Pos => case q of {True  => {s1=[]; s2="ли"++apc []};
                                                           False => {s1=apc []; s2=[]}} ;
                                         Neg => {s1="не"++apc li; s2=[]}
                                       } ;

                                 vf2 : Str -> {s1 : Str; s2 : Str} = \s ->
                                       case p of {
                                         Pos => case q of {True  => {s1=[]; s2="ли"++s};
                                                           False => {s1=s;  s2=[]}} ;
                                         Neg => case verb.vtype of
                                                          {VNormal => {s1="не"; s2=li} ;
				                           _       => {s1="не"++s++li; s2=[]}}
                                       } ;

                                 vf3 : Str -> {s1 : Str; s2 : Str} = \s ->
                                       case p of {
                                         Pos => {s1="ще"++s; s2=li} ;
                                         Neg => {s1="няма"++li++"да"++s; s2=[]}
                                       } ;

                                 vf4 : Str -> {s1 : Str; s2 : Str} = \s ->
                                       case p of {
                                         Pos => {s1=      s++li++clitic.s; s2=[]} ;
                                         Neg => {s1="не"++s++li++clitic.s; s2=[]}
                                       } ;

                                 verbs : {aux:{s1:Str; s2:Str}; main:Str}
                                       = case <t,a> of {
                                           <Pres,Simul> => {aux=vf2 clitic.s;  main=presentImperf} ;
                                           <Pres,Anter> => {aux=vf1 clitic.s;  main=perfect} ;
                                           <Past,Simul> => {aux=vf2 clitic.s;  main=aorist} ;
                                           <Past,Anter> => {aux=vf4 auxAorist; main=perfect} ;
                                           <Fut, Simul> => {aux=vf3 clitic.s;  main=present} ;
                                           <Fut, Anter> => {aux=vf3 (apc []);  main=perfect} ;
                                           <Cond,_    > => {aux=vf4 auxCond ;  main=perfect}
                                         }

                            in verbs.aux.s1 ++ verbs.main ++ verbs.aux.s2 ;
             imp = \\p,n,asp =>
                            case p of {
                              Pos => verb.s ! asp ! VImperative n ;
                              Neg => "не" ++ verb.s ! Imperf ! VImperative n
                            } ;
             ad = \\_ => [] ;
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
      ad  = vp.ad ;
      s2 = \\a => vp.s2 ! a ++ obj ! a ;
      subjRole = vp.subjRole
      } ;

    auxBe : VTable =
      table {
        VPres      Sg P1  => "съм" ; 
        VPres      Sg P2  => "си" ;
        VPres      Sg P3  => "е" ;
        VPres      Pl P1  => "сме" ; 
        VPres      Pl P2  => "сте" ;
        VPres      Pl P3  => "са" ;
        VAorist    Sg P1  => "бях" ; 
        VAorist    Sg _   => "беше" ;
        VAorist    Pl P1  => "бяхме" ; 
        VAorist    Pl P2  => "бяхте" ;
        VAorist    Pl P3  => "бяха" ;
        VImperfect Sg P1  => "бях" ; 
        VImperfect Sg _   => "беше" ;
        VImperfect Pl P1  => "бяхме" ; 
        VImperfect Pl P2  => "бяхте" ;
        VImperfect Pl P3  => "бяха" ;
        VPerfect    aform => regAdjective "бил" ! aform ;
        VPluPerfect aform => regAdjective "бил" ! aform ;
        VPassive    aform => regAdjective "бъден" ! aform ;
        VPresPart   aform => regAdjective "бъдещ" ! aform ;
        VImperative Sg    => "бъди" ;
        VImperative Pl    => "бъдете" ;
        VGerund           => "бидейки"
      } ;

    auxWould : VTable =
      table {
        VPres      Sg P1  => "бъда" ; 
        VPres      Sg P2  => "бъдеш" ;
        VPres      Sg P3  => "бъде" ; 
        VPres      Pl P1  => "бъдем" ; 
        VPres      Pl P2  => "бъдете" ;
        VPres      Pl P3  => "бъдат" ;
        VAorist    Sg P1  => "бих" ; 
        VAorist    Sg _   => "би" ;
        VAorist    Pl P1  => "бихме" ; 
        VAorist    Pl P2  => "бихте" ;
        VAorist    Pl P3  => "биха" ;
        VImperfect Sg P1  => "бъдех" ; 
        VImperfect Sg _   => "бъдеше" ;
        VImperfect Pl P1  => "бъдехме" ; 
        VImperfect Pl P2  => "бъдехте" ;
        VImperfect Pl P3  => "бъдеха" ;
        VPerfect    aform => regAdjective "бил" ! aform ;
        VPluPerfect aform => regAdjective "бъдел" ! aform ;
        VPassive    aform => regAdjective "бъден" ! aform ;
        VPresPart   aform => regAdjective "бъдещ" ! aform ;
        VImperative Sg    => "бъди" ;
        VImperative Pl    => "бъдете" ;
        VGerund           => "бъдейки"
      } ;

    verbBe    : Verb = {s=\\_=>auxBe ;    vtype=VNormal} ;
    verbWould : Verb = {s=\\_=>auxWould ; vtype=VNormal} ;

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

  regAdjective : Str -> AForm => Str = 
    \base -> table {
          ASg Masc Indef => base  ;
          ASg Masc Def   => (base+"ия") ;
          ASgMascDefNom  => (base+"ият") ;
          ASg Fem  Indef => (base+"a") ;
          ASg Fem  Def   => (base+"ата") ;
          ASg Neut Indef => (base+"о") ;
          ASg Neut Def   => (base+"ото") ;
          APl Indef      => (ia2e base+"и") ;
          APl Def        => (ia2e base+"ите")
        };
    
-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
  } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,p,o => 
        let 
          verb  : Bool => Str
                = \\q => vp.ad ! q ++ vp.s ! t ! a ! p ! agr ! q ! Perf ;
          compl = vp.s2 ! agr
        in case o of {
             Main  => subj ++ verb ! False ++ compl ;
             Inv   => verb ! False ++ compl ++ subj ;
             Quest => subj ++ verb ! True ++ compl
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
                               in case aform of {
                                    ASg Masc Indef => vtori ;
                                    ASg Masc Def   => vtori+"я" ;
                                    ASgMascDefNom  => vtori+"ят" ;
                                    ASg Fem  Indef => vtora ;
                                    ASg Fem  Def   => vtora+"та" ;
                                    ASg Neut Indef => vtoro ;
                                    ASg Neut Def   => vtoro+"то" ;
                                    APl Indef      => vtori ;
                                    APl Def        => vtori+"те"
                                  }
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
            RObj Dat => "на" ++ kogo ;
            RVoc     => koi
          } ;
      gn = gn
      } ;

    mkPron : (az,men,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite : Str) -> GenNum -> Person -> {s : Role => Str; gen : AForm => Str; a : Agr} =
      \az,men,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite,gn,p -> {
      s = table {
            RSubj    => az ;
            RObj Acc => men ;
            RObj Dat => mi ;
            RVoc     => az
          } ;
      gen = table {
              ASg Masc Indef => moj ;
              ASg Masc Def   => moia ;
              ASgMascDefNom  => moiat ;
              ASg Fem  Indef => moia_ ;
              ASg Fem  Def   => moiata ;
              ASg Neut Indef => moe ;
              ASg Neut Def   => moeto ;
              APl Indef      => moi ;
              APl Def        => moite
            } ;
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
            RObj Dat => "на" ++ s ;
            RVoc     => s
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

    suchRP : GenNum => Str
           = table {
               GSg Masc => "такъв" ;
               GSg Fem  => "такава" ;
               GSg Neut => "такова" ;
               GPl      => "такива"
             } ;
             
    thisRP : GenNum => Str
           = table {
               GSg Masc => "този" ;
               GSg Fem  => "тaзи" ;
               GSg Neut => "това" ;
               GPl      => "тези"
             } ;
}
