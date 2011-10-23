concrete AbsToAPIAbs of AbsToAPI = { 

lincat 
A, A2, A2V, AV, AS, AP, AdA, AdN, AdV, Adv, Ant, Art, CAdv, CN, Card, Cl, ClSlash, Comp, Conj, Det, Dig, Digit, Digits, IAdv, IComp, IDet, IP, IQuant, Imp, Interj, ListAP, ListAdv, ListCN, ListIAdv, ListNP, ListRS, ListS, N, N2, N3, NP, Num, Numeral, Ord, PConj, PN, Phr, Pol, Predet, Prep, Pron, QCl, QS, QVP, Quant, RCl, RP, RS, S, SC, SSlash, Subj, Temp, Tense, Text, Utt, V, V0, V2, V2A, V2Q, V2S, V2V, V3, VA, VP, VPSlash, VQ, VS, VV, Voc, String, QuantSg, QuantPl  = {ind : Str; attr : Str} ;

ImpForm = {ind : Str; attr : Str; iform : IForm} ;
Punct = {ind : Str; attr : Str; pform : PForm } ;

param PForm = PFullStop | PQuestMark | PExclMark ;
param IForm = IFSg | IFPl | IFPol ;

lin


mkText1 = \phr,punct,text ->  case punct.pform of 
             { PFullStop      => mkCompCat ( "TFullStop" ++ phr.attr ++ text.attr ) ;
               PExclMark     => mkCompCat ("TExclMark" ++ phr.attr ++ text.attr ) ; 
               _                    => mkCompCat ("TQuestMark" ++ phr.attr ++ text.attr) }; 

mkText2 = \x,t -> mkCompCat ("TFullStop" ++ x.attr ++ t.attr) ; 
mkText3 = \phr,punct -> case  punct.pform of
            {PFullStop      => mkCompCat ("TFullStop" ++ phr.attr ++ "TEmpty") ;
             PExclMark    => mkCompCat ("TExclMark" ++ phr.attr ++ "TEmpty") ;
             _                   => mkCompCat ("TQuestMark" ++ phr.attr ++ "TEmpty") }; 
mkText4 = \x -> mkCompCat ( "TFullStop" ++ x.attr ++ "TEmpty" ) ; 
mkText5 = \u -> mkCompCat ( "TFullStop" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ u.attr ++ "NoVoc" ++ ")" ++ "TEmpty" ) ; 
mkText6 = \s -> mkCompCat ( "TFullStop" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttS" ++ s.attr ++ ")" ++ "NoVoc" ++ ")" ++ "TEmpty" ) ; 
mkText7 = \c -> mkCompCat ( "TFullStop" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttS" ++ "(" ++ "UseCl" ++"(" ++ "TTAnt" ++ "TPres" ++ ")" ++ "ASimul" ++ "PPos" ++ c.attr ++ ")" ++ ")" ++ "NoVoc" ++ ")" ++ "TEmpty" ); 
mkText8 = \q -> mkCompCat ( "TQuestMark" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttQS" ++ q.attr ++ ")" ++ "NoVoc" ++ ")" ++ "TEmpty" ) ; 
mkText9 = \p,i -> mkCompCat ( "TExclMark" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttImpSg" ++ p.attr ++ i.attr ++ ")" ++ "NoVoc" ++ ")" ++ "TEmpty" ) ; 
mkText10 = \i -> mkCompCat ( "TExclMark" ++ "(" ++ "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttImpSg" ++ "PPos" ++ i.attr ++ ")" ++ "NoVoc" ++ ")" ++ "TEmpty" ) ; 

emptyText = mkSimpCat "TEmpty" ;

fullStopPunct  = mkSimpCat "PFullStop" ** {pform = PFullStop};      
questMarkPunct = mkSimpCat "PQuestMark" ** {pform = PQuestMark} ;
exclMarkPunct  = mkSimpCat "PExclMark" ** {pform = PExclMark};

mkPhr1 =  mkTernaryCat "PhrUtt"  ; 
mkPhr2 = \u,v -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ u.attr ++ v.attr ) ; 
mkPhr3 = \u,v -> mkCompCat ( "PhrUtt" ++ u.attr ++ v.attr ++ "NoVoc" ) ; 
mkPhr4 = \u -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ u.attr ++ "NoVoc" ) ; 
mkPhr5 = \s -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttS" ++ s.attr ++ ")" ++ "NoVoc" ) ; 
mkPhr6 = \s -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttS" ++ "(" ++ "UseCl" ++ "(" ++ "TTAnt" ++"TPres" ++ "ASimul" ++ ")" ++ "PPos" ++ s.attr ++ ")" ++ ")" ++ "NoVoc" ) ; 
mkPhr7 = \s -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttQS" ++ s.attr ++ ")" ++ "NoVoc" ) ; 
mkPhr8 = \s -> mkCompCat ( "PhrUtt" ++ "NoPConj" ++ "(" ++ "UttImpSg" ++ "PPos" ++ s.attr ++ ")" ++ "NoVoc" ) ;

mkPConj = mkUnaryCat "PConjConj" ; 
noPConj = mkSimpCat "NoPConj" ;

mkVoc = mkUnaryCat "VocNP" ; 
noVoc = mkSimpCat "NoVoc" ;

mkUtt1 = mkUnaryCat "UttS" ; 
mkUtt2 = \c -> mkCompCat ( "UttS" ++ "(" ++ "UseCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")"++ "PPos" ++ c.attr ++ ")" ) ; 
mkUtt3 = mkUnaryCat "UttQS" ; 
mkUtt4 = \c -> mkCompCat ( "UttQS" ++ "(" ++ "UseQCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ "PPos" ++ c.attr ++ ")" ) ; 
mkUtt5 = \f, p, i -> case f.iform of 
        { IFSg => mkCompCat ("UttImpSg" ++ p.attr ++ i.attr ) ;
          IFPl  => mkCompCat ("UttImpPl" ++ p.attr ++ i.attr) ;
          _      => mkCompCat ("UttImpPol" ++ p.attr ++ i.attr) } ; 
