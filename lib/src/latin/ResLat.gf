--# -path=.:../abstract:../common:../prelude

--1 Latin auxiliary operations.

resource ResLat = ParamX ** open Prelude,TenseX in {

param
  Case = Nom | Acc | Gen | Dat | Abl | Voc ;
  Gender = Masc | Fem | Neutr ;
--  Degree = DPos | DComp | DSup ;

  oper
    consonant : pattern Str = #( "p" | "b" | "f" | "v" | "m" | "t" | "d" | "s" | "z" | "n" | "r" | "c" | "g" | "l" | "q" | "qu" | "h" );

    Noun : Type = {s : Number => Case => Str ; g : Gender} ;
    NounPhrase : Type = 
      {
	s : Case => Str ; 
	g : Gender ; 
	n : Number ; 
	p : Person ;
      } ;
  param
    Order = SVO | VSO | VOS | OSV | OVS | SOV ; 
  param
    Agr = Ag Gender Number Case ; -- Agreement for NP et al.
  oper
    Adjective : Type = {
      s : Degree => Agr => Str ; 
--      comp_adv : Str ; 
--      super_adv : Str 
      } ;
    ComplexNoun : Type = 
    {
      s : Number => Case => Str ; 
      g : Gender ;
      preap : {s : Agr => Str } ;
      postap : {s : Agr => Str } ;
    } ;
-- nouns
  useCNasN : ComplexNoun -> Noun = \cn ->
    {
      s = cn.s ;
      g = cn.g ;
    } ;

  pluralN : Noun -> Noun = \n ->
    { 
      s = table {
	Pl => n.s ! Pl ;
	Sg => \\_ => nonExist -- no singular forms
	};
      g = n.g ;
      preap = n.preap ;
      postap = n.postap ;
    };
  
  mkNoun : (n1,_,_,_,_,_,_,_,_,n10 : Str) -> Gender -> Noun = 
    \sn,sa,sg,sd,sab,sv,pn,pa,pg,pd,g -> {
      s = table {
	Sg => table {
          Nom => sn ;
          Acc => sa ;
          Gen => sg ;
          Dat => sd ;
          Abl => sab ;
          Voc => sv
          } ;
	Pl => table {
          Nom | Voc => pn ;
          Acc => pa ;
          Gen => pg ;
          Dat | Abl => pd
          }
	} ;
      g = g
    } ;
  
-- to change the default gender

  nounWithGen : Gender -> Noun -> Noun = \g,n ->
    {s = n.s ; g = g} ;

  regNP : (_,_,_,_,_,_ : Str) -> Gender -> Number -> NounPhrase = 
    \nom,acc,gen,dat,abl,voc,g,n ->
    {
      s = table Case [ nom ; acc ; gen ; dat ; abl ; voc ] ;
      g = g ;
      n = n ;
      p = P3 
    } ;

  emptyNP : NounPhrase = { s = \\_ => ""; g = Masc; n = Sg; p = P1 }; 
-- also used for adjectives and so on

-- adjectives

  mkAdjective : (_,_,_ : Noun) -> 
    ( (Agr => Str) * Str ) -> 
    ( (Agr => Str) * Str ) -> Adjective = 
    \bonus,bona,bonum,melior,optimus ->
    {
      s = table {
	Posit => table {
	  Ag Masc  n c => bonus.s ! n ! c ;
	  Ag Fem   n c => bona.s  ! n ! c ;
	  Ag Neutr n c => bonum.s ! n ! c 
	  } ;
	Compar => melior.p1 ;
	Superl => optimus.p1 
	} ;
      comp_adv = melior.p2 ;
      super_adv = optimus.p2
    } ;


  noun3adj : Str -> Str -> Gender -> Noun = \audax,audacis,g ->
    let 
      audac   = Predef.tk 2 audacis ;
      audacem = case g of {Neutr => audax ; _ => audac + "em"} ;
      audaces = case g of {Neutr => audac +"ia" ; _ => audac + "es"} ;
      audaci  = audac + "i" ;
    in
    mkNoun
      audax audacem (audac + "is") audaci audaci audax
      audaces audaces (audac + "ium") (audac + "ibus") 
      g ;


  emptyAdj : Adjective = 
    { s = \\_,_ => "" ; comp_adv = "" ; super_adv = "" } ; 

-- verbs

param 
  VActForm  = VAct VAnter VTense Number Person ;
  VPassForm = VPass VTense Number Person ; -- No anteriority because perfect forms are built using participle
  VInfForm  = VInfActPres | VInfActPerf Gender | VInfActFut Gender | VInfPassPres | VInfPassPerf Gender | VinfPassFut ;
  VImpForm  = VImp1 Number | VImp2 Number Person ;
  VGerund   = VGenAcc | VGenGen |VGenDat | VGenAbl ;
  VSupine   = VSupAcc | VSupAbl ;
  VPartForm = VActPres | VActFut | VPassPerf ;

  VAnter = VAnt | VSim ;
  VTense = VPres VMood | VImpf VMood | VFut ; 
  VMood  = VInd | VConj ;

  VQForm = VQTrue | VQFalse ; -- Question suffix should be added to the Verb
  
  oper
  VerbPhrase : Type = {
    fin : VActForm => VQForm => Str ;
    inf : VInfForm => Str ;
    obj : Str ;
    adj : Agr => Str
  } ;

  Verb : Type = {
    act   : VActForm => Str ;
    pass  : VPassForm => Str ;
    inf   : VInfForm => Str ;
    imp   : VImpForm => Str ;
    ger   : VGerund => Str ;
    geriv : Agr => Str ; 
    sup   : VSupine => Str ;
    part  : VPartForm =>Agr => Str ;
    } ;

  Verb2 : Type = Verb ** { c : Preposition };
  Verb3 : Type = Verb ** { c : Preposition ; c2 : Preposition };
  
  VV : Type = Verb ** { isAux : Bool } ;

  tenseToVTense : Tense -> VTense = 
    \t ->
    case t of
    {
      Pres => VPres VInd ;
      Past => VImpf VInd ;
      Fut => VFut ;
      Cond => VPres VConj -- don't know what to do
    } ;
  
  anteriorityToVAnter : Anteriority -> VAnter = 
    \a ->
    case a of
    {
      Simul => VSim ;
      Anter => VAnt
    } ;

  useVV : VV -> Verb = \vv ->
    {
      act = vv.act ;
      pass = vv.pass ;
      inf = vv.inf ;
      imp = vv.imp ;
      ger = vv.ger ;
      geriv = vv.geriv ;
      sup = vv.sup ;
      part = vv.part ;
    } ;

  useVPasV : VerbPhrase -> Verb = \vp ->
    {
      act = \\a => vp.obj ++ vp.fin ! a ! VQFalse;
      pass = \\_ => nonExist ;
      inf = \\a => vp.obj ++ vp.inf ! a ;
      imp = \\_ => nonExist ;
      ger = \\_ => nonExist ;
      geriv = \\_ => nonExist ;
      sup = \\_ => nonExist ;
      part = \\_,_ => nonExist ;
    } ;

  mkVerb : 
    (regere,reg,regi,rega,regeba,regere,rege,regi,rex,rex,rexeri,rexera,rexisse,rexeri,rect : Str) 
    -> Verb = 
    \inf_act_pres,pres_stem,pres_ind_base,pres_conj_base,impf_ind_base,impf_conj_base,fut_I_base,imp_base,
    perf_stem,perf_ind_base,perf_conj_base,pqperf_ind_base,pqperf_conj_base,fut_II_base,part_stem -> 
    let
      fill : Str * Str * Str = case pres_stem of {
	_ + ( "a" | "e" ) => < "" , "" , "" > ;
	_ + #consonant => < "e" , "u" , "i" > ;
	_ => < "e" , "u" , "" >
	} ;
    in 
    {
      act = 
	table {
          VAct VSim (VPres VInd)  Sg P1 => -- Present Indicative
	    ( case pres_ind_base of {
		_ + "a" =>  ( init pres_ind_base ) ;
		_ => pres_ind_base
		}
	    ) + "o" ; --actPresEnding Sg P1 ;
	  VAct VSim (VPres VInd)  Pl P3 => -- Present Indicative
	    pres_ind_base + fill.p2 + actPresEnding Pl P3 ;
          VAct VSim (VPres VInd)  n  p  =>  -- Present Indicative
	    pres_ind_base + fill.p3 + actPresEnding n p ;
          VAct VSim (VPres VConj) n  p  => -- Present Conjunctive
	    pres_conj_base + actPresEnding n p ; 
          VAct VSim (VImpf VInd)  n  p  => -- Imperfect Indicative
	    impf_ind_base + actPresEnding n p ; 
          VAct VSim (VImpf VConj) n  p  => -- Imperfect Conjunctive
	    impf_conj_base + actPresEnding n p ; 
          VAct VSim VFut          Sg P1 => -- Future I
	    case fut_I_base of {
	      _ + "bi" => ( init fut_I_base ) + "o" ;
	      _  => ( init fut_I_base ) + "a" + actPresEnding Sg P1 
	    } ;
	  VAct VSim VFut          Pl P3 => -- Future I
	    ( case fut_I_base of {
		_ + "bi" => ( init fut_I_base ) + "u";
		_ => fut_I_base
		} 
	    ) + actPresEnding Pl P3 ;
          VAct VSim VFut          n  p  => -- Future I
	    fut_I_base + actPresEnding n p ; 
          VAct VAnt (VPres VInd)  n  p  => -- Prefect Indicative
	    perf_ind_base + actPerfEnding n p ; 
          VAct VAnt (VPres VConj) n  p  => -- Prefect Conjunctive
	    perf_conj_base + actPresEnding n p ; 
          VAct VAnt (VImpf VInd)  n  p  => -- Plusperfect Indicative
	    pqperf_ind_base + actPresEnding n p ; 
          VAct VAnt (VImpf VConj) n  p  => -- Plusperfect Conjunctive
	    pqperf_conj_base + actPresEnding n p ; 
          VAct VAnt VFut          Sg P1 => -- Future II 
	    ( init fut_II_base ) + "o" ; 
          VAct VAnt VFut          n  p  => -- Future II 
	    fut_II_base + actPresEnding n p 
        } ;
      pass = 
	table {
	  VPass (VPres VInd)  Sg P1 => -- Present Indicative
	    ( case pres_ind_base of
		{
		  _ + "a" => (init pres_ind_base ) ;
		  _ => pres_ind_base
		}
	    )  + "o" + passPresEnding Sg P1 ;
	  VPass (VPres VInd)  Sg P2 => -- Present Indicative
	    ( case imp_base of {
		_ + #consonant => 
		  ( case pres_ind_base of {
		      _ + "i" => ( init pres_ind_base ) ;
		      _ => pres_ind_base 
		      }
		  ) + "e" ;
		_ => pres_ind_base 
		}
	    ) + passPresEnding Sg P2 ;
	  VPass (VPres VInd)  Pl P3 => -- Present Indicative
	    pres_ind_base + fill.p2 + passPresEnding Pl P3 ;
	  VPass (VPres VInd)  n  p  => -- Present Indicative
	    pres_ind_base + fill.p3 + passPresEnding n p ;
	  VPass (VPres VConj) n  p  => -- Present Conjunctive
	    pres_conj_base + passPresEnding n p ;
	  VPass (VImpf VInd)  n  p  => -- Imperfect Indicative
	    impf_ind_base + passPresEnding n p ;
	  VPass (VImpf VConj) n  p  => -- Imperfect Conjunctive
	    impf_conj_base + passPresEnding n p ;
	  VPass VFut          Sg P1 => -- Future I
	    ( case fut_I_base of {
		_ + "bi" => ( init fut_I_base ) + "o" ;
		_ => ( init fut_I_base ) + "a"
		}
	    ) + passPresEnding Sg P1 ;
	  VPass VFut          Sg P2 => -- Future I
	    ( init fut_I_base ) + "e" + passPresEnding Sg P2 ;
	  VPass VFut          Pl P3 => -- Future I
	    ( case fut_I_base of {
		_ + "bi" => ( init fut_I_base ) + "u" ;
		_ => fut_I_base
		}
	    ) + passPresEnding Pl P3 ;
	  VPass VFut          n  p  => -- Future I
	    fut_I_base + passPresEnding n p
	} ;
      inf = 
	table {
          VInfActPres      => -- Infinitive Active Present
	    inf_act_pres ;
          VInfActPerf _    => -- Infinitive Active Perfect
	    perf_stem + "isse" ;
	  VInfActFut Masc  => -- Infinitive Active Future
	    part_stem + "urum" ;
	  VInfActFut Fem   => -- Infinitive Active Future
	    part_stem + "uram" ; 
	  VInfActFut Neutr => -- Infinitive Active Future
	    part_stem + "urum" ;
	  VInfPassPres       => -- Infinitive Present Passive
	    ( init inf_act_pres ) + "i" ;
	  VInfPassPerf Masc  => -- Infinitive Perfect Passive
	    part_stem + "um" ;
	  VInfPassPerf Fem   => -- Infinitive Perfect Passive
	    part_stem + "am" ;
	  VInfPassPerf Neutr => -- Infinitive Perfect Passive
	    part_stem + "um" ;
	  VInfPassFut        => -- Infinitive Future Passive
	    part_stem + "um"
        } ;
      imp = 
	let 
	  imp_fill : Str * Str =
	    case imp_base of {
	      _ + #consonant => < "e" , "i" > ;
	      _ => < "" , "" >
	    };
	  in
	table {
	  VImp1 Sg           => -- Imperative I
	    imp_base + imp_fill.p1 ;
	  VImp1 Pl           => -- Imperative I
	    imp_base + imp_fill.p2 + "te" ;
	VImp2 Sg ( P2 | P3 ) => -- Imperative II
	  imp_base + imp_fill.p2 + "to" ;
	VImp2 Pl P2          => -- Imperative II
	  imp_base +
	  ( case imp_base of {
	      _ + #consonant => "i" ;
	      _ => fill.p3
	      }
	  ) + "tote" ;
	VImp2 Pl P3          => -- Imperative II 
	  pres_stem + fill.p2 + "nto" ;
	_ => nonExist -- No imperative form
	} ;
      ger = 
	table {
	  VGenAcc => -- Gerund
	    pres_stem + fill.p1 + "ndum" ;
	  VGenGen => -- Gerund
	    pres_stem + fill.p1 + "ndi" ;
	  VGenDat => -- Gerund
	    pres_stem + fill.p1 + "ndo" ;
	  VGenAbl => -- Gerund
	    pres_stem + fill.p1 + "ndo" 
	} ;
      geriv = 
	( mkAdjective
	    ( mkNoun ( pres_stem + fill.p1 + "ndus" ) ( pres_stem + fill.p1 + "ndum" ) ( pres_stem + fill.p1 + "ndi" ) 
		( pres_stem + fill.p1 + "ndo" ) ( pres_stem + fill.p1 + "ndo" ) ( pres_stem + fill.p1 + "nde" ) 
		( pres_stem + fill.p1 + "ndi" ) ( pres_stem + fill.p1 + "ndos" ) ( pres_stem + fill.p1 + "ndorum" ) 
		( pres_stem + fill.p1 + "ndis" ) 
		Masc )
	    ( mkNoun ( pres_stem + fill.p1 + "nda" ) ( pres_stem + fill.p1 + "ndam" ) ( pres_stem + fill.p1 + "ndae" ) 
		( pres_stem + fill.p1 + "ndae" ) ( pres_stem + fill.p1 + "nda" ) ( pres_stem + fill.p1 + "nda" ) 
		( pres_stem + fill.p1 + "ndae" ) ( pres_stem + fill.p1 + "ndas" ) (pres_stem + fill.p1 +"ndarum" ) 
		( pres_stem + fill.p1 + "ndis" ) 
		Fem )
	    ( mkNoun ( pres_stem + fill.p1 + "ndum" ) ( pres_stem + fill.p1 + "ndum" ) ( pres_stem + fill.p1 + "ndi" ) 
		( pres_stem + fill.p1 + "ndo" ) ( pres_stem + fill.p1 + "ndo" ) ( pres_stem + fill.p1 + "ndum" ) 
		( pres_stem + fill.p1 + "nda" ) ( pres_stem + fill.p1 + "nda" ) ( pres_stem + fill.p1 + "ndorum" ) 
		( pres_stem + fill.p1 + "ndis" ) 
		Neutr )
	    < \\_ => "" , "" >
	    < \\_ => "" , "" >
	).s!Posit ;
      sup = 
	table {
	  VSupAcc => -- Supin
	    part_stem + "um" ;
	  VSupAbl => -- Supin
	    part_stem + "u" 
	} ;
      part= table {
	VActPres => table {
	  Ag ( Fem | Masc ) n c => 
	    ( mkNoun ( pres_stem + fill.p1 + "ns" ) ( pres_stem + fill.p1 + "ntem" ) ( pres_stem + fill.p1 + "ntis" ) 
		( pres_stem + fill.p1 + "nti" ) ( pres_stem + fill.p1 + "nte" ) ( pres_stem + fill.p1 + "ns" ) 
		( pres_stem + fill.p1 + "ntes" ) ( pres_stem + fill.p1 + "ntes" ) ( pres_stem + fill.p1 + "ntium" ) 
		( pres_stem + fill.p1 + "ntibus" ) 
 		Masc ).s ! n ! c ;
	  Ag Neutr n c =>
	    ( mkNoun ( pres_stem + fill.p1 + "ns" ) ( pres_stem + fill.p1 + "ns" ) ( pres_stem + fill.p1 + "ntis" ) 
		( pres_stem + fill.p1 + "nti" ) ( pres_stem + fill.p1 + "nte" ) ( pres_stem + fill.p1 + "ns" ) 
		( pres_stem + fill.p1 + "ntia" ) ( pres_stem + fill.p1 + "ntia" ) ( pres_stem + fill.p1 + "ntium" ) 
		( pres_stem + fill.p1 + "ntibus" ) 
 		Masc ).s ! n ! c
	} ;
	
	VActFut => 
	  ( mkAdjective
	      ( mkNoun ( part_stem + "urus" ) ( part_stem + "urum" ) ( part_stem + "uri" ) 
		  ( part_stem + "uro" ) ( part_stem + "uro" ) ( part_stem + "ure" ) ( part_stem + "uri" ) 
		  ( part_stem + "uros" ) ( part_stem + "urorum" ) ( part_stem + "uris" ) 
		  Masc )
	      ( mkNoun ( part_stem + "ura" ) ( part_stem + "uram" ) ( part_stem + "urae" ) 
		  ( part_stem + "urae" ) ( part_stem + "ura" ) ( part_stem + "ura" )( part_stem + "urae" ) 
		  ( part_stem + "uras" ) ( part_stem +"urarum" ) ( part_stem + "uris" ) 
		  Fem )
	      ( mkNoun ( part_stem + "urum" ) ( part_stem + "urum" ) ( part_stem + "uri" ) 
		  ( part_stem + "uro" ) ( part_stem + "uro" ) ( part_stem + "urum" ) ( part_stem + "ura" ) 
		  ( part_stem + "ura" ) ( part_stem + "urorum" ) ( part_stem + "uris" ) 
		  Neutr )
	      < \\_ => "" , "" >
	      < \\_ => "" , "" >
	  ).s!Posit ;
	VPassPerf => 
	  ( mkAdjective
	      ( mkNoun ( part_stem + "us" ) ( part_stem + "um" ) ( part_stem + "i" ) ( part_stem + "o" ) 
		  ( part_stem + "o" ) ( part_stem + "e" ) ( part_stem + "i" ) ( part_stem + "os" ) 
		  ( part_stem + "orum" ) ( part_stem + "is" ) 
		  Masc )
	      ( mkNoun ( part_stem + "a" ) ( part_stem + "am" ) ( part_stem + "ae" ) ( part_stem + "ae" ) 
		  ( part_stem + "a" ) ( part_stem + "a" ) ( part_stem + "ae" ) ( part_stem + "as" ) 
		  ( part_stem + "arum" ) ( part_stem + "is" ) 
		  Fem )
	      ( mkNoun ( part_stem + "um" ) ( part_stem + "um" ) ( part_stem + "i" ) ( part_stem + "o" ) 
		( part_stem + "o" ) ( part_stem + "um" ) ( part_stem + "a" ) ( part_stem + "a" ) 
		  ( part_stem + "orum" ) ( part_stem + "is" ) 
		  Neutr ) 
	      < \\_ => "" , "" >
	      < \\_ => "" , "" >
	  ).s!Posit
	}
    } ;
 

  mkDeponent : ( sequi,sequ,sequi,sequa,sequeba,sequere,seque,sequi,secut : Str ) -> Verb =
    \inf_pres,pres_stem,pres_ind_base,pres_conj_base,impf_ind_base,impf_conj_base,fut_I_base,imp_base,part_stem -> 
    let fill : Str * Str =
	  case pres_ind_base of {
	    _ + ( "a" | "e" ) => < "" , "" >;
	    _ => < "u" , "e" > 
	  }
    in
    {
      act = 
	table {
          VAct VSim (VPres VInd)  Sg P1 => -- Present Indicative
	    ( case pres_ind_base of {
		_ + "a" =>  ( init pres_ind_base ) ;
		_ => pres_ind_base
		}
	    ) + "o" + passPresEnding Sg P1 ;
	  VAct VSim (VPres VInd)  Sg P2 => -- Present Indicative
	    ( case inf_pres of {
		_ + "ri" => pres_ind_base  ;
		_ => ( case pres_ind_base of {
			 _ + "i" => init pres_ind_base ;
			 _ => pres_ind_base
			 }
		  ) + "e"
		}
	    ) + passPresEnding Sg P2 ;
          VAct VSim (VPres VInd)  Pl P3 => -- Present Indicative
	    pres_ind_base + fill.p1 + passPresEnding Pl P3 ;
          VAct VSim (VPres VInd)  n  p  => -- Present Indicative
	    pres_ind_base +
	    ( case pres_ind_base of {
		_ + #consonant => "i" ;
		_ => ""
		}
	    ) + passPresEnding n p ;
          VAct VSim (VPres VConj) n  p  => -- Present Conjunctive
	    pres_conj_base + passPresEnding n p ; 
          VAct VSim (VImpf VInd)  n  p  => -- Imperfect Indicative
	    impf_ind_base + passPresEnding n p ;
          VAct VSim (VImpf VConj) n  p  => -- Imperfect Conjunctive
	    impf_conj_base + passPresEnding n p ;
          VAct VSim VFut          Sg P1 => -- Future I
	    (init fut_I_base ) + 
	    ( case fut_I_base of {
		_ + "bi" => "o" ;
		_ => "a" 
		}
	    ) + passPresEnding Sg P1 ;
	  VAct VSim VFut          Sg P2 => -- Future I
	    ( case fut_I_base of {
		_ + "bi" => ( init fut_I_base ) + "e" ;
		_ => fut_I_base
		}
	    ) + passPresEnding Sg P2 ;
	  VAct VSim VFut          Pl P3 => -- Future I
	    (init fut_I_base ) + 
	    ( case fut_I_base of {
		_ + "bi" => "u" ;
		_ => "e" 
		}
	    ) + passPresEnding Pl P3 ;

          VAct VSim VFut          n  p  => -- Future I
	    fut_I_base + passPresEnding n p ;
          VAct VAnt (VPres VInd)  n  p  => -- Prefect Indicative
	    nonExist ; -- Use participle
          VAct VAnt (VPres VConj) n  p  => -- Prefect Conjunctive
	    nonExist ; -- Use participle
          VAct VAnt (VImpf VInd)  n  p  => -- Plusperfect Indicative
	    nonExist ; -- Use participle
          VAct VAnt (VImpf VConj) n  p  => -- Plusperfect Conjunctive
	    nonExist ; -- Use participle
          VAct VAnt VFut          n  p  => -- Future II
	    nonExist -- Use participle
        } ;
      pass =
	\\_ => nonExist ; -- no passive forms
      inf =
	table {
          VInfActPres        => -- Infinitive Present Active
	    inf_pres ;
          VInfActPerf Masc   => -- Infinitive Perfect Active
	    part_stem + "um" ;
	  VInfActPerf Fem    => -- Infinitive Perfect Active
	    part_stem + "am" ;
	  VInfActPerf Neutr  => -- Infinitive Perfect Active
	    part_stem + "um" ;
	  VInfActFut Masc    => -- Infinitive Future Active
	    part_stem + "urum" ;
	  VInfActFut Fem     => -- Infinitive Perfect Active
	    part_stem + "uram" ; 
	  VInfActFut Neutr   => -- Infinitive Perfect Active
	    part_stem + "urum" ;
	  VInfPassPres       => -- Infinitive Present Passive
	    nonExist ; -- no passive form
	  VInfPassPerf _     => -- Infinitive Perfect Passive
	    nonExist ; -- no passive form
	  VInfPassFut        => -- Infinitive Future Passive
	    nonExist  -- no passive form
        } ;
      imp = 
	table {
	  VImp1 Sg             => -- Imperative I
	    ( case inf_pres of {
		_ + "ri" => imp_base ;
		_ => (init imp_base ) + "e" 
		}
	    ) + "re" ;
	  VImp1 Pl             => -- Imperative I
	    imp_base + "mini" ;
	  VImp2 Sg ( P2 | P3 ) => -- Imperative II
	    imp_base + "tor" ;
	  VImp2 Pl P2          => -- Imperative II
	    nonExist ; -- really no such form?
	  VImp2 Pl P3          => -- Imperative II
	    pres_ind_base + fill.p1 + "ntor" ;
	  _ => nonExist -- No imperative form
	} ;
      ger = 
	table {
	  VGenAcc => -- Gerund
	    pres_stem + fill.p2 + "ndum" ;
	  VGenGen => -- Gerund
	    pres_stem + fill.p2 + "ndi" ;
	  VGenDat => -- Gerund
	    pres_stem + fill.p2 + "ndo" ;
	  VGenAbl => -- Gerund
	    pres_stem + fill.p2 + "ndo" 
	} ;
      geriv =
	( mkAdjective
	    ( mkNoun ( pres_stem + fill.p2 + "ndus" ) ( pres_stem + fill.p2 + "ndum" ) 
		( pres_stem + fill.p2 + "ndi" ) ( pres_stem + fill.p2 + "ndo" ) ( pres_stem + fill.p2 + "ndo" ) 
		( pres_stem + fill.p2 + "nde" ) ( pres_stem + fill.p2 + "ndi" ) ( pres_stem + fill.p2 + "ndos" ) 
		( pres_stem + fill.p2 + "ndorum" ) ( pres_stem + fill.p2 + "ndis" ) 
		Masc )
	    ( mkNoun ( pres_stem + fill.p2 + "nda" ) ( pres_stem + fill.p2 + "ndam" ) 
		( pres_stem + fill.p2 + "ndae" ) ( pres_stem + fill.p2 + "ndae" ) ( pres_stem + fill.p2 + "nda" ) 
		      ( pres_stem + fill.p2 + "nda" ) ( pres_stem + fill.p2 + "ndae" ) ( pres_stem + fill.p2 + "ndas" ) 
		(pres_stem + fill.p2 +"ndarum" ) ( pres_stem + fill.p2 + "ndis" ) 
		Fem )
	    ( mkNoun ( pres_stem + fill.p2 + "ndum" ) ( pres_stem + fill.p2 + "ndum" ) 
		( pres_stem + fill.p2 + "ndi" ) ( pres_stem + fill.p2 + "ndo" ) ( pres_stem + fill.p2 + "ndo" ) 
		( pres_stem + fill.p2 + "ndum" ) ( pres_stem + fill.p2 + "nda" ) ( pres_stem + fill.p2 + "nda" ) 
		( pres_stem + fill.p2 + "ndorum" ) ( pres_stem + fill.p2 + "ndis" ) 
		      Neutr )
	    < \\_ => "" , "" >
	    < \\_ => "" , "" >
	).s!Posit ;
      sup = 
	table {
	  VSupAcc => -- Supin
	    part_stem + "um" ;
	  VSupAbl => -- Supin
	    part_stem + "u" 
	} ;
      -- Bayer-Lindauer 44 1
      part = table {
	VActPres =>
	  table {
	    Ag ( Fem | Masc ) n c =>
	      ( mkNoun ( pres_stem + fill.p2 + "ns" ) ( pres_stem + fill.p2 + "ntem" ) 
		  ( pres_stem + fill.p2 + "ntis" ) ( pres_stem + fill.p2 + "nti" ) ( pres_stem + fill.p2 + "nte" ) 
		  ( pres_stem + fill.p2 + "ns" ) ( pres_stem + fill.p2 + "ntes" ) ( pres_stem + fill.p2 + "ntes" ) 
		  ( pres_stem + fill.p2 + "ntium" ) ( pres_stem + fill.p2 + "ntibus" ) 
 		  Masc ).s ! n ! c ;
	    Ag Neutr n c => 
	      ( mkNoun ( pres_stem + fill.p2 + "ns" ) ( pres_stem + fill.p2 + "ns" ) 
		( pres_stem + fill.p2 + "ntis" ) ( pres_stem + fill.p2 + "nti" ) ( pres_stem + fill.p2 + "nte" ) 
		  ( pres_stem + fill.p2 + "ns" ) ( pres_stem + fill.p2 + "ntia" ) ( pres_stem + fill.p2 + "ntia" ) 
		  ( pres_stem + fill.p2 + "ntium" ) ( pres_stem + fill.p2 + "ntibus" ) 
 		  Masc ).s ! n ! c 
	  } ;
	VActFut => 
	  ( mkAdjective
	      ( mkNoun ( part_stem + "urus" ) ( part_stem + "urum" ) ( part_stem + "uri" ) 
		  ( part_stem + "uro" ) ( part_stem + "uro" ) ( part_stem + "ure" ) ( part_stem + "uri" ) 
		  ( part_stem + "uros" ) ( part_stem + "urorum" ) ( part_stem + "uris" ) 
		  Masc )
	      ( mkNoun ( part_stem + "ura" ) ( part_stem + "uram" ) ( part_stem + "urae" ) 
		  ( part_stem + "urae" ) ( part_stem + "ura" ) ( part_stem + "ura" )( part_stem + "urae" ) 
		  ( part_stem + "uras" ) ( part_stem +"urarum" ) ( part_stem + "uris" ) 
		  Fem )
	      ( mkNoun ( part_stem + "urum" ) ( part_stem + "urum" ) ( part_stem + "uri" ) 
		  ( part_stem + "uro" ) ( part_stem + "uro" ) ( part_stem + "urum" ) ( part_stem + "ura" ) 
		  ( part_stem + "ura" ) ( part_stem + "urorum" ) ( part_stem + "uris" ) 
		  Neutr )
	      < \\_ => "" , "" >
	      < \\_ => "" , "" >
	  ).s!Posit ;
	VPassPerf =>
	  ( mkAdjective
	      ( mkNoun ( part_stem + "us" ) ( part_stem + "um" ) ( part_stem + "i" ) 
		  ( part_stem + "o" ) ( part_stem + "o" ) ( part_stem + "e" ) 
		  ( part_stem + "i" ) ( part_stem + "os" ) ( part_stem + "orum" ) 
		  ( part_stem + "is" ) 
		  Masc )
	      ( mkNoun ( part_stem + "a" ) ( part_stem + "am" ) ( part_stem + "ae" ) 
		  ( part_stem + "ae" ) ( part_stem + "a" ) ( part_stem + "a" ) 
		  ( part_stem + "ae" ) ( part_stem + "as" ) ( part_stem + "arum" ) 
		  ( part_stem + "is" ) 
		  Fem )
	      ( mkNoun ( part_stem + "um" ) ( part_stem + "um" ) ( part_stem + "i" ) 
		  ( part_stem + "o" ) ( part_stem + "o" ) ( part_stem + "um" ) 
		  ( part_stem + "a" ) ( part_stem + "a" ) ( part_stem + "orum" ) 
		  ( part_stem + "is" ) 
		  Neutr ) 
	      < \\_ => "" , "" >
	      < \\_ => "" , "" >
	  ).s!Posit
	}
    } ;

  actPresEnding : Number -> Person -> Str = 
    useEndingTable <"m", "s", "t", "mus", "tis", "nt"> ;

  actPerfEnding : Number -> Person -> Str = 
    useEndingTable <"i", "isti", "it", "imus", "istis", "erunt"> ;

  passPresEnding : Number -> Person -> Str =
    useEndingTable <"r", "ris", "tur", "mur", "mini", "ntur"> ;

  passFutEnding : Str -> Number -> Person -> Str = 
    \lauda,n,p ->
    let endings : Str * Str * Str * Str * Str * Str = case lauda of {
	  ( _ + "a" ) | 
	    ( _ + "e" ) => < "bo" , "be" , "bi" , "bi" , "bi" , "bu" > ;
	  _             => < "a"  , "e"  , "e"  , "e"  , "e"  , "e"  >
	  }
    in
    (useEndingTable endings n p) + passPresEnding n p ;
    
  useEndingTable : (Str*Str*Str*Str*Str*Str) -> Number -> Person -> Str = 
    \es,n,p -> case n of {
      Sg => case p of {
        P1 => es.p1 ;
        P2 => es.p2 ;
        P3 => es.p3
        } ;
      Pl => case p of {
        P1 => es.p4 ;
        P2 => es.p5 ;
        P3 => es.p6
        }
      } ;

-- pronouns

param
  PronReflForm = PronRefl | PronNonRefl ;
  PronDropForm = PronDrop | PronNonDrop;
--  PronIndefUsage = PronSubst | PronAdj ;
--  PronIndefPol = PronPos | PronNeg ;
--  PronIndefMeaning = PronSomeone | PronCertainOne | PronEvery ;
--  PronType = PronPers PronReflForm | PronPoss PronReflForm | PronDemo | PronRelat | PronInterrog | 
--    PronIndef PronIndefUsage PronIndefPol PronIndefMeaning ;

oper
  
  Pronoun : Type = {
    pers : PronDropForm => PronReflForm => Case => Str ;
    poss : PronReflForm => Agr => Str ;
    g : Gender ;
    n : Number ;
    p : Person ;
    } ;

  pronForms = overload {
    pronForms : (_,_,_,_,_ : Str) -> Case => Str = 
      \ego,me,mei,mihi,mee -> table Case [ego ; me ; mei ; mihi ; mee ; ego] ;
    pronForms : (_,_,_,_,_,_ : Str) -> Case => Str = 
      \meus,meum,mei,meo,meoo,mi -> table Case [meus ; meum ; mei ; meo ; meoo ; mi] ;
    };
    
  createPronouns : Gender -> Number -> Person -> ( ( PronDropForm => PronReflForm => Case => Str ) * ( PronReflForm => Agr => Str ) ) = \g,n,p ->
    case <g,n,p> of {
      <_,Sg,P1> =>
  	< 
  	table { 
  	  PronDrop    => \\_,_ => "" ;  
  	  PronNonDrop => \\_ => pronForms "ego" "me" "mei" "mihi" "me" "me"
  	},
  	\\_ => table {
  	  Ag Masc  Sg c => ( pronForms "meus" "meum" "mei" "meo" "meo" "mi" ) ! c ;
  	  Ag Masc  Pl c => ( pronForms "mei" "meos" "meorum" "meis" "meis" "mei" ) ! c ;
  	  Ag Fem   Sg c => ( pronForms "mea" "meam" "meae" "meae" "mea" "mea" ) ! c ;
   	  Ag Fem   Pl c => ( pronForms "meae" "meas" "mearum" "meis" "meis" "meae" ) ! c ;
  	  Ag Neutr Sg c => ( pronForms "meum" "meum" "mei" "meo" "meo" "meum" ) ! c ;
   	  Ag Neutr Pl c => ( pronForms "mea" "mea" "meorum" "meis" "meis" "mea" ) ! c
  	}
  	> ;
      <_,    Sg,P2> => 
      	< 
      	table {
      	  PronDrop => \\_,_ => "" ; 
      	  PronNonDrop => \\_ => pronForms "tu"  "te" "tui" "tibi" "te" "te" 
      	} ,
      	\\_ => table {
      	  Ag Masc  Sg c => ( pronForms "tuus" "tuum" "tui" "tuo" "tu" "tue" ) ! c ;
      	  Ag Masc  Pl c => ( pronForms "tui" "tuos" "tuorum" "tuis" "tuis" "tui" ) ! c ;
      	  Ag Fem   Sg c => ( pronForms "tua" "tuam" "tuae" "tuae" "tua" "tua" ) ! c ;
      	  Ag Fem   Pl c => ( pronForms "tuae" "tuas" "tuarum" "tuis" "tuis" "tuae" ) ! c ;
      	  Ag Neutr Sg c => ( pronForms "tuum" "tuum" "tui" "tuo" "tuo" "tuum" ) ! c ;
      	  Ag Neutr Pl c => ( pronForms "tua" "tua" "tuorum" "tuis" "tuis" "tua" ) ! c
      	}
      	> ;
      <_,    Pl,P1> => 
      	< 
      	table { 
      	  PronDrop => \\_,_ => "" ;
      	  PronNonDrop => \\_ => pronForms "nos" "nos" "nostri" "nobis" "nobis" --- nostrum
      	} , 
      	\\_ => table {
      	  Ag Masc  Sg c => ( pronForms "noster" "nostrum" "nostri" "nostro" "nostro" "noster" ) ! c ; 
      	  Ag Masc  Pl c => ( pronForms "nostri" "nostros" "nostrorum" "nostris" "nostris" "nostri" ) ! c ;
      	  Ag Fem   Sg c => ( pronForms "nostra" "nostram" "nostrae" "nostrae" "nostra" "nostra" ) ! c ;
      	  Ag Fem   Pl c => ( pronForms "nostrae" "nostras" "nostrarum" "nostris" "nostris" "nostrae" ) ! c ;
      	  Ag Neutr Sg c => ( pronForms "nostrum" "nostrum" "nostri" "nostro" "nostro" "nostrum" ) ! c ;
      	  Ag Neutr Pl c => ( pronForms "nostra" "nostra" "nostrorum" "nostris" "nostris" "nostra" ) ! c
      	}
      	> ; 
      <_,    Pl,P2> => 
      	< 
      	table {
      	  PronDrop => \\_,_ => "" ; 
      	  PronNonDrop => \\_ => pronForms "vos" "vos" "vestri" "vobis" "vobis"  --- vestrum
      	} ,
      	\\_ => table {
      	  Ag Masc  Sg c => ( pronForms "vester" "vestrum" "vestri" "vestro" "vestro" "vester" ) ! c ;
      	  Ag Masc  Pl c => ( pronForms "vestri" "vestros" "vestrorum" "vestris" "vestris" "vestri" ) ! c ;
      	  Ag Fem   Sg c => ( pronForms "vestra" "vestram" "vestrae" "vestrae" "vestra" "vestra" ) ! c ;
      	  Ag Fem   Pl c => ( pronForms "vestrae" "vestras" "vestrarum" "vestris" "vestris" "vestrae" ) ! c ;
      	  Ag Neutr Sg c => ( pronForms "vestrum" "vestrum" "vestri" "vestro" "vestro" "vestrum" ) ! c ;
      	  Ag Neutr Pl c => ( pronForms "vestra" "vestra" "vestrorum" "vestris" "vestris" "vestra" ) ! c
      	}
      	>; 
      <_,_ ,P3> => 
      	<
      	table {
      	  PronDrop => \\_,_ => "" ;
      	  PronNonDrop =>
      	    table { 
      	      PronNonRefl => 
      		case <g,n> of {
      		  <Masc ,Sg> => pronForms "is"  "eum" "eius"  "ei" "eo" ;
      		  <Fem  ,Sg> => pronForms "ea"  "eam" "eius"  "ei" "ea" ;
      		  <Neutr,Sg> => pronForms "id"  "id"  "eius"  "ei" "eo" ;
      		  <Masc ,Pl> => pronForms "ei"  "eos" "eorum" "eis" "eis" ;
      		  <Fem  ,Pl> => pronForms "eae" "eas" "earum" "eis" "eis" ;
      		  <Neutr,Pl> => pronForms "ea"  "ea"  "eorum" "eis" "eis"
      		} ;
      	      PronRefl => pronForms nonExist "se" "sui" "sibi" "se"
      	    }
      	} ,
      	table {
      	  PronNonRefl =>
      	    \\_ => nonExist ;
      	  PronRefl =>
      	    table {
      	      Ag Masc  Sg c => ( pronForms "suus" "suum" "sui" "suo" "suo" ) ! c ;
      	      Ag Masc  Pl c => ( pronForms "sui" "suos" "suorum" "suis" "suis" ) ! c ;
      	      Ag Fem   Sg c => ( pronForms "sua" "suam" "suae" "suae" "sua" ) ! c ;
      	      Ag Fem   Pl c => ( pronForms "suae" "suas" "suarum" "suis" "suis" ) ! c ;
      	      Ag Neutr Sg c => ( pronForms "suum" "suum" "sui" "suo" "suo" ) ! c ;
      	      Ag Neutr Pl c => ( pronForms "sua" "sua" "suorum" "suis" "suis" ) ! c
      	    }
      	}
      	> 
--	;
--      _ =>
--    	< \\_,_,_ => "######!" , \\_,_ => "######!" > -- should never be reached
    } ;

  mkPronoun : Gender -> Number -> Person -> Pronoun = \g,n,p ->
    let 
      -- Personal_Form * Possesive_Form
      prons : ( PronDropForm => PronReflForm => Case => Str ) * ( PronReflForm => Agr => Str ) =
      createPronouns g n p ;
    in
    {
     pers = prons.p1 ;
     poss = prons.p2 ;
     g = g ;
     n = n ;
     p = p
    } ;

-- prepositions

  Preposition : Type = {s : Str ; c : Case} ;

-- Bayer-Lindauer $149ff.
  about_P = lin Prep (mkPrep "de" Gen ) ; -- L...
  at_P = lin Prep (mkPrep "ad" Acc ) ; -- L...
  on_P = lin Prep ( mkPrep "ad" Gen ) ; -- L...
  to_P = lin Prep ( mkPrep "ad" Acc ) ; -- L...
  Gen_Prep = lin Prep ( mkPrep "" Gen ) ;
  Acc_Prep = lin Prep ( mkPrep "" Acc ) ;
  Dat_Prep = lin Prep ( mkPrep "" Dat ) ;
  Abl_Prep = lin Prep ( mkPrep "" Abl ) ;

  VPSlash = VerbPhrase ** {c2 : Preposition} ;

  predV : Verb -> VerbPhrase = \v -> {
    fin = \\a,q => v.act ! a ++ case q of { VQTrue => Prelude.BIND ++ "ne"; VQFalse => "" };
    inf = v.inf ;
    obj = [] ;
    adj = \\a => []
  } ;

  predV2 : Verb2 -> VPSlash = \v ->
    predV v ** {c2 = v.c} ;

  predV3 : Verb3 -> VPSlash = \v
    -> predV v ** {c2 = v.c2; c3 = v.c3 } ;

  appPrep : Preposition -> (Case => Str) -> Str = \c,s -> c.s ++ s ! c.c ;

  insertObj : Str -> VerbPhrase -> VerbPhrase = \obj,vp -> {
    fin = vp.fin ;
    inf = vp.inf ;
    obj = obj ++ vp.obj ;
    adj = vp.adj
  } ;

   insertObjc: Str -> VPSlash -> VPSlash = \obj,vp -> {
    fin = vp.fin ;
    inf = vp.inf ;
    obj = obj ++ vp.obj ;
    adj = vp.adj ;
    c2 = vp.c2
    } ;
    
  insertAdj : (Agr => Str) -> VerbPhrase -> VerbPhrase = \adj,vp -> {
    fin = vp.fin ;
    inf = vp.inf ;
    obj = vp.obj ;
    adj = \\a => adj ! a ++ vp.adj ! a
  } ;

  -- clauses
  Clause = {s : Tense => Anteriority => Polarity => VQForm => Order => Str} ;
  QClause = {s : Tense => Anteriority => Polarity => QForm => Str} ;

  -- The VQForm parameter defines if the ordinary verbform or the quistion form with suffix "-ne" will be used
  mkClause : NounPhrase -> VerbPhrase -> Clause = \np,vp -> {
    s = \\tense,anter,pol,vqf,order => case order of {
      SVO => np.s ! Nom ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.inf ! VInfActPres ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf ++ vp.obj ;
      VSO => negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf ++ np.s ! Nom ++ vp.obj ;
      VOS => negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf ++ vp.obj ++ np.s ! Nom ;
      OSV => vp.obj ++ np.s ! Nom ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf ;
      OVS => vp.obj ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf ++ np.s ! Nom ;
      SOV => np.s ! Nom ++ vp.obj ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ! vqf 
      } 
      -- np.s ! Nom ++ vp.obj ++ vp.adj ! np.g ! np.n ++ negation p ++ vp.fin ! VAct a t np.n np.p
    } ;

  -- questions
  mkQuestion : SS -> Clause -> QClause = \ss,cl -> {
    s = \\tense,anter,pol,form => case form of {
      QDir => ss.s ++ cl.s ! tense ! anter ! pol ! VQFalse ! OVS;
      QIndir => ss.s ++ cl.s ! tense ! anter ! pol ! VQFalse ! OSV
      }
    } ;
  
  negation : Polarity -> Str = \p -> case p of {
    Pos => [] ;   
    Neg => "non"
  } ;

-- determiners

  Determiner : Type = {
    s : Gender => Case => Str ; -- s,sp : Gender => Case => Str ; Don't know what sp is for
    n : Number
    } ;

  mkDeterminer : Adjective -> Number -> Determiner = \a,n ->
    {
      n = n ;
      s = \\g,c => a.s ! Posit ! Ag g n c ;
    } ;

  Quantifier : Type = {
    s,sp : Agr => Str ;
    } ;

  mkQuantifG : (_,_,_,_,_ : Str) -> (_,_,_,_ : Str) -> (_,_,_ : Str) -> 
    Gender => Case => Str = 
    \mn,ma,mg,md,mab, fno,fa,fg,fab, nn,ng,nab -> table {
      Masc  => pronForms mn  ma mg md mab ;
      Fem   => pronForms fno fa fg md fab ;
      Neutr => pronForms nn  nn ng md nab     
    } ;
      
  mkQuantifier : (sg,pl : Gender => Case => Str) -> Quantifier = \sg,pl ->
    let 
      ssp = 
	table {
	  Ag g Sg c => sg ! g ! c ; 
	  Ag g Pl c => pl ! g ! c
	}
    in 
    {
      s  = ssp ;
      sp = ssp 
    } ;

  hic_Quantifier = mkQuantifier
    (mkQuantifG 
       "hic" "hunc" "huius" "huic" "hoc"  "haec" "hanc" "huius" "hac"  "hoc" "huius" "hoc")
    (mkQuantifG 
       "hi" "hos" "horum" "his" "his"  "hae" "has" "harum" "his"  "haec" "horum" "his")
    ;

  ille_Quantifier = mkQuantifier
    (mkQuantifG 
       "ille" "illum" "illius" "illi" "illo"  
       "illa" "illam" "illius" "illa"  
       "illud" "illius" "illo")
    (mkQuantifG 
       "illi" "illos" "illorum" "illis" "illis"  
       "illae" "illas" "illarum" "illis"  
       "illa" "illorum" "illis")
    ;

  mkPrep : Str -> Case -> Preposition  = \s,c -> lin Preposition {s = s ; c = c} ;

  mkAdv : Str -> { s: Str } = \adv -> { s = adv } ;

param
  Unit = one | ten | hundred | thousand | ten_thousand | hundred_thousand ;

}
