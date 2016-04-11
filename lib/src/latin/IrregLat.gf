--# -path=.:prelude:../abstract:../common

concrete IrregLat of IrregLatAbs = CatLat ** open Prelude, ParadigmsLat, ResLat in {
--
--flags optimize=values ;
--

  lin
    -- Bayer-Lindauer 93 1
    be_V =
      let
	pres_stem = "s" ;
	pres_ind_base = "su" ;
	pres_conj_base = "si" ;
	impf_ind_base = "era" ;
	impf_conj_base = "esse" ;
	fut_I_base = "eri" ;
	imp_base = "es" ;
	perf_stem = "fu" ;
	perf_ind_base = "fu" ;
	perf_conj_base = "fueri" ;
	pqperf_ind_base = "fuera" ;
	pqperf_conj_base = "fuisse" ;
	fut_II_base = "fueri" ;
	part_stem = "fut" ;
	verb = mkVerb "esse" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base
    	  imp_base perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
	act = 
	  table {
    	    VAct VSim (VPres VInd)  n  p  => 
	      table Number [ table Person [ "sum" ; "es" ; "est" ] ;
    			     table Person [ "sumus" ; "estis" ; "sunt" ]
    	      ] ! n ! p ;
    	    a => verb.act ! a
	  };
	pass =
	  \\_ => nonExist ; -- no passive forms 
	inf =
	  verb.inf ;
	imp =
	  table {
	    VImp1 Sg => "es" ;
	    VImp1 Pl => "este" ;
	    VImp2 Pl P2 => "estote" ;
	    a => verb.imp ! a
	  } ;
	sup =
	  \\_ => nonExist ; -- no supin forms
	ger =
	  \\_ => nonExist ; -- no gerund forms
	geriv = 
	  \\_ => nonExist ; -- no gerundive forms
	part = table {
	  VActFut =>
	    verb.part ! VActFut ;
	  VActPres => 
	    \\_ => nonExist ; -- no such participle
	  VPassPerf =>
	    \\_ => nonExist -- no such participle
	  }
      } ;

    -- Bayer-Lindauer 93 2.2
    can_VV = 
      let
    	pres_stem = "pos" ;
    	pres_ind_base = "pos" ;
    	pres_conj_base = "possi" ;
    	impf_ind_base = "potera" ;
    	impf_conj_base = "posse" ;
    	fut_I_base = "poteri" ;
    	imp_base = "" ;
    	perf_stem = "potu" ;
    	perf_ind_base = "potu" ;
    	perf_conj_base = "potueri" ;
    	pqperf_ind_base = "potuera" ;
    	pqperf_conj_base = "potuisse" ;
    	fut_II_base = "potueri" ;
    	part_stem = "" ;
    	verb = mkVerb "posse" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base
    	  imp_base perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
    	act =
    	  table {
    	    VAct VSim (VPres VInd)  n  p  => 
	      table Number [ table Person [ "possum" ; "potes" ; "potest" ] ;
    			     table Person [ "possumus" ; "potestis" ; "possunt" ]
    	      ] ! n ! p ;
    	    a => verb.act ! a
    	  } ;
    	pass = 
    	  \\_ => nonExist ; -- no passive forms
    	inf = 
	  table {
	    VInfActFut _ => nonExist ;
	    a => verb.inf ! a
	  } ;
    	imp = 
	  \\_ => nonExist ;
    	sup = 
	  \\_ => nonExist ;
    	ger =
	  \\_ => nonExist ;
    	geriv =
	  \\_ => nonExist ;
    	part = table {
	  VActFut =>
    	    \\_ => nonExist ; -- no such participle
    	  VActPres => 
	    \\_ => nonExist ; -- no such participle
    	  VPassPerf =>
    	    \\_ => nonExist -- no such participle
	  } ;
    	isAux = False
      };

    -- Bayer-Lindauer 94
    bring_V = 
      let
    	pres_stem = "fer" ;
    	pres_ind_base = "fer" ;
    	pres_conj_base = "fera" ;
    	impf_ind_base = "fereba" ;
    	impf_conj_base = "ferre" ;
    	fut_I_base = "fere" ;
    	imp_base = "fer" ;
    	perf_stem = "tul" ;
    	perf_ind_base = "tul" ;
    	perf_conj_base = "tuleri" ;
    	pqperf_ind_base = "tulera" ;
    	pqperf_conj_base = "tulisse" ;
    	fut_II_base = "tuleri" ;
    	part_stem = "lat" ;
    	verb = mkVerb "ferre" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base
    	  imp_base perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
    	act =
	  table {
	    VAct VSim (VPres VInd) n p => 
	      table Number [ table Person [ "fero" ; "fers" ; "fert" ] ;
			     table Person [ "ferimus" ; "fertis" ; "ferunt" ] 
	      ] ! n ! p ;
	    a => verb.act ! a
	  } ;
    	pass = 
	  table {
	    VPass (VPres VInd) n p => 
	      table Number [ table Person [ "feror" ; "ferris" ; "fertur" ] ;
			     table Person [ "ferimur" ; "ferimini" ; "feruntur" ]
	      ] ! n ! p ;
	    a => verb.pass ! a
	  } ;
    	inf = 
	  verb.inf ;	  
    	imp =
	  table {
	    VImp1 n => table Number [ "fer" ; "ferte" ] ! n ;
	    VImp2 Sg ( P2 | P3 ) => "ferto" ;
	    VImp2 Pl P2 => "fertote" ;
	    a => verb.imp ! a 
	  } ; 
    	sup = 
	  verb.sup ;
    	ger =
	  verb.ger ;
    	geriv =
	  verb.geriv ;
    	part = verb.part ;
      };

    -- Bayer-Lindauer 95
    want_V = 
      let
	pres_stem = "vel" ;
	pres_ind_base = "vol" ;
	pres_conj_base = "veli" ;
	impf_ind_base = "voleba" ;
	impf_conj_base = "volle" ;
	fut_I_base = "vole" ;
	imp_base = "" ;
	perf_stem = "volu" ;
	perf_ind_base = "volu" ;
	perf_conj_base = "volueri" ;
	pqperf_ind_base = "voluera" ;
	pqperf_conj_base = "voluisse" ;
	fut_II_base = "volueri" ;
	part_stem = "volet" ;
	verb = mkVerb "velle" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base
    	  imp_base perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
	act =
	  table {
	    VAct VSim (VPres VInd)  n  p  => 
	      table Number [ table Person [ "volo" ; "vis" ; "vult" ] ;
    			     table Person [ "volumus" ; "vultis" ; "volunt" ]
    	      ] ! n ! p ;
    	    a => verb.act ! a
	  } ;
	  pass =
	    \\_ => nonExist ;
	  ger = 
	    verb.ger ;
	  geriv =
	    verb.geriv ;
	  imp = 
	    \\_ => nonExist ;
	  inf = 
	    verb.inf ;
	  part = table {
	    VActFut =>
	      \\_ => nonExist ;
	    VActPres =>
	      verb.part ! VActPres ;
	    VPassPerf =>
	      \\_ => nonExist
	    } ; 
	  sup =
	    verb.sup ;
      } ;

    -- Bayer-Lindauer 96 1
    go_V = 
      let
	pres_stem = "i" ;
	pres_ind_base = "i" ;
	pres_conj_base = "ea" ;
	impf_ind_base = "iba" ;
	impf_conj_base = "ire" ;
	fut_I_base = "ibi" ;
	imp_base = "i" ;
	perf_stem = "i" ;
	perf_ind_base = "i" ;
	perf_conj_base = "ieri" ;
	pqperf_ind_base = "iera" ;
	pqperf_conj_base = "isse" ;
	fut_II_base = "ieri" ;
	part_stem = "it" ;
	verb = mkVerb "ire" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base
    	  imp_base perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
	act =
	  table {
	    VAct VSim (VPres VInd)  n  p  => 
	      table Number [ table Person [ "eo" ; "is" ; "it" ] ;
    			     table Person [ "imus" ; "itis" ; "eunt" ]
    	      ] ! n ! p ;
	    VAct VAnt (VPres VInd)  Sg P2 => "isti" ;
	    VAct VAnt (VPres VInd)  Pl P2 => "istis" ;
    	    a => verb.act ! a
	  } ;
	pass = 
	  \\_ => nonExist; -- no passive forms
	ger = 
	  table VGerund [ "eundum" ; "eundi" ; "eundo" ; "eundo" ] ;
	geriv =
	  verb.geriv ;
	imp =
	  table {
	    VImp2 Pl P3 => "eunto" ;
	    a => verb.imp ! a
	  } ;
	inf =
	  table {
	    VInfActPerf _ => "isse" ;
	    a =>verb.inf ! a
	  };
	part = table {
	  VActFut => 
	    verb.part ! VActFut ;
	  VActPres => 
	    table {
	      Ag ( Fem | Masc ) n c =>
		( mkNoun ( "iens" ) ( "euntem" ) ( "euntis" ) 
		    ( "eunti" ) ( "eunte" ) ( "iens" ) 
		    ( "euntes" ) ( "euntes" ) ( "euntium" ) 
		    ( "euntibus" ) 
 		    Masc ).s ! n ! c ;
	      Ag Neutr n c =>
		( mkNoun ( "iens" ) ( "iens" ) ( "euntis" ) 
		    ( "eunti" ) ( "eunte" ) ( "iens" ) 
		    ( "euntia" ) ( "euntia" ) ( "euntium" ) 
		    ( "euntibus" ) 
 		    Masc ).s ! n ! c
	    } ;
	  VPassPerf => 
	    \\_ => nonExist -- no such participle
	  } ;
	sup = 
	  \\_ => nonExist -- really no such form?
      } ;

    -- Bayer-Lindauer 97
    become_V = 
      let
	pres_stem = "fi" ;
	pres_ind_base = "fi" ;
	pres_conj_base = "fia" ;
	impf_ind_base = "fieba" ;
	impf_conj_base = "fiere" ;
	fut_I_base = "fie" ;
	imp_base = "fi" ;
	perf_stem = "" ;
	perf_ind_base = "" ;
	perf_conj_base = "" ;
	pqperf_ind_base = "" ;
	pqperf_conj_base = "" ;
	fut_II_base = "" ;
	part_stem = "fact" ;

	verb = 
	  mkVerb "fieri" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
	  perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in
      {
	act = 
	  table {
	    VAct VSim (VPres VInd) Sg P1 => "fio" ;
	    VAct VAnt _            _  _  => nonExist ; -- perfect expressed by participle
	    a => verb.act ! a 
	  } ;
	pass =
	  \\_ => nonExist ; -- no passive forms
	ger =
	  \\_ => nonExist ; -- no gerund form
	geriv = 
	  \\_ => nonExist ; -- no gerundive form
	imp = 
	  verb.imp ;
	inf = 
	  table {
	    VInfActPerf _ => "factus" ;
	    VInfActFut Masc => "futurum" ;
	    VInfActFut Fem => "futura" ;
	    VInfActFut Neutr => "futurum" ;
	    a => verb.inf ! a
	  } ;
	part = table {
	  VActFut =>
	    \\_ => nonExist ; -- no such participle
	  VActPres => 
	    \\_ => nonExist ; -- no such participle
	  VPassPerf =>
	    verb.part ! VPassPerf
	  } ;
	sup = 
	  \\_ => nonExist -- no supin
      } ;

    -- Source ?
    rain_V =
      {
	act = 
	  table {
	    VAct VSim (VPres VInd) Sg P3 => "pluit" ;
	    VAct VSim (VPres VInd) Pl P3 => "pluunt" ;
	    VAct VSim (VImpf VInd) Sg P3 => "pluebat" ;
	    VAct VSim (VImpf VInd) Pl P3 => "pluebant" ;
	    VAct VSim VFut Sg P3 => "pluet" ;
	    VAct VSim VFut Pl P3 => "pluent" ;
	    VAct VAnt (VPres VInd) Sg P3 => "pluvit" ;
	    VAct VAnt (VPres VInd) Pl P3 => "pluverunt" ;
	    VAct VAnt (VImpf VInd) Sg P3 => "pluverat" ;
	    VAct VAnt (VImpf VInd) Pl P3 => "pluverat" ;
	    VAct VAnt VFut Sg P3 => "pluverit" ;
	    VAct VAnt VFut Pl P3 => "pluverint" ;
	    VAct VSim (VPres VConj) Sg P3 => "pluat" ;
	    VAct VSim (VPres VConj) Pl P3 => "pluant" ;
	    VAct VSim (VImpf VConj) Sg P3 => "plueret" ; 
	    VAct VSim (VImpf VConj) Pl P3 => "pluerent" ;
	    VAct VAnt (VPres VConj) Sg P3 => "pluverit" ;
	    VAct VAnt (VPres VConj) Pl P3 => "pluverint" ;
	    VAct VAnt (VImpf VConj) Sg P3 => "pluvisset" ;
	    VAct VAnt (VImpf VConj) Pl P3 => "pluvissent" ;
	    _ => nonExist -- no such forms
	  } ;
	pass = 
	  \\_ => nonExist ; -- no passive forms
	inf = table {
	  VInfActPres => "pluere" ;
	  VInfActPerf _ => "pluvisse" ;
	  _ => nonExist
	  } ;
	imp =
	  table {
	    VImp2 Sg ( P2 | P3 ) => "pluito" ;
	    VImp2 Pl P2 => "pluitote" ;
	    VImp2 Pl P3 => "pluunto" ;
	    _ => nonExist 
	  } ;
	ger = 
	  \\_ => nonExist ; -- no gerund forms
	geriv = 
	  \\_ => nonExist ; -- no gerundive forms
	sup = 
	  \\_ => nonExist ; -- no supin forms
	part = table { 
	  VActPres =>
	    \\_ => "pluens" ;
	  VActFut =>
	    \\_ => nonExist ; -- no such participle
	  VPassPerf =>
	    \\_ => nonExist -- no such participle
	  }
      } ;

    -- Bayer-Lindauer 98
    hate_V = 
      let  
	pres_stem = "" ;
	pres_ind_base = "" ;
	pres_conj_base = "" ;
	impf_ind_base = "" ;
	impf_conj_base = "" ;
	fut_I_base = "" ;
	imp_base = "" ;
	perf_stem = "od" ;
	perf_ind_base = "od" ;
	perf_conj_base = "oderi" ;
	pqperf_ind_base = "odera" ;
	pqperf_conj_base = "odissem" ;
	fut_II_base = "oderi" ;
	part_stem = "os" ;
	verb = 
	  mkVerb "odisse" pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
	  perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;
      in {
	act = table {
	  VAct VSim t n p => verb.act ! VAct VAnt t n p ;
	  _ => nonExist -- no such verb forms
	  } ;
	pass = \\_ => nonExist ; -- no passive forms 
	ger = \\_ => nonExist ; -- no gerund forms
	geriv = \\_ => nonExist ; -- no gerundive forms
	imp = \\_ => nonExist ; -- no imperative form
	inf = table {
	  VInfActPres => verb.inf ! VInfActPres ;
	  VInfActFut g => verb.inf ! VInfActFut g ; -- really ?
	  _ => nonExist
	  } ;
	part = table {
	  VActFut => 
	    verb.part ! VActFut ;
	  VActPres => 
	    \\_ => nonExist ; -- no such participle form
	  VPassPerf => 
	    \\_ => nonExist -- no such participle form
	  } ;
	sup = \\_ => nonExist ; -- no such supine form
      } ;
}
