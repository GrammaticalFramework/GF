--# -path=.:../abstract:../common:../../prelude
--# -coding=cp1251

--1 Bulgarian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResBul = ParamX ** open Prelude, Predef in {

  flags
    coding=cp1251 ;  optimize=all ;


-- Some parameters, such as $Number$, are inherited from $ParamX$.

--2 For $Noun$

-- This is the worst-case $Case$ needed for pronouns.

  param
    Role = RSubj | RObj Case | RVoc ;
    Case = Acc | Dat | WithPrep ;

    NForm = 
        NF Number Species
      | NFSgDefNom
      | NFPlCount
      | NFVocative
      ;
      
    NNumber =
        NNum Number
      | NCountable
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
     | VNoun NForm
     | VGerund
     ;
     
    VType =
       VNormal
     | VMedial  Case
     | VPhrasal Case
     ;

    VVType = VVInf Aspect | VVGerund ;

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

    numnnum : NNumber -> Number = \nn ->
      case nn of {
        NNum n     => n ;
        NCountable => Pl
      } ;

    orPol : Polarity -> Polarity -> Polarity = \p1,p2 ->
      case p1 of {
        Neg => Neg;
        Pos => p2
      } ;

    aform : GenNum -> Species -> Role -> AForm = \gn,spec,role -> 
      case gn of {
        GSg g  => case <g,spec,role> of {
                    <Masc,Def,RSubj> => ASgMascDefNom ;
                    _                => ASg g spec
                  } ;
        GPl    => APl spec
      } ;

    indefAForm : AForm -> AForm
      = \af -> case af of {
                 ASg g spec    => ASg g Indef ;
                 ASgMascDefNom => ASg Masc Indef ;
                 APl spec      => APl Indef
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

    aform2gennum : AForm -> GenNum 
      = \aform -> case aform of {
                    ASg g _       => GSg g ;
                    ASgMascDefNom => GSg Masc ;
                    _             => GPl
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
      vtype : VType ;
      p     : Polarity ;
      isSimple : Bool    -- regulates the place of participle used as adjective
    } ;

    VPSlash = {
      s      : Aspect => VTable ;
      ad     : {isEmpty : Bool; s : Str} ;         -- sentential adverb
      compl1 : Agr => Str ;
      compl2 : Agr => Str ;
      vtype  : VType ;
      p      : Polarity ;
      c2     : Preposition ;
      isSimple : Bool ;    -- regulates the place of participle used as adjective
      subjCtrl : Bool      -- the second complement agrees with the subject or with the first complement
    } ;

    predV : Verb -> VP = \verb -> {
      s     = verb.s ;
      ad    = {isEmpty=True; s=[]} ;
      compl = \\_ => [] ;
      vtype = verb.vtype ;
      p     = Pos ;
      isSimple = True
    } ;

    slashV : Verb -> Preposition -> Bool -> VPSlash = \verb,prep,subjCtrl -> {
      s      = verb.s ;
      ad     = {isEmpty=True; s=[]} ;
      compl1 = \\_ => [] ;
      compl2 = \\_ => [] ;
      vtype  = verb.vtype ;
      p      = Pos ;
      c2     = prep ;
      isSimple = True ;
      subjCtrl = subjCtrl
    } ;

    insertObj : (Agr => Str) -> Polarity -> VP -> VP = \obj,p,vp -> {
      s     = vp.s ;
      ad    = vp.ad ;
      compl = \\a => vp.compl ! a ++ obj ! a ;
      vtype = vp.vtype ;
      p     = case p of {
                Neg => Neg;
                _   => vp.p
              } ;
      isSimple = False
      } ;

    insertSlashObj1 : (Agr => Str) -> Polarity -> VPSlash -> VPSlash = \obj,p,slash -> {
      s      = slash.s ;
      ad     = slash.ad ;
      compl1 = \\a => slash.compl1 ! a ++ obj ! a ;
      compl2 = slash.compl2 ;
      vtype  = slash.vtype ;
      p      = case p of {
                 Neg => Neg ;
                 Pos => slash.p
               } ;
      c2     = slash.c2 ;
      isSimple = False ;
      subjCtrl = slash.subjCtrl
      } ;

    insertSlashObj2 : (Agr => Str) -> Polarity -> VPSlash -> VPSlash = \obj,p,slash -> {
      s      = slash.s ;
      ad     = slash.ad ;
      compl1 = slash.compl1 ;
      compl2 = \\a => slash.compl2 ! a ++ obj ! a ;
      vtype  = slash.vtype ;
      p      = case p of {
                 Neg => Neg ;
                 Pos => slash.p
               } ;
      c2     = slash.c2 ;
      isSimple = False ;
      subjCtrl = slash.subjCtrl
      } ;

    auxBe : VTable =
      table {
        VPres      Sg P1  => "���" ; 
        VPres      Sg P2  => "��" ;
        VPres      Sg P3  => "�" ;
        VPres      Pl P1  => "���" ; 
        VPres      Pl P2  => "���" ;
        VPres      Pl P3  => "��" ;
        VAorist    Sg P1  => "���" ; 
        VAorist    Sg _   => "����" ;
        VAorist    Pl P1  => "�����" ; 
        VAorist    Pl P2  => "�����" ;
        VAorist    Pl P3  => "����" ;
        VImperfect Sg P1  => "���" ; 
        VImperfect Sg _   => "����" ;
        VImperfect Pl P1  => "�����" ; 
        VImperfect Pl P2  => "�����" ;
        VImperfect Pl P3  => "����" ;
        VPerfect    aform => regAdjective "���" ! aform ;
        VPluPerfect aform => regAdjective "���" ! aform ;
        VPassive    aform => regAdjective "�����" ! aform ;
        VPresPart   aform => regAdjective "�����" ! aform ;
        VImperative Sg    => "����" ;
        VImperative Pl    => "������" ;
        VNoun _           => "������";
        VGerund           => "�������"
      } ;

    auxWould : VTable =
      table {
        VPres      Sg P1  => "����" ; 
        VPres      Sg P2  => "�����" ;
        VPres      Sg P3  => "����" ; 
        VPres      Pl P1  => "�����" ; 
        VPres      Pl P2  => "������" ;
        VPres      Pl P3  => "�����" ;
        VAorist    Sg P1  => "���" ; 
        VAorist    Sg _   => "����" ;
        VAorist    Pl P1  => "�����" ; 
        VAorist    Pl P2  => "�����" ;
        VAorist    Pl P3  => "����" ;
        VImperfect Sg P1  => "�����" ; 
        VImperfect Sg _   => "������" ;
        VImperfect Pl P1  => "�������" ; 
        VImperfect Pl P2  => "�������" ;
        VImperfect Pl P3  => "������" ;
        VPerfect    aform => regAdjective "���" ! aform ;
        VPluPerfect aform => regAdjective "�����" ! aform ;
        VPassive    aform => regAdjective "�����" ! aform ;
        VPresPart   aform => regAdjective "�����" ! aform ;
        VImperative Sg    => "����" ;
        VImperative Pl    => "������" ;
        VNoun _           => "������";
        VGerund           => "�������"
      } ;

    auxCond : Number => Person => Str =
      table {
        Sg => table {
                P1 => "���" ;
                _  => "��"
              } ;
        Pl => table {
                P1 => "�����" ;
                P2 => "�����" ;
                P3 => "����"
              }
      } ;

    verbBe    : Verb = {s=table Aspect [auxBe; auxWould] ; vtype=VNormal} ;

    reflClitics : Case => Str = table {Acc => "��"; Dat => "��"; WithPrep => with_Word ++ "���� ��"} ;

    personalClitics : Case => GenNum => Person => Str =
      table {
        Acc      => table {
                      GSg g => table {
                                 P1 => "��" ;
                                 P2 => "��" ;
                                 P3 => case g of {
                                         Masc => "��" ;
                                         Fem  => "�" ;
                                         Neut => "��"
                                       }
                               } ;
                      GPl   => table {
                                 P1 => "��" ;
                                 P2 => "��" ;
                                 P3 => "��"
                               }
                    } ;
        Dat      => table {
                      GSg g => table {
                                 P1 => "��" ;
                                 P2 => "��" ;
                                 P3 => case g of {
                                         Masc => "��" ;
                                         Fem  => "�" ;
                                         Neut => "��"
                                       }
                               } ;
                      GPl   => table {
                                 P1     => "��" ;
                                 P2     => "��" ;
                                 P3     => "��"
                               }
                    } ;
        WithPrep => table {
                      GSg g => table {
                                 P1 => with_Word ++ "���" ;
                                 P2 => with_Word ++ "���" ;
                                 P3 => case g of {
                                         Masc => with_Word ++ "����" ;
                                         Fem  => with_Word ++ "���" ;
                                         Neut => with_Word ++ "����"
                                       }
                               } ;
                      GPl   => table {
                                 P1     => with_Word ++ "���" ;
                                 P2     => with_Word ++ "���" ;
                                 P3     => with_Word ++ "���"
                               }
                    }
      } ;

    ia2e : Str -> Str =           -- to be used when the next syllable has vowel different from "�","�","�" or "�"
      \s -> case s of {
              x@(_*+_) + "�" + y@(("�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�"|"�")*)
                => x+"�"+y;
              _ => s
            };

  regAdjective : Str -> AForm => Str = 
    \base -> 
       let base0 : Str
                 = case base of {
                     x+"�" => x;
                     x     => x
                   }
       in table {
            ASg Masc Indef => base  ;
            ASg Masc Def   => (base0+"��") ;
            ASgMascDefNom  => (base0+"���") ;
            ASg Fem  Indef => (base0+"�") ;
            ASg Fem  Def   => (base0+"a�a") ;
            ASg Neut Indef => (base0+"�") ;
            ASg Neut Def   => (base0+"���") ;
            APl Indef      => (ia2e base0+"�") ;
            APl Def        => (ia2e base0+"���")
          };
    
-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
  } ;

  mkClause : Str -> Agr -> Polarity -> VP -> Clause =
    \subj,agr,p1,vp -> {
      s = \\t,a,p2,o => 
        let
          p : Polarity
            = case <p1,p2,vp.p> of {
                <Neg,_,_> => Neg ;
                <_,Neg,_> => Neg ;
                <_,_,Neg> => Neg ;
                _         => Pos
              } ;
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
          auxCondS  = auxCond ! numGenNum clitic.agr.gn ! clitic.agr.p ;

          apc : Str -> Str = \s ->
            case <numGenNum clitic.agr.gn, clitic.agr.p> of {
              <Sg, P3> => clitic.s++auxPres++s ;
              _        => auxPres++s++clitic.s
            } ;

          li0 = case <verb.ad.isEmpty,q0> of {<False,True> => "��"; _ => []} ;

          q   = case verb.ad.isEmpty of {True => q0; False => False} ;
          li  = case q of {True => "��"; _ => []} ;

          vf1 : Str -> {s1 : Str; s2 : Str} = \s ->
            case p of {
              Pos => case q of {True  => {s1=[]; s2="��"++apc []};
                                False => {s1=apc []; s2=[]}} ;
              Neg => {s1="��"++apc li; s2=[]}
            } ;

          vf2 : Str -> {s1 : Str; s2 : Str} = \s ->
            case p of {
              Pos => case q of {True  => {s1=[]; s2="��"++s};
                                False => {s1=s;  s2=[]}} ;
              Neg => case verb.vtype of
                       {VNormal => {s1="��"; s2=li} ;
			_       => {s1="��"++s++li; s2=[]}}
            } ;

          vf3 : Str -> {s1 : Str; s2 : Str} = \s ->
            case p of {
              Pos => {s1="��"++s; s2=li} ;
              Neg => {s1="����"++li++"��"++s; s2=[]}
            } ;

          vf4 : Str -> {s1 : Str; s2 : Str} = \s ->
            case p of {
              Pos => {s1=      s++li++clitic.s; s2=[]} ;
              Neg => {s1="��"++s++li++clitic.s; s2=[]}
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
              <Cond,_    > => {aux=vf4 auxCondS;  main=perfect} --# notpresent
            }

      in verb.ad.s ++ li0 ++ verbs.aux.s1 ++ verbs.main ++ verbs.aux.s2 ;

  daComplex : Anteriority -> Polarity -> VP -> Aspect => Agr => Str =
    \a,p,vp -> \\asp,agr =>
      let clitic = case vp.vtype of {
                     VNormal    => {s=[]; agr=agr} ;
                     VMedial c  => {s=reflClitics ! c; agr=agr} ;
                     VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                   } ;
          pol = case p of {Pos => ""; Neg => "��"}
      in vp.ad.s ++ "��" ++ pol ++ clitic.s ++
         case a of {
           Simul => vp.s ! asp ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ;
           Anter => auxBe ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ++
                    vp.s ! asp ! (VPerfect (aform clitic.agr.gn Indef (RObj Acc)))
         } ++
         vp.compl ! agr ;

  linrefVP : VP -> Str =
    \vp ->
      let agr = {gn = GSg Neut; p = P1};
          clitic = case vp.vtype of {
                     VNormal    => {s=[]; agr=agr} ;
                     VMedial c  => {s=reflClitics ! c; agr=agr} ;
                     VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                   } ;
      in vp.ad.s ++
         vp.s ! Imperf ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ++ clitic.s ++
         vp.compl ! agr ;
         
  linrefPrep : {s:Str; c:Case} -> Str =
    \p -> case p.c of {Acc=>""; Dat=>"��"; WithPrep=>with_Word} ++ p.s ;

  gerund : VP -> Aspect => Agr => Str =
    \vp -> \\asp,agr =>
      let clitic = case vp.vtype of {
                     VNormal    => {s=[]; agr=agr} ;
                     VMedial c  => {s=reflClitics ! c; agr=agr} ;
                     VPhrasal c => {s=personalClitics ! c ! agr.gn ! agr.p; agr={gn=GSg Neut; p=P3}}
                   }
      in vp.ad.s ++ clitic.s ++ vp.s ! asp ! VGerund ++ vp.compl ! agr ;

-- For $Numeral$.

    mkDigit : Str -> Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} =
      \dva, dvama, dve, vtori, dvaiset, dvesta ->
      {s = table {
             unit                  => mkCardOrd dva dvama dve vtori ;
             teen nf               => case nf of {
                                        Formal   => mkCardOrd (dva+"�������") (dva+"����������") (dva+"�������") (dva+"��������") ;
                                        Informal => mkCardOrd (dva+"������")  (dva+"������")     (dva+"������")  (dva+"������")
                                      } ;
             ten  nf               => case nf of {
                                        Formal   => mkCardOrd (dva+"�����")   (dva+"��������")   (dva+"�����")   (dva+"������") ;
                                        Informal => mkCardOrd dvaiset         dvaiset            dvaiset         (dvaiset+"�")
                                      } ;
             hundred               => let dvesten : Str
                                                  = case dvesta of {
                                                      dvest+"�"        => dvest+"��" ;
                                                      chetiristot+"��" => chetiristot+"��"
                                                    }
                                      in mkCardOrd100 dvesta dvesten
           }
      } ;

    mkCardOrd : Str -> Str -> Str -> Str -> CardOrd => Str =
      \dva, dvama, dve, vtori ->
               table {
                 NCard dg   => digitGenderSpecies dva dvama dve ! dg ;
                 NOrd aform => let vtora : Str = case vtori of {_+"�" => vtori; _ => init vtori} + "�" ;
                                   vtoro : Str = case vtori of {_+"�" => vtori; _ => init vtori} + "�";
                                   i     : Str = case vtori of {_+"�" => "�"; _ => ""}
                               in case aform of {
                                    ASg Masc Indef => vtori ;
                                    ASg Masc Def   => vtori+i+"�" ;
                                    ASgMascDefNom  => vtori+i+"��" ;
                                    ASg Fem  Indef => vtora ;
                                    ASg Fem  Def   => vtora+"��" ;
                                    ASg Neut Indef => vtoro ;
                                    ASg Neut Def   => vtoro+"��" ;
                                    APl Indef      => vtori+i ;
                                    APl Def        => vtori+i+"��"
                                  }
               } ;

    mkCardOrd100 : Str -> Str -> CardOrd => Str =
      \sto, stoten ->
               table {
                 NCard dg   => sto ;
                 NOrd aform => let stotn = init (init stoten) + last stoten ;
                               in case aform of {
                                    ASg Masc Indef => stoten ;
                                    ASg Masc Def   => stotn+"��" ;
                                    ASgMascDefNom  => stotn+"���" ;
                                    ASg Fem  Indef => stotn+"�" ;
                                    ASg Fem  Def   => stotn+"���" ;
                                    ASg Neut Indef => stotn+"�" ;
                                    ASg Neut Def   => stotn+"���" ;
                                    APl Indef      => stotn+"�" ;
                                    APl Def        => stotn+"���"
                                  }
               } ;

    digitGenderSpecies : Str -> Str -> Str -> CardForm => Str =
      \dva, dvama, dve
            -> let addDef : Str -> Gender -> Str =
                     \s,g -> case s of {
		             dves+"��" => dves+"����" ;
		             dv+"�"    => dv+"���" ;
		             "0"       => s+"��" ;
		             "1"       => s+case g of {Masc => "��"; Fem => "��"; Neut => "��"} ;
		             "2"       => s+case g of {Masc => "��"; _ => "��"} ;
		             x         => x+"��"
                     }
               in table {
                    CFMasc Indef  NonHuman => dva ;
                    CFMasc Def    NonHuman => addDef dva Masc ;
                    CFMascDefNom  NonHuman => addDef dva Masc ;
                    CFMasc Indef  Human    => dvama ;
                    CFMasc Def    Human    => addDef dvama Masc ;
                    CFMascDefNom  Human    => addDef dvama Masc ;
                    CFFem  Indef           => dve ;
                    CFFem  Def             => addDef dve Fem ;
                    CFNeut Indef           => dve ;
                    CFNeut Def             => addDef dve Neut
                  } ;

    mkIP : Str -> Str -> GenNum -> {s : Role => QForm => Str ; gn : GenNum} =
      \koi,kogo,gn -> {
      s = table {
            RSubj         => table QForm [koi;  koi+"��"] ;
            RObj Acc      => table QForm [kogo; kogo+"��"] ;
            RObj Dat      => table QForm ["��" ++ kogo; "��" ++ kogo+"��"] ;
            RObj WithPrep => table QForm [with_Word ++ kogo; with_Word ++ kogo+"��"] ;
            RVoc          => table QForm [koi;  koi+"��"]
          } ;
      gn = gn
      } ;

    with_Word : Str
      = pre { "�" ; 
              "���" / strs {"�" ; "�" ; "�" ; "�"}
            } ;

    mkPron : (az,men,me,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite : Str) -> 
             GenNum -> Person -> {s    : Role => Str; 
                                  clit : Case => Str;
                                  gen  : AForm => Str; 
                                  a : Agr
                                 } =
      \az,men,me,mi,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite,gn,p -> {
      s = table {
            RSubj         => az ;
            RObj Acc      => men ;
            RObj Dat      => "��" ++ men ;
            RObj WithPrep => with_Word ++ men ;
            RVoc          => az
          } ;
      clit = table {
               Acc      => me;
               Dat      => mi;
               WithPrep => with_Word ++ men
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

    mkNP : Str -> GenNum -> Person -> Polarity -> {s : Role => Str; a : Agr; p : Polarity} =
      \s,gn,p,pol -> {
      s = table {
            RSubj         => s ;
            RObj Acc      => s ;
            RObj Dat      => "��" ++ s ;
            RObj WithPrep => with_Word ++ s ;
            RVoc          => s
          } ;
      a = {
           gn = gn ;
           p = p
          } ;
      p = pol
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
                GSg Masc => "�����" ;
                GSg Fem  => "�����" ;
                GSg Neut => "�����" ;
                GPl      => "�����"
              } ;

    suchRP : GenNum => Str
           = table {
               GSg Masc => "�����" ;
               GSg Fem  => "������" ;
               GSg Neut => "������" ;
               GPl      => "������"
             } ;
             
    thisRP : GenNum => Str
           = table {
               GSg Masc => "����" ;
               GSg Fem  => "�a��" ;
               GSg Neut => "����" ;
               GPl      => "����"
             } ;

    linCoord : Ints 3 => Str ;
    linCoord = table {0 => "�"; 1=>"���"; 2=>"����"; 3=>"��"} ;

    linCoordSep : Str -> Bool => Ints 3 => Str ;
    linCoordSep s = table {True => linCoord; False=> \\_ => s} ;

    hyphen : Str = SOFT_BIND ++ "-" ++ SOFT_BIND ;

    reflPron : AForm => Str =
      table {
        ASg Masc Indef => "����" ;
        ASg Masc Def   => "����" ;
        ASgMascDefNom  => "�����" ;
        ASg Fem  Indef => "����" ;
        ASg Fem  Def   => "������" ;
        ASg Neut Indef => "����" ;
        ASg Neut Def   => "������" ;
        APl Indef      => "����" ;
        APl Def        => "������"
      } ;
}
