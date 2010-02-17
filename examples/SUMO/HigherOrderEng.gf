--# -path=.:englishExtended
concrete HigherOrderEng of HigherOrder = BasicEng ** open DictLangEng, DictEng, ParadigmsEng, ResEng, ParamBasic in {
 
lin


AsymmetricRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA asymmetric_A) (UseN relation_N)))))) ;
EquivalenceRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (ApposCN (UseN equivalence_N) (MassNP (UseN relation_N))))))) ;
IntransitiveRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA intransitive_A) (UseN relation_N)))))) ;
-- OneToOneFunction c1 c2 f = mkPolSent(PredVP f (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdvCN (UseN one_N) (PrepNP to_Prep (DetCN (DetQuant IndefArt (NumCard (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01))))))) (UseN function_N)))))))) ;
PartialOrderingRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA partial_A) (ApposCN (UseN2 (VerbToNounV2 order_V2)) (MassNP (UseN relation_N)))))))) ;
SequenceFunction c f = mkPolSent(PredVP  f (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (ApposCN (UseN sequence_N) (MassNP (UseN function_N))))))) ;
ReflexiveRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA reflexive_A) (UseN relation_N)))))) ;
SymmetricRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA symmetric_A) (UseN relation_N)))))) ;
TotalOrderingRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA total_A) (ApposCN (UseN2 (VerbToNounV2 order_V2)) (MassNP (UseN relation_N)))))))) ;
TransitiveRelation c f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA transitive_A) (UseN relation_N)))))) ;
IntentionalRelation c1 c2 f = mkPolSent(PredVP (sentToNoun f) (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (AdjCN (PositA intentional_A) (UseN relation_N)))))) ;
subRelation2El c1 c2 c3 c4 f g = mkPolSent (PredVP (sentToNoun f) (AdvVP (UseComp (CompNP (DetCN (DetQuant IndefArt NumSg) (ApposCN (UseN sub_N) (MassNP (UseN relation_N)))))) (PrepNP part_Prep (sentToNoun g)))) ;
identityElement c f elem = mkPolSent (PredVP elem (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (ApposCN (UseN identity_N) (MassNP (UseN element_N)))))) (PrepNP part_Prep f))) ;
inverse c f g = mkPolSent (PredVP (sentToNoun f) (AdvVP (UseComp (CompNP (DetCN (DetQuant DefArt NumSg) (UseN inverse_N)))) (PrepNP part_Prep (sentToNoun g)))) ;
};