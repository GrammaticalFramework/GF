--# -path=.:../abstract:../common:../../prelude


resource ResGre = ParamX  **  open Prelude in {

  flags coding= utf8 ;


  param
  Case   = Nom | Gen | Acc | Vocative |  CPrep Prepos;

  Gender = Masc | Fem | Neut | Change;

  Agr    = Ag Gender Number Person ;

  Mood   = Ind | Con | Hortative;

  TTense  = TPres | TPast  | TFut | TCond | TImperf ; 
  
  CardOrd = NCard Gender  Case| NCardX |   NOrd Gender Number Case ;

  DForm = unit  |  teen | ten | hundr isVowel ;
 
  isVowel = Is | isNot ;

  Aspect = Perf | Imperf ;

  Order = Main | Inv ;

  Form = Weak |Emphatic ;
  
  
  VForm =  VPres Mood Number Person Voice Aspect| VPast Mood Number Person Voice Aspect|  VNonFinite Voice| VImperative Aspect Number Voice|  Gerund  | Participle Degree Gender Number Case;

  Voice = Active | Passive;

  Prepos =  P_se | PNul | P_Dat;


  oper

  AAgr : Type = {g : Gender ; n : Number} ;

  VP = { v : Verb ;  clit,clit2 : Str ; comp : Agr => Str ; isNeg : Bool ; voice : Voice ; aspect :Aspect} ;

  NounPhrase = { s : Case  =>  {c1,c2,comp : Str ; isClit : Bool } ;  a : Agr ;isNeg:Bool} ; 

  Noun : Type = {s : Number => Case => Str ; g : Gender} ;

  Adj  : Type = {s : Degree => Gender => Number => Case => Str ; adv : Degree => Str } ;
 
  Adv  : Type = {s :  Str } ;

  Verb : Type = {s : VForm => Str } ;

  Det  : Type = {s : Gender => Case => Str ;  n : Number};

  PName : Type = {s : Number => Case => Str ; g : Gender} ;

  Pronoun : Type = { s : Case => {c1,c2,comp : Str ; isClit : Bool }  ;  a : Agr; poss :   Str } ;

  Preposition = {s : Str ; c : Case} ;
 
  Quantifier  = {s : Bool => Gender => Number => Case => Str ; sp : Gender => Number => Case  => Str ; isNeg:Bool } ;
   
  Compl : Type = {s : Str ; c : Case ; isDir : Bool} ;
   
  prepCase  : Case -> Str ;

 

    prepositionse   : Case = CPrep P_se ;
    dative : Case = CPrep P_Dat;
    possCase  : Gender -> Number -> Case -> Str ;
    possCase = artDef ;

    prepCase : Case -> Str = \c -> case c of {
     Nom =>[];
     Acc =>[];
     Gen =>[];
     Vocative => [] ;
     CPrep P_se => elisSe ;
     CPrep PNul => [] ;
     CPrep P_Dat => [] 
      } ;


    npPol : Bool -> Det -> NounPhrase = \isNeg, n -> heavyNPpol isNeg {
    s = \\c => prepCase c ++ n.s !  Masc ! c; 
    a = agrP3 Masc n.n
    } ;

    nppolPos : Det -> NounPhrase = npPol False ;
    nppolNeg : Det -> NounPhrase = npPol True ;


    mkPron: (aftos, tou,ton ,afton,aftou : Str) -> Gender -> Number -> Person -> Pronoun = 
    \aftos, tou,ton,afton,aftou, g,n,p ->
      let
        seafton : Case -> Str = \x -> prepCase x ++ afton ;
      in {
        s = table {
          Nom => {c1 = [] ; c2 = []; comp = aftos; isClit = False} ;
          Gen => {c1 = tou ; c2 = [] ;comp = []; isClit = True} ;
          Acc => {c1 = [] ; c2 = ton; comp = [] ; isClit = True} ;
          CPrep P_Dat  => {c1 = []  ;c2 = []; comp = aftou ; isClit = False} ;
          CPrep P_se  => {c1 = [] ;c2 = []; comp = seafton (CPrep P_se) ; isClit = False} ;
          CPrep PNul  => {c1 = [] ;c2 = []; comp = afton ; isClit = False} ;
          Vocative => {c1 = [] ; c2 = []; comp = [] ; isClit = False} 
          } ;
      poss = tou ;
      g = g;
      a = Ag g n p 
      } ;

 


  ---to use the emphatic forms of the pronouns in conjunctions-----
  conjunctCase : Case  -> Case ;

  conjunctCase : Case -> Case = \c -> 
    case c of {
      Acc => CPrep PNul ;
      _ => c 
      } ;

      
    heavyNP    : {s : Case => Str ; a : Agr} -> NounPhrase = heavyNPpol False ;

    heavyNPpol : Bool -> {s : Case => Str ; a : Agr} -> NounPhrase = \isNeg,np -> {
      s = \\c => {comp = np.s ! c ; c1 = []; c2 = []; isClit = False ;} ;
      a = np.a ;
      isNeg = isNeg
      } ;
  
 
 
    complAcc : Compl = {s = [] ; c = Acc ; isDir = True} ;
    complGen : Compl = {s = [] ; c = Gen ; isDir = False} ;
    complDat : Compl = {s = [] ; c = dative ; isDir = False} ;
    complPrepSe : Compl = {s = [] ; c = prepositionse ; isDir = False} ;
  
    mkVPSlash : Compl -> VP -> VP ** {c2 : Compl} = \c,vp -> vp ** {c2 = c} ;

    
    
    appCompl : Compl -> NounPhrase -> Str = \comp,np ->
      comp.s ++ (np.s ! comp.c).comp ;



    predVP : Str -> Agr -> VP -> {s : Order =>  TTense => Anteriority =>  Polarity => Mood => Str} = predVPPol False ;

    predVPPol : Bool -> Str -> Agr -> VP -> {s : Order =>  TTense => Anteriority =>  Polarity => Mood =>  Str} = \subjpol, subj,agr,vp ->
      let 
        comp  = vp.comp ! agr ;
        clit = vp.clit ;
        clit2=vp.clit2; 

        verb : Mood -> Voice -> Aspect->  TTense => Str = \m, vo ,as-> 
          table { TCond => agrV auxVerb m vo as TPres agr ++ vp.v.s ! VNonFinite vo;
          TImperf => agrV auxVerb m vo as TPast agr ++ vp.v.s ! VNonFinite vo;
          t    => agrV vp.v m vo as t agr 
          } ;
      in {
        s = \\o,t,ant, p, m => 
        let negpm = case orB subjpol vp.isNeg of {
          True => neg Neg m ;
          _ => neg p m 
          } ;
        vo = vp.voice ; 
        as = vp.aspect ;
        in        
        case <o,t,ant,m> of {
        <Main, TPres,Simul,Ind> =>  subj ++ negpm ++ clit ++ clit2 ++ verb m vo as ! t ++ comp;
        <Inv,  TPres,Simul,Ind> =>    negpm ++  clit ++ clit2 ++ verb m vo as ! t ++ subj ++   comp   ;

        <Main, TPres,Anter,Ind> =>  subj ++ negpm ++ clit ++  clit2++ verb m vo as! TCond  ++ comp ;
        <Inv, TPres,Anter,Ind> => negpm ++  clit ++ clit2 ++ verb m vo as ! TCond ++ subj ++ comp  ;

        <Main,TFut,Simul,Ind>  => subj ++ negpm ++ "θα" ++ clit ++  clit2 ++verb m vo as! t ++ comp ;
        <Inv,TFut,Simul,Ind>  =>  negpm  ++ "θα"++ clit ++ clit2++  verb m vo as! t ++  subj ++ comp  ;
      
        <Main,TFut,Anter,Ind>  => subj ++ negpm ++ "θα" ++ clit ++  clit2 ++ verb m vo as! TCond ++ comp ;
        <Inv,TFut,Anter,Ind>  => negpm  ++"θα" ++ clit  ++  clit2 ++ verb m vo  as! TCond ++ subj ++ comp    ;

        <Main,TCond,Simul,Ind>  => subj ++ negpm ++ "θα" ++ clit ++ verb m vo Imperf! TPast  ++ comp ;
        <Inv,TCond,Simul,Ind>  => negpm ++ "θα" ++ clit  ++  clit2 ++ verb m vo Imperf ! TPast ++ subj ++ comp  ;

        <Main,TCond,Anter,Ind> => subj ++ negpm  ++ "θα"++ clit ++ clit2 ++ verb m vo as! TImperf ++ comp ;
        <Inv,TCond,Anter,Ind> => negpm ++ "θα" ++clit  ++ clit2 ++ verb m vo  as! TImperf ++ subj ++comp    ;

        <Main, TPast,Simul,Ind>  =>  subj ++ negpm ++ clit ++ clit2 ++ verb m vo as! TPast ++ comp ;
        <Inv, TPast,Simul,Ind>  => negpm ++ clit ++ clit2 ++ verb m vo as! TPast ++ subj ++ comp  ;

        
        <Main, TPast,Anterior,Ind> =>  subj ++ negpm ++  clit ++ clit2 ++ verb m vo as!TImperf ++ comp;
        <Inv, TPast,Anterior,Ind> =>    negpm ++  clit ++ clit2 ++ verb m vo as!TImperf ++ subj ++comp ;

        <_, TImperf,Simul,Ind>  =>  subj ++ negpm ++  clit ++ clit2 ++ verb m vo as! t ++ comp ;
        <_, TImperf,Anterior,Ind> =>  negpm ++  clit ++ clit2 ++ verb m vo as! TImperf ++ subj ++ comp ;
  
        <_, _,_,Con> =>  subj ++  "να" ++ negpm ++ clit ++ clit2 ++  verb m vo as! t ++ comp ;
        <Main, _,_,Hortative> =>  subj ++ "ας" ++ negpm ++ clit ++ clit2 ++  verb m vo as! t ++ comp ; 
        <Inv, _,_,Hortative> =>  "ας" ++ negpm ++ clit ++ clit2 ++  verb m vo as! t ++  subj ++  comp 
        }
        } ;

    neg : Polarity -> Mood -> Str = \p,m -> case p of {
    Pos => [] ; 
    Neg => case m of {
      Ind  => "δεν" ; 
      Con |Hortative => "μήν"
      }
    } ;

   

 agrV : Verb -> Mood -> Voice -> Aspect ->  TTense -> Agr -> Str = \v,m,vo,as, t,a -> case a of {
    Ag _ n p => case <t,vo,as> of {
      <TPast,Active, Perf> => v.s ! VPast Ind n p Active Perf ;
      <TPast,Passive, Perf> => v.s ! VPast Ind n p Passive Perf ;
      <TPast,Active, Imperf> =>  v.s ! VPast m n p  Active Imperf;   
      <TPast,Passive, Imperf> =>  v.s ! VPast m n p Passive Imperf;    
      <TFut,Active,Imperf> =>  v.s ! VPres Ind  n p Active Imperf;
      <TFut,Passive,Imperf> =>  v.s ! VPres Ind n p  Passive Imperf;
      <TFut,Active,Perf> =>  v.s ! VPres Con n p Active Perf; 
      <TFut,Passive, Perf> =>  v.s ! VPres Con n p  Passive Perf;
      <TImperf,Active,_> =>  v.s ! VPast m n p Active Imperf;
      <TImperf,Passive,_> =>  v.s ! VPast m n p Passive Imperf;   
      <TPres,Active,_>   => v.s ! VPres m n p Active Perf;
      <TPres,Passive,_>   => v.s ! VPres m n p  Passive Perf;
      _  => v.s ! VPres m n p vo Perf
      }
    } ;
   
   predV : Verb  -> VP = \v -> {
    v = v ; 
    clit = [] ;
    clit2 = [] ; 
    comp   = \\a => [] ;
    isNeg = False; 
    voice = Active ;
    aspect = Perf ;
    } ;



    ------------Agreements -------------
    agrFeatures : Agr -> {g : Gender ; n : Number ; p : Person} = \a -> 
      case a of {Ag g n p => {g = g ; n = n ; p = p }} ;

    complAgr : Agr -> {g : Gender ; n : Number} = \a -> case a of {
      Ag g n _ => {g = g ; n = n} 
      } ;

    verbAgr : Agr -> {g : Gender ; n : Number ; p : Person} = \a -> case a of {
      Ag g n p => {g = g ; n = n  ; p = p} 
      } ;

    clitAgr : Agr -> { n : Number ; p : Person} = \a -> case a of {
      Ag _ n p => { n = n; p = p} 
      } ;


    agrP3 : Gender -> Number -> Agr = \g,n ->
      Ag g n P3 ;
      aagr : Gender -> Number -> AAgr = \g,n ->
      {g = g ; n = n} ;

   ---- Conjunction Agreements----

   conjAgr : Number -> Agr -> Agr -> Agr = \n,xa,ya -> 
    let 
      x = agrFeatures xa ; y = agrFeatures ya
    in Ag 
      (conjGender x.g y.g) 
      (conjNumber (conjNumber x.n y.n) n)
      (conjPPerson x.p y.p) ;


   conjGender : Gender -> Gender -> Gender = \m,n -> 
    case m of {
      Fem => n ;
      _ => Masc 
      } ;

 
    conjPPerson : Person -> Person -> Person = \p,q ->
    case <p,q> of {
      <_,P1>  | <_,P2>  =>  P1 ;
      <P1,P3>  => P1 ;
      <P2,P3>  => P2 ;
      <P3,P3>  => P3 
     };

  
  
  insertObject : Compl -> NounPhrase -> VP -> VP = \c,np,vp -> 
    let
      obj = np.s ! c.c ;
    in {
       v   = vp.v ;
      clit = vp.clit ++ obj.c1 ;
      clit2 = vp.clit2 ++ obj.c2;
      comp  = \\a => c.s ++ obj.comp ++ vp.comp ! a ;
      isNeg   = orB vp.isNeg np.isNeg ;
      voice = vp.voice ;
      aspect = vp.aspect  ;
    } ;


    insertComplement : (Agr => Str) -> VP -> VP = \co,vp -> { 
      v     = vp.v ;
      clit = vp.clit ; 
      clit2 = vp.clit2 ; 
      isNeg = vp.isNeg ; 
      comp  = \\a => vp.comp ! a ++ co ! a ;
      voice = vp.voice ;
      aspect = vp.aspect  ;
      } ;


    insertAdv : Str -> VP -> VP = \co,vp -> { 
      v     = vp.v ;
      clit = vp.clit ; 
      clit2 = vp.clit2 ;
      comp  = \\a => vp.comp ! a ++ co ;
      isNeg = vp.isNeg ;
      voice = vp.voice ;
      aspect = vp.aspect  ;
      } ;

   insertAdV : Str -> VP -> VP = \co,vp -> { 
      v     = vp.v ; 
      clit = vp.clit  ; 
      clit2 = vp.clit2 ; 
      comp  =\\a => co  ++ vp.comp ! a ; 
      isNeg = vp.isNeg ; 
      voice = vp.voice ;
      aspect = vp.aspect  ;
      } ;


 


 ----------Formation of Proper Names ----------
    mkName :(s1,_,_,_,_,_ : Str) -> Gender -> PName = 
        \nm,gm,am,vm,pn,pg, g -> {
            s = table {
              Sg => table {
                  Nom => nm ;
                  Gen |CPrep P_Dat => gm ;
                  Acc |CPrep P_se |CPrep PNul  => am ;
                  Vocative => vm
                  } ;
              Pl => table {
                  Nom |  Vocative |Acc  |CPrep P_se |CPrep PNul => pn ;
                  Gen |CPrep P_Dat => pg
                }
              } ;
          g = g
          } ;

    ----------Regular Proper Names----------
      regName: Str -> PName = \Giannis-> case Giannis of {
        Giann + "ης" => mkName Giannis (Giann + "η") (Giann + "η") (Giann + "η")  (Giann + "ηδες") (Giann + "ηδων")  Masc ;
        Kost + "ής" => mkName Giannis (Kost + "ή") (Kost + "ή") (Kost + "ή")(Kost + "ήδες") (Kost + "ήδων")   Masc ;
        Giorg + "ος" => mkName Giannis (Giorg + "ου") ( Giorg + "ο") (Giorg + "ο") (Giorg + "ηδες") ( Giorg + "ηδων")  Masc ;
        Kost + "ας" => mkName Giannis (Kost + "α") (Kost + "α") (Kost + "α")(Kost + "ηδες") (Kost + "ηδων")   Masc ;
        Mari + "α" => mkName  Giannis (Mari + "ας") (Mari + "α") (Mari + "α")(Mari + "ες") (Mari + "ων")   Fem ;
        Elen + "η" => mkName  Giannis (Elen + "ης") (Elen + "η") (Elen + "η")(Elen + "ες") (Elen + "ων")  Fem ;
        Fros + "ω" => mkName  Giannis (Fros + "ως") (Fros + "ω") (Fros + "ω") ("") ("")Fem ;
        Mirt + "ώ" => mkName  Giannis (Mirt + "ώς") (Mirt + "ώ") (Mirt + "ώ") ("")("")Fem ;
        Londin + "ο" => mkName  Giannis (Londin + "ου") (Londin + "ο") (Londin + "ο") (Londin + "α") (Londin + "ων")   Neut ;
        Paris + "ι" => mkName  Giannis (mkStemNouns Paris + "ιού") (Paris + "ι") (Paris + "ι")(Paris + "ια") (mkStemNouns Paris + "ιών")   Neut
      };


    ----------Regular Proper Names that change their Vocative ending--------------
     regName2: Str -> PName = \s-> case s of {
    Alexandr + "ος" => mkName s (Alexandr + "ου") (Alexandr + "ο") (Alexandr + "ε")(Alexandr + "οι") (Alexandr + "ων")   Masc ;
    Isimerin + "ός" => mkName s (Isimerin + "ού") ( Isimerin + "ό") (Isimerin + "έ") (Isimerin + "οί") ( Isimerin + "ών") Masc 
     };






 
 

    ---------------NOUNS ------------------------------------
    ---------------------------------------------------------
 

  mkNoun : (s1,_,_,_,_,_,_,_ : Str) -> Gender -> Noun = 
    \sn,sg,sa,sv,pn,pg,pa,pv, g -> {
    s = table {
      Sg => table {
        Nom => sn ;
        Gen |CPrep P_Dat=> sg ;
        Acc |CPrep P_se |CPrep PNul  => sa ;
        Vocative => sv
        } ;
      Pl => table {
        Nom => pn ;
        Gen |CPrep P_Dat=> pg ;
        Acc |CPrep P_se |CPrep PNul => pa;
        Vocative => pv 
        }
      } ;
    g = g
    } ;


    ------Masculine nouns in -ης, irregular --------------------
    mkNoun_prytanis : (s1,_ : Str) -> Gender -> Noun = 
    \prytanis, prytaneon,  g ->
    let
      prytani = init prytanis; 
      prytAn = Predef.tk 3 prytaneon ;
    in {
    s = table {
      Sg => table {
        Nom => prytanis ;
        Gen |CPrep P_Dat=> prytani  ;
        Acc | Vocative|CPrep P_se |CPrep PNul => prytani
        } ;
      Pl => table {
        Nom => prytAn + "εις" ;
        Gen |CPrep P_Dat=> prytaneon ;
        Acc   | Vocative |CPrep P_se |CPrep PNul  => prytAn + "εις" 
        }
      } ;
    g = g
    } ;


    ------Masculine nouns in -ς, irregular --------------------
    mkNoun_mys : (s1,_ : Str) -> Gender -> Noun = 
    \mys, myon,  g ->
    let
      my = init mys; 
    in {
    s = table {
      Sg => table {
        Nom => mys ;
        Gen |CPrep P_Dat=> my  ;
        Acc |CPrep P_se |CPrep PNul => mys;
        Vocative => []
        } ;
      Pl => table {
        Nom => my + "ες" ;
        Gen |CPrep P_Dat=> myon ;
        Acc |CPrep P_se |CPrep PNul => my + "ες" ;
        Vocative => []
        }
      } ;
    g = g
    } ;

    ------Masculine nouns -ος  parisyllabic, stressing in the penultimate syllable in genSg and acc/genPl--------------------
    mkNoun_anthropos : (s1,_ : Str) -> Gender -> Noun = 
    \anthropos, anthropon,  g ->
    let
      anthrop = Predef.tk 2 anthropos ;
      anthrOp = Predef.tk 2 anthropon ;
    in {
    s = table {
      Sg => table {
        Nom => anthropos ;
        Gen |CPrep P_Dat=> anthrOp + "ου" ;
        Acc |CPrep P_se |CPrep PNul =>  anthrop + "ο";
        Vocative => anthrop + "ε" 
        } ;
      Pl => table {
        Nom | Vocative=> anthrop + "οι" ;
        Gen |CPrep P_Dat=> anthropon ;
        Acc |CPrep P_se |CPrep PNul => anthrOp + "ους" 
        }
      } ;
    g = g
    } ;


    ------Masculine nouns in -as(-ias, -istas), parisyllabic, with genPL with the stress on the penultimate syllable. -----------
    mkNoun_filakas : (s1,_ : Str) -> Gender -> Noun = 
        \filakas, filakon,  g ->
        let
          filak = Predef.tk 2 filakas ;
        in {
        s = table {
          Sg => table {
            Nom => filakas ;
            Gen |CPrep P_Dat| Acc | Vocative |CPrep P_se |CPrep PNul  => mkGenSg filakas 
            } ;
          Pl => table {
            Nom |Acc | Vocative|CPrep P_se |CPrep PNul   => mkNomPl filakas  ;
            Gen|CPrep P_Dat => filakon 
            }
          } ;
        g = g
        } ;

    ------Masculine nouns in -as,, parisyllabic, with genPL with the stress on the penultimate or the final syllable. -----------
        mkNoun_touristas : (s1: Str) -> Gender -> Noun = 
        \touristas,  g ->
        let
          tourist = Predef.tk 2 touristas ;
        in {
        s = table {
          Sg => table {
            Nom => touristas ;
            Gen |CPrep P_Dat=> mkGenSg touristas;
            Acc | Vocative|CPrep P_se |CPrep PNul => mkAccSg touristas 
            } ;
          Pl => table {
            Nom | Acc | Vocative|CPrep P_se |CPrep PNul => mkNomPl touristas;
            Gen|CPrep P_Dat => mkGen touristas 
            }
          } ;
        g = g
        } ;


    ----------------Masculine nouns in -ης , imparisyllabic , augmenting syllables.--------------
        mkNoun_fournaris : (s1,_ : Str) -> Gender -> Noun = 
        \fournaris, fournarides,  g ->
        let
          fournar = Predef.tk 2 fournaris ;
          fournAr = Predef.tk 4 fournarides ;
        in {
        s = table {
          Sg => table {
            Nom => fournaris ;
            Gen |CPrep P_Dat| Acc | Vocative|CPrep P_se |CPrep PNul =>   mkGenSg fournaris 
            } ;
          Pl => table {
            Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> fournarides ;
            Gen|CPrep P_Dat => fournAr + "ηδων"
            }
          } ;
        g = g
        } ;


    ----------------Feminine nouns in -α ,parisyllabic.--------------
        mkNoun_thalassa : (s: Str) -> Gender -> Noun = 
        \thalassa,  g ->
        let
          thalass = init thalassa ;
        in {
        s = table {
          Sg => table {
            Nom | Acc | Vocative|CPrep P_se |CPrep PNul => thalassa ;
            Gen|CPrep P_Dat => mkGenSg thalassa 
            } ;
          Pl => table {
            Nom  | Acc | Vocative|CPrep P_se |CPrep PNul => thalass + "ες" ; 
            Gen|CPrep P_Dat => mkGen thalassa
            }
          } ;
        g = g
        } ;

        ----------------Feminine nouns in -η with plural in -εις  with stress movement--------------
        mkNoun_kivernisi : (s1,_ : Str) -> Gender -> Noun = 
        \kivernisi, kiverniseis,  g ->
        let
          kivernis = init kivernisi ;
          kivernIs = Predef.tk 3 kiverniseis ;
        in {
        s = table {
          Sg => table {
            Nom |Acc | Vocative|CPrep P_se |CPrep PNul  => kivernisi ;
            Gen |CPrep P_Dat=> kivernis + "ης" 
            } ;
          Pl => table {
            Nom | Acc | Vocative |CPrep P_se |CPrep PNul  => kiverniseis; 
            Gen |CPrep P_Dat=> kivernIs + "εων"
            }
          } ;
        g = g
        } ;

          ----------------Neuter nouns in -ι , with stress movement--------------
        mkNoun_agori : (s: Str) -> Gender -> Noun = 
        \agOri,   g ->
        let
          agori = mkStemNouns agOri;
        in {
        s = table {
          Sg => table {
            Nom | Acc | Vocative|CPrep P_se |CPrep PNul => agOri ;
            Gen |CPrep P_Dat=> mkGenSg agori
            } ;
          Pl => table {
            Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => mkNomPl agOri; 
            Gen |CPrep P_Dat=> mkGen agOri

            }
          } ;
        g = g
        } ;


    ----------------Neuter nouns in -oς , with stress movement in genSg and gen/accPl--------------
        mkNoun_megethos: (s1,_ : Str) -> Gender -> Noun = 
        \mEgethos, megEthi,  g ->
        let
          megEth = init megEthi ;
          megethos = mkStemNouns mEgethos ;
        in {
        s = table {
          Sg => table {
            Nom | Acc | Vocative  |CPrep P_se |CPrep PNul => mEgethos ;
            Gen |CPrep P_Dat=> megEth + "ους" 
            } ;
          Pl => table {
            Nom | Acc | Vocative |CPrep P_se |CPrep PNul => megEthi; 
            Gen|CPrep P_Dat => mkGen megethos
            }
          } ;
        g = g
        } ;

        ----------------Neuter nouns in -μα, -ιμο ,with stress movement in genSg and gen/accPl, and syllable augmentation. --------------
        mkNoun_provlima: (s1,_ : Str) -> Gender -> Noun = 
        \prOvlima, provlimata,  g ->
        let
          provlImat = init provlimata ;
          provlima = mkStemNouns prOvlima ;
        in {
        s = table {
          Sg => table {
            Nom | Acc | Vocative |CPrep P_se |CPrep PNul => prOvlima ;
            Gen |CPrep P_Dat=> provlImat + "ος" 
            } ;
          Pl => table {
            Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> provlimata; 
            Gen|CPrep P_Dat => mkGen provlima
            }
          } ;
        g = g
        } ;


     ---------------Neuter nouns in -o , with stress movement--------------
        mkNoun_prosopo : (s1,_ : Str) -> Gender -> Noun = 
        \prOsopo, prosOpon,  g ->
        let
          prosOpo = init prosOpon ;
          prosOp = init prosOpo ;
        in {
        s = table {
          Sg => table {
            Nom | Acc | Vocative|CPrep P_se |CPrep PNul => prOsopo ;
            Gen |CPrep P_Dat=>  prosOp + "ου" 
            } ;
          Pl => table {
            Nom |Acc | Vocative |CPrep P_se |CPrep PNul=> mkNomPl prOsopo  ;
            Gen |CPrep P_Dat=> prosOpon 
            }
          } ;
        g = g
        } ;

        
        mkNoun_anthropos : (s1,_ : Str) -> Gender -> Noun = 
        \anthropos, anthropon,  g ->
        let
          anthrop = Predef.tk 2 anthropos ;
          anthrOp = Predef.tk 2 anthropon ;
        in {
        s = table {
          Sg => table {
            Nom => anthropos ;
            Gen|CPrep P_Dat => anthrOp + "ου" ;
            Acc |CPrep P_se |CPrep PNul  => anthrop + "ο";
            Vocative => anthrop + "ε" 
            } ;
          Pl => table {
            Nom | Vocative=> anthrop + "οι" ;
            Gen |CPrep P_Dat=> anthropon ;
            Acc |CPrep P_se |CPrep PNul => anthrOp + "ους" 
            }
          } ;
        g = g
        } ;



       ----------------Neuter nouns in -ς , with  stress movement,syllabic augmentation,  irregular (φως, γεγονός, ημίφως) --------------
      mkNoun_fws: (s1,_ : Str) -> Gender -> Noun = 
      \fws, fwtos,  g ->
     let
        fW = init fws ;
      in {
      s = table {
        Sg => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul=> fws ;
          Gen |CPrep P_Dat=>fwtos
          } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => fW + "τα"; 
          Gen |CPrep P_Dat=> fW + "των"
          }
        } ;
      g = g
      } ;




       ----------------Neuter nouns in -ν , with  stress movement --------------
      mkNoun_endiaferon: (s1: Str) -> Gender -> Noun = 
      \endiaferon, g ->
     {
      s = table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> endiaferon ;
          Gen |CPrep P_Dat=> mkGenSg endiaferon 
          } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => mkNomPl endiaferon; 
          Gen |CPrep P_Dat=> mkGen endiaferon
          }
        } ;
      g = g
      } ;
   
   --------Indeclinable Nouns------------
    mkNounAklito: Str -> Gender -> Noun = 
        \s1,  g ->
       {
        s = table {
          Sg | Pl => table {
            Nom | Acc | Vocative |Gen |CPrep P_Dat| CPrep P_se |CPrep PNul => s1 
            } 
          } ;
        g = g
        } ;



    mkGen : Str -> Str = \s -> case s of {
      c + "άι" => c + "αγιών" ;
      c + "όι" => c + "ογιών" ;
      c + v@(#stressedVowel) + x@(_ + _) + "α" =>c + unstress v + x + "ών" ;
      c + v@(#stressedVowel) + x@(_ + _) + "ος" =>c + unstress v + x + "ών" ;
      c + "έας" => c + "έων" ;
      c + "ής" => c + "ών" ;
      --c + "ης" => c + "ών" ;
      c + "ος" => c + "ών" ;
      c + "άν" => c + "άντων" ;
      c + "όν" => c + "όντων" ;
      c + ("α" | "ο"  ) => c + "άτων" ;
     
      c + v@(#stressedVowel) + x@(_ + _) + "ας" =>c + unstress v + x + "ών" ;
      c + v@(#stressedVowel) + x@(_ + _) + "η" =>c + unstress v + x + "ών" ;
      c + v@(#stressedVowel) + x@(_ + _) + "ης" =>c + unstress v + x + "ών" ;
      c + v@(#stressedVowel) + x@(_ + _) + ("ι" | "υ") =>c + unstress v + x + "ιών" ;
      c + v@(#stressedVowel) + x@(_ + _) + "εν" =>c + unstress v + x + "έντων"  ;
      c + v@(#stressedVowel) + x@(_ + _) + "ον" =>c + unstress v + x + "όντων"  
    } ;



    mkGenSg : Str -> Str = \s -> 
    case s of
    {x + "η"    => x + "ης";
     x + "ος"   => x + "ους"; 
     x + "αι"    => x + "αγιού";
     x + "οι"    => x + "ογιού";
     x + "ης"   => x + "η"; 
     x + "α"   => x + "ας";
     x + "έας"   => x + "έα";
     x + "ο"   => x + "ου";
     x + "ής"   => x + "ή";
     x + "ον"   => x + "οντος";
     x + "όν"   => x + "όντος";
     x + "εν"    => x + "εντος";
     x + "άν"    => x + "άντος";
     x + ("ι" | "υ")   => x + "ιού";
     x + "ας"   => x + "α" 
    }; 

    mkNomPl : Str -> Str = \s -> 
    case s of
    {
    x + "έας"   => x + "είς" ;
    x + "ής"   => x + "είς" ;
    x + "ης"   => x + "ες" ;
    x + "ος"   => x + "η" ;
    x + "άι"    => x + "άγια";
    x + "όι"    => x + "όγια";
    x + "ον"    => x + "οντα";
     x + "όν"    => x + "όντα";
    x + "άν"    => x + "άντα";
    x + "εν"    => x + "εντα";
    x + ("ι" | "υ")   => x + "ια" ;
    x + "ας"    => x + "ες" ;
    x + "ο"   => x + "α" 
    }; 


    mkAccSg : Str -> Str = \s -> 
    case s of
    {x + "ής"    => x + "ή" ;
    x + "ης"    => x + "η" ;
    x + "έας"   => x + "έα";
    x + "ος"   => x + "ος";
    x + "ας"   => x + "α" 
    }; 




    mkStemNouns : Str -> Str = \s -> case s of {
      c + v@(#stressedVowel) + x@(_ + _)  =>c + unstress v + x   
    } ;



    



    --Nouns with no stress movement. 
 regN: Str -> Noun = \s-> case s of {
    kaloger + "ος" => mkNoun s (kaloger + "ου") (kaloger + "ο") (kaloger + "ε") (kaloger + "οι") (kaloger + "ων") (kaloger + "ους")(kaloger + "οι") Masc ;
    ouran + "ός" => mkNoun s (ouran + "ού") (ouran + "ό") (ouran + "έ") (ouran + "οί") (ouran + "ών") (ouran + "ούς") (ouran + "οί") Masc ;
    ypologist + "ής" => mkNoun s (ypologist + "ή") (ypologist + "ή") (ypologist + "ή") (ypologist + "ές") (ypologist + "ών") (ypologist + "ές") (ypologist + "ές") Masc ;
    pater + "ας" => mkNoun s (pater + "α") (pater + "α") (pater + "α") (pater + "ες") (pater + "ων") (pater + "ες")(pater + "ες") Masc ;
    tom + "έας" => mkNoun s (tom + "έα") (tom + "έα") (tom + "έα")(tom + "είς") (tom + "έων") (tom + "είς") (tom + "είς")Masc ;
    agelad + "α" => mkNoun s (agelad + "ας") (agelad + "α") (agelad + "α")(agelad + "ες") (agelad + "ων") (agelad + "ες") (agelad + "ες")Fem ;
    koili  + "ά" => mkNoun s (koili + "άς") (koili + "ά") (koili + "ά")(koili + "ές") (koili + "ών") (koili + "ές") (koili + "ές")Fem ;
    allag + "ή" => mkNoun s (allag + "ής") (allag + "ή") (allag + "ή")(allag + "ές") (allag + "ών") (allag + "ές") (allag + "ές")Fem ;
    pswm + "ί" => mkNoun s (pswm + "ιού") (pswm + "ί") (pswm + "ί") (pswm + "ιά") (pswm + "ιών") (pswm + "ιά") (pswm + "ιά") Neut ;
    mwr + "ό" => mkNoun s (mwr + "ού") (mwr + "ό") (mwr + "ό")  (mwr + "ά") (mwr+ "ών") (mwr + "ά") (mwr + "ά") Neut ;
    vivli + "ο" => mkNoun s (vivli + "ου") (vivli + "ο")(vivli + "ο") (vivli + "α") (vivli+ "ων") (vivli + "α")  (vivli + "α") Neut 

   };

  --Nouns with no stress movement, that augment the number of syllables when declined. 
   regNaniso: Str -> Noun = \s-> case s of {
    manav + "ης" => mkNoun s (manav + "η") (manav + "η") (manav + "η")(manav + "ηδες") (manav + "ηδων") (manav + "ηδες") (manav + "ηδες")Masc ;
    aer + "ας" => mkNoun s (aer + "α") (aer + "α") (aer + "α")(aer + "ηδες") (aer + "ηδων") (aer + "ηδες") (aer + "ηδες")Masc ;
    mpogiatz + "ής" => mkNoun s (mpogiatz + "ή") (mpogiatz + "ή")(mpogiatz + "ή") (mpogiatz + "ήδες") (mpogiatz + "ήδων") (mpogiatz + "ήδες") (mpogiatz + "ήδες") Masc ;
    kanap + "ές" => mkNoun s (kanap + "έ") (kanap + "έ")(kanap + "έ")  (kanap + "έδες") (kanap + "έδων") (kanap + "έδες") (kanap + "έδες") Masc ;
    papp + "ούς" => mkNoun s (papp + "ού") (papp + "ού") (papp + "ού")(papp + "ούδες") (papp + "ούδων") (papp + "ούδες") (papp + "ούδες")Masc ;
    pap + "άς" => mkNoun s (pap + "ά") (pap  + "ά") (pap + "ά") (pap  + "άδες") (pap  + "άδων") (pap  + "άδες") (pap  + "άδες") Masc ;
    giagi + "ά" => mkNoun s (giagi + "άς") (giagi + "ά") (giagi + "ά") (giagi + "άδες") (giagi + "άδων") (giagi + "άδες") (giagi + "άδες")Fem ;
    alep + "ού" => mkNoun s (alep + "ούς") (alep + "ού") (alep + "ού") (alep + "ούδες") (alep + "ούδων") (alep + "ούδες") (alep + "ούδες") Fem ;
    ix + "ώ" => mkNoun s (ix + "ούς") (ix + "ώ") (ix + "ώ") ("") ("") ("")  ("") Fem ;   -----this is an exeption noun 
    ox + "ύ" => mkNoun s (ox + "έος") (ox + "ύ") (ox + "ύ")(ox + "έα") (ox + "έων") (ox + "έα") (ox + "έα") Neut ;  ---this is an exeption noun
    plout + "ος" => mkNoun s (plout + "ου") (plout + "ο") (plout + "ε")(plout + "η") (plout + "ων") (plout + "η") (plout + "η") Change;
    san + "ός" => mkNoun s (san + "ού") (san + "ό") (san + "έ")(san + "ά") (san + "ών") (san + "ά") (san + "ά") Change  
   };

  regIrreg: Str -> Noun = \s-> case s of {
    kre + "ας" => mkNoun s (mkStemNouns kre + "ατος") (kre + "ας") (kre + "ας")(kre + "ατα") (mkStemNouns kre + "άτων") (kre + "ατα") (kre + "ατα") Neut; 
    xron + "ος" => mkNoun s (xron + "ου") (xron + "ο") (xron + "ε")(xron + "ια") (xron + "ων") (xron + "ια") (xron + "ια") Change;  
    gal + "α" => mkNoun s ( gal + "ατος") (gal + "α") (gal + "α")(gal + "ατα") (mkStemNouns gal + "άτων") (gal + "ατα") (gal + "ατα") Neut ;
    mel + "ι" => mkNoun s ( mel + "ιτος") (mel + "ι") (mel + "ι")(mel + "ια") (mkStemNouns mel + "ιών") (mel + "ια") (mel + "ια") Neut ;
    p + "ύρ" => mkNoun s ( p + "υρός") (p + "ύρ") (p + "ύρ")(p + "υρά") ( p + "υρών") (p + "υρά") (p + "υρά") Neut ;   ---exeptions from ancient greek
    ip + "αρ" => mkNoun s ( ip + "ατος") (ip + "αρ") (ip + "αρ")(ip + "ατα") ( mkStemNouns ip + "άτων") (ip + "ατα") (ip + "ατα") Neut    ---exeptions from ancient greek 
   };

  


       --------------------------ADJECTIVES/ADVERBS -------------------------
       ----------------------------------------------------------------------

      -------suffixed comparative form of an adjective-------------------
     mkComparative : Str -> Str = \s -> 
    case s of
    {
    x + "κακός"   => x + "χειρότερος" ;
    x + "καλός"   => x + "καλύτερος" ;
    x + "μεγάλος"   => x + "μεγαλύτερος" ;
    x + "ύς"   => x + "ύτερος" ; 
    x + "ής"   => x + "έστερος" ;
    x + "ός"   => x + "ότερος" ;
    c + v@(#stressedVowel) + x@(_ + _) + "ος" =>c + unstress v + x + "ότερος" ;
    c + v@(#stressedVowel) + x@(_ + _) + ("ής" | "ης")  =>c + unstress v + x + "έστερος" 
    }; 



    -----Creates the adverb, by using Neutral, Sg, Nom ------
    mkAdverb : Str ->  Str =
        \s -> case s of
    {
    x + "ο"    => x + "α" ;
    x + "ό"    => x + "ά" ;
    x + "γον"    => x + "γόντως" ;
    x + "λον"    =>x + "λοντικά" ;
    x + "ής"    => x + "ώς" ;
    x + "ης"    => x + "ως" ;
    x + "ές"    => x + "ώς" ;
    x + "ύ"    => x + "ιά" ;
    x + "ικο"    => x + "ικα" 
    };


    mkAdverb2 : Str ->  Str =
        \s -> case s of
      {
      x + "ύ"    => x + "έως" 
      };

    -----comparative form of the adverb ------
    mkAdverbCompar : Str ->  Str =
        \s -> case s of
    {x + "κακό"   => x + "χειρότερα" ;
    x + "καλό"   => x + "καλύτερα" ;
    x + "ο"    => x + "ότερα" ;
    x + "ό"    => x + "ότερα" ;
    x + "ύ"    => x + "ύτερα" ;
    x + "έως"    => x + "ύτερα" ;
    x + "ές"    => x + "έστερα" 

    };


    -----superlative form of the adverb ------
    mkAdverbSuper : Str ->  Str =
        \s -> case s of
    {x + "κακό"   => x + "κάκιστα" ;
    x + "καλό"   => x + "κάλιστα" ;
    x + ("ο"  | "ό" ) => x + "ότατα" ;
    x + "ύ"    => x + "ύτατα" ;
    x + "έως"    => x + "ύτατα" ;
    x + "ές"    => x + "έστατα" 

    };

    ----Adjectives that form the comparative with a suffix----------
     mkAdjective2 : (s1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Adj = \sn,sg,sa,sv,pn,pg,pa,snf,sgf,pnf,pgf,snn,sgn,pnn,pgn, comp ->
     let
         adverb = mkAdverb snn;
         comp1 = mkComparative sn; 
         comp =Predef.tk 2 comp1 ;
          in  {
        s = table { Posit  => table {
          Masc  => table {
            Sg => table {
              Nom => sn ; Gen |CPrep P_Dat=> sg ; Acc |CPrep P_se |CPrep PNul => sa ; Vocative => sv
            } ;
            Pl => table {
              Nom | Vocative => pn ; Gen |CPrep P_Dat=> pg ; Acc |CPrep P_se |CPrep PNul  => pa 
            }} ;
            Change=> table {
            Sg => table {
              Nom => sn ; Gen|CPrep P_Dat => sg ; Acc |CPrep P_se |CPrep PNul => sa ; Vocative => sv
            } ;
            Pl => table {
              Nom | Acc | Vocative|CPrep P_se |CPrep PNul => pnn ; Gen |CPrep P_Dat=> pgn 
            }} ;
          Fem   => table {
            Sg => table {
             Nom | Acc | Vocative|CPrep P_se |CPrep PNul => snf ; Gen|CPrep P_Dat => sgf 
            } ;
            Pl => table {
               Nom | Acc | Vocative |CPrep P_se |CPrep PNul => pnf ; Gen |CPrep P_Dat=> pgf  
            }} ;
          Neut => table {
            Sg => table {
              Nom | Acc | Vocative |CPrep P_se |CPrep PNul => snn ; Gen|CPrep P_Dat => sgn 
            } ;
            Pl => table {
              Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> pnn ; Gen|CPrep P_Dat => pgn 
            }} } ;
            Compar | Superl => table {
          Masc  => table {
            Sg => table {
              Nom =>  comp1  ; Gen|CPrep P_Dat => comp  + "ου"; Acc |CPrep P_se |CPrep PNul=> comp + "ο"; Vocative => comp + "ος"
            } ;
            Pl => table {
              Nom | Vocative => comp + "οι"; Gen|CPrep P_Dat => comp+ "ων"; Acc |CPrep P_se |CPrep PNul  => comp + "ους"
            }} ;
          Fem   => table {
            Sg => table {
             Nom | Acc | Vocative|CPrep P_se |CPrep PNul => comp + "η" ; Gen|CPrep P_Dat => comp + "ης"
            } ;
            Pl => table {
               Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => comp + "ες"; Gen |CPrep P_Dat=> comp + "ων" 
            }} ;
          Neut | Change=> table {
            Sg => table {
              Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => comp + "ο" ; Gen |CPrep P_Dat=> comp + "ου"
            } ;
            Pl => table {
              Nom | Acc |Vocative|CPrep P_se |CPrep PNul => comp + "α"; Gen|CPrep P_Dat => comp + "ων"
            }} }
          } ;
    adv = table { Posit => adverb  ; Compar => mkAdverbCompar snn ; Superl => mkAdverbSuper snn} ;
        } ;


    ----Adjectives that form the comparative with a suffix, irregularities in the formation of adverbs. 
    -----It concerns mostly adjectives with endings -ύς, -εία,  -ύ, that differenciate from those ending in -ύς, -ιά,  -ύ.
    mkAdjectiveIr : (s1,_ : Str) -> Adj = \eythis,eytheos -> 
     let 
      eyth = Predef.tk 2 eythis;
      eythIteros = mkComparative eythis ;
      eythIter = Predef.tk 2 eythIteros;
      adverb = eytheos;
    in {
    s = table { Posit | Superl => table {
      Masc | Change => table {
        Sg => table {
          Nom  => eythis ; Gen |CPrep P_Dat=> eyth + "έος" ; Acc |CPrep P_se |CPrep PNul| Vocative => eyth + "ύ"
        } ;
        Pl => table {
          Nom | Vocative |Acc |CPrep P_se |CPrep PNul  => eyth + "είς" ; Gen|CPrep P_Dat => eyth + "έων"  
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative|CPrep P_se |CPrep PNul => eyth + "εία"; Gen |CPrep P_Dat=> eyth + "είας"
        } ;
        Pl => table {
           Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => eyth + "είες" ; Gen |CPrep P_Dat=> eyth + "ειών" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => eyth + "ύ" ; Gen |CPrep P_Dat=> eyth + "έος" 
        } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> eyth + "έα" ; Gen|CPrep P_Dat => eyth + "έων"  
        }}  };
     Compar => table {
      Masc | Change => table {
        Sg => table {
          Nom  | Vocative => eythIteros  ; Gen|CPrep P_Dat => eythIter  + "ου"; Acc |CPrep P_se |CPrep PNul => eythIter + "ο" 
        } ;
        Pl => table {
          Nom | Vocative => eythIter + "οι"; Gen|CPrep P_Dat => eythIter+ "ων"; Acc |CPrep P_se |CPrep PNul => eythIter + "ους"
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative |CPrep P_se |CPrep PNul => eythIter + "η" ; Gen|CPrep P_Dat => eythIter + "ης"
        } ;
        Pl => table {
           Nom | Acc | Vocative  |CPrep P_se |CPrep PNul=> eythIter + "ες"; Gen |CPrep P_Dat=> eythIter + "ων" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => eythIter + "ο" ; Gen|CPrep P_Dat => eythIter + "ου"
        } ;
        Pl => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul => eythIter + "α"; Gen|CPrep P_Dat => eythIter + "ων"
        }} }
      } ;
      adv = table { Posit => eytheos  ; Compar =>  mkAdverbCompar eytheos  ; Superl => mkAdverbSuper eytheos} ; 
    } ;



  -------Adjectives that form the comparative using "πιό"------
    mkAdjective : (s1,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Adj = \sn,sg,sa,sv,pn,pg,pa,snf,sgf,pnf,pgf,snn,sgn,pnn,pgn ->
 let
      adverb = mkAdverb snn;
      a = "πιό";
      in  {
    s = table { Posit  => table {
      Masc  => table {
        Sg => table {
          Nom => sn ; Gen|CPrep P_Dat => sg ; Acc |CPrep P_se |CPrep PNul => sa ; Vocative  => sv
        } ;
        Pl => table {
          Nom | Vocative => pn ; Gen |CPrep P_Dat=> pg ; Acc |CPrep P_se |CPrep PNul => pa 
        }} ;
      Change=> table {
        Sg => table {
          Nom => sn ; Gen|CPrep P_Dat => sg ; Acc |CPrep P_se |CPrep PNul=> sa ; Vocative => sv
        } ;
        Pl => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul => pnn ; Gen|CPrep P_Dat => pgn 
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative|CPrep P_se |CPrep PNul => snf ; Gen|CPrep P_Dat => sgf 
        } ;
        Pl => table {
           Nom | Acc | Vocative |CPrep P_se |CPrep PNul => pnf ; Gen |CPrep P_Dat=> pgf  
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => snn ; Gen|CPrep P_Dat => sgn 
        } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> pnn ; Gen |CPrep P_Dat=> pgn 
        }} } ;
        Compar| Superl => table {
      Masc  => table {
        Sg => table {
          Nom => a ++ sn ; Gen|CPrep P_Dat => a ++ sg ; Acc |CPrep P_se |CPrep PNul => a ++ sa ; Vocative => a ++ sv 
        } ;
        Pl => table {
          Nom | Vocative => a ++ pn ; Gen |CPrep P_Dat=> a ++ pg ; Acc |CPrep P_se |CPrep PNul=> a ++ pa 
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative|CPrep P_se |CPrep PNul => a ++ snf  ; Gen|CPrep P_Dat => a ++ sgf 
        } ;
        Pl => table {
           Nom | Acc | Vocative |CPrep P_se |CPrep PNul => a ++ pnf ; Gen|CPrep P_Dat => a ++pgf 
        }} ;
      Neut  | Change=> table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => a ++ snn ; Gen|CPrep P_Dat => a ++ sgn 
        } ;
        Pl => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul => a ++ pnn ; Gen|CPrep P_Dat => a ++ pgn 
        }} }
      };
    adv = table { Posit => adverb  ; Compar =>  adverb ; Superl => adverb} ;
    } ;


  -------Category of adjectives ending in -ων, -ουσα, -ον with stress movement.------------------
    mkAdjective3 : (s1,_ : Str) -> Adj = \epeigwn,epeigontwn -> 
     let
      a = "πιό"; 
      epeIg = Predef.tk 2 epeigwn;
      epeIgon = epeIg + "ον" ;
      epeig = mkStemNouns epeIg ;
      epeigon = mkStemNouns epeIgon ;
      adverb = mkAdverb epeigon;
    in {
    s = table { Posit  => table {
      Masc | Change => table {
        Sg => table {
          Nom | Vocative => epeigwn ; Gen |CPrep P_Dat=> epeIg + "οντος" ; Acc |CPrep P_se |CPrep PNul  => epeIg + "οντα"
        } ;
        Pl => table {
          Nom | Vocative |Acc |CPrep P_se |CPrep PNul  => epeIg + "οντες" ; Gen |CPrep P_Dat=> epeigontwn  
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative|CPrep P_se |CPrep PNul => epeIg + "ουσα";Gen |CPrep P_Dat=> epeIg + "ουσας" 
        } ;
        Pl => table {
           Nom | Acc |Vocative|CPrep P_se |CPrep PNul  => epeIg + "ουσες" ; Gen|CPrep P_Dat => epeig + "ουσών" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => epeIg + "ον" ; Gen|CPrep P_Dat => epeIg + "οντος" 
        } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> epeIg + "οντα" ; Gen |CPrep P_Dat=> epeigontwn 
        }}  };
     Compar | Superl => table {
      Masc | Change => table {
        Sg => table {
          Nom  | Vocative => a ++ epeigwn; Gen |CPrep P_Dat=> a ++ epeIg + "οντος"  ; Acc |CPrep P_se |CPrep PNul  => a ++ epeIg + "οντα"  
        } ;
        Pl => table {
          Nom | Vocative | Acc | CPrep P_se |CPrep PNul => a ++ epeIg + "οντες" ; Gen|CPrep P_Dat => a ++ epeigontwn  
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative |CPrep P_se |CPrep PNul => a ++ epeIg + "ουσα" ; Gen |CPrep P_Dat=> a ++ epeIg + "ουσας"
        } ;
        Pl => table {
           Nom | Acc | Vocative |CPrep P_se |CPrep PNul => a ++ epeIg + "ουσες" ; Gen|CPrep P_Dat => a ++ epeig + "ουσών" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => a ++ epeIg + "ον"; Gen |CPrep P_Dat=> a ++ epeIg + "οντος" 
        } ;
        Pl => table {
          Nom | Acc | Vocative|CPrep P_se |CPrep PNul  => a ++ epeIg + "οντα"  ; Gen |CPrep P_Dat=> a ++ epeigontwn
        }} }
      } ;
      adv = table { Posit => adverb  ; Compar =>  a ++ adverb  ; Superl => a ++ adverb} ; 
    } ;


  
        -------Category of adjectives ending in -ης, -ης, -ες with stress movement in Neutral.------------------
    mkAdjective4 : (s1,_: Str) -> Adj = \sinithis,sInithes -> 
    let
          adverb = mkAdverb sinithis;
          sinIthi = init sinithis;
          sinIth = Predef.tk 2 sinithis;
          sin = mkComparative sinithis ;
          si = Predef.tk 2 sin;
        in
      {
      s = table { Posit  => table {
      Masc | Fem  | Change=> table {
        Sg => table {
          Nom => sinithis ; Gen|CPrep P_Dat => sinIth  + "ους" ; Acc | Vocative|CPrep P_se |CPrep PNul =>  sinIthi 
        } ;
        Pl => table {
          Nom | Vocative | Acc |CPrep P_se |CPrep PNul => sinIth + "εις" ; Gen |CPrep P_Dat=> sinIth  + "ων" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul => sInithes ; Gen |CPrep P_Dat=> sinIth  + "ους"  
        } ;
        Pl => table {
          Nom | Acc |Vocative|CPrep P_se |CPrep PNul => sinIthi ; Gen |CPrep P_Dat=> sinIth  + "ων"  
        }}  } ;
     Compar |  Superl => table {
      Masc | Change => table {
        Sg => table {
          Nom => sin  ; Gen |CPrep P_Dat=>   si  + "ου"; Acc |CPrep P_se |CPrep PNul  => si + "ο"; Vocative => si + "ος"
        } ;
        Pl => table {
          Nom | Vocative => si + "οι"; Gen |CPrep P_Dat=> si+ "ων"; Acc |CPrep P_se |CPrep PNul =>si + "ους"
        }} ;
      Fem   => table {
        Sg => table {
         Nom | Acc | Vocative|CPrep P_se |CPrep PNul => si + "η" ; Gen |CPrep P_Dat=> si + "ης"
        } ;
        Pl => table {
           Nom | Acc | Vocative |CPrep P_se |CPrep PNul => si + "ες"; Gen |CPrep P_Dat=> si + "ων" 
        }} ;
      Neut => table {
        Sg => table {
          Nom | Acc |Vocative|CPrep P_se |CPrep PNul=> si + "ο" ; Gen|CPrep P_Dat => si + "ου"
        } ;
        Pl => table {
          Nom | Acc | Vocative |CPrep P_se |CPrep PNul=> si + "α"; Gen |CPrep P_Dat=> si + "ων"
        }} }
      } ;
      adv = table { Posit => adverb  ; Compar =>  sin ++ "τερα"  ; Superl => sin ++ "τατα"} ; 
    } ;



  ------ Indeclinable Adjectives  ------
    mkAdjAklito :  Str -> Adj = \s1 -> 
    let
      a = "πιό" ;
    in {
    s = table { Posit | Superl => table {
      Masc |Fem | Neut | Change  => table {
          Sg |Pl  => table {
              Nom | Gen | Acc| Vocative |CPrep P_se |CPrep PNul|CPrep P_Dat  => s1 
        } }
        } ;
        Compar => table {
     Masc |Fem | Neut | Change  => table {
        Sg |Pl  => table {
          Nom | Gen | Acc| Vocative | CPrep P_se |CPrep PNul |CPrep P_Dat => a ++  s1 
        } }}
        };
        adv = table { Posit => " "  ; Compar =>  " " ; Superl =>  " "} ; 
    } ;

  

    ---Adjectives with endings -ος (-ός), -η, -ο  

  regAdj : Str -> Adj = \mikros -> case mikros of {
    mikr + "ός" => mkAdjective mikros (mikr + "ού") (mikr + "ό")(mikr + "έ")  (mikr + "οί")(mikr + "ών")(mikr + "ούς")
                  (mikr + "ή") (mikr + "ής") (mikr + "ές")(mikr + "ών")
                  (mikr + "ό")(mikr + "ού")(mikr + "ά")(mikr + "ών") ;
    omorf + "ος" => mkAdjective mikros (omorf + "ου") (omorf + "ο") (omorf + "ε") (omorf + "οι")(omorf + "ων")(omorf + "ους")
                  (omorf + "η") (omorf + "ης") (omorf + "ες")(omorf + "ων")
                  (omorf + "ο")(omorf + "ου")(omorf + "α")(omorf + "ων") ;
     ex + "ων" => mkAdjective mikros (ex + "οντος") (ex + "οντα") (ex + "οντα") (ex + "οντες")(unstress ex + "όντων")(ex + "οντες")
                  (ex + "ουσα")(ex + "ουσας") (ex + "ουσες")(ex + "ουσων")
                  (ex + "ον")(ex+ "οντος")(ex + "οντα")(unstress ex + "όντων")  ; 
    nonExist  => mkAdjective mikros (nonExist ) (nonExist ) (nonExist ) (nonExist)(nonExist )(nonExist )
                (nonExist ) (nonExist ) (nonExist )(nonExist )
                  (nonExist )(nonExist )(nonExist )(nonExist )

    } ;


    -----adjectives with endings -ος (-ός), -α , -ο | -ύς, -ια , -υ | -ης, -α , -ικο | -ών, -ουσα , -ων   και -ης , -ια, -ι

    regAdj1 : Str -> Adj = \metrios -> case metrios of {
     metri + "ος" => mkAdjective metrios (metri + "ου") (metri + "ο")(metri + "ε")  (metri + "οι")(metri + "ων")(metri + "ους")
                  (metri + "α") (metri + "ας") (metri + "ες")(metri + "ων")
                  (metri + "ο")(metri + "ου")(metri + "α")(metri + "ων") ;
     pali+ "ός" => mkAdjective metrios (pali + "ού") (pali + "ό")(pali + "έ")  (pali + "οί")(pali + "ών")(pali + "ούς")
                  (pali + "ά") (pali + "άς") (pali + "ές")(pali + "ών")
                  (pali + "ό")(pali + "ού")(pali + "ά")(pali + "ών")  ;
     pax + "ύς" => mkAdjective metrios (pax + "ύ") (pax + "ύ") (pax + "ύ")(pax + "ιοί")(pax + "ιών")(pax + "ιούς")
                  (pax + "ιά")(pax + "ιάς") (pax + "ιές")(pax + "ιών")
                  (pax + "ύ")(pax + "ιού")(pax + "ιά")(pax + "ιών") ;
     staxt + "ής" => mkAdjective metrios (staxt + "ή") (staxt + "ή") (staxt + "ή")(staxt + "ιοί")(staxt + "ιών")(staxt + "ιούς")
                  (staxt + "ιά")(staxt + "ιάς") (staxt + "ιές")(staxt + "ιών")
                  (staxt + "ί")(staxt + "ιού")(staxt + "ιά")(staxt + "ιών") ;
      tempel + "ης" => mkAdjective metrios (tempel + "η") (tempel + "η") (tempel + "η") (tempel + "ηδες")(tempel + "ηδων")(tempel + "ηδες")
                  (tempel + "α")(tempel + "ας") (tempel + "ες")(tempel + "ων")
                  (tempel + "ικο")(tempel + "ικου")(tempel + "ικα")(tempel + "ικων") ;
      par + "ών" => mkAdjective metrios (par + "όντος") (par + "όντα") (par + "όντα") (par + "όντες")(par + "όντων")(par + "όντες")
                  (par + "ούσα")(par + "ούσας") (par + "ούσες")(par + "ουσών")
                  (par + "όν")(par+ "όντος")(par + "όντα")(par + "όντων")      
    } ;      



    -----adjectives with endings -ος, -ια , -ο |-υς, -εια , -υ | -ης, -ης , -ες 

    regAdj2 : Str -> Adj = \glikos -> case glikos of {
     glik + "ός" => mkAdjective glikos (glik + "ού") (glik + "ό") (glik + "έ")(glik + "οί")(glik + "ών")(glik + "ούς")
                  (glik + "ιά") (glik + "ιάς") (glik + "ές")(glik + "ών")
                  (glik + "ό")(glik + "ού")(glik + "ά")(glik + "ών")  ;
      fresk + "ος" => mkAdjective glikos (fresk + "ου") (fresk + "ο") (fresk + "ε")(fresk + "οι")(fresk + "ων")(fresk + "ους")
                  (fresk + "ια") (fresk + "ιας") (fresk + "ες")(fresk + "ων")
                  (fresk + "ο")(fresk + "ουύ")(fresk + "α")(fresk + "ων") ;
     
      akriv + "ής" => mkAdjective glikos (akriv + "ή") (akriv + "ή") (akriv + "ή") (akriv + "είς")(akriv + "ών")(akriv + "είς")
                  (akriv + "ής")(akriv + "ή") (akriv + "είς")(akriv + "ών")
                  (akriv + "ές")(akriv + "ούς")(akriv + "ή")(akriv + "ών")  

    } ;

     irregAdj : Str -> Adj = \ilIthios -> case ilIthios of {
     ilIth + "ιος" => mkAdjective ilIthios (ilIth + "ιου") (ilIth + "ιο") (ilIth + "ιε")(ilIth + "ιοι")(mkStemNouns ilIth + "ίων")(ilIth + "ιους")
                  (ilIth + "ια") (ilIth + "ιας") (ilIth + "ιες")(mkStemNouns ilIth + "ίων")
                  (ilIth + "ιο")(ilIth + "ιου")(ilIth + "ια")(mkStemNouns ilIth + "ίων")  
    } ;

 
 ---------------------------------------------------------------------------------------------------------------------------------------------
---------For Adjectives with suffixed comparative----------------

    ---Adjectives with endings -ος, -η, -ο

  regAdj3 : Str -> Adj = \mikros -> case mikros of {
    mikr + "ός" => mkAdjective2 mikros (mikr + "ού") (mikr + "ό")(mikr + "έ")  (mikr + "οί")(mikr + "ών")(mikr + "ούς")
                  (mikr + "ή") (mikr + "ής") (mikr + "ές")(mikr + "ών")
                  (mikr + "ό")(mikr + "ού")(mikr + "ά")(mikr + "ών") (mikr + "ότερος") ;
    omorf + "ος" => mkAdjective2 mikros (omorf + "ου") (omorf + "ο") (omorf + "ε") (omorf + "οι")(omorf + "ων")(omorf + "ους")
                  (omorf + "η") (omorf + "ης") (omorf + "ες")(omorf + "ων")
                  (omorf + "ο")(omorf + "ου")(omorf + "α")(omorf + "ων") (omorf + "ότερος") 
    } ;


    -----adjectives with endings -ος, -α , -ο | -υς, -ια , -υ  και -ης , -ια, -ι

    regAdj4 : Str -> Adj = \metrios -> case metrios of {
     metri + "ος" => mkAdjective2 metrios (metri + "ου") (metri + "ο")(metri + "ε")  (metri + "οι")(metri + "ων")(metri + "ους")
                  (metri + "α") (metri + "ας") (metri + "ες")(metri + "ων")
                  (metri + "ο")(metri + "ου")(metri + "α")(metri + "ων") (metri + "ότερος");
     pali+ "ός" => mkAdjective2 metrios (pali + "ού") (pali + "ό")(pali + "έ")  (pali + "οί")(pali + "ών")(pali + "ούς")
                  (pali + "ά") (pali + "άς") (pali + "ές")(pali + "ών")
                  (pali + "ό")(pali + "ού")(pali + "ά")(pali + "ών") (pali + "ότερος") ;
     pax + "ύς" => mkAdjective2 metrios (pax + "ύ") (pax + "ύ") (pax + "ύ")(pax + "ιοί")(pax + "ιών")(pax + "ιούς")
                  (pax + "ιά")(pax + "ιάς") (pax + "ιές")(pax + "ιών") 
                  (pax + "ύ")(pax + "ιού")(pax + "ιά")(pax + "ιών")(pax + "ύτερος");
    staxt + "ής" => mkAdjective2 metrios (staxt + "ή") (staxt + "ή") (staxt + "ή")(staxt + "ιοί")(staxt + "ιών")(staxt + "ιούς")
                  (staxt + "ιά")(staxt + "ιάς") (staxt + "ιές")(staxt + "ιών")
                  (staxt + "ί")(staxt + "ιού")(staxt + "ιά")(staxt + "ιών")  (staxt + "ύτερος")   


    } ;


    -----adjectives with endings -ος (-ός), -ια , -ο | -ύς, -εια , -υ | -ής, -ης , -ες 

    regAdj5 : Str -> Adj = \glikos -> case glikos of {
     glik + "ός" => mkAdjective2 glikos (glik + "ού") (glik + "ό") (glik + "έ")(glik + "οί")(glik + "ών")(glik + "ούς")
                  (glik + "ιά") (glik + "ιάς") (glik + "ές")(glik + "ών")
                  (glik + "ό")(glik + "ού")(glik + "ά")(glik + "ών") (glik + "ότερος")  ;
      fresk + "ος" => mkAdjective2 glikos (fresk + "ου") (fresk + "ο") (fresk + "ε")(fresk + "οι")(fresk + "ων")(fresk + "ους")
                  (fresk + "ια") (fresk + "ιας") (fresk + "ες")(fresk + "ων")
                  (fresk + "ο")(fresk + "ουύ")(fresk + "α")(fresk + "ων")(fresk + "ότερος") ;
      akriv + "ής" => mkAdjective2 glikos (akriv + "ή") (akriv + "ή") (akriv + "ή") (akriv + "είς")(akriv + "ών")(akriv + "είς")
                  (akriv + "ής")(akriv + "ή") (akriv + "είς")(akriv + "ών")
                  (akriv + "ές")(akriv + "ούς")(akriv + "ή")(akriv + "ών")  (akriv + "έστερος")      

    } ;


  -----Pattern for the final -ν in the Feminine Accusative of the definite article----------
   FemAccFinalN : pattern Str = #("ά" | "ό" | "ί"| "έ" | "ή" | "ύ"| "ώ" | "α" | "ο" | "ι"| "ε" |"η" | "υ" | "ω" |"κ"|"π" |"τ"| "ξ" |"ψ"| "γκ" |"μπ" |"ντ" );




    mkDeterminer : (s1,_,_,_,_,_,_,_,_,_,_,_ : Str)  ->  Number -> Det  = \mn,mg,ma,yn,yg,ya,nn,ng,na,c,cg,ca,n -> 
     {  
     s = table {
        Masc  => table { Nom => mn ; Gen |CPrep P_Dat=> mg ; Acc |CPrep P_se |CPrep PNul  => ma ; Vocative => []} ;
        Fem => table { Nom => yn ; Gen |CPrep P_Dat=> yg ; Acc |CPrep P_se |CPrep PNul  => ya ;Vocative => [] } ;
        Neut  => table { Nom => nn ; Gen |CPrep P_Dat=> ng ; Acc |CPrep P_se |CPrep PNul  => na; Vocative => [] } ;
        Change => table { Nom => c ; Gen|CPrep P_Dat => cg ; Acc |CPrep P_se |CPrep PNul   => ca; Vocative => [] } 
        } ; 
       n = n ;
      } ;



   artDef : Gender -> Number -> Case -> Str = \g,n,c ->               
     case <g,n,c> of {
        <Masc | Change , Sg, Nom> => "ο";
        <Masc | Change,Sg, Gen|CPrep P_Dat>  =>  "του" ;
        <Masc | Change,Sg, Acc | CPrep PNul > => prepCase c++   "τον" ; 
        <Masc | Change,Sg,CPrep P_se > =>   "στον" ; 
        <Fem, Sg, Nom>    => "η" ;
        <Fem, Sg, Gen|CPrep P_Dat>   =>  "της" ;
        <Fem, Sg, Acc |CPrep PNul>   =>   pre { FemAccFinalN => "την" ; _=> "τη"} ;
        <Fem, Sg, CPrep P_se  >   =>   pre { FemAccFinalN => "στην" ; _=> "στη"} ;
        <Neut, Sg, Nom | Acc |CPrep PNul>    => prepCase c++  "το" ;
        <Neut, Sg, Gen|CPrep P_Dat>   =>  "του" ;
        <Neut, Sg, CPrep P_se >    =>   "στο" ;
        <Masc,Pl, Nom> => "οι";
        <Masc,Pl, Gen|CPrep P_Dat>  =>   "των" ;
        <Masc,Pl, Acc |CPrep PNul>    => prepCase c++   "τους" ;
        <Masc,Pl,CPrep P_se >    =>   "στους" ;
        <Fem, Pl, Nom>    => "οι" ;
        <Fem, Pl, Gen|CPrep P_Dat>   =>  "των" ;
        <Fem, Pl, Acc |CPrep PNul>   => prepCase c++  "τις";
        <Fem, Pl, CPrep P_se >   =>  "στις";
        < Neut | Change ,Pl, Nom |Acc |CPrep PNul >    => prepCase c++  "τα" ;
        < Neut | Change ,Pl, CPrep P_se  >    =>  "στα" ;
        <Neut | Change, Pl, Gen|CPrep P_Dat>   => prepCase c++  "των" ;
        <_,_, Vocative >    => " " 
        } ; 





      relPron : Bool => AAgr => Case => Str = \\b,ag,c => 
      case b of {
      False => case c of {
        Nom => case <ag.g, ag.n > of
                                                    {<Fem,Sg> => "η οποία" ;   
                                                     <Masc |Change,Sg> => "ο οποίος" ;
                                                     <Neut,Sg> => "το οποίο" ;  
                                                     <Fem,Pl> => "οι οποίες" ;   
                                                     <Masc |Change,Pl> => "οι οποίοι" ;
                                                     <Neut,Pl> => "τα οποία"  
                                                      };
        Gen |CPrep P_Dat => case <ag.g, ag.n > of
                                                    {<Fem,Sg> => prepCase c ++"της οποίας" ;   
                                                     <Masc |Change |Neut,Sg> =>prepCase c ++ "του οποίου" ;
                                                     <Masc |Change |Fem |Neut ,Pl> => prepCase c ++"των οποίων" 
                                                      };
        Acc | CPrep PNul  => case <ag.g, ag.n > of
                                                    {<Fem,Sg> => prepCase c ++ "την οποία" ;   
                                                     <Masc |Change,Sg> => prepCase c ++"τον οποίο" ;
                                                     <Neut,Sg> => prepCase c ++ "το οποίο" ;  
                                                     <Fem,Pl> => prepCase c ++ "τις οποίες" ;   
                                                     <Masc |Change,Pl> => prepCase c ++"τους οποίους" ;
                                                     <Neut,Pl> => prepCase c ++"τα οποία"  
                                                      };
         CPrep P_se => case <ag.g, ag.n > of
                                                    {<Fem,Sg> =>  "στην οποία" ;   
                                                     <Masc |Change,Sg> => "στον οποίο" ;
                                                     <Neut,Sg> => "στο οποίο" ;  
                                                     <Fem,Pl> => "στις οποίες" ;   
                                                     <Masc |Change,Pl> => "στους οποίους" ;
                                                     <Neut,Pl> => "στα οποία" 
                                                      } ;
        Vocative =>  case <ag.g, ag.n > of
                                                    {<_,_> => " " 
                                                      } 
        } ;
      _   => "που"
      } ;




      artIndef : Gender  -> Number->  Case -> Str = \g,n,c ->
      case <g,n,c> of {
        <Masc | Change,Sg, Nom > => "ένας";
        <Masc | Change,Sg,  Gen|CPrep P_Dat>  => "ενός" ;
        <Masc | Change,Sg, Acc |CPrep P_se |CPrep PNul> => prepCase c++  "ένα";
        <Masc | Change ,Sg, Vocative> => " "; 
        <Fem, Sg,  Nom >    => prepCase c++  "μία" ;
        <Fem, Sg,  Gen|CPrep P_Dat>   => "μίας" ;
        <Fem, Sg,  Acc |CPrep P_se |CPrep PNul >    => prepCase c++  "μία" ;
        <Fem ,Sg, Vocative> => " ";
        <Neut,Sg,   Nom|Acc |CPrep P_se |CPrep PNul > =>prepCase c++ "ένα" ;
        <Neut,Sg,   Gen|CPrep P_Dat>   => "ενός";
        <Neut ,Sg, Vocative> => " " ;
        <_ ,Pl, _> =>prepCase c ++  " "
     } ;




    reflPron : Agr => Case =>  Str = \\ag,c => case <ag,c >  of  {
         < Ag _ Sg P1 ,Nom |Vocative >     => "ο εαυτός μου" ;
         < Ag _ Sg P1 ,Gen |CPrep P_Dat >     => "του εαυτού μου" ;
         < Ag _ Sg P1 ,Acc| CPrep PNul>     => "τον εαυτό μου" ;
         < Ag _ Sg P1 ,CPrep P_se>     => "στον εαυτό μου" ;
       

         < Ag _ Sg P2 ,Nom |Vocative >     => "ο εαυτός σου" ;
         < Ag _ Sg P2 ,Gen |CPrep P_Dat >     => "του εαυτού σου" ;
         < Ag _ Sg P2 ,Acc| CPrep PNul>     => "τον εαυτό σου" ;
         < Ag _ Sg P2 ,CPrep P_se>     => "στον εαυτό σου" ;
         

         < Ag Fem Sg P3 ,Nom |Vocative >     => "ο εαυτός της" ;
         < Ag Fem Sg P3 ,Gen |CPrep P_Dat >     => "του εαυτού της" ;
         < Ag Fem Sg P3 ,Acc| CPrep PNul>     => "τον εαυτό της" ;
         < Ag Fem Sg P3 ,CPrep P_se>     => "στον εαυτό της" ;
        

         < Ag _  Sg P3 ,Nom |Vocative >     => "ο εαυτός του" ;
         < Ag _  Sg P3 ,Gen |CPrep P_Dat >     => "του εαυτού του" ;
         < Ag  _  Sg P3 ,Acc| CPrep PNul>     => "τον εαυτό του" ;
         < Ag _  Sg P3 ,CPrep P_se>     => "στον εαυτό του" ;
        

         < Ag _ Pl P1 ,Nom |Vocative >     => "οι εαυτοί μας" ;
         < Ag _ Pl P1 ,Gen |CPrep P_Dat >     => "των εαυτών μας" ;
         < Ag _ Pl P1 ,Acc| CPrep PNul >     => "τους εαυτούς μας" ;
         < Ag _ Pl P1 ,CPrep P_se>     => "στους εαυτούς μας" ;
        

         < Ag _ Pl P2 ,Nom |Vocative >     => "οι εαυτοί σας" ;
         < Ag _ Pl P2 ,Gen |CPrep P_Dat >     => "των εαυτών σας" ;
         < Ag _ Pl P2 ,Acc| CPrep PNul>     => "τους εαυτούς σας" ;
         < Ag _ Pl P2 ,CPrep P_se>     => "στους εαυτούς σας" ;
       

         < Ag _ Pl P3 ,Nom |Vocative >     => "οι εαυτοί τους" ;
         < Ag _ Pl P3 ,Gen |CPrep P_Dat >     => "των εαυτών τους" ;
         < Ag _ Pl P3 ,Acc| CPrep PNul>     => "τους εαυτούς τους" ;
         < Ag _ Pl P3 ,CPrep P_se>     => "στους εαυτούς τους" 
         };


      Predet : Type = {s :Number =>  Gender => Case => Str} ;

     mkPredet : (s1,s2,s3,s4,s5,s6,s7,s8,s9,s10: Str)  ->   Predet  = \olos,olou,olo,oli,olis,oloi,olwn,olous,oles,ola-> 
       {  
       s = table { 
       Sg => table {
          Masc | Change  => table { Nom => olos ; Gen |CPrep P_Dat=> olou ; Acc |CPrep P_se |CPrep PNul  => olo ; Vocative => []} ;
          Fem => table { Nom => oli ; Gen |CPrep P_Dat=> olis ; Acc |CPrep P_se |CPrep PNul  => oli ;Vocative => [] } ;
          Neut  => table { Nom => olo ; Gen |CPrep P_Dat=> olou ; Acc |CPrep P_se |CPrep PNul  => olo; Vocative => [] }
          } ; 
        Pl => table {
          Masc  => table { Nom => oloi ; Gen |CPrep P_Dat=> olwn ; Acc |CPrep P_se |CPrep PNul  => olous ; Vocative => []} ;
          Fem => table { Nom => oles ; Gen |CPrep P_Dat=> olwn ; Acc |CPrep P_se |CPrep PNul  => oles ;Vocative => [] } ;
          Neut |Change => table { Nom => ola ; Gen |CPrep P_Dat=> olwn ; Acc |CPrep P_se |CPrep PNul  => ola; Vocative => [] } 
      }}; } ;
  

  
  
  

        copula : Verb = {
          s = \\a => case a of {
            VPres _ Sg P1 Active _=> "είμαι" ;
            VPres _ Sg P2 Active _=> "είσαι" ;
            VPres _ Sg P3 Active _=> "είναι" ;
            VPres _ Pl P1 Active _=> "είμαστε" ;
            VPres _ Pl P2 Active _=> "είσαστε" ;
            VPres _ Pl P3 Active _=> "είναι" ;
            VPres _ Sg P1 Passive _=> "είμαι" ;
            VPres _ Sg P2 Passive _=> "είσαι" ;
            VPres _ Sg P3 Passive _=> "είναι" ;
            VPres _ Pl P1 Passive _=> "είμαστε" ;
            VPres _ Pl P2 Passive _=> "είσαστε" ;
            VPres _ Pl P3 Passive _=> "είναι" ;
            VPast _ Sg P1 Active _=> "ήμουν" ;
            VPast _ Sg P2 Active _=> "ήσουν" ;
            VPast _ Sg P3 Active _=> "ήταν" ;
            VPast _ Pl P1 Active _=> "ήμασταν" ;
            VPast _ Pl P2 Active _=> "ήσασταν" ;
            VPast _ Pl P3 Active _=> "ήταν" ;
            VPast _ Sg P1 Passive _=> "ήμουν" ;
            VPast _ Sg P2 Passive _=> "ήσουν" ;
            VPast _ Sg P3 Passive _=> "ήταν" ;
            VPast _ Pl P1 Passive _=> "ήμασταν" ;
            VPast _ Pl P2 Passive _=> "ήσασταν" ;
            VPast _ Pl P3 Passive _=> "ήταν" ;
            
            VNonFinite  Active => "υπάρξει" ;
            VNonFinite Passive   => "υπάρξει" ;
            VImperative Perf Sg Active=> "να είσαι" ;
            VImperative Perf Pl Active=> "να είστε" ;
            VImperative Imperf Sg Active=> "να είσαι" ;
            VImperative Imperf Pl Active=> "να είστε"  ;

            VImperative _ Sg Passive =>  "να είσαι" ;
            VImperative _  Pl Passive=> "να είστε" ;

            Gerund => "όντας" ;

            Participle d  g n c => (regAdj1 "ών").s !d! g !n !c
             } 
          } ;


    Exist : Verb = {
        s = \\a => case a of {
            VPres _ Sg P1 Active _=> "υπάρχω" ;
            VPres _ Sg P2 Active _=> "υπάρχεις" ;
            VPres _ Sg P3 Active _=> "υπάρχει" ;
            VPres _ Pl P1 Active _=> "υπάρχουμε" ;
            VPres _ Pl P2 Active _=> "υπάρχετε" ;
            VPres _ Pl P3 Active _=> "υπάρχουν" ;
            VPres _ Sg P1 Passive _=> "υπάρχω" ;
            VPres _ Sg P2 Passive _=>"υπάρχει" ;
            VPres _ Sg P3 Passive _=> "υπάρχουμε" ;
            VPres _ Pl P1 Passive _=> "υπάρχουμε" ;
            VPres _ Pl P2 Passive _=> "υπάρχετε" ;
            VPres _ Pl P3 Passive _=> "υπάρχουν" ;
            VPast _ Sg P1 Active _=> "υπήρχα" ;
            VPast _ Sg P2 Active _=> "υπήρχες" ;
            VPast _ Sg P3 Active _=> "υπήρχε" ;
            VPast _ Pl P1 Active _=> "υπήρχαμε" ;
            VPast _ Pl P2 Active _=> "υπήρχατε" ;
            VPast _ Pl P3 Active _=> "υπήρχαν" ;
            VPast _ Sg P1 Passive _=> "υπήρχα" ;
            VPast _ Sg P2 Passive _=> "υπήρχες" ;
            VPast _ Sg P3 Passive _=> "υπήρχε" ;
            VPast _ Pl P1 Passive _=> "υπήρχαμε" ;
            VPast _ Pl P2 Passive _=> "υπήρχατε" ;
            VPast _ Pl P3 Passive _=> "υπήρχαν" ;
          
            VNonFinite  Active => "υπάρξει" ;
            VNonFinite  Passive => "υπάρξει" ;
            VImperative Perf Sg Active=> "να υπάρχεις" ;
            VImperative Perf Pl Active=> "να υπάρχετε" ;
            VImperative Imperf Sg Active=> "να υπάρχεις" ;
            VImperative Imperf Pl Active=> "να υπάρχετε"  ;

            VImperative _ Sg Passive=>  " " ;
            VImperative _ Pl Passive=> "" ;

            Gerund => "υπάρχοντας" ;

            Participle d  g n c => (regAdj1 "υπάρχων").s !d! g !n !c
          } 
        } ;


      auxVerb : Verb = mkAux "έχω" "είχα" "έχε" "έχετε" "έχων" ;



     mkAux  : (x1,_,_,_,_: Str) -> Verb = \Exw,eIxa, Exe, Exete, Exwn->
        let
          Ex= init Exw ;  
          eIx = init eIxa ;   
        in 
       {
        s = table {
          VPres _ Sg P1 _ _=> Exw ;
          VPres _ Sg P2 _ _=> Ex + "εις" ;
          VPres _ Sg P3 _ _=> Ex + "ει" ;
          VPres _ Pl P1 _ _=> Ex+ "ουμε" ;
          VPres _ Pl P2 _ _=> Ex + "ετε" ;
          VPres _ Pl P3 _ _=> Ex + "ουν" ;

         

          VPast _ Sg P1 _ _=> eIxa ;
          VPast _ Sg P2 _ _=> eIx + "ες" ;
          VPast _ Sg P3 _ _ => eIx + "ε" ;
          VPast _ Pl P1 _ _ => eIx + "αμε" ;
          VPast _ Pl P2 _ _ => eIx + "ατε" ;
          VPast _ Pl P3 _ _ => eIx + "αν" ;
        
         

          VNonFinite    Active    => Ex + "ει" ; 
          VNonFinite  Passive      => " " ; 

          VImperative Perf Sg Active=> Exe ;
          VImperative Perf Pl Active=> Exe ;
          VImperative Imperf Sg Active=> Exe ;
          VImperative Imperf Pl Active=> Exe  ;

          VImperative _ Sg Passive =>  " " ;
          VImperative  _ Pl Passive=> " " ;

          Gerund =>  Ex  + "οντας" ;

          Participle d  g n c => (regAdj Exwn).s !d! g !n !c
          } 
          };


        
    conjThat : Str = "οτι" ;

    ---------  Elision ---------
     vowel : Strs = strs {
        "α" ; "ά" ; "ο" ; "ό" ; "ε" ; "έ" ; "ι" ; 
        "ί" ; "η" ; "ή";
        "υ" ; "ύ" ; "ω" ; "ώ" ;
        "Α" ; "Ο" ; "Ι" ; "Ε" ; "Υ" ; "Η" ; "Ω"
        } ;

      elision : Str -> Str = \d -> d + pre {"ε" ; "'" / vowel} ;

      elisSe  = elision "σ" ;
  

    
      ---To control the stress movement  we define the stress/unstressed vowels, and convert them to their opposite-----
    stressedVowel : pattern Str = #("ά" | "ό" | "ί"| "έ" | "ή" | "ύ"| "ώ" | "εύ");

    unstressedVowel : pattern Str = #("α" | "ο" | "ι"| "ε" |"η" | "υ" | "ω" | "ευ");

    unstress : Str -> Str = \v -> case v of {
          "ά" => "α" ;
          "ό" => "ο" ;
          "ί" => "ι" ;
          "έ" => "ε" ;
          "ή" => "η" ;
          "ύ"  => "υ";
          "ώ"  => "ω" ;
          "εύ"  => "ευ" ;
         _ => v
      } ;

      stress : Str -> Str = \x -> case x of {
          "α" => "ά" ;
          "ο" => "ό" ;
          "ι" => "ί" ;
          "ε" => "έ" ;
          "η" => "ή" ;
          "υ" => "ύ" ;
          "ω" => "ώ" ;
          "ευ" => "εύ" ;
          _ => x
      } ;


      mkVerbStem : Str -> Str  = \s -> 
        case s of {
        c + v@(#stressedVowel) + x@(_ + _)  => c + unstress v + x
        } ;

}


         














































































      