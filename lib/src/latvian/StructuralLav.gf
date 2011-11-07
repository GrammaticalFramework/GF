concrete StructuralLav of Structural = CatLav ** 
  open MorphoLav, ResLav, ParadigmsLav, ParadigmsPronounsLav, MakeStructuralLav, Prelude in {

flags
  optimize = all ;
  coding = utf8 ; 
  
lin  
 
  every_Det = {
    s = (\\g,c => (mkPronoun_Gend "ikviens").s ! g ! Sg ! c) ;   -- TODO - kā ar loģikā lietotajiem 'visi', 'katrs' ?
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
		Voc => NON_EXISTENT
		} ;
	possessive = table {
		Masc => table {
			Sg => table {
				Nom => "mans";
				Gen => "mana";
				Dat => "manam";
				Acc => "manu";
				Loc => "manā";
				Voc => "mans"
			};
			Pl => table {
				Nom => "mani";
				Gen => "manu";
				Dat => "maniem";
				Acc => "manus";
				Loc => "manos";
				Voc => "mani"
			}
		} ;
		Fem => table {
			Sg => table {
				Nom => "mana";
				Gen => "manas";
				Dat => "manai";
				Acc => "manu";
				Loc => "manā";
				Voc => "mana"				
			};
			Pl => table {
				Nom => "manas";
				Gen => "manu";
				Dat => "manām";
				Acc => "manas";
				Loc => "manās";
				Voc => "manas"
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
		Voc => NON_EXISTENT
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
		Voc => "tu"
		} ;
	possessive = table {
		Masc => table {
			Sg => table {
				Nom => "tavs";
				Gen => "tava";
				Dat => "tavam";
				Acc => "tavu";
				Loc => "tavā"				;
				Voc => "tavs"
			};
			Pl => table {
				Nom => "tavi";
				Gen => "tavu";
				Dat => "taviem";
				Acc => "tavus";
				Loc => "tavos";
				Voc => "tavi"
			}
		} ;
		Fem => table {
			Sg => table {
				Nom => "tava";
				Gen => "tavas";
				Dat => "tavai";
				Acc => "tavu";
				Loc => "tavā";
				Voc => "tava"
			};
			Pl => table {
				Nom => "tavas";
				Gen => "tavu";
				Dat => "tavām";
				Acc => "tavas";
				Loc => "tavās";
				Voc => "tavas"
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
		Voc => "jūs"
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
		Voc => "jūs"
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
    
  very_AdA = mkAdA "ļoti" ;
  almost_AdA = mkAdA "gandrīz" ;
  so_AdA = mkAdA "tik" ;
  too_AdA = mkAdA "pārāk" ;

  and_Conj = mkConj "un" ;
  or_Conj = mkConj "vai" Sg ;

  but_PConj = ss "bet" ;
  otherwise_PConj = ss "tomēr" ; --?
  therefore_PConj = ss "tātad" ; --?
  
  more_CAdv = (mkCAdv [] "nekā" Compar) | (mkCAdv "vairāk" "nekā" Posit);  
  less_CAdv = mkCAdv "mazāk" "nekā" Posit;  
  as_CAdv = mkCAdv "tikpat" "kā" Posit;
  
  here_Adv = mkAdv "šeit" ;
  there_Adv = mkAdv "tur" ;

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
		Voc => NON_EXISTENT
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
		Voc => NON_EXISTENT
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
  
--FIXME placeholder
  by8agent_Prep = mkPrep NON_EXISTENT Nom Nom;  
  whatSg_IP = {s = \\_ => NON_EXISTENT; n= Sg};  
  
oper
  reflPron : Case => Str = table {
	Nom => NON_EXISTENT;
	Gen => "sevis";
	Dat => "sev";
	Acc => "sevi";
	Loc => "sevī";
	Voc => NON_EXISTENT
  } ;
  
  lai_Subj = ss "lai" ; 
  kameer_Subj = ss "kamēr" ; 
  
{-
  by8agent_Prep = mkPrep "by" ;
  by8means_Prep = mkPrep "by" ;
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
  during_Prep = mkPrep "during" ;
  everybody_NP = regNP "everybody" singular ;
  every_Det = mkDeterminer singular "every" ;
  everything_NP = regNP "everything" singular ;
  everywhere_Adv = mkAdv "everywhere" ;
  few_Det = mkDeterminer plural "few" ;
---  first_Ord = ss "first" ; DEPRECATED
  here7to_Adv = mkAdv ["to here"] ;
  here7from_Adv = mkAdv ["from here"] ;
  how8many_IDet = mkDeterminer plural ["how many"] ;
  in8front_Prep = mkPrep ["in front of"] ;
  many_Det = mkDeterminer plural "many" ;
  much_Det = mkDeterminer singular "much" ;
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
---b  no_Phr = ss "no" ;
  no_Utt = ss "no" ;
----  one_Quant = mkDeterminer singular "one" ; -- DEPRECATED
  part_Prep = mkPrep "of" ;
  quite_Adv = mkAdv "quite" ;
  somebody_NP = regNP "somebody" singular ;
  something_NP = regNP "something" singular ;
  somewhere_Adv = mkAdv "somewhere" ;
  that_Quant = mkQuant "that" "those" ;
  there7to_Adv = mkAdv "there" ;
  there7from_Adv = mkAdv ["from there"] ;
  this_Quant = mkQuant "this" "these" ;
  through_Prep = mkPrep "through" ;
  
  whatPl_IP = mkIP "what" "what" "what's" plural ;
  whatSg_IP = mkIP "what" "what" "what's" singular ;
---b  whichPl_IDet = mkDeterminer plural ["which"] ;
---b  whichSg_IDet = mkDeterminer singular ["which"] ;
  whoPl_IP = mkIP "who" "whom" "whose" plural ;
  whoSg_IP = mkIP "who" "whom" "whose" singular ;
  
---b  yes_Phr = ss "yes" ;

  not_Predet = {s = "not" ; lock_Predet = <>} ;
  no_Quant = mkQuant "no" "no" "none" "none" ;
  if_then_Conj = mkConj "if" "then" singular ;
  nobody_NP = regNP "nobody" singular ;
  nothing_NP = regNP "nothing" singular ;

  except_Prep = mkPrep "except" ;
  
  have_V2 = dirV2 (mk5V "have" "has" "had" "had" "having") ;
  lin language_title_Utt = ss "English" ;
-}
}