mkUtt6 = \f,i -> case f.iform of 
        { IFSg => mkCompCat ("UttImpSg" ++ "PPos" ++ i.attr ) ;
          IFPl  => mkCompCat ("UttImpPl" ++ "PPos" ++ i.attr) ;
          _      => mkCompCat ("UttImpPol" ++ "PPos" ++ i.attr) } ;
mkUtt7 = mkBinaryCat "UttImpSg" ; 
mkUtt8 = mkUnaryCat ("UttImpSg" ++ "PPos") ; 
mkUtt9 = mkUnaryCat "UttIP" ; 
mkUtt10 = mkUnaryCat "UttIAdv" ; 
mkUtt11 = mkUnaryCat "UttNP" ; 
mkUtt12 = mkUnaryCat "UttAdv" ; 
mkUtt13 = mkUnaryCat "UttVP" ; 
mkUtt14 = mkUnaryCat "UttCN" ; 
mkUtt15 = mkUnaryCat "UttAP" ; 
mkUtt16 = mkUnaryCat "UttCard" ; 

lets_Utt = mkUnaryCat "ImpPl1" ; 

negativePol = mkSimpCat "PNeg" ;
positivePol = mkSimpCat "PPos" ;

simultaneousAnt = mkSimpCat "ASimul" ;
anteriorAnt = mkSimpCat "AAnter" ;

presentTense = mkSimpCat "TPres" ;
pastTense = mkSimpCat "TPast" ;
futureTense = mkSimpCat "TFut" ; 
conditionalTense = mkSimpCat "TCond" ; 

mkTemp = mkBinaryCat "TTAnt" ;

singularImpForm = mkSimpCat "IFSg" ** {iform = IFSg} ; 
pluralImpForm = mkSimpCat "IFPI" ** {iform = IFPl}; 
politeImpForm = mkSimpCat "IFPol" ** {iform = IFPol} ;  

mkS1 = mkUnaryCat ("UseCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ "PPos" ) ; 
mkS2 = \t, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ "PPos" ++ cl.attr) ; 
mkS3 = \a, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++"TPres" ++ a.attr ++ ")" ++ "PPos" ++ cl.attr) ; 
mkS4 = \p, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ p.attr ++ cl.attr) ; 
mkS5 = \t,a, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ "PPos" ++ cl.attr ) ; 
mkS6 = \t,p, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ p.attr ++ cl.attr) ; 
mkS7 = \a,p, cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++"TPres" ++ a.attr ++ ")" ++ p.attr ++ cl.attr) ; 
mkS8 = \t,a,p,cl -> mkCompCat ( "UseCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ p.attr ++ cl.attr ) ; 
mkS9 = mkTernaryCat "UseCl" ; 
mkS10 = \c,x,y -> mkCompCat ( "ConjS" ++ c.attr ++ "(" ++ "BaseS" ++ x.attr ++ y.attr ++ ")" ) ; 
mkS11 = \c,xy -> mkCompCat ( "ConjS" ++ c.attr ++ xy.attr ) ; 
mkS12 = mkBinaryCat "AdvS" ; 

mkCl1 = \s,v -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "UseV" ++ v.attr ++ ")" ) ; 
mkCl2 = \s,v,o -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplV2" ++ v.attr ++ o.attr ++ ")" ) ; 
mkCl3 = \s,v,o,i -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplV3" ++ v.attr ++ o.attr ++ i.attr ++ ")" ) ; 
mkCl4 = \s,v,vp -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplVV" ++ v.attr ++ vp.attr ++ ")" ) ; 
mkCl5 = \s,v,p -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplVS" ++ v.attr ++ p.attr ++ ")" ) ; 
mkCl6 = \s,v,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplVQ" ++ v.attr ++ q.attr ++ ")" ) ; 
mkCl7 = \s,v,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkCl8 = \s,v,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ q.attr ++ ")" ) ; 
mkCl9 = \s,v,n,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkCl10 = \s,v,n,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ q.attr ++ ")" ) ; 
mkCl11 = \s,v,n,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2S" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkCl12 = \s,v,n,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2Q" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkCl13 = \s,v,n,q -> mkCompCat ( "PredVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2V" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkCl14 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "PositA" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkCl15 = \x,y,z -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComparA" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkCl16 = \x,y,z -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComplA2" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkCl17 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ y.attr ++ ")" ++ ")" ) ; 
mkCl18 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompNP" ++ y.attr ++ ")" ++ ")" ) ; 
mkCl19 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ "(" ++ "UseN" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkCl20 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ y.attr ++ ")" ++ ")" ) ; 
mkCl21 = \x,y -> mkCompCat ( "PredVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAdv" ++ y.attr ++ ")" ++ ")" ) ; 
mkCl22 = mkBinaryCat "PredVP" ; 
mkCl23 = \y -> mkCompCat ( "ExistNP" ++ "(" ++ "DetArtSg" ++ "IndefArt" ++ "(" ++ "UseN" ++ y.attr ++ ")" ++ ")" ) ; 
mkCl24 = \y -> mkCompCat ( "ExistNP" ++ "(" ++ "DetArtSg" ++ "IndefArt" ++ y.attr ++ ")" ) ; 
mkCl25 = mkUnaryCat "ExistNP" ; 
mkCl26 = mkBinaryCat "CleftNP" ; 
mkCl27 = mkBinaryCat "CleftAdv" ; 
mkCl28 = \v -> mkCompCat ( "ImpersCl" ++ "(" ++ "UseV" ++ v.attr ++ ")" ) ; 
mkCl29 = mkUnaryCat "ImpersCl" ; 
mkCl30 = mkBinaryCat "PredSCVP" ;
 
