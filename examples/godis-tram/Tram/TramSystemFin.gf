--# -path=.:../Common:prelude:alltenses:mathematical

concrete TramSystemFin of TramSystem = GodisSystemFin, StopsFin, LinesFin ** TramSystemI with 
    (Grammar=GrammarFin), (GodisLang=GodisLangFin), (TramLexicon=TramLexiconFin);

