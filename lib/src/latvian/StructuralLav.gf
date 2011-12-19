--# -path=.:../abstract:../common:../prelude

concrete StructuralLav of Structural = CatLav ** open
  Prelude,
  ResLav,
  ParadigmsLav,
  ParadigmsPronounsLav,
  NounLav
  in {

flags
  optimize = all ;
  coding = utf8 ;

lin
  language_title_Utt = ss "Latviešu valoda" ;

  -- TODO: kā ar loģikā lietotajiem 'visi', 'katrs' ?
  every_Det = {
    s = (\\g,c => (mkPronoun_Gend "ikviens").s ! g ! Sg ! c) ;
    n = Sg ;
    d = Indef
  } ;

  someSg_Det = {
    s = (\\g,c => (mkPronoun_Gend "kāds").s ! g ! Sg ! c) ;  --  lai atļautu arī tukšo, jāliek (\\_,_ => []) |  klāt
    n = Sg ;
    d = Indef
  } ;

  somePl_Det = {
	s = (\\g,c => (mkPronoun_Gend "kāds").s ! g ! Pl ! c) ;   --  lai atļautu arī tukšo, jāliek (\\_,_ => []) |  klāt
	n = Pl ;
	d = Indef
  } ;

  few_Det = {
	s = (\\g,c => (mkPronoun_Gend "dažs").s ! g ! Pl ! c) ;
	n = Pl ;
	d = Indef
  } ;

  many_Det = {
	s = (\\g,c => (mkPronoun_Gend "daudzs").s ! g ! Pl ! c) ;  -- 'daudzs' izlocīsies korekti uz daudzskaitļa 'daudzi'
	n = Pl ;
	d = Indef
  } ;

  much_Det = {
	s = (\\g,c => "daudz") ;  -- FIXME - ņem saistību ar ģenitīvu; kā to realizēt?
	n = Sg ;
	d = Indef
  } ;

  this_Quant = {
    s = (mkPronoun_ThisThat This).s ;
	d = Def
  } ;

  that_Quant = {
    s = (mkPronoun_ThisThat That).s ;
	d = Def
  } ;


  i_Pron = {
    s = table {
		Nom => "es";
		Gen => "manis";
		Dat => "man";
		Acc => "mani";
		Loc => "manī";
		ResLav.Voc => NON_EXISTENT
		} ;
	possessive = table {
		Masc => table {
			Sg => table {
				Nom => "mans";
				Gen => "mana";
				Dat => "manam";
				Acc => "manu";
				Loc => "manā";
				ResLav.Voc => "mans"
			};
			Pl => table {
				Nom => "mani";
				Gen => "manu";
				Dat => "maniem";
				Acc => "manus";
				Loc => "manos";
				ResLav.Voc => "mani"
			}
		} ;
		Fem => table {
			Sg => table {
				Nom => "mana";
				Gen => "manas";
				Dat => "manai";
				Acc => "manu";
				Loc => "manā";
				ResLav.Voc => "mana"
			};
			Pl => table {
				Nom => "manas";
				Gen => "manu";
				Dat => "manām";
				Acc => "manas";
				Loc => "manās";
				ResLav.Voc => "manas"
			}
		}
	} ;
	a = AgP1 Sg ;
  } ;

  we_Pron = {
    s = table {
		Nom => "mēs";
		Gen => "mūsu";
		Dat => "mums";
		Acc => "mūs";
		Loc => "mūsos";
		ResLav.Voc => NON_EXISTENT
		} ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "mūsu"
			}
		}
	} ;
	a = AgP1 Pl ;
  } ;

  youSg_Pron = {
    s = table {
		Nom => "tu";
		Gen => "tevis";
		Dat => "tev";
		Acc => "tevi";
		Loc => "tevī";
		ResLav.Voc => "tu"
		} ;
	possessive = table {
		Masc => table {
			Sg => table {
				Nom => "tavs";
				Gen => "tava";
				Dat => "tavam";
				Acc => "tavu";
				Loc => "tavā"				;
				ResLav.Voc => "tavs"
			};
			Pl => table {
				Nom => "tavi";
				Gen => "tavu";
				Dat => "taviem";
				Acc => "tavus";
				Loc => "tavos";
				ResLav.Voc => "tavi"
			}
		} ;
		Fem => table {
			Sg => table {
				Nom => "tava";
				Gen => "tavas";
				Dat => "tavai";
				Acc => "tavu";
				Loc => "tavā";
				ResLav.Voc => "tava"
			};
			Pl => table {
				Nom => "tavas";
				Gen => "tavu";
				Dat => "tavām";
				Acc => "tavas";
				Loc => "tavās";
				ResLav.Voc => "tavas"
			}
		}
	} ;
	a = AgP2 Sg ;
  } ;

  youPl_Pron = {
    s = table {
		Nom => "jūs";
		Gen => "jūsu";
		Dat => "jums";
		Acc => "jūs";
		Loc => "jūsos";
		ResLav.Voc => "jūs"
		} ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "jūsu"
			}
		}
	} ;
	a = AgP2 Pl ;
  } ;

  youPol_Pron = {
    s = table {
		Nom => "jūs";
		Gen => "jūsu";
		Dat => "jums";
		Acc => "jūs";
		Loc => "jūsos";
		ResLav.Voc => "jūs"
		} ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "jūsu"
			}
		}
	} ;
	a = AgP2 Pl ;
  } ;

  he_Pron = {
    s = (\\c => (mkPronoun_Gend "viņš").s ! Masc ! Sg ! c) ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "viņa"
			}
		}
	} ;
	a = AgP3 Sg Masc ;
  } ;

  she_Pron = {
    s = (\\c => (mkPronoun_Gend "viņš").s ! Fem ! Sg ! c) ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "viņas"
			}
		}
	} ;
	a = AgP3 Sg Fem ;
  } ;

  they_Pron = {
    s = (\\c => (mkPronoun_Gend "viņš").s ! Masc ! Pl ! c) ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "viņu"
			}
		}
	} ;
	a = AgP3 Pl Masc ;
  } |
  {
    s = (\\c => (mkPronoun_Gend "viņš").s ! Fem ! Pl ! c) ;
	possessive = table {
		_ => table {
			_ => table {
				_ => "viņu"
			}
		}
	} ;
	a = AgP3 Pl Fem ;
  } ;

  it_Pron = {
	s = \\c => (mkPronoun_ThisThat That).s ! Masc ! Sg ! c;
	possessive = table { _ => table { _ => table { _ => "tā" }}};
	a = AgP3 Sg Masc
  } | {
  	s = \\c => (mkPronoun_ThisThat That).s ! Fem ! Sg ! c;
	possessive = table { _ => table { _ => table { _ => "tās" }}};
	a = AgP3 Sg Fem
  };

  -- manuprāt prievārdi tomēr ir valodas-specifiski un nebūtu tieši 1-pret-1 jātulko
  above_Prep = mkPrep "virs" Gen Dat;
  after_Prep = mkPrep "pēc" Gen Dat;
  before_Prep = mkPrep "pirms" Gen Dat;
  behind_Prep = mkPrep "aiz" Gen Dat;
  between_Prep = mkPrep "starp" Acc Dat;
  for_Prep = mkPrep "priekš" Gen Dat;
  from_Prep = mkPrep "no" Gen Dat;
  on_Prep = mkPrep "uz" Gen Dat;
  with_Prep = mkPrep "ar" Acc Dat; -- ar sievu, ar sievām
  in_Prep = mkPrep Loc ;
  to_Prep = mkPrep "līdz" Dat Dat; --FIXME - ļoti dažādi tulkojas
  possess_Prep = mkPrep Gen ; --FIXME - reku vajadzētu vārdu secību otrādi, ka pirms paskaidrojamā vārda likt
  under_Prep = mkPrep "zem" Gen Dat;
  with_Prep = mkPrep "ar" Acc Dat;
  without_Prep = mkPrep "bez" Gen Dat;
  by8agent_Prep = nom_Prep;   --- A was attacked by B -> A-Dat uzbruka B-Nom
  by8means_Prep = mkPrep "ar" Acc Dat;
  during_Prep = mkPrep "laikā" Gen Gen; --FIXME nevaru saprast. laikam postfix 'X laikā' jāliek
  in8front_Prep = mkPrep "priekšā" Dat Dat;
  part_Prep = mkPrep Gen ; --FIXME - reku vajadzētu vārdu secību otrādi, ka pirms paskaidrojamā vārda likt
  through_Prep = mkPrep "cauri" Dat Dat;
  except_Prep = mkPrep "izņemot" Acc Acc;

  very_AdA = mkAdA "ļoti" ;
  almost_AdA = mkAdA "gandrīz" ;
  so_AdA = mkAdA "tik" ;
  too_AdA = mkAdA "pārāk" ;

  and_Conj = mkConj "un" ;
  or_Conj = mkConj "vai" Sg ;
  if_then_Conj = mkConj "ja" "tad";

  but_PConj = ss "bet" ;
  otherwise_PConj = ss "tomēr" ; --?
  therefore_PConj = ss "tātad" ; --?

  more_CAdv = (mkCAdv [] "nekā" Compar) | (mkCAdv "vairāk" "nekā" Posit);
  less_CAdv = mkCAdv "mazāk" "nekā" Posit;
  as_CAdv = mkCAdv "tikpat" "kā" Posit;

  here_Adv = mkAdv "šeit" ;
  there_Adv = mkAdv "tur" ;
  everywhere_Adv = mkAdv "visur" ;
  here7to_Adv = mkAdv ["uz šejieni"] ;
  here7from_Adv = mkAdv ["no šejienes"] ;
  there7to_Adv = mkAdv "uz turieni" ;
  there7from_Adv = mkAdv "no turienes";
  somewhere_Adv = mkAdv "kaut kur" ;
  quite_Adv = mkAdv "diezgan" ;

  both7and_DConj = mkConj "gan" ("," ++ "gan"); --FIXME - komati nav tā kā vajag
  either7or_DConj = mkConj ("vai" ++ "nu") ("," ++ "vai") Sg ; --FIXME - komati nav tā kā vajag

  want_VV = mkVV (mkV "gribēt" third_conjugation) ;

  whoSg_IP = {
	s = table {
		Nom => "kurš"; -- FIXME - Fem?
		Gen => "kura";
		Dat => "kuram";
		Acc => "kuru";
		Loc => "kurā";
		ResLav.Voc => NON_EXISTENT
	};
	n = Sg
  };
  whoPl_IP = {
	s = table {
		Nom => "kuri";
		Gen => "kuru";
		Dat => "kuriem";
		Acc => "kurus";
		Loc => "kuros";
		ResLav.Voc => NON_EXISTENT
	};
	n = Pl
  };
  whatSg_IP = {
	s = table {
		Nom => "kas"; -- FIXME - Fem? standarta locīšana?
		Gen => "kā";
		Dat => "kam";
		Acc => "ko";
		Loc => "kur";
		ResLav.Voc => NON_EXISTENT
	};
	n = Sg
  };
  whatPl_IP = {
	s = table {
		Nom => "kas"; -- FIXME - Fem? standarta locīšana?
		Gen => "kā";
		Dat => "kam";
		Acc => "ko";
		Loc => "kur";
		ResLav.Voc => NON_EXISTENT
	};
	n = Pl
  };

  why_IAdv = ss "kāpēc" ;
  how_IAdv = ss "kā" ;
  how8much_IAdv = ss "cik daudz" ;
  when_IAdv = ss "kad" ;
  where_IAdv = ss "kur" ;

  which_IQuant = {s = table {
		Masc => table { Sg => "kurš"; Pl => "kuri"};
		Fem => table { Sg => "kura"; Pl => "kuras"}
	}
  } ;

  when_Subj = ss "kad" ;
  although_Subj = ss "kaut arī" ;
  because_Subj = ss "jo" ;
  if_Subj = ss "ja" ;
  that_Subj = ss "ka" ; -- ja pareizi saprotu šo konkrēto 'that' pielietojumu

  all_Predet = { s = table {
	Masc => "visi";
	Fem => "visas"
	}
  };
  only_Predet = { s = table { _ => "tikai"} };
  most_Predet = { s = table { _ => "vairums"} };

  yes_Utt = ss "jā" ;
  please_Voc = ss "lūdzu" ;

  almost_AdN = mkAdN "gandrīz" ;
  at_least_AdN = mkAdN "vismaz" ;
  at_most_AdN = mkAdN "ne vairāk kā" ;

  always_AdV = mkAdV "vienmēr" ;


  how8many_IDet = { s = table { _ => "cik daudz"}; n = Sg }; --TODO jātestē kā to pielieto un vai nevajag vēl kaut ko


  everybody_NP = DetCN emptyPl_Det (UseN (mkN "visi"));
  everything_NP = DetCN emptySg_Det (UseN (mkN "viss"));
  nobody_NP = DetCN emptySg_Det (UseN (mkN "neviens"));
  nothing_NP = DetCN emptySg_Det (UseN (mkN "nekas"));
  somebody_NP = DetCN emptySg_Det (UseN (mkN "kāds"));
  something_NP = DetCN emptySg_Det (UseN (mkN "kaut kas"));

