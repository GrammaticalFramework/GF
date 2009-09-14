resource BeschRon = open Prelude, MorphoRon,CatRon in {

flags optimize=noexpand ; 

oper mkNV : Verbe -> V = \ve -> {s = ve.s ; isRefl = \\_ => RNoAg ; nrClit = VNone; pReflClit = Composite ;lock_V = <> } ;
oper mkRVAcc : Verbe -> V = \ve -> {s = ve.s ; isRefl = \\a => aRefl a; nrClit = VRefl; pReflClit = Short ;lock_V = <>} ;
oper mkRVDat : Verbe -> V = \ve -> {s = ve.s ; isRefl = \\a => dRefl a; nrClit = VRefl; pReflClit = Composite  ;lock_V = <>};

-- for Group 1 - verbs ending in a (last sylablle) - the default behaviour is conjugation with "ez"
--        with small mutation, depending on the second last letter (80 % verbs - especially neological)
-- for Group 2 - verbs ending in ea - there are relatively few verbs, most of them irregular
--        default behavior - covers almost 25 %
-- for Group 3 - verbs ending in e - most verbs have phonetical mutations in the stem, for different 
--        tenses, difficult to find a pattern that describes this behavior
--        default conjugation - covers almost 20%
-- for Group 4 - verbs ending in i/î - the default behaviour is the conjugation with "sc", which 
--        characterizes almost 75 % of the verbs
-- in general : Group 1 + Group 4 are the most frequent for verbs
-- the smart paradigm covers (60-70% cases for a reasonably big database)
--          (statistical tests also needed)                    



oper conj : Str -> Verbe = mkV6 ;  
oper v_besch6 : Str -> V = \s -> mkNV (mkV6 s) ;
oper v_besch7 : Str -> V = \s -> mkNV (mkV7 s) ;
oper v_besch8 : Str -> V = \s -> mkNV (mkV8 s) ;
oper v_besch9 : Str -> V = \s -> mkNV (mkV9 s) ;
oper v_besch10 : Str -> V = \s -> mkNV (mkV10 s) ;
oper v_besch11 : Str -> V = \s -> mkNV (mkV11 s) ;
oper v_besch12 : Str -> V = \s -> mkNV (mkV12 s) ;
oper v_besch13 : Str -> V = \s -> mkNV (mkV13 s) ;
oper v_besch14 : Str -> V = \s -> mkNV (mkV14 s) ;
oper v_besch15 : Str -> V = \s -> mkNV (mkV15 s) ; 
oper v_besch16 : Str -> V = \s -> mkNV (mkV16 s) ;
oper v_besch17 : Str -> V = \s -> mkNV (mkV17 s) ;
oper v_besch18 : Str -> V = \s -> mkNV (mkV18 s) ;
oper v_besch19 : Str -> V = \s -> mkNV (mkV19 s) ;
oper v_besch20 : Str -> V = \s -> mkNV (mkV20 s) ;
oper v_besch21 : Str -> V = \s -> mkNV (mkV21 s) ; 
oper v_besch22 : Str -> V = \s -> mkNV (mkV22 s) ;
oper v_besch23 : Str -> V = \s -> mkNV (mkV23 s) ;
oper v_besch24 : Str -> V = \s -> mkNV (mkV24 s) ;
oper v_besch25 : Str -> V = \s -> mkNV (mkV25 s) ;
oper v_besch26 : Str -> V = \s -> mkNV (mkV26 s) ;
oper v_besch27 : Str -> V = \s -> mkNV (mkV27 s) ;
oper v_besch28 : Str -> V = \s -> mkNV (mkV28 s) ;
oper v_besch29 : Str -> V = \s -> mkNV (mkV29 s) ;
oper v_besch30 : Str -> V = \s -> mkNV (mkV30 s) ;
oper v_besch31 : Str -> V = \s -> mkNV (mkV31 s) ;
oper v_besch32 : Str -> V = \s -> mkNV (mkV32 s) ;
oper v_besch33 : Str -> V = \s -> mkNV (mkV33 s) ;
oper v_besch34 : Str -> V = \s -> mkNV (mkV34 s) ;
oper v_besch35 : Str -> V = \s -> mkNV (mkV35 s) ;
oper v_besch36 : Str -> V = \s -> mkNV (mkV36 s) ;
oper v_besch37 : Str -> V = \s -> mkNV (mkV37 s) ;
oper v_besch38 : Str -> V = \s -> mkNV (mkV38 s) ;
oper v_besch39 : Str -> V = \s -> mkNV (mkV39 s) ;
oper v_besch40 : Str -> V = \s -> mkNV (mkV40 s) ;
oper v_besch41 : Str -> V = \s -> mkNV (mkV41 s) ;
oper v_besch42 : Str -> V = \s -> mkNV (mkV42 s) ;
oper v_besch43 : Str -> V = \s -> mkNV (mkV43 s) ;
oper v_besch44 : Str -> V = \s -> mkNV (mkV44 s) ;
oper v_besch45 : Str -> V = \s -> mkNV (mkV45 s) ;
oper v_besch46 : Str -> V = \s -> mkNV (mkV46 s) ;
oper v_besch47 : Str -> V = \s -> mkNV (mkV47 s) ;
oper v_besch48 : Str -> V = \s -> mkNV (mkV48 s) ;
oper v_besch49 : Str -> V = \s -> mkNV (mkV49 s) ;
oper v_besch50 : Str -> V = \s -> mkNV (mkV50 s) ; 
oper v_besch51 : Str -> V = \s -> mkNV (mkV51 s) ;
oper v_besch52 : Str -> V = \s -> mkNV (mkV52 s) ;
oper v_besch53 : Str -> V = \s -> mkNV (mkV53 s) ;
oper v_besch54 : Str -> V = \s -> mkNV (mkV54 s) ;
oper v_besch55 : Str -> V = \s -> mkNV (mkV55 s) ;
oper v_besch56 : Str -> V = \s -> mkNV (mkV56 s) ;
oper v_besch57 : Str -> V = \s -> mkNV (mkV57 s) ;
oper v_besch58 : Str -> V = \s -> mkNV (mkV58 s) ;
oper v_besch59 : Str -> V = \s -> mkNV (mkV59 s) ;
oper v_besch60 : Str -> V = \s -> mkNV (mkV60 s) ;
oper v_besch61 : Str -> V = \s -> mkNV (mkV61 s) ;
oper v_besch62 : Str -> V = \s -> mkNV (mkV62 s) ;
--oper v_besch63 : Str -> V = \s -> mkNV (mkV63 s) ;
oper v_besch64 : Str -> V = \s -> mkNV (mkV64 s) ;
oper v_besch65 : Str -> V = \s -> mkNV (mkV65 s) ;
oper v_besch66 : Str -> V = \s -> mkNV (mkV66 s) ;
oper v_besch67 : Str -> V = \s -> mkNV (mkV67 s) ;
oper v_besch68 : Str -> V = \s -> mkNV (mkV68 s) ;
oper v_besch69 : Str -> V = \s -> mkNV (mkV69 s) ;
oper v_besch70 : Str -> V = \s -> mkNV (mkV70 s) ;
oper v_besch71 : Str -> V = \s -> mkNV (mkV71 s) ;
oper v_besch72 : Str -> V = \s -> mkNV (mkV72 s) ;
oper v_besch73 : Str -> V = \s -> mkNV (mkV73 s) ;
oper v_besch74 : Str -> V = \s -> mkNV (mkV74 s) ;
--oper v_besch75 : Str -> V = \s -> mkNV (mkV75 s) ;
oper v_besch76 : Str -> V = \s -> mkNV (mkV76 s) ;
oper v_besch77 : Str -> V = \s -> mkNV (mkV77 s) ;
oper v_besch78 : Str -> V = \s -> mkNV (mkV78 s) ;
oper v_besch79 : Str -> V = \s -> mkNV (mkV79 s) ;
oper v_besch80 : Str -> V = \s -> mkNV (mkV80 s) ;
oper v_besch81 : Str -> V = \s -> mkNV (mkV81 s) ;
oper v_besch82 : Str -> V = \s -> mkNV (mkV82 s) ;
oper v_besch83 : Str -> V = \s -> mkNV (mkV83 s) ;
oper v_besch84 : Str -> V = \s -> mkNV (mkV84 s) ;
oper v_besch85 : Str -> V = \s -> mkNV (mkV85 s) ;
oper v_besch86 : Str -> V = \s -> mkNV (mkV86 s) ;
oper v_besch87 : Str -> V = \s -> mkNV (mkV87 s) ;
oper v_besch88 : Str -> V = \s -> mkNV (mkV88 s) ;
oper v_besch89 : Str -> V = \s -> mkNV (mkV89 s) ;
oper v_besch90 : Str -> V = \s -> mkNV (mkV90 s) ;
oper v_besch91 : Str -> V = \s -> mkNV (mkV91 s) ;
oper v_besch92 : Str -> V = \s -> mkNV (mkV92 s) ;
oper v_besch93 : Str -> V = \s -> mkNV (mkV93 s) ;
oper v_besch94 : Str -> V = \s -> mkNV (mkV94 s) ;
oper v_besch95 : Str -> V = \s -> mkNV (mkV95 s) ;
oper v_besch96 : Str -> V = \s -> mkNV (mkV96 s) ;
oper v_besch97 : Str -> V = \s -> mkNV (mkV97 s) ;
oper v_besch98 : Str -> V = \s -> mkNV (mkV98 s) ;
oper v_besch99 : Str -> V = \s -> mkNV (mkV99 s) ;
oper v_besch100 : Str -> V = \s -> mkNV (mkV100 s) ; 
oper v_besch101 : Str -> V = \s -> mkNV (mkV101 s) ; 
oper v_besch102 : Str -> V = \s -> mkNV (mkV102 s) ; 
oper v_besch103 : Str -> V = \s -> mkNV (mkV103 s) ; 
oper v_besch104 : Str -> V = \s -> mkNV (mkV104 s) ; 
oper v_besch105 : Str -> V = \s -> mkNV (mkV105 s) ; 
oper v_besch106 : Str -> V = \s -> mkNV (mkV106 s) ; 
--oper v_besch107 : Str -> V = \s -> mkNV (mkV107 s) ; 
oper v_besch108 : Str -> V = \s -> mkNV (mkV108 s) ; 
oper v_besch109 : Str -> V = \s -> mkNV (mkV109 s) ; 
oper v_besch110 : Str -> V = \s -> mkNV (mkV110 s) ; 
--oper v_besch111 : Str -> V = \s -> mkNV (mkV111 s) ; 
oper v_besch112 : Str -> V = \s -> mkNV (mkV112 s) ; 
oper v_besch113 : Str -> V = \s -> mkNV (mkV113 s) ; 
--oper v_besch114 : Str -> V = \s -> mkNV (mkV114 s) ; 
oper v_besch115 : Str -> V = \s -> mkNV (mkV115 s) ; 
oper v_besch116 : Str -> V = \s -> mkNV (mkV116 s) ; 
oper v_besch117 : Str -> V = \s -> mkNV (mkV117 s) ; 
oper v_besch118 : Str -> V = \s -> mkNV (mkV118 s) ; 
oper v_besch119 : Str -> V = \s -> mkNV (mkV119 s) ; 
oper v_besch120 : Str -> V = \s -> mkNV (mkV120 s) ; 
oper v_besch121 : Str -> V = \s -> mkNV (mkV121 s) ; 
oper v_besch122 : Str -> V = \s -> mkNV (mkV122 s) ; 
oper v_besch123 : Str -> V = \s -> mkNV (mkV123 s) ; 
oper v_besch124 : Str -> V = \s -> mkNV (mkV124 s) ; 
oper v_besch125 : Str -> V = \s -> mkNV (mkV125 s) ; 
oper v_besch126 : Str -> V = \s -> mkNV (mkV126 s) ; 
oper v_besch127 : Str -> V = \s -> mkNV (mkV127 s) ; 
oper v_besch128 : Str -> V = \s -> mkNV (mkV128 s) ; 
oper v_besch129 : Str -> V = \s -> mkNV (mkV129 s) ; 
oper v_besch130 : Str -> V = \s -> mkNV (mkV130 s) ; 
oper v_besch131 : Str -> V = \s -> mkNV (mkV131 s) ; 
oper v_besch132 : Str -> V = \s -> mkNV (mkV132 s) ; 
oper v_besch133 : Str -> V = \s -> mkNV (mkV133 s) ; 
oper v_besch134 : Str -> V = \s -> mkNV (mkV134 s) ; 
oper v_besch135 : Str -> V = \s -> mkNV (mkV135 s) ; 
oper v_besch136 : Str -> V = \s -> mkNV (mkV136 s) ; 
oper v_besch137 : Str -> V = \s -> mkNV (mkV137 s) ; 
oper v_besch138 : Str -> V = \s -> mkNV (mkV138 s) ; 
oper v_besch139 : Str -> V = \s -> mkNV (mkV139 s) ; 
oper v_besch140 : Str -> V = \s -> mkNV (mkV140 s) ; 
oper v_besch141 : Str -> V = \s -> mkNV (mkV141 s) ; 
oper v_besch142 : Str -> V = \s -> mkNV (mkV142 s) ; 
oper v_besch143 : Str -> V = \s -> mkNV (mkV143 s) ; 
oper v_besch144 : Str -> V = \s -> mkNV (mkV144 s) ;
oper v_have : V = mkNV (mkV1 "avea") ;


}
