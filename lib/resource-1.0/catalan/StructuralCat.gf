concrete StructuralCat of Structural = CatCat ** 
  open PhonoCat, MorphoCat, ParadigmsCat, BeschCat, Prelude in {

  flags optimize=all ;

lin

  above_Prep = mkPreposition "sobre" ;
  after_Prep = {s = ["desprŽs"] ; c = MorphoCat.genitive ; isDir = False} ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "tot" "tota" "tots" "totes" ! a ;
    c = Nom
    } ;
  almost_AdA, almost_AdN = ss (variants {"quasi"; "gairebè"}) ;
  always_AdV = ss "sempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
	and_Conj = etConj ;
  because_Subj = ss "perque" ** {m = Indic} ;
  before_Prep = {s = "abans" ; c = MorphoCat.genitive ; isDir = False} ;
  behind_Prep = {s = "darrera" ; c = MorphoCat.genitive ; isDir = False} ;
  between_Prep = mkPreposition "entre" ;
  both7and_DConj = {s1,s2 = etConj.s ; n = Pl} ;
  but_PConj = ss "per˜" ;
  by8agent_Prep = mkPreposition "per" ;
  by8means_Prep = mkPreposition "mitjançant" ;
--  can8know_VV = mkVV (verbV (saber_71 "saber")) ;
--  can_VV = mkVV (verbV (poder_58 "poder")) ;
  during_Prep = mkPreposition "durant" ; ----
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = makeNP ["tothom"] Masc Sg ;
  every_Det = {s = \\_,_ => "cada" ; n = Sg} ;
  everything_NP = pn2np (mkPN ["tot"] Masc) ;
  everywhere_Adv = ss ["a tot arreu"] ;
  few_Det  = {s = \\g,c => prepCase c ++ genForms "pocs" "poques" ! g ; n = Pl} ;
  first_Ord = {s = \\ag => (regA "primer").s ! Posit ! AF ag.g ag.n} ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun 
     "ell" "lo" "el" "ell"
     ["el seu"] ["la seva"] ["els seus"] ["les seves"]
      Masc Sg P3 ;
  here_Adv = mkAdv "aquí" ;		-- ací
  here7to_Adv = mkAdv ["cap aquí"] ;
  here7from_Adv = mkAdv ["de aquí"] ;
  how_IAdv = ss "com" ;
  how8many_IDet = 
    {s = \\g,c => prepCase c ++ genForms "quants" "quantes" ! g ; n = Pl} ;
  if_Subj = ss "si" ** {m = Indic} ;
  in8front_Prep = {s = "davant" ; c = MorphoCat.genitive ; isDir = False} ;
  i_Pron = 
    mkPronoun
      "jo" "em" "em" "mi"
      ["el meu"] ["la meva"] ["els meus"] ["les meves"]
      Fem Sg P1 ;
  in_Prep = mkPreposition "en" ;
  it_Pron = 
	mkPronoun 
     "ell" "lo" "el" "ell"
     ["el seu"] ["la seva"] ["els seus"] ["les seves"]
     Masc Sg P3 ;
  less_CAdv = ss "menys" ; ----
  many_Det = {s = \\g,c => prepCase c ++ genForms "molts" "moltes" ! g ; n = Pl} ;
  more_CAdv = ss "més" ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la majoria"] ; c = CPrep P_de} ;
  much_Det = {s = \\g,c => prepCase c ++ genForms "molt" "molta" ! g ; n = Sg} ;
