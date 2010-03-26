--# -path=.:../abstract:../romance:../common:prelude

concrete StructuralRon of Structural = CatRon ** 
  open  MorphoRon, ParadigmsRon, BeschRon, Prelude,(X = ConstructX) in {

  flags optimize=all ; 
        coding=utf8 ;

lin

  above_Prep = mkPrep "deasupra" Ge ;
  after_Prep = mkPrep "după" Ac True;
  all_Predet = {
    s = \\a => table { AGenDat => aagrForms nonExist nonExist "tuturor" "tuturor" ! a ;
                       _       => aagrForms "tot" "toată" "toţi" "toate" ! a 
                     };
    c = No
    } ;
  almost_AdA, almost_AdN = ss "aproape" ;
  always_AdV = ss "mereu" ;
  although_Subj = ss "deşi" ;
  and_Conj = {s1 = [] ; s2 = "şi" ; n = Pl} ;
  because_Subj = ss "deoarece" ;
  before_Prep = mkPrep "înaintea" Ge ;
  behind_Prep = mkPrep "înapoia" Ge ;
  between_Prep = mkPrep "între" Ac True ;
  both7and_DConj = {s1,s2 = "şi" ; n = Pl} ;
  but_PConj = ss "dar" ;
  by8agent_Prep = mkPrep "de către" Ac True;
  by8means_Prep = mkPrep "de" Ac True;
  can8know_VV = mkVV (v_besch68 "putea") ;
  can_VV = mkVV (v_besch68 "putea") ;
  during_Prep = mkPrep "în timpul" Ge ;
  either7or_DConj = {s1,s2 = "sau" ; n = Pl} ;
  everybody_NP = mkNP "toţi" "tuturor" Pl Masc True; -- form for Fem needed also !
  every_Det = mkDet "orice" "orice" "oricărui" "oricărei" "orice" "orice" "oricăruia" "oricăreia" Sg ; 
  everything_NP = mkNP "totul" nonExist Sg Masc False;
  everywhere_Adv = ss "pretutindeni" ;
  few_Det  = mkDet "câţiva" "câteva" "câtorva" "câtorva" Pl ;
  for_Prep = mkPrep "pentru" Ac True;
  from_Prep = mkPrep "de la" Ac True; 
  
  he_Pron = 
    mkPronoun
      "el" "el" "lui" "lui" [] "său" "sa" "săi" "sale"  Masc Sg P3 ;
  
  here7from_Adv = ss "de aici" ;
  here7to_Adv = ss "până aici" ;
  here_Adv = ss "aici" ;
  how_IAdv = ss "cum" ;
  how8much_IAdv = ss "cât" ; ---- ? AR
  how8many_IDet = {s = \\g,c => case <g,c> of
                                   { <Fem,AGenDat> => "câtor"; <Fem,_> => "câte" ;
                                     <Masc,AGenDat> => "câtor" ; _ => "câţi" 
                                     };
                   n = Pl
                    } ;
  if_Subj = ss "dacă" ;
  in8front_Prep = mkPrep "în faţa" Ge ;
  i_Pron = mkPronoun "eu" "mine" "mie" [] [] "meu" "mea" "mei" "mele" Masc Sg P1 ;
  in_Prep = mkPrep "în" Ac True;
  it_Pron = 
     mkPronoun
      "" "el" "lui" "lui" [] "său" "sa" "săi" "sale"  Masc Sg P3 ;
  
  have_V2 = dirV2 (v_have) ;
  less_CAdv = {s = "mai puţin" ; sNum = ""; p = conjThan ; lock_CAdv = <> } ; 
  many_Det = mkDet "mulţi" "multe" "multor" "multor" "mulţi" "multe" "multora" "multora" Pl; 
  more_CAdv = {s = "mai" ; sNum = "mult" ; p =conjThan ; lock_CAdv = <>};
  most_Predet = {
    s = \\a => table { AGenDat => "marii parţi a" ;
                       ANomAcc => "marea parte a"; 
                       AVoc    => "mare parte a"
                     };
    c = Ge
    };
  much_Det = mkDet "mult" "multă" nonExist nonExist Sg ;
  must_VV = mkVV (v_besch140 "trebui") ;
  no_Utt = ss "nu" ;
  on_Prep = mkPrep "pe" Ac True;
  only_Predet = {s = \\_,c => "doar" ; c = No} ; 
  or_Conj = {s1 = [] ; s2 = "sau" ; n = Sg} ;
  otherwise_PConj = ss "altfel" ;
  part_Prep = mkPrep "din" Ac True;
  please_Voc = ss ["vă rog"] ;
  possess_Prep = mkPrep "" Ge ; -- required forms for Fem Sg, Masc Pl and Fem Pl - maybe variants
  quite_Adv = ss "chiar" ;
  she_Pron = 
    mkPronoun
       "ea" "ea" "ei" "ei" [] "său" "sa" "săi" "sale"  
        Fem Sg P3 ;

  so_AdA = ss "aşa" ;
  somebody_NP = mkNP "cineva" "cuiva" Sg Masc True;
somePl_Det = mkDet "unii" "unele" "unor" "unor" "unii" "unele" "unora" "unora" Pl ;
someSg_Det = mkDet "nişte" "nişte" "la nişte" "la nişte" Sg ;
  something_NP = mkNP "ceva" "a ceva" Sg Masc False;
  somewhere_Adv = ss ["undeva"] ; --- ne - pas

that_Quant = {
    s = \\_ => table {
      Sg => table {Masc => table { AGenDat => "acelui";
                                   _       => "acel"
                                 };
                   Fem  => table {AGenDat => "acelei";
                                  _       => "acea"
                                 }
                  };
      Pl => table { Masc => table {AGenDat => "acelor";
                                   _       => "acei" 
                                  };
                    Fem  => table {AGenDat => "acelor";
                                   _       => "acele" 
                                  }
                   }
                      } ;
    sp = table { 
      Sg => table {Masc => table { AGenDat => "aceluia";
                                   _       => "acela"
                                 };
                   Fem  => table {AGenDat => "aceleia";
                                  _       => "aceea"
                                 }
                  };
      Pl => table {Masc => table {AGenDat => "acelora";
                                  _       => "aceia" 
                                  };
                   Fem  => table {AGenDat => "acelora";
                                  _       => "acelea" 
                                 }
                  }
              }; 
  isDef = False ; isPost = False ; hasRef = False
};

  there7from_Adv = ss ["de acolo"] ;
  there7to_Adv = ss "până acolo" ; 
  there_Adv = ss "acolo" ;
  therefore_PConj = ss "astfel" ;
  --these_NP = mkNP "aceştia" "acestora" Masc Pl True; --form for Fem needed also !
  they_Pron = mkPronoun
      "ei" "ei" "lor" "lor" [] "lor" "lor" "lor" "lor"  
        Masc Pl P3 ;
  this_Quant = {
    s = \\_ => table {
      Sg => table {Masc => table { AGenDat => "acestui";
                                   _       => "acest"
                                 };
                   Fem  => table {AGenDat => "acestei";
                                  _       => "această"
                                 }
                  };
      Pl => table { Masc => table {AGenDat => "acestor";
                                   _       => "aceşti" 
                                  };
                    Fem  => table {AGenDat => "acestor";
                                   _       => "aceste" 
                                  }
                   }
                      } ;
    sp = table { 
      Sg => table {Masc => table { AGenDat => "acestuia";
                                   _       => "acesta"
                                 };
                   Fem  => table {AGenDat => "acesteia";
                                  _       => "aceasta"
                                 }
                  };
      Pl => table {Masc => table {AGenDat => "acestora";
                                  _       => "aceştia" 
                                  };
                   Fem  => table {AGenDat => "acestora";
                                  _       => "acestea" 
                                 }
                  }
              } ;
   isDef = False ; isPost = False ; hasRef = False
 };
  through_Prep = mkPrep "prin" Ac True;
  too_AdA = ss "prea" ;
  to_Prep = mkPrep "la" Ac True;
  under_Prep = mkPrep "sub" Ac True;
  very_AdA = ss "foarte" ;
  want_VV = mkVV (v_besch74 "vrea") ; 
  we_Pron =  mkPronoun
    "noi" "noi" "nouă" [] [] "nostru" "noastră" "noştri" "noastre"  
        Masc Pl P1 ; 
whatSg_IP = 
    {s = \\c => case c of
                { Da => "căruia"  ;
                  Ge => "a căruia" ; 
                  _      => "ce" };
     a = aagr Masc Sg;
     hasRef = False
    };

whatPl_IP = 
   {s = \\c => case c of
                { Da => "cărora" ;
                  Ge => "a cărora" ; 
                  _      => "ce" };
     a = aagr Masc Pl;
     hasRef = False
    };
  when_IAdv = ss "când" ;
  when_Subj = ss "când" ;
  where_IAdv = ss "unde" ;
  which_IQuant = {s = table {
      Sg => table {Masc => table { AGenDat => "cărui";
                                   _       => "care"
                                 };
                   Fem  => table {AGenDat => "cărei";
                                  _       => "care"
                                 }
                  };
      Pl => \\g => table {AGenDat => "căror";
                                   _       => "care" 
                                  }
                   
                    };
   isDef = False 
  };

  whoPl_IP = {s = \\c => case c of
                { Da => "cui" ;
                  Ge => "a cui" ; 
                  _      => "cine" };
     a = aagr Masc Pl;
     hasRef = True
    };

  whoSg_IP = {s = \\c => case c of
                { Da => "cui" ;
                  Ge => "a cui" ; 
                  _      => "cine" };
     a = aagr Masc Sg;
     hasRef = True
    };
  why_IAdv = ss "de ce" ;
  without_Prep = mkPrep "fără" Ac True;
  with_Prep = mkPrep "cu" Ac ;
  yes_Utt = ss "da" ; 

  youSg_Pron = mkPronoun 
    "tu" "tine" "ţie" [] "tu" "tău" "ta" "tăi" "tale"  
        Masc Sg P2 ;
  youPl_Pron, youPol_Pron = 
    mkPronoun
      "voi" "voi" "vouă" [] "voi" "vostru" "voastră" "voştri" "voastre"  
         Masc Pl P2 ;

 not_Predet = {s = \\a,c => "nu" ; c = No} ;

  no_Quant = 
{
    s = \\_ => table {
      Sg => table {Masc => table { AGenDat => "niciunui";
                                   _       => "niciun"
                                 };
                   Fem  => table {AGenDat => "niciunei";
                                  _       => "nicio"
                                 }
                  };
      Pl => table { Masc => table {AGenDat => "niciunor";
                                   _       => "niciunii" 
                                  };
                    Fem  => table {AGenDat => "niciunor";
                                   _       => "niciunele" 
                                  }
                   }
                      } ;
    sp = table { 
      Sg => table {Masc => table { AGenDat => "nimănui";
                                   _       => "nimeni"
                                 };
                   Fem  => table {AGenDat => "nimănui";
                                  _       => "nimeni"
                                 }
                  };
      Pl => table {Masc => table {AGenDat => "niciunora";
                                  _       => "niciunii" 
                                  };
                   Fem  => table {AGenDat => "niciunora";
                                  _       => "niciunele" 
                                 }
                  }
              } ;
 isDef = False ; isPost = False ; hasRef = False
};
  if_then_Conj = {s1 = "dacă" ; s2 = "atunci" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = mkNP "nimeni" "nimănui" Sg Masc True;
 
  nothing_NP = mkNP "nimic" "nimicului" Sg Masc False;
  at_least_AdN = ss "cel puţin" ;
  at_most_AdN = ss "cel mult" ;

  except_Prep = mkPrep "cu excepţia" Ge ;

  as_CAdv = { s = "la fel de"; sNum = "mult"; p = "ca" ; lock_CAdv = <> };

}

