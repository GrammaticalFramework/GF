-- (c) 2009 Ramona Enache under LGPL

concrete FoodRon of Food = SentencesRon ** open
  SyntaxRon,
  ParadigmsRon in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin" "vinuri" neuter) ;
Cheese = mkCN (mkN "brânzã" "brânzeturi" feminine) ;
Fish = mkCN (mkN "peºte" "peºti" masculine) ;
Pizza = mkCN (mkN "pizza" "pizze" feminine) ;

Fresh = mkAPA "proaspãt" "proaspãtã" "proaspeþi" "proaspete" ;
Warm = mkAPA "cald" "caldã" "calzi" "calde" ;
Italian = mkAPA "italian" "italianã" "italieni" "italiene" ;
Expensive = mkAPA "scump" "scumpã" "scumpi" "scumpe" ;
Delicious = mkAPA "delicios" "delcioasã" "delicioºi" "delicioase" ;
Boring = mkAPA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;

oper
mkAPA : (_,_,_,_ : Str) -> AP = \x,y,z,u -> mkAP (mkA x y z u) ;

}