--  must_VV = mkVV (verbV (deber_6 "deber")) ;
  no_Phr = ss "no" ;
  on_Prep = mkPreposition "sobre" ;
  one_Quant = {s = \\g,c => prepCase c ++ genForms "un" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "només" ; c = Nom} ;
  or_Conj = {s = "o" ; n = Sg} ;
  otherwise_PConj = ss "altrament" ;
  part_Prep = complGen ;
  please_Voc = ss "sisplau" ;
  possess_Prep = complGen ;
  quite_Adv = ss "bastant" ;
  she_Pron = 
    mkPronoun
      "ella" "la" "la" "ella"
      ["el seu"] ["la seva"] ["els seus"] ["les seves"]
      Fem Sg P3 ;
  so_AdA = ss "tan" ;
  somebody_NP = pn2np (mkPN ["algú"] Masc) ;
  somePl_Det = {s = \\g,c => prepCase c ++ genForms "alguns" "algunes" ! g ; n = Pl} ;
  someSg_Det = {s = \\g,c => prepCase c ++ genForms "algun" "alguna" ! g ; n = Sg} ;
  something_NP = pn2np (mkPN ["quelcom"] Masc) ;
  somewhere_Adv = ss ["a algun lloc"] ;
  that_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ genForms "aquell" "aquella" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "aquells" "aquelles" ! g
      }
    } ;
  that_NP = makeNP ["alló"] Masc Sg ;
  there_Adv = mkAdv "allà" ;		-- allá
  there7to_Adv = mkAdv ["cap a allà"] ;
  there7from_Adv = mkAdv ["d'allà"] ;	
  therefore_PConj = ss ["per tant"] ;
  these_NP = makeNP ["aquestes"] Fem Pl ;
  they_Pron = mkPronoun
    "elles" "les" "les" "elles"
    ["el seu"] ["la seva"] ["llurs"] ["llurs"]
    Fem Pl P3 ;
  this_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ genForms "aquest" "aquesta" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "aquests" "aquestes" ! g
      }
    } ;
  this_NP = pn2np (mkPN ["això"] Masc) ;
  those_NP = makeNP ["aquelles"] Fem Pl ;
  through_Prep = mkPreposition "mitjançant" ;
  too_AdA = ss "massa" ;
  to_Prep = complDat ;
  under_Prep = mkPreposition "sota" ;
  very_AdA = ss "molt" ;
--  want_VV = mkVV (verbV (querer_64 "querer")) ;
  we_Pron = 
    mkPronoun 
      "nosaltres" "nos" "nos" "nosaltres"
      ["el nostre"] ["la nostra"] ["els nostres"] ["les nostres"]
      Fem Pl P1 ;
   whatSg_IP = {s = \\c => prepCase c ++ ["què"] ; a = aagr Masc Sg} ;
    whatPl_IP = {s = \\c => prepCase c ++ ["qué"] ; a = aagr Masc Pl} ; ---
    when_IAdv = ss "quan" ;
    when_Subj = ss "quan" ** {m = Indic} ;
    where_IAdv = ss "on" ;
    whichPl_IDet = {s = \\g,c => prepCase c ++ "quin" ; n = Sg} ;  --per fer: femení quina
    whichSg_IDet = {s = \\g,c => prepCase c ++ "quins" ; n = Pl} ;  --per fer: femení quines
    whoPl_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Fem Pl} ;
    whoSg_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Fem Sg} ;
    why_IAdv = ss ["per què"] ;
    without_Prep = mkPreposition "sense" ;
    with_Prep = mkPreposition "amb" ;
  yes_Phr = ss "sí" ;  
  youSg_Pron = mkPronoun 
    "tu" "et" "et" "tu"
    ["el teu"] ["la teva"] ["els teus"] ["les teves"]
    Fem Sg P2 ;
  youPl_Pron =
    mkPronoun
      "vosaltres" "us" "us" "vosaltres"
      ["el vostre"] ["la vostra"] ["els vostres"] ["les vostres"]
      Fem Pl P2 ;
  youPol_Pron =
    mkPronoun
      "vostè" "li" "li" "vostè"
      ["el seu"] ["la seva"] ["els seus"] ["les seves"]
      Fem Pl P2 ;

oper
  etConj : {s : Str ; n : MorphoCat.Number} = {s = "i" } ** {n = Pl} ;

}

