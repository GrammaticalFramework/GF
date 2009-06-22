--# -path=.:../abstract:../common:../../prelude
--
----1 Arabic auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResAra = PatternsAra ** open  Prelude, Predef   in {

  flags optimize=noexpand ; coding=utf8 ;


  param     
    
    Vowel   = u | a | i ;
    Number  = Sg | Dl | Pl;
    Gender  = Masc | Fem ;
    Case    = Nom | Acc | Gen ;
    Person  = P1 | P2 | P3 ;
    Species = NoHum | Hum ;
    State   = Def | Indef | Const ;
    Mood    = Ind | Cnj | Jus ;
    Voice   = Act | Pas ;
    Tense   = Pres | Past | Fut ;
    Order   = Verbal | Nominal ;

  oper    
    
    --roots, patterns, and making words:
    
    Pattern : Type = {h, m1, m2, t : Str};
    Root    : Type = {f : Str};
    Root2   : Type = Root ** {c : Str} ;
    Root3   : Type = Root2 ** {l : Str} ;

    mkRoot3 : Str -> Root3 = \fcl ->
      let { cl = drop 2 fcl; --drop 1 fcl
	        l' = dp 2 fcl; --last fcl
		    c' = take 2 cl} in --take 1 cl
      {f = take 2 fcl; c = c'; --take 1 fcl
       l = case l' of {
         "ّ" => c';
		 _	=> l'
	     }
      };
    
    --for roots with 2 consonants (works also for assimilated strs, like fc~, 
    --because the function discards anything after the first two characters
    mkRoot2 : Str -> Root2 = \fcl ->
      let { cl = drop 2 fcl} in --drop 1 fcl
      {f = take 2 fcl; c = take 2 cl}; --take 1
    
    --opers to interdigitize (make words out of roots and patterns:

  oper
    --regular case, 3 non-weak consonants
    mkStrong : Pattern -> Root3 -> Str = \p,fcl ->
      p.h + fcl.f + p.m1 + fcl.c + p.m2 + fcl.l + p.t;
    
    mkDefective: Pattern -> Root3 -> Str = \p,fcl -> 
      p.h + fcl.f + p.m1 + fcl.c + p.t;

    mkHollow: Pattern -> Root3 -> Str = \p,fcl ->
      p.h + fcl.f + p.m1 + fcl.l + p.t;

    mkAssimilated: Pattern -> Root3 -> Str = \p,fcl ->
      p.h + fcl.c + p.m1 + fcl.l + p.t;

    -- takes a weak pattern and a triliteral root and makes
    -- a word, deducing which root consonant is weak
    mkWeak : Pattern -> Str -> Str = \pat,root ->
      let fcl = mkRoot3 root in 
      case root of {
        _ + ("و"|"ي"|"ّ") => mkDefective   pat fcl;
        _ + ("و"|"ي") + _ => mkHollow      pat fcl;
        ("و"|"ي") + _     => mkAssimilated pat fcl
      };

    mkBilit : Pattern -> Root2 -> Str = \p,fcl ->
      p.h + fcl.f + p.m1 + fcl.c + p.t;

    --takes a pattern string and root string and makes a word
    mkWord : Str -> Str -> Str  =\pS, rS ->
      case pS of {
        w@_ + "ف" + x@_ + "ع" + y@_ + "ل" + z@_ => 
          mkStrong { h = w ; m1 = x; m2 = y; t = z} (mkRoot3 rS);
        w@_ + "ف" + x@_ + "ع" + y@_ => 
          let pat = { h = w ; m1 = x; m2 = ""; t = y} in
          case <length rS : Ints 100> of {
            6 | 5 => mkWeak pat rS ; --3=>
            4 | 3 => mkBilit pat (mkRoot2 rS) ; --2=>
            _ => rS ---- AR error "expected 3--6" 
          }
      };

    --types of open classes:

    NTable = Number => State => Case => Str;

    Noun : Type = {s : NTable ; g : Gender; h : Species} ;
--    Adj  : Type = {s : Gender => NTable} ;
    Adj  : Type = {s : AForm => Str} ;
    Verb : Type = {s : VForm => Str} ;
    
  param
    VForm =
      VPerf Voice PerGenNum
      | VImpf Mood Voice PerGenNum
      | VImp Gender Number 
      | VPPart ;
    
    PerGenNum = 
      Per3 Gender Number 
      | Per2 Gender Number
      | Per1 SgPl;
    
    SgPl = Sing | Plur;
    
    AForm = 
      APosit Gender Number State Case
      | AComp State Case ;
    
    --verbal morphology
    
oper 
  
  --macro for sound verb
  --PerfAct, PerfPas, ImpfAct, ImpfPas, Imp, PPart
  verb : (_,_,_,_,_,_ : Str) -> Verb = 
    \katab,kutib,aktub,uktab,euktub,maktUb -> { 
      s = table {
        VPerf Act pgn     => katab + suffixPerf ! pgn ;
        VPerf Pas pgn     => kutib + suffixPerf ! pgn ;
        VImpf Ind Act pgn => prefixImpf!pgn + aktub + suffixImpfInd !pgn;
        VImpf Ind Pas pgn => prefixImpf!pgn + uktab + suffixImpfInd !pgn;
        VImpf m Act pgn => prefixImpf!pgn + aktub + suffixImpfCJ m ! pgn;
        VImpf m Pas pgn => prefixImpf !pgn + uktab + suffixImpfCJ m !pgn;
        VImp  g n  => euktub + suffixImpfCJ Jus ! (Per2 g n);
        VPPart     => maktUb
        } 
    } ;
  
  --affixes of sound verbs
  
  suffixPerf : PerGenNum => Str = 
    table {
      Per3 Masc Sg => "َ" ;      
      Per3 Masc Dl => "َا" ;     
      Per3 Masc Pl => "ُوا" ;  
      Per3 Fem  Sg => "َتْ" ;    
      Per3 Fem  Dl => "َتَا" ;  
      Per3 Fem  Pl => "ْنَ" ;    
      Per2 Masc Sg => "ْتَ" ;    
      Per2 _    Dl => "ْتُمَا" ;
      Per2 Masc Pl => "ْتُمْ" ;  
      Per2 Fem  Sg => "ْتِ" ;    
      Per2 Fem  Pl => "ْتُنَّ" ; 
      Per1 Sing    => "ْتُ" ;    
      Per1 Plur    => "ْنَا"
    } ;

  prefixImpf : PerGenNum => Str = 
    table {
      Per1 Sing    => "أ" ;    
      Per1 Plur    => "ن" ;
      Per3 Masc _  => "ي" ;      
      Per3 Fem  Pl => "ي" ;    
      _			=> "ت"
    } ;
  
  suffixImpfInd : PerGenNum => Str = 
    table {
      Per3	Masc Pl => "ُونَ" ;  
      Per3	Fem  Pl => "ْنَ" ;    
      Per3	g	 Dl => "َانِ" ;  
      Per2	Masc Pl => "ُونَ" ;  
      Per2 Fem  Sg => "ِينَ" ;    
      Per2	g	 Dl => "َانِ" ;  
      Per2	Fem  Pl => "ْنَ" ;    
      _			=> "ُ"
    } ;
  
  suffixImpfCJ : Mood -> PerGenNum => Str = \m ->
    table {
      Per3	Masc Pl => "ُوا" ;  
      Per3	Fem  Pl => "ْنَ" ;    
      Per3	g	 Dl => "َا" ;  
      Per2	Masc Pl => "ُوا" ;  
      Per2 Fem  Sg => "ِي" ;    
      Per2	g	 Dl => "َا" ;  
      Per2	Fem  Pl => "ْنَ" ;    
      _			=> endVowel ! m
    } ;
  
  --macro for geminate verbs: FIXME, change the misleading variable names 
  verbGeminate : (_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = 
	\xAf,xif,xyf,xuf,axAf,axaf,uxAf,uxaf,xaf,xAf',ppart ->
    let { perfPattern = patHollowPerf xAf xif xyf xuf ;
		  impfPattern = patHollowImpf axAf axaf uxAf uxaf ;
		  impPattern  = patHollowImp xaf xAf'
	} in
    { s = table {
        VPerf     v pgn => perfPattern ! v ! pgn  + suffixPerf ! pgn ;
	    VImpf Ind v pgn => prefixImpf ! pgn + impfPattern ! v ! pgn +  suffixImpfInd ! pgn ;
	    VImpf m   v pgn => prefixImpf ! pgn + impfPattern ! v ! pgn +  suffixImpfCJ m ! pgn ;
	    VImp	g	n	  =>			        impPattern ! g ! n +  suffixImpfCJ Jus ! (Per2 g n);
        VPPart => ppart
        }
    } ;
  
  --macro for hollow verbs:
  verbHollow : (_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = 
	\xAf,xif,xyf,xuf,axAf,axaf,uxAf,uxaf,xaf,xAf',ppart ->
    let { perfPattern = patHollowPerf xAf xif xyf xuf ;
		  impfPattern = patHollowImpf axAf axaf uxAf uxaf ;
		  impPattern  = patHollowImp axaf xAf' ;
          jusPattern  = patHollowJus axaf axAf uxaf uxAf ;
 	} in
    { s = table {
        VPerf     v pgn => perfPattern ! v ! pgn  + suffixPerf ! pgn ;
	    VImpf Ind v pgn => prefixImpf ! pgn + impfPattern ! v ! pgn +  suffixImpfInd ! pgn ;
	    VImpf Cnj v pgn => prefixImpf ! pgn + impfPattern ! v ! pgn +  suffixImpfCJ Cnj ! pgn ;
	    VImpf Jus v pgn => prefixImpf ! pgn + jusPattern ! v ! pgn +  suffixImpfCJ Jus ! pgn ;
	    VImp	g	n	  =>			        impPattern ! g ! n +  suffixImpfCJ Jus ! (Per2 g n);
        VPPart => ppart
        }
    } ;
  
  --macro for defective verbs:
  verbDef: (_,_,_,_,_,_,_,_,_,_,_ : Str) -> Vowel -> Verb =
    \rama,ramay,rumi,rumu,rumiy,armi,armu,urma,Irmi,Irmu,ppart,vowel ->
    let {
	  patPerf = patDefPerf rama ramay rumi rumu rumiy ;
	  patImpfAct = patDefImpfAct armi armu ;
	  patImp = patDefImp Irmi Irmu 
    } in
    { s = table {
        VPerf v pgn => patPerf ! v ! pgn + (suffixPerfDef v) ! pgn ;
	    VImpf m Act pgn => prefixImpf ! pgn + patImpfAct ! pgn + (suffixImpfDef Act vowel) ! m  ! pgn ;
	    VImpf m Pas pgn => prefixImpf ! pgn + urma + (suffixImpfDef Pas vowel) ! m  ! pgn ;
	    VImp g n =>  patImp ! g ! n + (suffixImpfDef Act vowel) ! Jus ! (Per2 g n) ;
        VPPart => ppart
        }
    } ;
  
  patDefPerf : (_,_,_,_,_ :Str) -> Voice => PerGenNum => Str = \rama,ramay,rumi,rumu,rumy ->
    table {
      Act => 
        table {
          Per3 Fem Pl => ramay ;
	      Per3 _	_  => rama ;
	      _		   => ramay
	    } ;
      Pas =>
        table {
          Per3 Masc Pl => rumu ;
	      Per3 Fem Pl => rumy ;
	      Per3 _	_  => rumi ;
	      _		   => rumy
	    }
    } ;
  
  --ignores the vowel=u case, eg "دعو"
  patDefImpfAct :  (_,_ : Str) -> PerGenNum => Str = \rmi,rmu ->
  table {
    Per3 Masc Pl => rmu ;
	Per2 Masc Pl => rmu ;
	_			 => rmi
    } ;
  
  
  patDefImp : (_,_ : Str) -> Gender => Number => Str = \rmi, rmu ->
    table {
      Masc => table {Pl => rmu ; _ => rmi} ;
      _	=> table {_ => rmi}
    } ;
  

  suffixPerfDef : Voice -> PerGenNum => Str = \v ->
    let {p3ms = 
           case v of {
		     Act => "ى" ;
		     Pas => "يَ"
		   } ;
	     ya = 
           case v of {
		     Act => "" ;
		     Pas => "يَ"
		   }
    } in
    table {
      Per3 Masc Sg => p3ms ;      
      Per3 Masc Dl => "يَا" ;     
      Per3 Masc Pl => "وْا" ;  
      Per3 Fem  Sg => ya + "تْ" ;    
      Per3 Fem  Dl => ya + "تَا" ;  
      Per3 Fem  Pl => "نَ" ;    
      Per2 Masc Sg => "تَ" ;    
      Per2 _    Dl => "تُمَا" ;
      Per2 Masc Pl => "تُمْ" ;  
      Per2 Fem  Sg => "تِ" ;    
      Per2 Fem  Pl => "تُنَّ" ; 
      Per1 Sing    => "تُ" ;    
      Per1 Plur    => "نَا"
    } ;
  
  
  suffixImpfDef : Voice -> Vowel -> Mood => PerGenNum => Str = \vc,vw ->
    let {     
      default : Mood -> Str = \m -> 
        case vc of {
          Pas => case m of {Jus => "" ; _ => "ى"} ;
          Act => case vw of {
            u => case m of {Ind => "و" ; Cnj => "وَ" ; Jus => ""} ;
            i => case m of {Ind => "ي" ; Cnj => "يَ" ; Jus => ""} ;
            a => case m of {Ind => "ى" ; Cnj => "ى" ; Jus => ""}
            }
        } 
    } in
    table {
      Ind =>
        table {
          Per3 Masc Pl => "وْنَ" ;  
          Per2 Masc Pl => "وْنَ" ;  
          Per3 g    Dl => "يَانِ" ;  
          Per2 g    Dl => "يَانِ" ;  
          Per3 Fem  Pl => "يْنَ" ;    
          Per2 Fem  _  => "يْنَ" ;    
          _            => default Ind
        } ;
      m =>
        table {
          Per3 Masc Pl => "وْا" ;  
          Per2 Masc Pl => "وْا" ;  
          Per3 g    Dl => "يَا" ;  
          Per2 g    Dl => "يَا" ;  
          Per3 Fem  Pl => "يْنَ" ;    
          Per2 Fem  Pl => "يْنَ" ;    
          Per2 Fem  Sg => "ي" ;    
          _            => default m
        }
    } ;

--now is used for the sound, assimilated (weak C1), and when C1 = hamza:

v1sound : Root3 -> Vowel -> Vowel -> Verb = 
  \fcl,vPerf,vImpf ->
  let {
    qf = {f = fcl.c ; c = fcl.l} ;
    qif = mkBilit (fvc ! vImpf) qf;
	katab = mkStrong (patV1Perf ! vPerf) fcl ;
    kutib = mkStrong fucil fcl ;		--FIXME no passive if vPerf == u
	ktub  = mkStrong (patV1Impf ! vImpf) fcl ;
	aktub = "َ" + 
      case fcl.f of {
        "و"|"ي" => qif ;
        _       => ktub
      };
    uktab = mkStrong ufcal fcl ;
	euktub = case fcl.f of {
      "؟"|"و"|"ي" => qif ;
      _   => prefixImp ! vImpf + ktub
      };
    maktUb = mkStrong mafcUl fcl 
  } in
  verb katab kutib aktub uktab euktub maktUb ;

v1hollow : Root3 -> Vowel -> Verb =
  \xwf,vowel -> 
  let {
	xAf = mkHollow fAc xwf ;
	xif = mkHollow (patHol1 ! vowel) xwf ;
	xyf = mkHollow fIc xwf ;
	xuf = mkHollow (patHol2 ! vowel) xwf ; 
	xaf = mkHollow (fvc ! vowel) xwf ;
	axaf= "َ" + xaf ; 
	uxAf= mkHollow ufAc xwf ;
	uxaf= "ُ" + xaf ;
	xAf'= mkHollow (patHol3 ! vowel) xwf ;
	axAf= "َ" + xAf';
    ppart = "مَ" + xAf' -- FIXME actually wierd anomalies happen with the a vowel.. 

  }  in verbHollow xAf xif xyf xuf axAf axaf uxAf uxaf xaf xAf' ppart ;

patHol1 : Vowel => Pattern =
  table { u => fuc ; _ => fic} ;

patHol2 : Vowel => Pattern =
  table { u => fic ; _ => fuc} ;

patHol3 : Vowel => Pattern =
  table {
    u => fUc ;
	i => fIc ;
	a => fAc
  } ;

--used in assimilated (wqf -> qif, wqc -> qac..) and hollow (qwl -> qul, xwf->xaf..)
fvc : Vowel => Pattern =
  table {
    u => fuc ;
	i => fic ;
	a => fac
  } ;


v1geminate : Str -> Vowel -> Vowel -> Verb =
  \rootStr,vPerf,vImpf -> 
  let {
	mdd = mkRoot3 rootStr ;	--fcc
	md  = mkRoot2 rootStr ;	--fc
	madd = mkBilit facc md ;
	madad = mkStrong (patGem1 ! vPerf) mdd ;
	mudd = mkBilit fucc md ;
	mudid = mkStrong fucil mdd ;
	mudd' = mkBilit (patGem2 ! vImpf) md ;
	amudd = "َ" + mudd' ;
	mdud = mkStrong (patGem3 ! vImpf) mdd ;
	amdud = "َ" + mdud ;
	umadd = "ُ" + madd ;
	umdad = "ُ" + mkStrong fcal mdd ;
	Umdud = (prefixImp ! vImpf) + mdud;
    mamdUd = mkStrong mafcUl mdd
  }  in verbGeminate madd madad mudd mudid amudd amdud umadd umdad Umdud mudd' mamdUd;

patGem1 : Vowel => Pattern =
  table {
    a => facal ;
	u => facul ;
	i => facil
  } ;

patGem2 : Vowel => Pattern =
  table {
    u => fucc ;
	a => facc ;
	i => ficc			--no such verb probably exists
  } ;

patGem3 : Vowel => Pattern =
  table {
    u => fcul ;
	a => fcal ;
	i => fcil			--no such verb probably exists
  } ;

v1defective : Root3 -> Vowel -> Verb =
	\rmy,vowel -> 
  let {
	rama = mkDefective faca rmy ;
	ramay = mkStrong facalo rmy ;	   
	rumi = mkDefective fuci rmy ;
	rumu = mkDefective fucu rmy ;
	rumiy = mkStrong fucilo rmy ;
	rmi = mkDefective (patDef1 ! vowel)  rmy ;
	armi = "َ" + rmi ;
	rmu = mkDefective (patDef2 ! vowel) rmy ;	   
	armu = "َ" + rmu ;
	urma = mkDefective ufca rmy ;
    eirmi = prefixImp ! vowel + rmi;
    eirmu = prefixImp ! vowel + rmu;
    marmiy = mkStrong mafcil rmy
  } in verbDef rama ramay rumi rumu rumiy armi armu urma eirmi eirmu marmiy vowel ;

patDef1 : Vowel => Pattern =
  table {
    u => fcu ;
	a => fca ;
	i => fci			
  } ;

patDef2 : Vowel => Pattern =
  table {
	a => fca ;			
    _ => fcu
  } ;

v2sound : Root3 -> Verb = \qsm ->
  let {
	qassam = mkStrong faccal qsm ;
    qussim = mkStrong fuccil qsm ;
	qassim  = mkStrong faccil qsm ;
    uqassim = "ُ" + qassim ;
	uqassam = "ُ" + qassam ;
    muqassam = "مُ" + qassam
  } in
  verb qassam qussim uqassim uqassam qassim muqassam;

v2defective : Root3 -> Verb = \gny ->
  let {
	ganna = mkDefective facca gny ;
	gannay = mkStrong faccalo gny ;	   
	gunni = mkDefective fucci gny ;
	gunnu = mkDefective fuccu gny ;
	gunniy = mkStrong fuccilo gny ;
    ganni = mkDefective facci gny;
    uganni = "ُ" + ganni;
    gannu = mkDefective faccu gny;
    ugannu = "ُ" + gannu;
    uganna = "ُ" + ganna;
    mugannaY = "مُ" + ganna + "ى"
  } in verbDef ganna gannay gunni gunnu gunniy uganni ugannu uganna ganni gannu mugannaY i;

v3sound : Root3 -> Verb = 
  \tbc ->
  let {
    tAbac = mkStrong fAcal tbc ;
    twbic = mkStrong fUcil tbc ;
    tAbic = mkStrong fAcil tbc ;
    utAbic  = "ُ" + tAbic ;
    utAbac = mkStrong ufAcal tbc ;
    mutAbac = "م" + utAbac  
  } in verb tAbac twbic utAbic utAbac tAbic mutAbac;

v4sound : Root3 -> Verb =
  \qnc ->
  let {
    eaqnac = mkStrong eafcal qnc;
    euqnic = mkStrong eufcil qnc;
    uqnic = mkStrong ufcil qnc;
    uqnac = mkStrong ufcal qnc;
    eaqnic = mkStrong eafcil qnc;
    muqnac = "م" + uqnac
  } in 
  verb eaqnac euqnic uqnic uqnac eaqnic muqnac;


v4defective : Root3 -> Verb = \cTy ->
  let {
	cTa = mkDefective fca cTy;
    cTu = mkDefective fcu cTy;
    cTi = mkDefective fci cTy;
    eacTa = "أَ" + cTa;
	eacTay = mkStrong eafcal cTy ;	   
    ucTi = "ُ" + cTi;
	eucTi = "أُ" + cTi;
    ucTu = "ُ" + cTu;
	eucTu = "أُ" + cTu;
	eucTiy = mkStrong eufcil cTy ;
    ucTa = "ُ" + cTa;
    eacTi = "أَ" + cTi;
    eacTu = "أَ" + cTu;
    mucTaY = "م" + ucTa +"ى"
  } in verbDef eacTa eacTay eucTi eucTu eucTiy ucTi ucTu ucTa eacTi eacTu mucTaY i;

v5sound : Root3 -> Verb = 
  \nfs ->
  let {
    tanaffas = mkStrong tafaccal nfs ;
    tunuffis = mkStrong tufuccil nfs ;
    atanaffas  = "َ" + tanaffas ;
    utanaffas = "ُ" + tanaffas ;
    mutanaffas = "م" + tanaffas
  } in verb tanaffas tunuffis atanaffas utanaffas tanaffas mutanaffas;

v6sound : Root3 -> Verb = 
  \fqm ->
  let {
    tafAqam = mkStrong tafAcal fqm ;
    tufUqim = mkStrong tufUcil fqm ;
    atafAqam = "َ" + tafAqam ;
    utafAqam = "ُ" + tafAqam ;
    mutafAqam = "م" + utafAqam
  } in verb tafAqam tufUqim atafAqam utafAqam tafAqam mutafAqam;

v8sound : Root3 -> Verb = 
  \rbT ->
  let {
    rtabiT = mkStrong ftacil rbT ;
    rtabaT = mkStrong ftacal rbT ;
    eirtabaT = "إِ" + rtabaT ;
    eurtubiT = mkStrong euftucil rbT ;
    artabiT = "َ" + rtabiT ;
    urtabaT  = "ُ" + rtabaT ;
    eirtabiT = "إِ" + rtabiT ;
    murtabaT =  "م" + urtabaT
  } in verb eirtabaT eurtubiT artabiT urtabaT eirtabiT murtabaT;

patV1Perf : Vowel => Pattern =
  table {
    a => facal ; --katab
	u => facul ; --Hasun
	i => facil   --rabiH
  } ;

patV1Impf : Vowel => Pattern =
  table {
    u => fcul ;  --ktub
	a => fcal ;  --rbaH
	i => fcil    --Hsin
  } ;

endVowel : Mood => Str =
  table {
	Cnj => "َ" ;
	Jus => "ْ" ;
	Ind => ""
  } ;

prefixImp : Vowel => Str = 
  table {
    u => "أُ" ;
	_ => "إِ"
  } ;

patHollowPerf : (_,_,_,_ :Str) -> Voice => PerGenNum => Str = \xAf,xif,xyf,xuf ->
  table {
    Act => 
      table {
        Per3 Fem Pl => xif ;
	    Per3 _	_  => xAf ;
	    _		   => xif
	  } ;
    Pas =>
      table {
        Per3 Fem Pl => xuf ;
	    Per3 _	_  => xyf ;
	    _		   => xuf
	  }
  } ;

--this is the pattern of imperfect  hollow (ind & conj) and geminate verbs (all)
patHollowImpf : (_,_,_,_ :Str) -> Voice => PerGenNum => Str = \axAf,axaf,uxAf,uxaf ->
  table {
    Act => 
      table {
	    Per3 Fem Pl => axaf ;
	    Per2 Fem Pl => axaf ;
	    _		=> axAf
	  } ;
    Pas =>
      table {
	    Per3 Fem Pl => uxaf ;
	    Per2 Fem Pl => uxaf ;
	    _		=> uxAf
	  }
  } ;

patHollowJus : (_,_,_,_ : Str) -> Voice => PerGenNum => Str =\axaf,axAf,uxaf,uxAf->
  table {
    Act => 
      table {
        Per3 g Sg    => axaf ;
        Per3 Fem Pl  => axaf;
        Per2 Fem Pl  => axaf;
        Per2 Masc Sg => axaf;
        Per1 _       => axaf;
	    _		     => axAf
	  } ;
    Pas => 
      table {
        Per3 g Sg    => uxaf ;
        Per3 Fem Pl  => uxaf;
        Per2 Fem Pl  => uxaf;
        Per2 Masc Sg => uxaf;
        Per1 _       => uxaf;
	    _		     => uxAf
	  } 
  } ;
    


patHollowImp : (_,_ :Str) -> Gender => Number => Str =\xaf,xAf ->
  table {
    Masc => table { Sg => xaf ; _ => xAf} ;
    Fem  => table { Pl => xaf ; _ => xAf}
  } ;

--Nominal Morphology

--takes the adjective lemma and gives the Posit table
  positAdj : Str -> Gender => NTable  =
    \kabIr ->
    let kabIra = kabIr + "َة" in 
    table {
      Masc => sndm kabIr;
      Fem  => sndf kabIra
    };
  
  clr : Str -> Str -> Str -> AForm => Str =
    \aHmar,HamrA',Humr ->
    table {
      APosit Masc n d c => case n of {
        Sg => indeclN aHmar ! d ! c ;
        Dl => dual aHmar ! d ! c ;
        Pl => sing Humr ! d ! c
        };
      APosit Fem n d c => case n of {
        Sg => indeclN HamrA'  ! d ! c;
        Dl => dual ((tk 2 HamrA') + "و") ! d ! c;
        Pl => sing Humr ! d ! c
        };
      AComp d c => indeclN aHmar ! d ! c 
    };
  
  -- indeclinable nominal word (mamnuu3 mina S-Sarf)
  indeclN : Str -> State => Case => Str =
    \aHmar -> \\s,c => Al!s + aHmar + indecl!c;

    -- takes 2 words, singular and broken plural, and gives the 
    -- complete noun inflection table
    reg : Str -> Str -> NTable =
      \kitAb,kutub ->
      table {
        Sg => sing kitAb ;
        Dl => dual kitAb ;
        Pl => sing kutub 
      };
    
    --takes the sound noun in singular and gives the 
    --complete noun inflection table of sound feminine plural
    sndf : Str -> NTable  =
      \lawHa ->
      table {
        Sg => sing lawHa ;
        Dl => dual lawHa ;
        Pl => plurF lawHa 
      };
    
    --takes the sound noun in singular and gives the 
    --complete inflection table of sound masculine plural nominals
    sndm : Str -> NTable =
      \muzAric ->
      table {
        Sg => sing muzAric ;
        Dl => dual muzAric ;
        Pl => plurM muzAric 
      };
    
    -- takes a singular or broken plural word and tests the ending to
    -- determine the declension and gives the corresponding inf table
    sing : Str -> State => Case => Str = 
      \word -> 
      case word of {
         lemma + "ِي" => \\s,c => Al ! s + lemma + dec2sg ! s ! c ;
        _ + ("ا"|"ى") => \\s,c => Al ! s + word + dec3sg ! s ! c ;
        _                 => \\s,c => Al ! s + word + dec1sg ! s ! c 
      };

    -- takes a singular word and tests the ending to
    -- determine the declension and gives the corresponding dual inf table
    dual : Str -> State => Case => Str = 
      \caSaA -> 
      case caSaA of {
        lemma + ("ا"|"ى") => \\s,c => Al ! s + lemma + "ي" + dl ! s ! c ;
        _                 => \\s,c => Al ! s + caSaA + dl ! s ! c 
      };

    -- takes a singular word and gives the corresponding sound 
    --plural feminine table
    plurF : Str -> State => Case => Str = 
      \kalima -> 
      \\s,c => Al ! s + (mkAt kalima) + f_pl ! s ! c ;

    -- takes a singular word and gives the corresponding sound 
    --plural masculine table. FIXME: consider declension 3
    plurM : Str -> State => Case => Str = 
      \mucallim -> 
      \\s,c => Al ! s + mucallim + m_pl ! s ! c ;


    -- to add the Al prefix for Definite words
    Al : State => Str = 
      table {
        Def => "ال";
        _   => ""
      };

    --declection 1 (strong ending) of the singular or broken plural words
    dec1sg : State => Case => Str = 
      table {
        Indef => 
          table {
            Nom => "ٌ";
            Acc => "ً";
            Gen => "ٍ"
          };
        _ => 
          table { --think of ?axU, ?axA, (the five nouns)
            Nom => "ُ";
            Acc => "َ";
            Gen => "ِ"
          }
      };

    --indeclinables (mamnuu3 mina S-Sarf) 
    indecl :  Case => Str =
      table {
        Nom => "ُ";
        _ => "َ"
      };
        

    --declection 2 (ends in yaa') 
    dec2sg : State => Case => Str = 
      table {
        Indef => 
          table {
            Acc => "ِياً";
            _ => "ٍ"
          };
        _ => 
          table { 
            Acc => "ِيَ";
            _ => "ِي"
          }
      };

    --declention 3 (ending in alif)
    dec3sg : State => Case => Str = 
      table {
        Indef => 
          table {
            _ => "ً"
          };
        _ => 
          table { 
            _ => ""
          }
      };

    
    --dual suffixes
    dl : State => Case => Str =
      table {
        Const =>
          table {
            Nom => "َا";
            _   => "َي"
          };
        _ =>
          table {
            Nom => "َانِ";
            _   => "َينِ"
          }
      };

    --sound mascualine plural suffixes
    m_pl : State => Case => Str =
      table {
        Const =>
          table {
            Nom => "ُو";
            _   => "ِي"
          };
        _ =>
          table {
            Nom => "ُونَ";
            _   => "ِينَ"
          }
      };

    --sound feminine plural suffixes
    f_pl : State => Case => Str =
      table {
        Indef =>
          table {
            Nom => "ٌ";
            _   => "ٍ"
          };
        _ =>
          table {
            Nom => "ُ";
            _   => "ِ"
          }
      };

  
    mkAt : Str -> Str = \bayDo ->
      case bayDo of {
        bayD + "ة"  => bayD + "ات";
        bayD + "اء" => bayD + "اوات";
        bayD + "ى"  => bayD + "يَات";
        _           => bayDo + "ات"
      };
    

  oper
    
    sizeToNumber : Size -> Number = \s ->
      case s of {
        ThreeTen | None  => Pl;
        Two => Dl;
        _ => Sg
      } ;

    numberToSize : Number -> Size = \n ->
      case n of {
        Pl => ThreeTen;
        Dl => Two ;
        Sg => One -- or Hundreds or NonTeen
      } ;

    detGender : Gender -> Size -> Gender =
      \g,s ->
      case s of {
        ThreeTen | Teen => genPolarity ! g;
        _ => g
      };

    nounState : State -> Number -> State =
      \s,n ->
      case <s,n> of {
        <Const,Pl> => Def;   --kullu l-kutubi, bacDu l-kutubi
        <Const,Sg> => Indef; --kullu kitaabin
        <Indef,_> => Indef;  --kitaabun
        _ => Def             --Lkitaabu
      };


    --FIXME needs testing
    nounCase : Case -> Size -> State -> Case = 
      \c,size,s -> 
      case <size,s> of {
        <Teen,_> => Acc;
        <NonTeen,_> => Acc;
        <ThreeTen,_> => Gen;
        <Hundreds,_> => Gen;
        <_,Const> => Gen;
        _     => c
      };
    
    definite : State => State =
      table {
        Indef => Indef;
        _     => Def
      };

    --things like mi{aö and vlAva and >alf should be treated as Const
    --before the counted noun, so (vlAvaöN kutubK) is wrong
    toDef : State -> Size -> State =
      \s,n ->
      case <s,n> of {
        <Indef,Hundreds> => Const;
        <Indef,ThreeTen> => Const;
        _ => s 
      };

    -- in a NP, sometimes the common noun preceedes the determiner
    -- e.g. some determiners act as adjectives modifying the noun they count
    -- "the three children, two children"
    -- e.g. possesive pronouns: his book (kitaabuhu"
    cnB4det : Bool -> Bool -> Size -> State -> Bool = \isPron,isNum,s,d ->
      case <isPron,isNum,s,d> of {
        <True,_,_,_> => True;
        <_,False,_,_> => False; --non-numerals
        <_,True,_,Def> => True; --definite numbers act as adjectives
        <_,True,Two,_> => True; --numerals one and two always adjectives
        <_,True,One,_> => True; --numerals one and two always adjectives
        _ => False          
      };
    
    agrP3 : Species -> Gender -> Number -> PerGenNum= \h,g,n ->
      case <h,n> of {
        <NoHum,Pl> => Per3 Fem Sg;
        _          => Per3 g n
      };

    pgn2gn : PerGenNum -> {g : Gender; n : Number} = \pgn ->
      case pgn of {
        Per3 gn nm => {g = gn; n = nm};
        Per2 gn nm => {g = gn; n = nm};
        _ => {g = Masc; n = Sg} --randomly
      };
 

    mkIP : Str -> Number -> {s : Str ; n : Number} =
     \s,n -> {s = s ; n = n} ;

    mkOrd : (_,_ : Str) -> {s : Gender => State => Case => Str ; n : Size } =
      \aysar,yusra -> 
      { s = \\g,s,c =>
          case g of {
            Masc => (sing aysar) ! s ! c;
            Fem  => (sing yusra) ! s ! c
          };
        n = None
      };
    

  oper

    Det : Type = {
      s : Species => Gender => Case => Str ; 
      d : State; 
      n : Size; 
      isNum : Bool;
      -- for genitive pronouns (suffixes). if true, then "cn ++ det" 
      --should be used instead of "det ++ cn" when constructing the NP
      isPron : Bool 
      } ;

    Predet : Type = { 
      s : Case => Str;
      isDecl : Bool 
      };

    Agr = { pgn : PerGenNum; isPron : Bool} ;
    AAgr = { g : Gender ; n : Number} ;

    Comp : Type = {
      s : AAgr => Case => Str
      } ; 

    Obj : Type = { 
      s : Str ; 
      a : Agr
      };

    NP : Type = {
      s : Case => Str ; 
      a : Agr 
      } ;
    
    param VPForm =
        VPPerf 
      | VPImpf Mood 
      | VPImp ;

  oper

    VP : Type = { 
      s : PerGenNum => VPForm => Str;
      obj : Obj;
      pred : Comp;
      isPred : Bool; --indicates if there is a predicate (xabar)
      s2 : Str
      }; 

    predV : Verb -> VP = \v ->
      { s = \\pgn,vf => 
          let gn = pgn2gn pgn in
          case vf of {
            VPPerf => v.s ! (VPerf Act pgn);
            VPImpf m => v.s ! (VImpf m Act pgn);
            VPImp => v.s ! (VImp Masc Sg)--gn.g gn.n)
          };
        obj = {
          s = [] ; 
          a = {pgn = Per3 Masc Sg ; isPron = False} 
          }; --or anything!
        s2 = [];
        pred = { s = \\_,_ => []};
        isPred = False
      };

    
    -- in verbal sentences, the verb agrees with the subject 
    -- in Gender but not in number
    verbalAgr : PerGenNum -> PerGenNum = \pgn ->
      case pgn of {
        Per3 g _ => Per3 g Sg;
        _        => pgn
      };

    insertObj : NP -> VP -> VP = \np,vp ->
      { s = vp.s;
        obj = {s = np.s ! Acc ; a = np.a};
        s2 = vp.s2;
        pred = vp.pred;
        isPred = vp.isPred
      };

    insertPred : {s : AAgr => Case => Str} -> VP -> VP = \p,vp ->
      { s = vp.s;
        obj = vp.obj;
        s2 = vp.s2;
        pred = p;
        isPred = True
      };

    insertStr : Str -> VP -> VP = \str,vp ->
      { s = vp.s;
        obj = vp.obj;
        s2 = str;
        pred = vp.pred;
        isPred = vp.isPred
      };

    kaan : {s : AAgr => Case => Str} -> VP = \xabar -> 
      insertPred xabar (predV (v1hollow {f = "ك"; c = "و" ; l = "ن"} u) );

  param

    Size = One | Two | ThreeTen | Teen | NonTeen | Hundreds | None ;
    DForm = unit | ten ;
    CardOrd = NCard | NOrd ;

  oper
    --digits 1, 3 - 10: take the lemmas of the card ords & in masculine 
    --form and calculates the whole table 

    regNum : Str -> Str -> 
      {s : DForm => CardOrd => Gender => State => Case => Str} = 
      \xams,xAmis ->
      let { xamsa = xams + "َة";
            xAmisa = xAmis +  "َة"} in 
      mkNum xamsa xAmis xAmisa;

    mkNum : Str -> Str -> Str ->
      {s : DForm => CardOrd => Gender => State => Case => Str} = 
      \wAhid,awwal,Ula ->
      let { wAhida = wAhid + "َة"} in
      { s= table {
          unit => table {
            NCard => table {
              Masc => \\s,c => (sing wAhid) ! s ! c ;
              --all fem are first declension:
              Fem => \\s,c => Al ! s + wAhida + dec1sg ! s ! c 
              };
            NOrd => table {
              Masc => \\s,c => Al ! s + awwal + dec1sg ! s ! c;
              Fem => \\s,c => (sing Ula) ! s ! c 
              }
            };
          ten => table {
            NCard => \\_,s,c => Al ! s + wAhid + m_pl ! Indef ! c;
            NOrd => \\_,s,c => Al ! s + awwal + m_pl ! Indef ! c
            }
          }
      };

    num3_10 : Str -> Str -> { s : DForm => CardOrd => Gender 
                                => State => Case => Str ; n : Size } =
      \xams,xAmis ->
      regNum xams xAmis ** { n = ThreeTen };

    num2 : { s : DForm => CardOrd => Gender => State => Case => Str} =
      { s = table {
          unit => table {
              NCard => table {
                Masc => \\s,c => Al ! s + "ٱِثن" + dl ! s ! c ;
                Fem => \\s,c => Al ! s + "ٱِثنَت" + dl ! s ! c 
                };
              NOrd => table {
                Masc => \\s,c => Al ! s + "ثان" + dec2sg ! s ! c ;
                Fem => \\s,c => Al ! s + "ثانِيَة" + dec1sg ! s ! c 
                }
            };
          ten => \\_,_,s,c => Al ! s + "عِشر" + m_pl ! Indef ! c
          }
      };

    num100 : State => Case => Str =
      \\s,c => Al ! s + "مِٱَة" + dec1sg ! s ! c;

    num200 : State => Case => Str =
      \\s,c => Al ! s + "مِٱَة" + dl ! s ! c ;

    num1000 : State => Case => Str =
      \\s,c => Al ! s + "أَلف" + dec1sg ! s ! c;

    num2000 : State => Case => Str =
      \\s,c => Al ! s + "أَلف" + dl ! s ! c ;

    teen : Gender => Str = 
      table {
        Masc => "عَشَرَ";
        Fem  => "عَشرَةَ"
      };

    genPolarity : Gender => Gender =
      table {
        Masc => Fem;
        Fem => Masc
      };


}