genericCl = mkUnaryCat "GenericCl" ;
 
mkVP1 = mkUnaryCat "UseV" ; 
mkVP2 = mkBinaryCat "ComplV2" ; 
mkVP3 = mkTernaryCat "ComplV3" ; 
mkVP4 = mkBinaryCat "ComplVV" ; 
mkVP5 = mkBinaryCat "ComplVS" ; 
mkVP6 = mkBinaryCat "ComplVQ" ; 
mkVP7 = mkBinaryCat "ComplVA" ; 
mkVP8 = mkTernaryCat "ComplV2A" ; 
mkVP9 = \v,n,q -> mkCompCat (  "ComplSlash" ++ "(" ++ "SlashV2S" ++ v.attr ++ q.attr ++ ")" ++ n.attr  ) ; 
mkVP10 = \v,n,q -> mkCompCat ( "ComplSlash" ++ "(" ++ "SlashV2Q" ++ v.attr ++ q.attr ++ ")" ++ n.attr ) ; 
mkVP11 = \v,n,q -> mkCompCat ( "ComplSlash" ++ "(" ++ "SlashV2V" ++ v.attr ++ q.attr ++ ")" ++ n.attr ) ; 
mkVP12 = \a -> mkCompCat ( "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "PositA" ++ a.attr ++ ")" ++ ")" ) ; 
mkVP13 = \y,z -> mkCompCat (  "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComparA" ++ y.attr ++ z.attr ++ ")" ++ ")" ) ; 
mkVP14 = \y,z -> mkCompCat ( "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComplA2" ++ y.attr ++ z.attr ++ ")" ++ ")" ) ; 
mkVP15 = \a -> mkCompCat ( "UseComp" ++ "(" ++ "CompAP" ++ a.attr ++ ")" ) ; 
mkVP16 = \y -> mkCompCat ( "UseComp" ++ "(" ++ "CompCN" ++ "(" ++ "UseN" ++ y.attr ++ ")" ++ ")" ) ; 
mkVP17 = \y -> mkCompCat ( "UseComp" ++ "(" ++ "CompCN" ++ y.attr ++ ")" ) ; 
mkVP18 = \a -> mkCompCat ( "UseComp" ++ "(" ++ "CompNP" ++ a.attr ++ ")" ) ; 
mkVP19 = \a -> mkCompCat ( "UseComp" ++ "(" ++ "CompAdv" ++ a.attr ++ ")" ) ; 
mkVP20 = mkBinaryCat "AdvVP" ; 
mkVP21 = mkBinaryCat "AdVVP" ; 
mkVP22 = mkBinaryCat "ComplSlash" ; 
mkVP23 = mkUnaryCat "ReflVP" ; 
mkVP24 = mkUnaryCat "UseComp" ; 

reflexiveVP1 = \v -> mkCompCat ( "ReflVP" ++ "(" ++ "SlashV2a" ++ v.attr ++ ")" ) ; 
reflexiveVP2 = mkUnaryCat "ReflVP" ;
 
passiveVP1 = mkUnaryCat "PassV2" ; 
passiveVP2 = \v,np -> mkCompCat ( "AdvVP" ++ "(" ++ "PassV2" ++ v.attr ++ ")" ++ "(" ++ "PrepNP" ++ "by8agent_Prep" ++ np.attr ++ ")" ) ; 
 
progressiveVP = mkUnaryCat "ProgrVP" ;
 
mkComp1 = mkUnaryCat "CompAP" ; 
mkComp2 = mkUnaryCat "CompNP" ; 
mkComp3 = mkUnaryCat "CompAdv" ; 

mkSC1 = mkUnaryCat "EmbedS" ; 
mkSC2 = mkUnaryCat "EmbedQS" ; 
mkSC3 = mkUnaryCat "EmbedVP" ; 

mkImp1 = mkUnaryCat "ImpVP" ; 
mkImp2 = \v -> mkCompCat ( "ImpVP" ++ "(" ++ "UseV" ++ v.attr ++ ")" ) ; 
mkImp3 = \v,np -> mkCompCat ( "ImpVP" ++ "(" ++ "ComplV2" ++ v.attr ++ np.attr ++ ")" ) ; 

