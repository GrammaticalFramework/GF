concrete StructuralSwa of Structural = CatSwa ** 
  open MorphoSwa, ResSwa, ParadigmsSwa,
  (C = ConstructX), Prelude in {

	 flags optimize=all ;
lin
 	
        this_Quant  = {s = \\n,g,anim,c => mkQuant SpHrObj n g anim Nom P3} ;
        this_Quant1  = {s = \\n,g,anim,c => mkQuant HrObj n g anim Nom P3} ;
	that_Quant  = {s = \\n,g,anim,c => mkQuant SpHr n g anim Nom P3} ;

	

}

