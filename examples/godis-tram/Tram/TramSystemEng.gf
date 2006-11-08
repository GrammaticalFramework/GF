--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

concrete TramSystemEng of TramSystem = GodisSystemEng, StopsEng, LinesEng ** TramSystemI with 
    (Grammar=GrammarEng), (GodisLang=GodisLangEng), (TramLexicon=TramLexiconEng);