mkNP1 = \q,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ "NumSg" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP2 = \q,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ "NumSg" ++ ")" ++ n.attr ) ; 
mkNP3 = \q,nu,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ nu.attr ++ ")" ++ n.attr ) ; 
mkNP4 = \q,nu,or,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuantOrd" ++ q.attr ++ nu.attr ++ or.attr ++ ")" ++ n.attr ) ; 
mkNP5 = \q,nu,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ nu.attr ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP6 = mkBinaryCat "DetCN" ; 
mkNP7 = \d,n -> mkCompCat ( "DetCN" ++ d.attr ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP8 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumNumeral" ++ d.attr ++ ")" ++ ")" ++ n.attr ) ; 
mkNP9 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumNumeral" ++ d.attr ++ ")" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP10 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumDigits" ++ d.attr ++ ")" ++ ")" ++ n.attr ) ; 
mkNP11 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumDigits" ++ d.attr ++ ")" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP12 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumNumeral" ++ "(" ++ "num" ++ "(" ++ "pot2as3" ++ "(" ++ "pot1as2" ++ "(" ++ "pot0as1" ++ "(" ++ "pot0" ++ d.attr ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ n.attr ) ; 
mkNP13 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumNumeral" ++ "(" ++ "num" ++ "(" ++ "pot2as3" ++ "(" ++ "pot1as2" ++ "(" ++ "pot0as1" ++ "(" ++ "pot0" ++ d.attr ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP14 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ d.attr ++ ")" ++ n.attr ) ; 
mkNP15 = \d,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetArtCard" ++ "IndefArt" ++ d.attr ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP16 = \p,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ "(" ++ "PossPron" ++ p.attr ++ ")" ++ "NumSg" ++ ")" ++ n.attr ) ; 
mkNP17 = \p,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ "(" ++ "PossPron" ++ p.attr ++ ")" ++ "NumSg" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP18 = mkUnaryCat "UsePN" ; 
mkNP19 = mkUnaryCat "UsePron" ; 
mkNP20 = \q -> mkCompCat ( "DetNP" ++ "(" ++ "DetQuant" ++ q.attr ++ "NumSg" ++ ")" ) ; 
mkNP21 = \q,n -> mkCompCat ( "DetNP" ++ "(" ++ "DetQuant" ++ q.attr ++ n.attr ++ ")" ) ; 
mkNP22 = mkUnaryCat "DetNP" ; 
mkNP23 = mkUnaryCat "MassNP" ; 
mkNP24 = \n -> mkCompCat ( "MassNP" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkNP25 = mkBinaryCat "PredetNP" ; 
mkNP26 = mkBinaryCat "PPartNP" ; 
mkNP27 = mkBinaryCat "AdvNP" ; 
mkNP28 = mkBinaryCat "RelNP" ; 
mkNP29 = \c,x,y -> mkCompCat ( "ConjNP" ++ c.attr ++ "(" ++ "BaseNP" ++ x.attr ++ y.attr ++ ")" ) ; 
mkNP30 = \c,xy -> mkCompCat ( "ConjNP" ++ c.attr ++ xy.attr ) ; 
mkNP31 = \q,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ "NumSg" ++ ")" ++ n.attr ) ; 
mkNP32 = \q,n -> mkCompCat ( "DetCN" ++ "(" ++ "DetQuant" ++ q.attr ++ "NumPl" ++ ")" ++ n.attr ) ;

i_NP = mkCompCat ("mkNP" ++ "i_Pron") ;         
you_NP = mkCompCat ("mkNP" ++ "youSg_Pron") ;     
youPol_NP = mkCompCat ("mkNP" ++ "youPol_Pron") ; 
he_NP = mkCompCat ("mkNP" ++ "he_Pron") ;      
she_NP = mkCompCat ("mkNP" ++ "she_Pron") ;     
it_NP = mkCompCat ("mkNP" ++ "it_Pron") ;      
we_NP = mkCompCat ("mkNP" ++ "we_Pron") ;       
youPl_NP = mkCompCat ("mkNP" ++ "youPl_Pron") ; 
they_NP = mkCompCat ("mkNP" ++ "they_Pron") ; 
this_NP = mkCompCat ("DetNP" ++ "(" ++ "DetQuant" ++ "this_Quant" ++ "NumSg" ++ ")") ; 
that_NP = mkCompCat ("DetNP" ++ "(" ++ "DetQuant" ++ "that_Quant" ++ "NumSg" ++ ")") ; 
these_NP = mkCompCat ("DetNP" ++ "(" ++ "DetQuant" ++ "this_Quant" ++ "NumPl" ++ ")") ; 
those_NP = mkCompCat ("DetNP" ++ "(" ++ "DetQuant" ++ "that_Quant" ++ "NumPl" ++ ")") ;

 
mkDet1 = \q -> mkCompCat ( "DetQuant" ++ q.attr ++ "NumSg" ) ; 
mkDet2 = \d,nu -> mkCompCat ( "DetQuant" ++ d.attr ++ "(" ++ "NumCard" ++ nu.attr ++ ")" ) ; 
mkDet3 = \q,o -> mkCompCat ( "DetQuantOrd" ++ q.attr ++ "NumSg" ++ o.attr ) ; 
mkDet4 = mkTernaryCat "DetQuantOrd" ; 
mkDet5 = mkBinaryCat "DetQuant" ; 
mkDet6 = mkUnaryCat ("DetArtCard" ++ "IndefArt" ) ; 
mkDet7 = \d -> mkCompCat ( "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumDigits" ++ d.attr ++ ")" ) ; 
mkDet8 = \d -> mkCompCat ( "DetArtCard" ++ "IndefArt" ++ "(" ++ "NumNumeral" ++ d.attr ++ ")" ) ; 
mkDet9 = \p -> mkCompCat ( "DetQuant" ++ "(" ++ "PossPron" ++ p.attr ++ ")" ++ "NumSg" ) ; 
mkDet10 = \p,n -> mkCompCat ( "DetQuant" ++ "(" ++ "PossPron" ++ p.attr ++ ")" ++ n.attr ) ; 

the_Det = mkCompCat ("DetQuant" ++ "DefArt" ++ "NumSg") ;
a_Det = mkCompCat ("DetQuant" ++ "IndefArt" ++ "NumSg") ;
theSg_Det = mkCompCat ("DetQuant" ++ "DefArt" ++ "NumSg") ; 
thePl_Det = mkCompCat ("DetQuant" ++ "DefArt" ++ "NumPl") ; 
aSg_Det = mkCompCat ("DetQuant" ++ "IndefArt" ++ "NumSg") ;
aPl_Det = mkCompCat ("DetQuant" ++ "DefArt" ++ "NumPl") ;
this_Det = mkCompCat ("DetQuant" ++ "this_Quant" ++ "NumSg") ;
that_Det = mkCompCat ("DetQuant" ++ "that_Quant" ++ "NumSg") ;
these_Det = mkCompCat ("DetQuant" ++ "this_Quant" ++ "NumPl") ; 
those_Det = mkCompCat ("DetQuant" ++ "that_Quant" ++ "NumPl") ; 

mkQuant = mkUnaryCat "PossPron" ; 

the_Quant = mkSimpCat "DefArt" ; 
a_Quant = mkSimpCat "IndefArt" ;  

mkNum2 = \d -> mkCompCat ( "NumCard" ++ "(" ++ "NumNumeral" ++ d.attr ++ ")" ) ; 
mkNum3 = \d -> mkCompCat ( "NumCard" ++ "(" ++ "NumDigits" ++ d.attr ++ ")" ) ; 
mkNum4 = \d -> mkCompCat ( "NumCard" ++ "(" ++ "NumNumeral" ++ "(" ++ "num" ++ "(" ++ "pot2as3" ++ "(" ++ "pot1as2" ++ "(" ++ "pot0as1" ++ "(" ++ "pot0" ++ d.attr ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ) ; 
mkNum5 = mkUnaryCat "NumCard" ; 
mkNum6 = \a,c -> mkCompCat ( "NumCard" ++  "(" ++ "AdNum" ++ a.attr ++ c.attr ++")" ) ;

singularNum = mkSimpCat "NumSg" ;           
pluralNum = mkSimpCat "NumPl" ;  

mkCard2 = mkUnaryCat  "NumNumeral" ; 
mkCard3 = mkUnaryCat "NumDigits" ; 
mkCard4 = mkBinaryCat "AdNum" ; 

mkOrd1 = mkUnaryCat "OrdNumeral" ; 
mkOrd2 = mkUnaryCat "OrdDigits" ; 
mkOrd3 = \d -> mkCompCat ( "OrdNumeral" ++ "(" ++ "num" ++ "(" ++ "pot2as3" ++ "(" ++ "pot1as2" ++ "(" ++ "pot0as1" ++ "(" ++ "pot0" ++ d.attr ++ ")" ++ ")" ++ ")" ++ ")" ++ ")" ) ; 
mkOrd4 = mkUnaryCat "OrdSuperl" ;


mkAdN = mkUnaryCat "AdnCAdv" ; 

mkCN1 = mkUnaryCat "UseN" ; 
mkCN2 = mkBinaryCat "ComplN2" ; 
mkCN3 = \f,x,n -> mkCompCat ( "ComplN2" ++ "(" ++ "ComplN3" ++ f.attr ++ x.attr ++ ")" ++ n.attr ) ; 
mkCN4 = mkUnaryCat "UseN2" ; 
mkCN5 = \n -> mkCompCat ( "UseN2" ++ "(" ++ "Use2N3" ++ n.attr ++ ")" ) ; 
mkCN6 = \x,y -> mkCompCat ( "AdjCN" ++ "(" ++ "PositA" ++ x.attr ++ ")" ++ "(" ++ "UseN" ++ y.attr ++ ")" ) ; 
mkCN7 = \x,y -> mkCompCat ( "AdjCN" ++ "(" ++ "PositA" ++ x.attr ++ ")" ++ y.attr ) ; 
mkCN8 = \x,y -> mkCompCat ( "AdjCN" ++ x.attr ++ "(" ++ "UseN" ++ y.attr ++ ")" ) ; 
mkCN9 = mkBinaryCat "AdjCN" ; 
mkCN10 = \x,y -> mkCompCat ( "AdjCN" ++ y.attr ++ x.attr ) ; 
mkCN11 = \x,y -> mkCompCat ( "AdjCN" ++ y.attr ++ "(" ++ "UseN" ++ x.attr ++ ")" ) ; 
mkCN12 = \x,y -> mkCompCat ( "RelCN" ++ "(" ++ "UseN" ++ x.attr ++ ")" ++ y.attr ) ; 
mkCN13 = mkBinaryCat "RelCN" ; 
mkCN14 = \x,y -> mkCompCat ( "AdvCN" ++ "(" ++ "UseN" ++ x.attr ++ ")" ++ y.attr ) ; 
mkCN15 = mkBinaryCat "AdvCN" ; 
mkCN16 = \cn,s -> mkCompCat ( "SentCN" ++ cn.attr ++ "(" ++ "EmbedS" ++ s.attr ++ ")" ) ; 
mkCN17 = \cn,s -> mkCompCat ( "SentCN" ++ cn.attr ++ "(" ++ "EmbedQS" ++ s.attr ++ ")" ) ; 
mkCN18 = \cn,s -> mkCompCat ( "SentCN" ++ cn.attr ++ "(" ++ "EmbedVP" ++ s.attr ++ ")" ) ; 
mkCN19 = \cn,s -> mkCompCat ( "SentCN" ++ cn.attr ++ s.attr ) ; 
mkCN20 = \x,y -> mkCompCat ( "ApposCN" ++ "(" ++ "UseN" ++ x.attr ++ ")" ++ y.attr ) ; 
mkCN21 = mkBinaryCat "ApposCN" ; 



mkAP1 = mkUnaryCat "PositA" ; 
mkAP2 = mkBinaryCat "ComparA" ; 
mkAP3 = mkBinaryCat "ComplA2" ; 
mkAP4 = mkUnaryCat "UseA2" ; 
mkAP5 = \ap,s -> mkCompCat ( "SentAP" ++ ap.attr ++ "(" ++ "EmbedS" ++ s.attr ++ ")" ) ; 
mkAP6 = \ap,s -> mkCompCat ( "SentAP" ++ ap.attr ++ "(" ++ "EmbedQS" ++ s.attr ++ ")" ) ; 
mkAP7 = \ap,s -> mkCompCat ( "SentAP" ++ ap.attr ++ "(" ++ "EmbedVP" ++ s.attr ++ ")" ) ; 
mkAP8 = \ap,s -> mkCompCat ( "SentAP" ++ ap.attr ++ s.attr ) ; 
mkAP9 =\x,y -> mkCompCat ( "AdAP" ++ x.attr ++ "(" ++ "PositA" ++ y.attr ++ ")" ) ; 
mkAP10 = mkBinaryCat "AdAP" ; 
mkAP11 = \c,x,y -> mkCompCat ( "ConjAP" ++ c.attr ++ "(" ++ "BaseAP" ++ x.attr ++ y.attr ++ ")" ) ; 
mkAP12 = \c,xy -> mkCompCat ( "ConjAP" ++ c.attr ++ xy.attr ) ; 
mkAP13 = mkUnaryCat "AdjOrd" ; 
mkAP14 = mkTernaryCat "CAdvAP" ; 

reflAP = mkUnaryCat "ReflA2" ; 
comparAP = mkUnaryCat "UseComparA" ; 

mkAdv1 = mkUnaryCat "PositAdvAdj" ; 
mkAdv2 = mkBinaryCat "PrepNP" ; 
mkAdv3 = mkBinaryCat "SubjS" ; 
mkAdv4 = mkTernaryCat "ComparAdvAdj" ; 
mkAdv5 = mkTernaryCat "ComparAdvAdjS" ; 
mkAdv6 = mkBinaryCat "AdAdv" ; 
mkAdv7 = \c,x,y -> mkCompCat ( "ConjAdv" ++ c.attr ++ "(" ++ "BaseAdv" ++ x.attr ++ y.attr ++ ")" ) ; 
mkAdv8 = \c,xy -> mkCompCat ( "ConjAdv" ++ c.attr ++ xy.attr ) ; 

mkQS1 = mkUnaryCat ("UseQCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ "PPos") ; 
mkQS2 = \t, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ "PPos" ++ qcl.attr) ; 
mkQS3 = \a, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++"TPres" ++ a.attr ++ ")" ++ "PPos" ++ qcl.attr) ; 
mkQS4 = \p, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ p.attr ++ qcl.attr) ; 
mkQS5 = \t,a, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ "PPos" ++ qcl.attr) ; 
mkQS6 = \t,p, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ p.attr ++ qcl.attr) ; 
mkQS7 = \a,p, qcl -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++"TPres" ++ a.attr ++ ")" ++ p.attr ++ qcl.attr ) ; 
mkQS8 = \t,a, p, qcl -> mkCompCat ("UseQCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ p.attr ++ qcl.attr ) ; 
mkQS9 = \x -> mkCompCat ( "UseQCl" ++ "(" ++ "TTAnt" ++"TPres" ++ "ASimul" ++ ")"++ "PPos" ++ "(" ++ "QuestCl" ++ x.attr ++ ")") ; 

mkQCl1 = mkUnaryCat "QuestCl" ; 
mkQCl2 = mkBinaryCat "QuestVP" ; 
mkQCl3 = \s,v -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "UseV" ++ v.attr ++ ")" ) ; 
mkQCl4 = \s,v,o -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplV2" ++ v.attr ++ o.attr ++ ")" ) ; 
mkQCl5 = \s,v,o,i -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplV3" ++ v.attr ++ o.attr ++ i.attr ++ ")" ) ; 
mkQCl6 = \s,v,vp -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplVV" ++ v.attr ++ vp.attr ++ ")" ) ; 
mkQCl7 = \s,v,p -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplVS" ++ v.attr ++ p.attr ++ ")" ) ; 
mkQCl8 = \s,v,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplVQ" ++ v.attr ++ q.attr ++ ")" ) ; 
mkQCl9 = \s,v,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkQCl10 = \s,v,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ q.attr ++ ")" ) ; 
mkQCl11 = \s,v,n,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkQCl12 = \s,v,n,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ q.attr ++ ")" ) ; 
mkQCl13 = \s,v,n,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2S" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkQCl14 = \s,v,n,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2Q" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkQCl15 = \s,v,n,q -> mkCompCat ( "QuestVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2V" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkQCl16 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "PositA" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkQCl17 = \x,y,z -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComparA" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkQCl18 = \x,y,z -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComplA2" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkQCl19 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ y.attr ++ ")" ++ ")" ) ; 
mkQCl20 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompNP" ++ y.attr ++ ")" ++ ")" ) ; 
mkQCl21 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ "(" ++ "UseN" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkQCl22 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ y.attr ++ ")" ++ ")" ) ; 
mkQCl23 = \x,y -> mkCompCat ( "QuestVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAdv" ++ y.attr ++ ")" ++ ")" ) ; 
mkQCl24 = \ip,np,v -> mkCompCat ( "QuestSlash" ++ ip.attr ++ "(" ++ "SlashVP" ++ np.attr ++ "(" ++ "SlashV2a" ++ v.attr ++ ")" ++ ")" ) ; 
mkQCl25 = mkBinaryCat "QuestSlash" ; 
mkQCl26 = mkBinaryCat "QuestIAdv" ; 
mkQCl27 = \p,ip, cl -> mkCompCat ( "QuestIAdv" ++ "(" ++ "PrepIP" ++ p.attr ++ ip.attr ++ ")" ++ cl.attr ) ; 
mkQCl28 = \a,n -> mkCompCat ( "QuestIComp" ++ "(" ++ "CompIAdv" ++ a.attr ++ ")" ++ n.attr ) ; 
mkQCl29 = \a,n -> mkCompCat ( "QuestIComp" ++ a.attr  ++ n.attr) ; 
mkQCl30 = mkUnaryCat "ExistIP" ;
 
