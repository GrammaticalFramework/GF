
concrete TestVars of TestVarsA = open TestVarsR in {

lincat S = { s : XYZ => Str; p : { s : Str; a : AB } };

lin a = { s = table { X _ => variants { "x1" ; "x2" };
      	      	      Y   => variants { "y1" ; "y2" };
		      _   => variants { "z1" ; "z2" } };
          p = variants { { s = "s1" ; a = A } ;
	      	       	 { s = "s2" ; a = B } };
        };

}

