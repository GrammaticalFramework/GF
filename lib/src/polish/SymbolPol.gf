    --# -path=.:../abstract:../common:../prelude

concrete SymbolPol of Symbol = CatPol ** open Prelude, ResPol, AdjectiveMorphoPol in {

lin
  SymbPN i = {nom= i.s; voc=i.s; dep = \\_=>i.s; gn = NeutSg; p=P3} ;
  IntPN i  = {nom= i.s; voc=i.s; dep = \\_=>i.s; gn = NeutSg; p=P3} ;
  FloatPN i = {nom= i.s; voc=i.s; dep = \\_=>i.s; gn = NeutSg; p=P3} ;
  NumPN i = {nom= i.s!Nom!(Masc Inanimate); voc=i.s!Nom!(Masc Inanimate); dep = \\_=>i.s!Nom!(Masc Inanimate); gn = NeutSg; p=P3} ;
  CNIntNP cn i = {
    nom= cn.s!Sg!Nom ++ i.s;
    voc= cn.s!Sg!VocP ++ i.s;
    dep = \\cc => cn.s !Sg !(extract_case! cc) ++ i.s; 
    gn = (accom_gennum !<NoA, cn.g, Sg>);
    p=P3
  } ;
  
  CNNumNP cn i = {
    nom= cn.s!Sg!Nom ++ i.s!Nom!(Masc Inanimate);
    voc= cn.s!Sg!VocP ++ i.s!Nom!(Masc Inanimate);
    dep = \\cc => cn.s !Sg !(extract_case! cc) ++ i.s!Nom!(Masc Inanimate); 
    gn = (accom_gennum !<NoA, cn.g, Sg>);
    p=P3
  } ; 
  
  CNSymbNP kazdy facet xs = {
    nom = (kazdy.s ! Nom  ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,Nom, facet.g>)) ++ xs.s;
    voc = (kazdy.s ! VocP ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,VocP,facet.g>)) ++ xs.s;
    dep = \\cc => let c = extract_case! cc in 
      (kazdy.s ! c ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,c,facet.g>)) ++ xs.s;
    gn = (accom_gennum !<kazdy.a, facet.g, kazdy.n>);
    p = P3
  } ;

  SymbS sy = sy ; 

  SymbNum sy = { s = \\_,_=>sy.s; a=StoA; n=Pl };
  SymbOrd sy = { s = \\af => sy.s ++ (mkAtable (guess_model "-ty"))!af} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;
  BaseSymb = infixSS "i" ;
  ConsSymb = infixSS "," ;
}
