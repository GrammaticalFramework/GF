incomplete concrete BronzeageI of Bronzeage = open Syntax in {

  lincat
    Phr = Syntax.Phr ;
    Imp = Syntax.Imp ;
    Cl = Syntax.Cl ;
    CN = Syntax.CN ;
    MassCN = Syntax.CN ;

  lin
    PhrPos = mkPhr ;
    PhrNeg sent = mkPhr (mkS negativePol sent) ;
    PhrQuest sent = mkPhr (mkQS sent) ;
    PhrIAdv iadv sent = mkPhr (mkQS (mkQCl iadv sent)) ; 
    PhrImp = mkPhr ;
    PhrImpNeg imp = mkPhr (mkUtt negativePol imp) ;
    
    SentV v x = mkCl x v ;

    SentV2 v x y = mkCl x v y ;
    SentV2Mass v x y = mkCl x v (mkNP y) ;
    SentV3 v x y z = mkCl x v y z ;
    SentA  a x = mkCl x a ;
    SentNP a x = mkCl x a ;

    SentAdvV  v np adv = mkCl np (mkVP (mkVP v) adv) ;
    SentAdvV2 v x y adv = mkCl x (mkVP (mkVP v y) adv) ;

    ImpV = mkImp ;
    ImpV2 = mkImp ;

    DetCN = mkNP ;
    NumCN = mkNP ;

    UseN = mkCN ;
    ModCN = mkCN ;

    UseMassN = mkCN ;
    ModMass = mkCN ;

    DefCN = mkNP the_Art ;
    IndefCN = mkNP a_Art ;
    PrepNP = mkAdv ;
    on_Prep = Syntax.on_Prep ;

}
