--# -path=.:romanian:abstract:prelude:common
concrete MergeRon of Merge = BasicRon ** open DictLangRon, ParadigmsRon, ResRon, LexiconRon, ExtraLexiconRon, ParamBasic,StructuralRon in {
 
lin
-- single instances 



-- subclass declarations :

Animal = UseN animal_N ;
AnimalLanguage = ApposCN (UseN animal_N) (MassNP (UseN language_N)) ;
Blood = UseN blood_N ;
Bone = UseN bone_N ;
Book = UseN book_N ;
Buying = UseN2 (VerbToNounV2 buy_V2) ;
Day = UseN day_N ;
Eating = UseN2 (VerbToNounV2 eat_V2) ;
Egg = UseN egg_N ;
House = UseN house_N ; 
Man = UseN man_N ;
Meat = UseN meat_N ;
WaterCloud = ApposCN (UseN water_N) (MassNP (UseN cloud_N)) ;
Wind = UseN wind_N ;
Woman = UseN woman_N ;
Worm = UseN worm_N ;
Year = UseN year_N ;

-- unary functions
FloorFn ob = AdvNP (DetCN (DetQuant DefArt NumSg) (UseN floor_N)) (PrepNP part_Prep ob) ; 
YearFn ob = AdvCN (UseN year_N) (PrepNP part_Prep ob) ;
SquareRootFn ob = AdvNP (DetCN (DetQuant DefArt NumSg) (AdjCN (PositA square_A) (UseN root_N))) (PrepNP part_Prep ob) ;
RoundFn ob = AdvNP (DetCN (DetQuant DefArt NumSg) (AdjCN (PositA round_A) (UseN value_N))) (PrepNP possess_Prep ob) ;

-- binary functions 


DayFn ob1 ob2 = AdvCN (ApposCN (UseN day_N) ob1) (PrepNP part_Prep (MassNP ob2)) ;



knows ob1 ob2 = mkPolSent (PredVP ob1 (ComplSlash (SlashV2a know_V2) (sentToNoun ob2))) ;
smaller ob1 ob2 = mkPolSent (PredVP ob1 (UseComp (CompAP (ComparA small_A ob2)))) ;
husband ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN husband_N)))) (PrepNP part_Prep ob2))) ;
wife ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN wife_N)))) (PrepNP part_Prep ob2))) ;
sister ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN sister_N)))) (PrepNP part_Prep ob2))) ;

-- ternary predicate 


--others
toInt x = mkNP x.s ("lui" ++ x.s) x.s Sg Masc;
toRealNum x = mkNP x.s ("lui" ++ x.s) x.s Sg Masc; 


---------------- CNL demo
Entity = UseN entity_N ;
Abstract = UseN abstract_N ;
Attribute = UseN attribute_N ; 
Graph = UseN graph_N ;
GraphElement = AdvCN (UseN element_N) (PrepNP part_Prep (MassNP (UseN graph_N))) ;
Proposition = UseN proposition_N ;
Quantity = UseN quantity_N ;
SetOrClass = ConjCN or_Conj (BaseCN (UseN set_N) (UseN class_N)) ;
Physical = UseN physical_N ;
ContentBearingPhysical = AdvCN (UseN physical_N) (PrepNP with_Prep (MassNP (UseN content_N))) ;
Object = UseN object_N ;
PhysicalSystem = AdjCN (PositA physical_A) (UseN system_N) ;
Process = UseN process_N ;


};