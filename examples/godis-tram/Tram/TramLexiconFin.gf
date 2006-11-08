--# -path=.:../Common:alltenses

concrete TramLexiconFin of TramLexicon = CatFin ** 
    open Prelude, ParadigmsFin, ParamX, (Lex=LexiconFin), GodisLangFin in {

lin

-- Adjectives
short_A = Lex.short_A;

-- Conjunctions
and_then_Conj = {s = ["ja sitten"]; n = Pl; lock_Conj = <>};

-- Nouns
route_N     = regN "reitti";
stop_N      = regN "pys‰kki";
way_N       = regN "tie";

-- Prepositions
from_Prep   = casePrep from_Case ; ----
to_Prep     = casePrep to_Case ; ----

-- Verb-1
help_V      = regV "auttaa";
restart_V   = regV "uudelleenaloittaa"; ---- alusta

-- Verb-2
go_from_V2   = caseV2 Lex.go_V from_Case ;
go_to_V2     = caseV2 Lex.go_V to_Case ;
find_V2      = Lex.find_V2;
findout_V2   = dirV2 (regV "selvitt‰‰");
take_V2      = dirV2 (regV "ottaa") ;

}
