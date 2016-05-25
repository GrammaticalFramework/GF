abstract TransferGrcAbs = Sentence, Noun, Verb, Structural, ExtraGrcAbs ** {

fun refl2medium : Cl -> Cl ;
def refl2medium (PredVP subj (ReflVP (SlashV2a v))) = PredVP subj (MedVP v) ;

-- The transformation of a (PossPron pron):Quant to an adjective or Adv is impossible,
-- since it would need data DetCN rather than fun DetCN !
--
-- data DetCN : Cat.Det -> Cat.CN -> Cat.NP ;
--
-- fun possAdj : NP -> NP ;
-- def possAdj (DetCN (DetQuant (PossPron pers) num) cn) = 
--             (DetCN (DetQuant DefArt num) (AdvCN cn (PrepNP possess_Prep (UsePron pers)))) ;

-- Likewise, PartVP is not a data constructor!
-- fun partAP : AP -> AP ;
-- def partAP (PartVP vp) = PartPresVP PPos vp ;

}    

{- 
-- Expl. > i AllGrc.gf 
--       > p "e)gw' le'gw e)mayto'n" | pt -transfer=refl2medium | l 
-- PhrUtt NoPConj (UttS (UseCl (TTAnt TPres ASimul) PPos (PredVP (UsePron i_Pron) (ReflVP (SlashV2a read_V2))))) NoVoc

AllGrcAbs> pt (PredVP (UsePron i_Pron) (ReflVP (SlashV2a read_V2))) | l
e)gw' le'gw e)mayto'n

AllGrcAbs> pt -transfer=refl2medium (PredVP (UsePron i_Pron) (ReflVP (SlashV2a read_V2))) | l
e)gw' le'gomai

-} 


