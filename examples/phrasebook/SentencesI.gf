incomplete concrete SentencesI of Sentences = Numeral ** 
  open Syntax in {
  lincat
    Sentence = Utt ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
    Object = NP ;
  lin
    Is item quality = mkUtt (mkCl item quality) ;
    IsNot item quality = mkUtt (mkS negativePol (mkCl item quality)) ;
    WhetherIs item quality = mkUtt (mkQCl (mkCl item quality)) ;
    IWant obj = mkUtt (mkCl (mkNP i_Pron) want_VV (mkVP have_V2 obj)) ;
    DoYouHave kind = 
      mkUtt (mkQCl (mkCl (mkNP youPol_Pron) have_V2 (mkNP kind))) ;
    ObjItem i = i ;
    ObjNumber n k = mkNP <n : Numeral> k ;

    This kind = mkNP this_Quant kind ;
    That kind = mkNP that_Quant kind ;
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    SuchKind quality kind = mkCN quality kind ;
    Very quality = mkAP very_AdA quality ;
}
