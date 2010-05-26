concrete StructuralGer of Structural = CatGer ** 

  open MorphoGer, MakeStructuralGer, (X = ConstructX), 
       (P = ParadigmsGer), IrregGer, Prelude in {

  flags optimize=all ;

  lin

  above_Prep = mkPrep "über" P.dative ;
  after_Prep = mkPrep "nach" P.dative ;
  all_Predet = {s = appAdj (regA "all") ; c = noCase ; a = PAgNone} ;
  almost_AdA, almost_AdN = ss "fast" ;
  although_Subj = ss "obwohl" ;
  always_AdV = ss "immer" ;
  and_Conj = {s1 = [] ; s2 = "und" ; n = Pl} ;
  because_Subj = ss "weil" ;
  before_Prep = mkPrep "vor" P.dative ;
  behind_Prep = mkPrep "hinter" P.dative ;
  between_Prep = mkPrep "zwischen" P.dative ;
  both7and_DConj = sd2 "sowohl" ["als auch"] ** {n = Pl} ;
  but_PConj = ss "aber" ;
  by8agent_Prep = mkPrep "durch" P.accusative ;
  by8means_Prep = mkPrep "mit" P.dative ;
  can8know_VV, can_VV = auxVV 
      (mkV 
        "können" "kann" "kannst" "kann" "könnt" "könn" 
        "konnte" "konntest" "konnten" "konntet"
        "könnte" "gekonnt" [] 
        VHaben) ;
  during_Prep = mkPrep "während" P.genitive ;
  either7or_DConj = sd2 "entweder" "oder" ** {n = Sg} ;
  everybody_NP = nameNounPhrase {s = caselist "jeder" "jeden" "jedem" "jedes"} ;
  every_Det = detLikeAdj Sg "jed" ;
  everything_NP = nameNounPhrase {s = caselist "alles" "alles" "allem" "alles"} ;
  everywhere_Adv = ss "überall" ;
  few_Det = detLikeAdj Pl "wenig" ;
----  first_Ord = {s = (regA "erst").s ! Posit} ;
  for_Prep = mkPrep "für" P.accusative ;
  from_Prep = mkPrep "aus" P.dative ;
  he_Pron = mkPronPers "er" "ihn" "ihm" "seiner" "sein"  Masc Sg P3 ;
  here7to_Adv = ss ["hierher"] ;
  here7from_Adv = ss ["hieraus"] ;
  here_Adv = ss "hier" ;
  how_IAdv = ss "wie" ;
  how8much_IAdv = ss "wieviel" ;
  how8many_IDet = {s = \\g,c => (detLikeAdj Pl "wieviel").s ! g ! NPC c ; n = Pl} ;
  if_Subj = ss "wenn" ;
  in8front_Prep = mkPrep "vor" P.dative ;
  i_Pron = mkPronPers "ich" "mich" "mir" "meiner" "mein" Masc Sg P1 ;
  in_Prep = mkPrep [] (NPP CInDat) ;
  it_Pron = mkPronPers "es" "es" "ihm" "seiner" "sein"  Neutr Sg P3 ;
  less_CAdv = X.mkCAdv "weniger" "als" ;
  many_Det = detLikeAdj Pl "viel" ;
  more_CAdv = X.mkCAdv "mehr" "als" ;
  most_Predet = {s = appAdj (regA "meist") ; c = noCase ; a = PAgNone} ;
  much_Det = detLikeAdj Sg "viel" ;
  must_VV = auxVV 
      (mkV 
        "müssen" "muß" "mußt" "muß" "müßt" "müß" 
        "mußte" "mußtest" "mußten" "mußtet"
        "müßte" "gemußt" [] 
        VHaben) ;
---  one_Quant = DEPREC
  only_Predet = {s = \\_,_,_ => "nur" ; c = noCase ; a = PAgNone} ;
  no_Utt = ss "nein" ;
---b  no_Phr = ss "nein" ;
  on_Prep = mkPrep "auf" P.dative ;
  or_Conj = {s1 = [] ; s2 = "oder" ; n = Sg} ;
  otherwise_PConj = ss "sonst" ;
  part_Prep = mkPrep "von" P.dative ;
  please_Voc = ss "bitte" ;
  possess_Prep = mkPrep "von" P.dative ;
  quite_Adv = ss "ziemlich" ;
  she_Pron = mkPronPers "sie" "sie" "ihr" "ihrer" "ihr" Fem Sg P3 ;
  so_AdA = ss "so" ;
  somebody_NP = nameNounPhrase {s = caselist "jemand" "jemanden" "jemandem" "jemands"} ;
  somePl_Det = detLikeAdj Pl "einig" ;
  someSg_Det = {
      s,sp = \\g,c => 
             usePrepC c (\k -> "ein" + pronEnding ! GSg g ! k) ;  ---- einer,eines
      n = Sg ;
      a = Strong
      } ;
  something_NP = nameNounPhrase {s = \\_ => "etwas"} ;
  somewhere_Adv = ss "irgendwo" ;
  that_Quant = let 
     jener : Number => Gender => PCase => Str = \\n => (detLikeAdj n "jen").s in 
     {s = \\_ => jener ; sp = jener ; a = Weak} ;
---b  that_NP = nameNounPhrase {s = caselist "das" "das" "denem" "dessen"} ; ----
  there_Adv = ss "da" ;
  there7to_Adv = ss "dahin" ;
  there7from_Adv = ss ["daher"] ;
  therefore_PConj = ss "deshalb" ;
---b  these_NP = {s = caselist "diese" "diese" "diesen" "dieser" ; a = agrP3 Pl} ;
  they_Pron = mkPronPers "sie" "sie" "ihnen" "ihrer" "ihr" Fem Pl P3 ;
  this_Quant = let 
     dieser : Number => Gender => PCase => Str = \\n => (detLikeAdj n "dies").s in 
     {s = \\_ => dieser ; sp = dieser ; a = Weak} ;
---b  this_NP = nameNounPhrase {s = caselist "dies" "dies" "diesem" "dieses"} ; ----
---b  those_NP = {s = caselist "jene" "jene" "jenen" "jener" ; a = agrP3 Pl} ;
  through_Prep = mkPrep "durch" P.accusative ;
  too_AdA = ss "zu" ;
  to_Prep = mkPrep "nach" P.dative ;
  under_Prep = mkPrep "unter" P.dative ;
  very_AdA = ss "sehr" ;
  want_VV = auxVV 
      (mkV 
        "wollen" "will" "willst" "will" "wollt" "woll" 
        "wollte" "wolltest" "wollten" "wolltet"
        "wollte" "gewollt" [] 
        VHaben) ;
  we_Pron = mkPronPers "wir" "uns"  "uns"   "unser"  "unser" Fem Pl P1 ;

  whatSg_IP = {s = caselist "was" "was" "was" "wessen" ; n = Sg} ; ----
  whatPl_IP = {s = caselist "was" "was" "was" "wessen" ; n = Pl} ; ----

  when_IAdv = ss "wann" ;
  when_Subj = ss "wenn" ;
  where_IAdv = ss "wo" ;
  which_IQuant = {s = \\n,g,c => (detLikeAdj n "welch").s ! g ! NPC c} ;

  whoSg_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Sg} ;
  whoPl_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Pl} ;
  why_IAdv = ss "warum" ;
  without_Prep = mkPrep "ohne" P.accusative ;
  with_Prep = mkPrep "mit" P.dative ;
  youSg_Pron = mkPronPers "du" "dich" "dir" "deiner" "dein" Fem Sg P2 ;
  youPl_Pron = mkPronPers "ihr" "euch" "euch" "eurer" "euer" Fem Pl P2 ; ---- poss
  youPol_Pron = mkPronPers "Sie" "Sie" "Ihnen" "Ihrer" "Ihr" Fem Pl P3 ;
  yes_Utt = ss "ja" ;

  not_Predet = {s = \\_,_,_ => "nicht" ; c = noCase ; a = PAgNone} ;
  no_Quant = let 
     keiner : Number => Gender => PCase => Str = table {
       Sg => \\g,c => usePrepC c (\k -> "kein" + pronEnding ! GSg g ! k) ;
       Pl => (detLikeAdj Pl "kein").s
       }
     in 
     {s = \\_ => keiner ; sp = keiner ; a = Strong} ;   ---- sp
  if_then_Conj = {s1 = "wenn" ; s2 = "dann" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = 
    nameNounPhrase {s = caselist "niemand" "niemanden" "niemandem" "niemands"} ;
  nothing_NP = 
    nameNounPhrase {s = \\_ => "nichts"} ;
  at_least_AdN = ss "wenigstens" ;
  at_most_AdN = ss "höchstens" ;
  except_Prep = mkPrep "außer" P.dative ;

  as_CAdv = X.mkCAdv "ebenso" "wie" ;
  have_V2 = P.dirV2 IrregGer.haben_V ;
  that_Subj = ss "daß" ;

  lin language_title_Utt = ss "Deutsch" ;

}
