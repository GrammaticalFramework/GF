--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

concrete GodisSystemEng of GodisSystem = GodisSystemI with 
    (Grammar=GrammarEng), (Extra=ExtraEng), (GodisLang=GodisLangEng);
