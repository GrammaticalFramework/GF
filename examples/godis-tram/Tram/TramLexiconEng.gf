--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

concrete TramLexiconEng of TramLexicon = CatEng ** 
    open Prelude, ParadigmsEng, ParamX, (Lex=LexiconEng), (Irr=IrregEng), GodisLangEng in {

lin

-- Adjectives
short_A = Lex.short_A;

-- Conjunctions
and_then_Conj = {s = ["and then"]; n = Pl; lock_Conj = <>};

-- Nouns
route_N     = regN "route";
stop_N      = regN "stop";
way_N       = regN "way";

-- Prepositions
from_Prep   = ss "from";
to_Prep     = ss "to";

-- Verb-1
help_V      = regV "help";
restart_V   = regV "restart";

-- Verb-2
go_from_V2   = dirV2 (partV (regV "go") "from"); --- ??
go_to_V2     = dirV2 (partV (regV "go") "to"); --- ??
find_V2      = Lex.find_V2;
findout_V2   = dirV2 (regV "findout");  --- ??
take_V2      = dirV2 Irr.take_V;

}
