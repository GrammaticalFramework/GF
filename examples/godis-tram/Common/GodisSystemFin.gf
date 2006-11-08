--# -path=.:prelude:alltenses

concrete GodisSystemFin of GodisSystem = GodisSystemI with 
    (Grammar=GrammarFin), (Extra=ExtraFin), (GodisLang=GodisLangFin);
