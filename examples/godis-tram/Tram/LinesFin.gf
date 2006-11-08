--# -path=.:../Common:alltenses:mathematical

concrete LinesFin of Lines = open Prelude, CatFin, GodisLangFin, ParadigmsFin, SymbolFin in {

lincat Line = NP;

lin
Tram1 = ratikka "1" ;
Tram2 = ratikka "2";
Tram3 = ratikka "3";
Tram4 = ratikka "4";
Tram5 = ratikka "5";
Tram6 = ratikka "6";
Tram7 = ratikka "7";
Tram8 = ratikka "8";
Tram9 = ratikka "9";

Bus34 = bussi "34";
Bus40 = bussi "40";
Bus51 = bussi "51";
Bus60 = bussi "60";
Bus62 = bussi "62";

Alvsnabben = mkNP (regN "älvsnabben-lautta") singular ;

oper

ratikka : Str -> NP = \s -> CNIntNP (regN "ratikka") (int s) ;
bussi : Str -> NP = \s -> CNIntNP (regN "bussi") (int s) ;

---- this shouldn't be needed
int : Str -> {
  s : Str ;
  last : % Predef.Ints 9 ;
  size : % Predef.Ints 1
  } = \s -> {
  s = s ;
  last = 0 ;
  size = 1
  } ;

}