mkIComp1 = mkUnaryCat "CompIAdv" ; 
mkIComp2 = mkUnaryCat "CompIP" ; 

mkIP1 = mkBinaryCat "IdetCN" ; 
mkIP2 = \i,n -> mkCompCat ( "IdetCN" ++ i.attr ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkIP3 = mkUnaryCat "IdetIP" ; 
mkIP4 = \i,n -> mkCompCat ( "IdetCN" ++ "(" ++ "IdetQuant" ++ i.attr ++ "NumSg" ++ ")" ++ n.attr ) ; 
mkIP5 = \i,nu,n -> mkCompCat ( "IdetCN" ++ "(" ++ "IdetQuant" ++ i.attr ++ nu.attr ++ ")" ++ n.attr ) ; 
mkIP6 = \i,n -> mkCompCat ( "IdetCN" ++ "(" ++ "IdetQuant" ++ i.attr ++ "NumSg" ++ ")" ++ "(" ++ "UseN" ++ n.attr ++ ")" ) ; 
mkIP7 = mkBinaryCat "AdvIP" ; 

what_IP = mkSimpCat "whatSg_IP" ; 
who_IP = mkSimpCat "whoSg_IP" ; 

mkIAdv1 = mkBinaryCat "PrepIP" ; 
mkIAdv2 = mkBinaryCat "AdvIAdv" ; 

mkIDet1 = \i,nu -> mkCompCat ( "IdetQuant" ++ i.attr ++ nu.attr ) ; 
mkIDet2 = \i -> mkCompCat ( "IdetQuant" ++ i.attr ++ "NumSg" ) ; 

which_IDet = mkSimpCat "whichSg_IDet" ;
whichSg_IDet =mkCompCat ("IdetQuant" ++ "which_IQuant" ++ "NumSg") ;  
whichPl_IDet = mkCompCat ("IdetQuant" ++ "which_IQuant" ++ "NumPl") ; 

mkRS1 = mkUnaryCat ("UseRCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ "PPos") ; 
mkRS2 = \t, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ "PPos" ++ rcl.attr ) ; 
mkRS3 = \a, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ a.attr ++ ")" ++ "PPos" ++ rcl.attr ) ; 
mkRS4 = \p, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++ "TPres" ++ "ASimul" ++ ")" ++ p.attr ++ rcl.attr ) ; 
mkRS5 = \t,a, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ "PPos" ++ rcl.attr) ; 
mkRS6 = \t,p, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++ t.attr ++ "ASimul" ++ ")" ++ p.attr ++ rcl.attr) ; 
mkRS7 = \a,p, rcl -> mkCompCat ( "UseRCl" ++ "(" ++ "TTAnt" ++"TPres" ++ a.attr ++ ")" ++ p.attr ++ rcl.attr ) ; 
mkRS8 = \t,a,p,rcl -> mkCompCat ("UseRCl" ++ "(" ++ "TTAnt" ++ t.attr ++ a.attr ++ ")" ++ p.attr ++ rcl.attr ) ; 
mkRS9 = mkTernaryCat "UseRCl" ; 
mkRS10 = \c,x,y -> mkCompCat ( "ConjRS" ++ c.attr ++ "(" ++ "BaseRS" ++ x.attr ++ y.attr ++ ")" ) ; 
mkRS11 = \c,xy -> mkCompCat ( "ConjRS" ++ c.attr ++ xy.attr ) ; 

