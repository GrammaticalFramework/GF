--# -path=.:../Common:prelude:alltenses:mathematical

concrete TramUserFin of TramUser = TramUserFin0-[stop_dest_stop, stop_dept_stop] **
  open GrammarFin, GodisLangFin, TramLexiconFin, ParadigmsFin in {

lin
  stop_dest_stop x y = 
    UttAdv (mkAdv (
      (PrepNP (casePrep from_Case) x).s ++
      (PrepNP (casePrep to_Case) y).s
        )
      ) ;
  stop_dept_stop x y = 
    UttAdv (mkAdv (
      (PrepNP (casePrep to_Case) x).s ++
      (PrepNP (casePrep from_Case) y).s
        )
      ) ;
}

