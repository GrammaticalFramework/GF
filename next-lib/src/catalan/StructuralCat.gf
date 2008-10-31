concrete StructuralCat of Structural = CatCat ** 
  open PhonoCat, MorphoCat, ParadigmsCat, BeschCat, Prelude in {

  flags optimize=all ; coding=utf8 ;

lin

  above_Prep = mkPrep "sobre" ;
  after_Prep = {s = ["després"] ; c = MorphoCat.genitive ; isDir = False} ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "tot" "tota" "tots" "totes" ! a ;
    c = Nom
    } ;
  almost_AdA, almost_AdN = ss (variants {"quasi"; "gairebé"}) ;
  always_AdV = ss "sempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
  and_Conj = {s1 = [] ; s2 = etConj.s ; n = Pl} ;
  because_Subj = ss "perque" ** {m = Indic} ;
  before_Prep = {s = "abans" ; c = MorphoCat.genitive ; isDir = False} ;
  behind_Prep = {s = "darrera" ; c = MorphoCat.genitive ; isDir = False} ;
  between_Prep = mkPrep "entre" ;
  both7and_DConj = {s1,s2 = etConj.s ; n = Pl} ;
  but_PConj = ss "però" ;
  by8agent_Prep = mkPrep "per" ;
  by8means_Prep = mkPrep "mitjançant" ;
  can8know_VV = mkVV (verbV (saber_99 "saber")) ;
  can_VV = mkVV (verbV (poder_85 "poder")) ;
  during_Prep = mkPrep "durant" ; ----
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = makeNP ["tothom"] Masc Sg ;
  every_Det = {s,sp = \\_,_ => "cada" ; n = Sg ; s2 = []} ;
  everything_NP = pn2np (mkPN ["tot"] Masc) ;
  everywhere_Adv = ss ["a tot arreu"] ;
  few_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "pocs" "poques" ! g ; n = Pl ; s2 = []} ;
---  first_Ord = {s = \\ag => (regA "primer").s ! Posit ! AF ag.g ag.n} ;
  for_Prep = mkPrep ["per a"] ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun 
     "ell" "lo" "el" "ell"
     ["el seu"] ["la seva"] ["els seus"] ["les seves"]
      Masc Sg P3 ;
  here_Adv = mkAdv "aquí" ;		-- acÌ
  here7to_Adv = mkAdv ["cap aquí"] ;
  here7from_Adv = mkAdv ["d'aquí"] ;
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
  in_Prep = mkPrep "en" ;
  it_Pron = 
	mkPronoun 
     "ell" "lo" "el" "ell"
     ["el seu"] ["la seva"] ["els seus"] ["les seves"]
     Masc Sg P3 ;
  less_CAdv = ss "menys" ; ----
  many_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "molts" "moltes" ! g ; n = Pl ; s2 = []} ;
  more_CAdv = ss "més" ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la majoria"] ; c = CPrep P_de} ;
  much_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "molt" "molta" ! g ; n = Sg ; s2 = []} ;
  must_VV = mkVV (verbV (haver_59 "haver")) ;   -- + of_Prep
  no_Utt = ss "no" ;
  on_Prep = mkPrep "sobre" ;
---  one_Quant = {s = \\g,c => prepCase c ++ genForms "un" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "nomÈs" ; c = Nom} ;
  or_Conj = {s1 = [] ; s2 = "o" ; n = Sg} ;
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
  somebody_NP = pn2np (mkPN ["alg˙"] Masc) ;
  somePl_Det = {s,sp = 
    \\g,c => prepCase c ++ genForms "alguns" "algunes" ! g ; n = Pl ; s2 = []} ;
  someSg_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "algun" "alguna" ! g ; n = Sg ; s2 = []} ;
  something_NP = pn2np (mkPN ["quelcom"] Masc) ;
  somewhere_Adv = ss ["a algun lloc"] ;
  that_Quant =
    let aquell : ParadigmsCat.Number => ParadigmsCat.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "aquell" "aquella" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "aquells" "aquelles" ! g
      }
    in {
      s = \\_ => aquell ;
      sp = aquell ;
      s2 = []
    } ;
  there_Adv = mkAdv "allà" ;		-- all·
  there7to_Adv = mkAdv ["cap a allà"] ;
  there7from_Adv = mkAdv ["d'allà"] ;	
  therefore_PConj = ss ["per tant"] ;
  they_Pron = mkPronoun
    "elles" "les" "les" "elles"
    ["el seu"] ["la seva"] ["llurs"] ["llurs"]
    Fem Pl P3 ;

  this_Quant =
    let aquest : ParadigmsCat.Number => ParadigmsCat.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "aquest" "aquesta" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "aquests" "aquestes" ! g
      }
    in {
      s = \\_ => aquest ;
      sp = aquest ;
      s2 = []
    } ;
  through_Prep = mkPrep "mitjançant" ;
  too_AdA = ss "massa" ;
  to_Prep = complDat ;
  under_Prep = mkPrep "sota" ;
  very_AdA = ss "molt" ;
  want_VV = mkVV (verbV (voler_120 "voler")) ;
  we_Pron = 
    mkPronoun 
      "nosaltres" "nos" "nos" "nosaltres"
      ["el nostre"] ["la nostra"] ["els nostres"] ["les nostres"]
      Fem Pl P1 ;
   whatSg_IP = {s = \\c => prepCase c ++ ["què"] ; a = aagr Masc Sg} ;
   whatPl_IP = {s = \\c => prepCase c ++ ["què"] ; a = aagr Masc Pl} ; ---
   when_IAdv = ss "quan" ;
   when_Subj = ss "quan" ** {m = Indic} ;
   where_IAdv = ss "on" ;
   which_IQuant = {s = table {
      Sg => \\g,c => prepCase c ++ "quin" ;  --per fer: femenÌ quina
      Pl => \\g,c => prepCase c ++ "quins"
      }
     } ;  --per fer: femenÌ quines
    whoPl_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Fem Pl} ;
    whoSg_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Fem Sg} ;
    why_IAdv = ss ["per quË"] ;
    without_Prep = mkPrep "sense" ;
    with_Prep = mkPrep "amb" ;
  yes_Utt = ss "sí" ;  
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
      "vosté" "li" "li" "vosté"
      ["el seu"] ["la seva"] ["els seus"] ["les seves"]
      Fem Pl P2 ;

oper
  etConj : {s : Str ; n : MorphoCat.Number} = {s = "i" } ** {n = Pl} ;

}
