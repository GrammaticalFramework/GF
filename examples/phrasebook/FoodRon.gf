-- (c) 2009 Ramona Enache under LGPL

concrete FoodRon of Food = SentencesRon ** open
  SyntaxRon,
  ParadigmsRon in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin" "vinuri" neuter) ;
Cheese = mkCN (mkN "brânză" "brânzeturi" feminine) ;
Fish = mkCN (mkN "peşte" "peşti" masculine) ;
Pizza = mkCN (mkN "pizza" "pizze" feminine) ;

Fresh = mkAPA "proaspăt" "proaspătă" "proaspeţi" "proaspete" ;
Warm = mkAPA "cald" "caldă" "calzi" "calde" ;
Italian = mkAPA "italian" "italiană" "italieni" "italiene" ;
Expensive = mkAPA "scump" "scumpă" "scumpi" "scumpe" ;
Delicious = mkAPA "delicios" "delcioasă" "delicioşi" "delicioase" ;
Boring = mkAPA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;

oper
mkAPA : (_,_,_,_ : Str) -> AP = \x,y,z,u -> mkAP (mkA x y z u) ;

}
