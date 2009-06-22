concrete StructuralGer of Structural = CatGer ** 

  open MorphoGer, Prelude in {

  flags optimize=all ;

  lin

  above_Prep = mkPrep "über" Dat ;
  after_Prep = mkPrep "nach" Dat ;
  all_Predet = {s = appAdj (regA "all")} ;
  almost_AdA, almost_AdN = ss "fast" ;
  although_Subj = ss "obwohl" ;
  always_AdV = ss "immer" ;
  and_Conj = {s1 = [] ; s2 = "und" ; n = Pl} ;
  because_Subj = ss "weil" ;
  before_Prep = mkPrep "vor" Dat ;
  behind_Prep = mkPrep "hinter" Dat ;
  between_Prep = mkPrep "zwischen" Dat ;
  both7and_DConj = sd2 "sowohl" ["als auch"] ** {n = Pl} ;
  but_PConj = ss "aber" ;
  by8agent_Prep = mkPrep "durch" Acc ;
  by8means_Prep = mkPrep "mit" Dat ;
  can8know_VV, can_VV = auxVV 
      (mkV 
        "können" "kann" "kannst" "kann" "könnt" "könn" 
        "konnte" "konntest" "konnten" "konntet"
        "könnte" "gekonnt" [] 
        VHaben) ;
  during_Prep = mkPrep "während" Gen ;
  either7or_DConj = sd2 "entweder" "oder" ** {n = Sg} ;
  everybody_NP = nameNounPhrase {s = caselist "jeder" "jeden" "jedem" "jedes"} ;
  every_Det = detLikeAdj Sg "jed" ;
  everything_NP = nameNounPhrase {s = caselist "alles" "alles" "allem" "alles"} ;
  everywhere_Adv = ss "überall" ;
  few_Det = detLikeAdj Pl "wenig" ;
----  first_Ord = {s = (regA "erst").s ! Posit} ;
  for_Prep = mkPrep "für" Acc ;
  from_Prep = mkPrep "aus" Dat ;
  he_Pron = mkPronPers "er" "ihn" "ihm" "seiner" "sein"  Masc Sg P3 ;
  here7to_Adv = ss ["hierher"] ;
  here7from_Adv = ss ["hieraus"] ;
  here_Adv = ss "hier" ;
  how_IAdv = ss "wie" ;
  how8many_IDet = detLikeAdj Pl "wieviel" ;
  if_Subj = ss "wenn" ;
  in8front_Prep = mkPrep "vor" Dat ;
  i_Pron = mkPronPers "ich" "mich" "mir" "meiner" "mein" Masc Sg P1 ;
  in_Prep = mkPrep "in" Dat ;
  it_Pron = mkPronPers "es" "es" "ihm" "seiner" "sein"  Neutr Sg P3 ;
  less_CAdv = ss "weniger" ;
  many_Det = detLikeAdj Pl "viel" ;
  more_CAdv = ss "mehr" ;
  most_Predet = {s = appAdj (regA "meist")} ;
  much_Det = detLikeAdj Sg "viel" ;
  must_VV = auxVV 
      (mkV 
        "müssen" "muß" "mußt" "muß" "müßt" "müß" 
        "mußte" "mußtest" "mußten" "mußtet"
        "müßte" "gemußt" [] 
        VHaben) ;
---  one_Quant = DEPREC
  only_Predet = {s = \\_,_,_ => "nur"} ;
  no_Utt = ss "nein" ;
---b  no_Phr = ss "nein" ;
  on_Prep = mkPrep "auf" Dat ;
  or_Conj = {s1 = [] ; s2 = "oder" ; n = Sg} ;
  otherwise_PConj = ss "sonst" ;
  part_Prep = mkPrep "von" Dat ;
  please_Voc = ss "bitte" ;
  possess_Prep = mkPrep "von" Dat ;
  quite_Adv = ss "ziemlich" ;
  she_Pron = mkPronPers "sie" "sie" "ihr" "ihrer" "ihr" Fem Sg P3 ;
  so_AdA = ss "so" ;
  somebody_NP = nameNounPhrase {s = caselist "jemand" "jemanden" "jemandem" "jemands"} ;
  somePl_Det = detLikeAdj Pl "einig" ;
  someSg_Det = {
      s = \\g,c => "ein" + pronEnding ! GSg g ! c ;  
      n = Sg ;
      a = Strong
      } ;
  something_NP = nameNounPhrase {s = \\_ => "etwas"} ;
  somewhere_Adv = ss "irgendwo" ;
  that_Quant = {s = \\n => (detLikeAdj n "jen").s ; a = Weak} ;
---b  that_NP = nameNounPhrase {s = caselist "das" "das" "denem" "dessen"} ; ----
  there_Adv = ss "da" ;
  there7to_Adv = ss "dahin" ;
  there7from_Adv = ss ["daher"] ;
  therefore_PConj = ss "deshalb" ;
---b  these_NP = {s = caselist "diese" "diese" "diesen" "dieser" ; a = agrP3 Pl} ;
  they_Pron = mkPronPers "sie" "sie" "ihnen" "ihrer" "ihr" Fem Pl P3 ;
  this_Quant = {s = \\n => (detLikeAdj n "dies").s ; a = Weak} ;
---b  this_NP = nameNounPhrase {s = caselist "dies" "dies" "diesem" "dieses"} ; ----
---b  those_NP = {s = caselist "jene" "jene" "jenen" "jener" ; a = agrP3 Pl} ;
  through_Prep = mkPrep "durch" Acc ;
  too_AdA = ss "zu" ;
  to_Prep = mkPrep "nach" Dat ;
  under_Prep = mkPrep "unter" Dat ;
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
  which_IQuant = {s = \\n => (detLikeAdj n "welch").s} ;

---b  whichPl_IDet = detLikeAdj Pl "welch" ;
---b  whichSg_IDet = detLikeAdj Sg "welch" ;
  whoSg_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Sg} ;
  whoPl_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Pl} ;
  why_IAdv = ss "warum" ;
  without_Prep = mkPrep "ohne" Acc ;
  with_Prep = mkPrep "mit" Dat ;
  youSg_Pron = mkPronPers "du" "dich" "dir" "deiner" "dein" Fem Sg P2 ;
  youPl_Pron = mkPronPers "ihr" "euch" "euch" "eurer" "euer" Fem Pl P2 ; ---- poss
  youPol_Pron = mkPronPers "Sie" "Sie" "Ihnen" "Ihrer" "Ihr" Fem Pl P3 ;
  yes_Utt = ss "ja" ;
---b  yes_Phr = ss "ja" ;

}