mkRCl1 = mkBinaryCat "RelVP" ; 
mkRCl2 = \s,v -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "UseV" ++ v.attr ++ ")" ) ; 
mkRCl3 = \s,v,o -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplV2" ++ v.attr ++ o.attr ++ ")" ) ; 
mkRCl4 = \s,v,o,i -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplV3" ++ v.attr ++ o.attr ++ i.attr ++ ")" ) ; 
mkRCl5 = \s,v,vp -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplVV" ++ v.attr ++ vp.attr ++ ")" ) ; 
mkRCl6 = \s,v,p -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplVS" ++ v.attr ++ p.attr ++ ")" ) ; 
mkRCl7 = \s,v,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplVQ" ++ v.attr ++ q.attr ++ ")" ) ; 
mkRCl8 = \s,v,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkRCl9 = \s,v,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplVA" ++ v.attr ++ q.attr ++ ")" ) ; 
mkRCl10 = \s,v,n,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ "(" ++ "PositA" ++ q.attr ++ ")" ++ ")" ) ; 
mkRCl11 = \s,v,n,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplV2A" ++ v.attr ++ n.attr ++ q.attr ++ ")" ) ; 
mkRCl12 = \s,v,n,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2S" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkRCl13 = \s,v,n,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2Q" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkRCl14 = \s,v,n,q -> mkCompCat ( "RelVP" ++ s.attr ++ "(" ++ "ComplSlash" ++ "(" ++ "SlashV2V" ++ v.attr ++ q.attr ++ ")" ++ n.attr ++ ")" ) ; 
mkRCl15 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "PositA" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkRCl16 = \x,y,z -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComparA" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkRCl17 = \x,y,z -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ "(" ++ "ComplA2" ++ y.attr ++ z.attr ++ ")" ++ ")" ++ ")" ) ; 
mkRCl18 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAP" ++ y.attr ++ ")" ++ ")" ) ; 
mkRCl19 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompNP" ++ y.attr ++ ")" ++ ")" ) ; 
mkRCl20 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ "(" ++ "UseN" ++ y.attr ++ ")" ++ ")" ++ ")" ) ; 
mkRCl21 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompCN" ++ y.attr ++ ")" ++ ")" ) ; 
mkRCl22 = \x,y -> mkCompCat ( "RelVP" ++ x.attr ++ "(" ++ "UseComp" ++ "(" ++ "CompAdv" ++ y.attr ++ ")" ++ ")" ) ; 
mkRCl23 = \ip,np,v -> mkCompCat ( "RelSlash" ++ ip.attr ++ "(" ++ "SlashVP" ++ np.attr ++ "(" ++ "SlashV2a" ++ v.attr ++ ")" ++ ")" ) ; 
mkRCl24 = mkBinaryCat "RelSlash" ; 
mkRCl25 = mkUnaryCat "RelCl" ;
 