oper
  reflPron : Case => Str = table {
	Nom => NON_EXISTENT;
	Gen => "sevis";
	Dat => "sev";
	Acc => "sevi";
	Loc => "sevī";
	ResLav.Voc => NON_EXISTENT
  } ;

  lai_Subj = ss "lai" ;
  kameer_Subj = ss "kamēr" ;

  emptyPl_Det = {
	s:Gender => Case => Str = \\_,_ => [];
	n = Pl ;
	d = Indef
  } ;
  emptySg_Det = {
	s:Gender => Case => Str = \\_,_ => [];
	n = Sg ;
	d = Indef
  } ;

  no_Utt = ss "nē" ;

{-
  can8know_VV, can_VV = {
    s = table {
      VVF VInf => ["be able to"] ;
      VVF VPres => "can" ;
      VVF VPPart => ["been able to"] ;
      VVF VPresPart => ["being able to"] ;
      VVF VPast => "could" ;      --# notpresent
      VVPastNeg => "couldn't" ;   --# notpresent
      VVPresNeg => "can't"
      } ;
    isAux = True
    } ;
  must_VV = {
    s = table {
      VVF VInf => ["have to"] ;
      VVF VPres => "must" ;
      VVF VPPart => ["had to"] ;
      VVF VPresPart => ["having to"] ;
      VVF VPast => ["had to"] ;      --# notpresent
      VVPastNeg => ["hadn't to"] ;      --# notpresent
      VVPresNeg => "mustn't"
      } ;
    isAux = True
    } ;

  not_Predet = {s = "not" ; lock_Predet = <>} ;
  no_Quant = mkQuant "no" "no" "none" "none" ;

  have_V2 = dirV2 (mk5V "have" "has" "had" "had" "having") ;

-}
}

