--# -path=.:french:romance:abstract:prelude:common
concrete Mid_level_ontologyFre of Mid_level_ontology = MergeFre ** open DictLangFre, ParadigmsFre, LexiconFre, ExtraLexiconFre  in{

lin

-- individual instances :

Student = MassNP (UseN student_N) ;
Teacher = MassNP (UseN teacher_N) ;


-- subclasses 
Apple = UseN apple_N ;
ArtSchool = ApposCN (UseN art_N) (MassNP (UseN school_N)) ;
Beer = UseN beer_N ;
BirdEgg = ApposCN (UseN bird_N) (MassNP (UseN egg_N)) ;
Boy = UseN boy_N ;
Closing = UseN2 (VerbToNounV2 close_V2) ;
DaySchool = ApposCN (UseN day_N) (MassNP (UseN school_N)) ;
Eye = UseN eye_N ;
Girl = UseN girl_N ;
Grass = UseN grass_N ;
Head = UseN head_N ;
Heart = UseN heart_N ;
Knee = UseN knee_N ;
Milk = UseN milk_N ;
Restaurant = UseN restaurant_N ;

-- unary functions :

FirstFn ob = AdvNP (DetCN (DetQuantOrd DefArt NumSg (OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))))) (UseN element_N)) (PrepNP part_Prep ob) ;


--bespeak_V2
speaksLanguage ob1 ob2 = mkPolSent (PredVP ob1 (ComplSlash (SlashV2a speak_V2) (DetCN (DetQuant DefArt NumSg) (ApposCN (UseN language_N) ob2)))) ;
student ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN student_N)))) (PrepNP part_Prep ob2))) ;
teacher ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN teacher_N)))) (PrepNP part_Prep ob2))) ;
friend ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN friend_N)))) (PrepNP part_Prep ob2))) ;
cousin ob1 ob2 = mkPolSent (PredVP ob1 (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN cousin_N)))) (PrepNP part_Prep ob2))) ;
fears ob1 ob2 = mkPolSent (PredVP ob1 (ComplSlash (SlashV2a fear_V2) (sentToNoun ob2))) ;

 };