which_RP = mkSimpCat "IdRP" ;

mkRP = mkTernaryCat "FunRP" ;
 
mkSSlash = mkTernaryCat "UseSlash" ;
 
mkClSlash1 = \np,vps -> mkCompCat ( "SlashVP" ++ np.attr ++ vps.attr ) ; 
mkClSlash2 = \np,v2 -> mkCompCat ( "SlashVP" ++ np.attr ++ "(" ++ "SlashV2a" ++ v2.attr ++ ")" ) ; 
mkClSlash3 = \np,vv,v2 -> mkCompCat ( "SlashVP" ++ np.attr ++ "(" ++ "SlashVV" ++ vv.attr ++ "(" ++ "SlashV2a" ++ v2.attr ++ ")" ++ ")" ) ; 
mkClSlash4 = mkBinaryCat "SlashPrep" ; 
mkClSlash5 = mkBinaryCat "AdvSlash" ; 
mkClSlash6 = mkTernaryCat "SlashVS" ;

mkVPSlash1 = mkUnaryCat "SlashV2a" ; 
mkVPSlash2 = mkBinaryCat "Slash2V3" ; 
mkVPSlash3 = mkBinaryCat "SlashV2A" ; 
mkVPSlash4 = mkBinaryCat "SlashV2Q" ; 
mkVPSlash5 = mkBinaryCat "SlashV2S" ; 
mkVPSlash6 = mkBinaryCat "SlashV2V" ; 
mkVPSlash7 = mkBinaryCat "SlashVV" ; 
mkVPSlash8 = mkTernaryCat "SlashV2VNP" ; 

