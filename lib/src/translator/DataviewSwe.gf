concrete DataviewSwe of Dataview = DictionarySwe ** open ResSwe, CommonScand, Prelude in {

-- Generating database entries from Dictionary
-- AR 9/1/2015 under LGPL/BSD

lincat
  Row = {s : Str} ; -- a row in the database

lin
  RowN noun = ss (sep 
        (noun.s ! Sg ! Indef ! Nom)
	(noun.s ! Sg ! Def ! Nom)
	(noun.s ! Pl ! Indef ! Nom)
	(noun.s ! Pl ! Def ! Nom)
        (gender (lin N noun))
	[]
    ) ; 

{-
  RowN2  : N2 -> Row ;
  RowN3  : N3 -> Row ;
  RowA   : A -> Row ;
  RowA2  : A2 -> Row ;
-}

  RowV  verb = ss (sep (rowV (lin V verb)) []) ;
  RowV2 verb = ss (sep (rowV (lin V verb)) (pad verb.c2.s) []) ;

oper
  rowV : V -> Str = \verb -> sep
    (verb.s ! VI (VInfin Act))
    (verb.s ! VF (VPres Act))
    (sep
    (verb.s ! VF (VImper Act))
    (verb.s ! VF (VPret Act))
    (verb.s ! VI (VSupin Act))
    (verb.s ! VI (VPtPret (Strong (GSg Utr)) Nom))
    (pad verb.part)
    (vtype verb.vtype)
    ) ;


{-
  RowV2  : V2 -> Row ;
  RowVV  : VV -> Row ;
  RowVS  : VS -> Row ;
  RowVQ  : VQ -> Row ;
  RowVA  : VA -> Row ;
  RowV3  : V3 -> Row ;
  RowV2V : V2V -> Row ;
  RowV2S : V2S -> Row ;
  RowV2Q : V2Q -> Row ;
  RowV2A : V2A -> Row ;
  RowAdv : Adv -> Row ;
  RowPrep : Prep -> Row ;
-}

oper
  gender : N -> Str = \noun -> case noun.g of {Utr => "Utr" ; Neutr => "Neutr"} ;
  vtype : VType -> Str = \vt -> case vt of {VAct => "Act" ; VPass => "Dep" ; VRefl => "Refl"} ;

oper
  sep = overload {
    sep : (_,_ : Str) -> Str = \x,y -> seps x y ;
    sep : (_,_,_ : Str) -> Str = \x,y,z -> seps x (seps y z) ;
    sep : (_,_,_,_ : Str) -> Str = \x,y,z,u -> seps x (seps y (seps z u)) ;
    sep : (_,_,_,_,_ : Str) -> Str = \x,y,z,u,v -> seps x (seps y (seps z (seps u v))) ;
    sep : (_,_,_,_,_,_ : Str) -> Str = \x,y,z,u,v,w -> seps x (seps y (seps z (seps u (seps v w)))) ;
    } ;
  seps : Str -> Str -> Str = \x,y -> x ++ BIND ++ "," ++ y ;

  pad : Str -> Str = \s -> "+" ++ s ;

}
