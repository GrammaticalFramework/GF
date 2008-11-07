--# -path=.:../abstract:../common

concrete CompatibilityBul of Compatibility = CatBul ** open Prelude, ResBul in {

-- from Noun 19/4/2008
flags
  coding = cp1251 ;

lin
  NumInt n = {s = \\_ => n.s; n = Pl; nonEmpty = True} ;
  OrdInt n = {s = \\aform => n.s ++ "-" ++ 
                             case aform of {
                               ASg Masc Indef => "ти" ;
                               ASg Fem  Indef => "та" ;
                               ASg Neut Indef => "то" ;
                               ASg Masc Def   => "тия" ;
                               ASg Fem  Def   => "тата" ;
                               ASg Neut Def   => "тото" ;
                               ASgMascDefNom  => "тият" ;
                               APl Indef      => "ти" ;
                               APl Def        => "тите"
                             }
                } ;

}