mkListS1 = mkBinaryCat "BaseS" ; 
mkListS2 = mkBinaryCat "ConsS" ; 

mkListAdv1 = mkBinaryCat "BaseAdv" ; 
mkListAdv2 = mkBinaryCat "ConsAdv" ; 

mkListAP1 = mkBinaryCat "BaseAP" ; 
mkListAP2 = mkBinaryCat "ConsAP" ; 

mkListNP1 = mkBinaryCat "BaseNP" ; 
mkListNP2 = mkBinaryCat "ConsNP" ; 

mkListRS1 = mkBinaryCat "BaseRS" ; 
mkListRS2 = mkBinaryCat "ConsRS" ; 

 the_Art = mkSimpCat "DefArt" ;      
 a_Art = mkSimpCat "IndefArt" ;  
 sgNum = mkSimpCat "NumSg";  
 plNum = mkSimpCat "NumPl" ;  

oper mkSimpCat : Str-> {ind : Str ; attr : Str}  = \s -> {ind  = s; attr  = s};

oper mkCompCat : Str -> {ind : Str ; attr : Str} = \s -> {ind = s; attr = "(" ++ s ++ ")"} ;

oper mkUnaryCat : Str -> {ind : Str ; attr : Str} -> {ind : Str ; attr : Str} = \s, o1 -> 
                                                                                                      {ind = s ++ o1.attr ; 
                                                                                                       attr = "(" ++ s ++ o1.attr ++ ")"};

oper mkBinaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str ; attr : Str} = \s, o1, o2 -> 
                                                                                                      {ind = s ++ o1.attr ++ o2.attr; 
                                                                                                       attr = "(" ++ s ++ o1.attr ++ o2.attr ++ ")"};

oper mkTernaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr: Str} -> {ind : Str ; attr : Str} = \s, o1, o2, o3 -> 
                                                                                                     {ind = s ++ o1.attr ++ o2.attr ++ o3.attr;
                                                                                                      attr = "(" ++ s ++ o1.attr ++ o2.attr ++ o3.attr ++")"};


oper mkQuaternaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr: Str} -> {ind : Str ; attr : Str} = \s, o1, o2, o3, o4 ->
                                                                                                     {ind = s ++ o1.attr ++ o2.attr ++ o3.attr ++ o4.attr;
                                                                                                      attr = "(" ++ s ++ o1.attr ++ o2.attr ++ o3.attr ++o4.attr++ ")"};


-----------------------------
lin 

testNoun_1 = mkSimpCat "noun_1" ;
testNoun_2 = mkSimpCat "noun_2" ;
testNoun_3 = mkSimpCat "noun_3" ;
testNoun_4 = mkSimpCat "noun_4" ;
testNoun_5 = mkSimpCat "noun_5" ;
testA_1 = mkSimpCat "adj_1" ;
testA_2 = mkSimpCat "adj_2" ;
testA_3 = mkSimpCat "adj_3" ;
testA_4 = mkSimpCat "adj_4" ;
testA_5 = mkSimpCat "adj_5" ;
testV_1 = mkSimpCat "verb_1" ;
testV_2 = mkSimpCat "verb_2" ;
testV_3 = mkSimpCat "verb_3" ;
testV_4 = mkSimpCat "verb_4" ;
testV_5 = mkSimpCat "verb_5" ;
testV2_1 = mkSimpCat "verb2_1" ;
testV2_2 = mkSimpCat "verb2_2" ;
testV2_3 = mkSimpCat "verb2_3" ;
testV2_4 = mkSimpCat "verb2_4" ;
testV2_5 = mkSimpCat "verb2_5" ;
testAdv_1 = mkSimpCat "adv_1" ;
testAdv_2 = mkSimpCat "adv_2" ;
testAdv_3 = mkSimpCat "adv_3" ;
testAdv_4 = mkSimpCat "adv_4" ;
testAdv_5 = mkSimpCat "adv_5" ;

}
