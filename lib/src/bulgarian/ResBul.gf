--# -path=.:../abstract:../common:../../prelude

--1 Bulgarian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResBul = ParamX ** open Prelude in {

  flags
    coding=cp1251 ;  optimize=all ;


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

    Animacy = Human | NonHuman ;

    AGender =
       AMasc Animacy
     | AFem
     | ANeut
     ;
    
    CardForm =
       CFMasc Species Animacy
     | CFMascDefNom   Animacy
     | CFFem  Species
     | CFNeut Species
     ;

    CardOrd = NCard CardForm | NOrd AForm ;
    NumF  = Formal | Informal ;
    DForm = unit | teen NumF | ten NumF | hundred ;

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

    gennum : AGender -> Number -> GenNum = \g,n ->
      case n of {
        Sg => GSg (case g of {
                     AMasc _       => Masc ;
                     AFem          => Fem ;
                     ANeut         => Neut
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

    dgenderSpecies : AGender -> Species -> Role -> CardForm =
      \g,spec,role -> case <g,spec> of {
                        <AMasc a,Indef> => CFMasc Indef a ;
                        <AMasc a,Def>   => case role of {
                                             RSubj => CFMascDefNom a ;
                                             _     => CFMasc Def a
                                           } ;
                        <AFem   ,Indef> => CFFem Indef ;
                        <AFem   ,Def>   => CFFem Def ;
                        <ANeut  ,Indef> => CFNeut Indef ;
                        <ANeut  ,Def>   => CFNeut Def
                      } ;

    nform2aform : NForm -> AGender -> AForm
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
      s     : Aspect => VTable ;
      ad    : {isEmpty : Bool; s : Str} ;          -- sentential adverb
      compl : Agr => Str ;
      vtype : VType
    } ;
    
    VPSlash = {
      s      : Aspect => VTable ;
      ad     : {isEmpty : Bool; s : Str} ;         -- sentential adverb
      compl1 : Agr => Str ;
      compl2 : Agr => Str ;
      vtype  : VType ;
      c2     : Preposition
    } ;

    predV : Verb -> VP = \verb -> {
      s     = verb.s ;
      ad    = {isEmpty=True; s=[]} ;
      compl = \\_ => [] ;
      vtype = verb.vtype ;
    } ;

    slashV : Verb -> Preposition -> VPSlash = \verb,prep -> {
      s      = verb.s ;
      ad     = {isEmpty=True; s=[]} ;
      compl1 = \\_ => [] ;
      compl2 = \\_ => [] ;
      vtype  = verb.vtype ;
      c2     = prep ;
    } ;

    insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
      s     = vp.s ;
      ad    = vp.ad ;
      compl = \\a => vp.compl ! a ++ obj ! a ;
      vtype = vp.vtype
      } ;

    insertSlashObj1 : (Agr => Str) -> VPSlash -> VPSlash = \obj,slash -> {
      s      = slash.s ;
      ad     = slash.ad ;
      compl1 = \\a => slash.compl1 ! a ++ obj ! a ;
      compl2 = slash.compl2 ;
      vtype  = slash.vtype ;
      c2     = slash.c2
      } ;

    insertSlashObj2 : (Agr => Str) -> VPSlash -> VPSlash = \obj,slash -> {
      s      = slash.s ;
      ad     = slash.ad ;
      compl1 = slash.compl1 ;
      compl2 = \\a => slash.compl2 ! a ++ obj ! a ;
      vtype  = slash.vtype ;
      c2     = slash.c2
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
    \base -> 
       let base0 : Str
                 = case base of {
                     x+"и" => x;
                     x     => x
                   }
       in table {
            ASg Masc Indef => base  ;
            ASg Masc Def   => (base0+"ия") ;
            ASgMascDefNom  => (base0+"ият") ;
            ASg Fem  Indef => (base0+"а") ;
            ASg Fem  Def   => (base0+"aтa") ;
            ASg Neut Indef => (base0+"о") ;
            ASg Neut Def   => (base0+"ото") ;
            APl Indef      => (ia2e base0+"и") ;
            APl Def        => (ia2e base0+"ите")
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
                = \\q => vpTenses vp ! t ! a ! p ! agr ! q ! Perf ;
          compl = vp.compl ! agr
        in case o of {
             Main  => subj ++ verb ! False ++ compl ;
             Inv   => verb ! False ++ compl ++ subj ;
             Quest => subj ++ verb ! True ++ compl
           }
    } ;

  vpTenses : VP -> Tense => Anteriority => Polarity => Agr => Bool => Aspect => Str =
    \verb -> \\t,a,p,agr,q0,asp =>
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
              <Sg, P3> => clitic.s++auxPres++s ;
              _        => auxPres++s++clitic.s
            } ;

          li0 = case <verb.ad.isEmpty,q0> of {<False,True> => "ли"; _ => []} ;

          q   = case verb.ad.isEmpty of {True => q0; False => False} ;
          li  = case q of {True => "ли"; _ => []} ;

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

          verbs : {aux:{s1:Str; s2:Str}; main:Str} =
            case <t,a> of {
              <Pres,Simul> => {aux=vf2 clitic.s;  main=presentImperf}
              ;                                                    --# notpresent
              <Pres,Anter> => {aux=vf1 clitic.s;  main=perfect} ; --# notpresent
              <Past,Simul> => {aux=vf2 clitic.s;  main=aorist} ; --# notpresent
              <Past,Anter> => {aux=vf4 auxAorist; main=perfect} ; --# notpresent
              <Fut, Simul> => {aux=vf3 clitic.s;  main=present} ; --# notpresent
              <Fut, Anter> => {aux=vf3 (apc []);  main=perfect} ; --# notpresent
              <Cond,_    > => {aux=vf4 auxCond ;  main=perfect} --# notpresent
            }

      in verb.ad.s ++ li0 ++ verbs.aux.s1 ++ verbs.main ++ verbs.aux.s2 ;

  daComplex : VP -> Aspect => Agr => Str =
    \vp -> \\asp,agr =>
      let clitic = case vp.vtype of {
                     VNormal    => {s=[]; agr=agr} ;
                     VMedial c  => {s=reflClitics ! c; agr=agr} ;
                     VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                   }
      in vp.ad.s ++ "да" ++ clitic.s ++ vp.s ! asp ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ++ vp.compl ! agr ;

-- For $Numeral$.

    mkDigit : Str -> Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} =
      \dva, dvama, dve, vtori, dvaiset, dvesta ->
      {s = table {
             unit                  => mkCardOrd dva dvama dve vtori ;
             teen nf               => case nf of {
                                        Formal   => mkCardOrd (dva+"надесет") (dva+"надесетима") (dva+"надесет") (dva+"надесети") ;
                                        Informal => mkCardOrd (dva+"найсет")  (dva+"найсет")     (dva+"найсет")  (dva+"найсти")
                                      } ;
             ten  nf               => case nf of {
                                        Formal   => mkCardOrd (dva+"десет")   (dva+"десетима")   (dva+"десет")   (dva+"десети") ;
                                        Informal => mkCardOrd dvaiset         dvaiset            dvaiset         (dvaiset+"и")
                                      } ;
             hundred               => let dvesten : Str
                                                  = case dvesta of {
                                                      dvest+"а"        => dvest+"ен" ;
                                                      chetiristot+"ин" => chetiristot+"ен"
                                                    }
                                      in mkCardOrd100 dvesta dvesten
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

    mkCardOrd100 : Str -> Str -> CardOrd => Str =
      \sto, stoten ->
               table {
                 NCard dg   => sto ;
                 NOrd aform => let stotn = init (init stoten) + last stoten ;
                               in case aform of {
                                    ASg Masc Indef => stoten ;
                                    ASg Masc Def   => stotn+"ия" ;
                                    ASgMascDefNom  => stotn+"ият" ;
                                    ASg Fem  Indef => stotn+"а" ;
                                    ASg Fem  Def   => stotn+"ата" ;
                                    ASg Neut Indef => stotn+"о" ;
                                    ASg Neut Def   => stotn+"ото" ;
                                    APl Indef      => stotn+"и" ;
                                    APl Def        => stotn+"ите"
                                  }
               } ;

    digitGenderSpecies : Str -> Str -> Str -> CardForm => Str =
      \dva, dvama, dve
            -> let addDef : Str -> Str =
                     \s -> case s of {
		             dves+"та" => dves+"тате" ;
		             dv+"а"    => dv+"ата" ;
		             x         => x+"те"
                           }
               in table {
                    CFMasc Indef  NonHuman => dva ;
                    CFMasc Def    NonHuman => addDef dva ;
                    CFMascDefNom  NonHuman => addDef dva ;
                    CFMasc Indef  Human    => dvama ;
                    CFMasc Def    Human    => addDef dvama ;
                    CFMascDefNom  Human    => addDef dvama ;
                    CFFem  Indef           => dve ;
                    CFFem  Def             => addDef dve ;
                    CFNeut Indef           => dve ;
                    CFNeut Def             => addDef dve
                  } ;

    mkIP : Str -> Str -> GenNum -> {s : Role => QForm => Str ; gn : GenNum} =
      \koi,kogo,gn -> {
      s = table {
            RSubj    => table QForm [koi;  koi+"то"] ;
            RObj Acc => table QForm [kogo; kogo+"то"] ;
            RObj Dat => table QForm ["на" ++ kogo; kogo+"то"] ;
            RVoc     => table QForm [koi;  koi+"то"]
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
      {s : QForm => Str} -> Clause -> 
      {s : Tense => Anteriority => Polarity => QForm => Str} = \wh,cl ->
      {
      s = \\t,a,p,qform => 
            let cls = cl.s ! t ! a ! p ;
            in wh.s ! qform ++ cls ! case qform of {
                                       QDir   => Inv ;
                                       QIndir => Main
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

    linCoord : Bool => Str ;
    linCoord = table {True => "и"; False=>"или"} ;
    
    linCoordSep : Str -> Bool => Bool => Str ;
    linCoordSep s = table {True => linCoord; False=> \\_ => s} ;
}
