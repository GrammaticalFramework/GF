resource MissingLat = open GrammarLat, Prelude in {

-- temporary definitions to enable the compilation of RGL API
oper AdAdv : AdA -> Adv -> Adv = notYet "AdAdv" ;
oper AdNum : AdN -> Card -> Card = notYet "AdNum" ;
oper AdVVP : AdV -> VP -> VP = notYet "AdVVP" ;
oper AdjOrd : Ord -> AP = notYet "AdjOrd" ;
oper AdnCAdv : CAdv -> AdN = notYet "AdnCAdv" ;
oper AdvCN : CN -> Adv -> CN = notYet "AdvCN" ;
oper AdvIAdv : IAdv -> Adv -> IAdv = notYet "AdvIAdv" ;
oper AdvIP : IP -> Adv -> IP = notYet "AdvIP" ;
oper AdvS : Adv -> S -> S = notYet "AdvS" ;
oper AdvSlash : ClSlash -> Adv -> ClSlash = notYet "AdvSlash" ;
oper ApposCN : CN -> NP -> CN = notYet "ApposCN" ;
oper BaseNP : NP -> NP -> ListNP = notYet "BaseNP" ;
oper BaseRS : RS -> RS -> ListRS = notYet "BaseRS" ;
oper BaseS : S -> S -> ListS = notYet "BaseS" ;
oper CAdvAP : CAdv -> AP -> NP -> AP = notYet "CAdvAP" ;
oper CleftAdv : Adv -> S -> Cl = notYet "CleftAdv" ;
oper CleftNP : NP -> RS -> Cl = notYet "CleftNP" ;
oper CompAdv : Adv -> Comp = notYet "CompAdv" ;
oper CompCN : CN -> Comp = notYet "CompCN" ;
oper CompIP : IP -> IComp = notYet "CompIP" ;
oper CompNP : NP -> Comp = notYet "CompNP" ;
oper ComparA : A -> NP -> AP = notYet "ComparA" ;
oper ComparAdvAdj : CAdv -> A -> NP -> Adv = notYet "ComparAdvAdj" ;
oper ComparAdvAdjS : CAdv -> A -> S -> Adv = notYet "ComparAdvAdjS" ;
oper ComplA2 : A2 -> NP -> AP = notYet "ComplA2" ;
oper ComplN2 : N2 -> NP -> CN = notYet "ComplN2" ;
oper ComplN3 : N3 -> NP -> N2 = notYet "ComplN3" ;
oper ConjNP : Conj -> ListNP -> NP = notYet "ConjNP" ;
oper ConjRS : Conj -> ListRS -> RS = notYet "ConjRS" ;
oper ConsNP : NP -> ListNP -> ListNP = notYet "ConsNP" ;
oper ConsRS : RS -> ListRS -> ListRS = notYet "ConsRS" ;
oper ConsS : S -> ListS -> ListS = notYet "ConsS" ;
oper DetNP : Det -> NP = notYet "DetNP" ;
oper DetQuantOrd : Quant -> Num -> Ord -> Det = notYet "DetQuantOrd" ;
oper EmbedQS : QS -> SC = notYet "EmbedQS" ;
oper EmbedS : S -> SC = notYet "EmbedS" ;
oper EmbedVP : VP -> SC = notYet "EmbedVP" ;
oper ExistIP : IP -> QCl = notYet "ExistIP" ;
oper ExistNP : NP -> Cl = notYet "ExistNP" ;
oper FunRP : Prep -> NP -> RP -> RP = notYet "FunRP" ;
oper GenericCl : VP -> Cl = notYet "GenericCl" ;
oper IdRP : RP = notYet "IdRP" ;
oper IdetCN : IDet -> CN -> IP = notYet "IdetCN" ;
oper IdetIP : IDet -> IP = notYet "IdetIP" ;
oper IdetQuant : IQuant -> Num -> IDet = notYet "IdetQuant" ;
oper ImpPl1 : VP -> Utt = notYet "ImpPl1" ;
oper ImpVP : VP -> Imp = notYet "ImpVP" ;
oper ImpersCl : VP -> Cl = notYet "ImpersCl" ;
oper MassNP : CN -> NP = notYet "MassNP" ;
oper NumCard : Card -> Num = notYet "NumCard" ;
oper NumDigits : Digits -> Card = notYet "NumDigits" ;
oper NumNumeral : Numeral -> Card = notYet "NumNumeral" ;
oper OrdDigits : Digits -> Ord = notYet "OrdDigits" ;
oper OrdNumeral : Numeral -> Ord = notYet "OrdNumeral" ;
oper OrdSuperl : A -> Ord = notYet "OrdSuperl" ;
oper PPartNP : NP -> V2 -> NP = notYet "PPartNP" ;
oper PassV2 : V2 -> VP = notYet "PassV2" ;
oper PositAdvAdj : A -> Adv = notYet "PositAdvAdj" ;
oper PossPron : Pron -> Quant = notYet "PossPron" ;
oper PredSCVP : SC -> VP -> Cl = notYet "PredSCVP" ;
oper PredetNP : Predet -> NP -> NP = notYet "PredetNP" ;
oper PrepIP : Prep -> IP -> IAdv = notYet "PrepIP" ;
oper ProgrVP : VP -> VP = notYet "ProgrVP" ;
oper ReflA2 : A2 -> AP = notYet "ReflA2" ;
oper ReflVP : VPSlash -> VP = notYet "ReflVP" ;
oper RelCN : CN -> RS -> CN = notYet "RelCN" ;
oper RelCl : Cl -> RCl = notYet "RelCl" ;
oper RelNP : NP -> RS -> NP = notYet "RelNP" ;
oper RelSlash : RP -> ClSlash -> RCl = notYet "RelSlash" ;
oper RelVP : RP -> VP -> RCl = notYet "RelVP" ;
oper SentAP : AP -> SC -> AP = notYet "SentAP" ;
oper SentCN : CN -> SC -> CN = notYet "SentCN" ;
oper Slash2V3 : V3 -> NP -> VPSlash = notYet "Slash2V3" ;
oper SlashV2S : V2S -> S -> VPSlash = notYet "SlashV2S" ;
oper SlashV2V : V2V -> VP -> VPSlash = notYet "SlashV2V" ;
oper SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash = notYet "SlashV2VNP" ;
oper SlashVS : NP -> VS -> SSlash -> ClSlash = notYet "SlashVS" ;
oper SlashVV : VV -> VPSlash -> VPSlash = notYet "SlashVV" ;
oper Use2N3 : N3 -> N2 = notYet "Use2N3" ;
oper UseComparA : A -> AP = notYet "UseComparA" ;
oper UseRCl : Temp -> Pol -> RCl -> RS = notYet "UseRCl" ;
oper UseSlash : Temp -> Pol -> ClSlash -> SSlash = notYet "UseSlash" ;
oper UttAP : AP -> Utt = notYet "UttAP" ;
oper UttAdv : Adv -> Utt = notYet "UttAdv" ;
oper UttCN : CN -> Utt = notYet "UttCN" ;
oper UttCard : Card -> Utt = notYet "UttCard" ;
oper UttIAdv : IAdv -> Utt = notYet "UttIAdv" ;
oper UttIP : IP -> Utt = notYet "UttIP" ;
oper UttImpPl : Pol -> Imp -> Utt = notYet "UttImpPl" ;
oper UttImpPol : Pol -> Imp -> Utt = notYet "UttImpPol" ;
oper UttImpSg : Pol -> Imp -> Utt = notYet "UttImpSg" ;
oper UttNP : NP -> Utt = notYet "UttNP" ;
oper UttVP : VP -> Utt = notYet "UttVP" ;
oper n2 : Digit = notYet "n2" ;
oper n3 : Digit = notYet "n3" ;
oper n4 : Digit = notYet "n4" ;
oper n5 : Digit = notYet "n5" ;
oper n6 : Digit = notYet "n6" ;
oper n7 : Digit = notYet "n7" ;
oper n8 : Digit = notYet "n8" ;
oper n9 : Digit = notYet "n9" ;
oper num : Sub1000000 -> Numeral = notYet "num" ;
oper pot0 : Digit -> Sub10 = notYet "pot0" ;
oper pot01 : Sub10 = notYet "pot01" ;
oper pot0as1 : Sub10 -> Sub100 = notYet "pot0as1" ;
oper pot1 : Digit -> Sub100 = notYet "pot1" ;
oper pot110 : Sub100 = notYet "pot110" ;
oper pot111 : Sub100 = notYet "pot111" ;
oper pot1as2 : Sub100 -> Sub1000 = notYet "pot1as2" ;
oper pot1plus : Digit -> Sub10 -> Sub100 = notYet "pot1plus" ;
oper pot1to19 : Digit -> Sub100 = notYet "pot1to19" ;
oper pot2 : Sub10 -> Sub1000 = notYet "pot2" ;
oper pot2as3 : Sub1000 -> Sub1000000 = notYet "pot2as3" ;
oper pot2plus : Sub10 -> Sub100 -> Sub1000 = notYet "pot2plus" ;
oper pot3 : Sub1000 -> Sub1000000 = notYet "pot3" ;
oper pot3plus : Sub1000 -> Sub1000 -> Sub1000000 = notYet "pot3plus" ;

}

{-
AR 28/3/2017

To build:

$ gf api/TryLat.gf  | grep constant | sort -u >missLat.tmp

$ ghci
Prelude> pgf <- PGF.readPGF "Lang.pgf"
Prelude> ms <- readFile "missLat.tmp" >>= return . map (last . words) . lines
Prelude> let ts = [PGF.showType [] t | m <- ms, Just t <- [PGF.functionType pgf (PGF.mkCId m)]]
Prelude> putStrLn $ unlines ["oper " ++ f ++ " : " ++ t ++ " = notYet \"" ++ f ++ "\" ;" | (f,t) <- zip ms ts]

To use:

--# -path=.:alltenses:prelude:../latin
resource ConstructorsLat = Constructors with (Grammar = GrammarLat)  **
 open MissingLat in {}

-}