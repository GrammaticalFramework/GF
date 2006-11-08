--# -path=.:../Common:prelude:alltenses:mathematical

concrete TramUserFin0 of TramUser = GodisUserFin, StopsFin ** TramUserI
    with (Grammar=GrammarFin), (GodisLang=GodisLangFin), 
         (TramSystemI=TramSystemFin), (TramLexicon=TramLexiconFin);

