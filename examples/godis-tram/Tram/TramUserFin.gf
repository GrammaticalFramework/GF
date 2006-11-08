--# -path=.:../Common:prelude:alltenses:mathematical

concrete TramUserFin of TramUser = TramUserFin0-[stop_dest_stop, stop_dept_stop] **
  open GrammarFin, GodisLangFin, TramLexiconFin in {

lin
  stop_dest_stop x y = 
    UttAdv (mkAdv (
      fromStr Adv (PrepNP (casePrep from_Case) x) ++
      fromStr Adv (PrepNP (casePrep to_Case) y)
        )
      ) ;
}

