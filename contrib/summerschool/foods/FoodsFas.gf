-- (c) 2009 Sedigheh Moradi under LGPL

concrete FoodsFas of Foods = {

      lincat
        Comment = {s : Str} ;
		Quality = {s : Add => Str; prep : Str} ;
        Kind = {s : Add => Number => Str ; prep : Str};
        Item = {s : Str ; n : Number};
      lin
        Pred item quality = {s = item.s ++ quality.s ! Indep ++ copula ! item.n} ;
        This = det Sg "in" ;
        That = det Sg "aan" ;
        These = det Pl "in" ;
        Those = det Pl "aan" ;
        
        Mod quality kind = {s = \\a,n =>  kind.s ! Attr ! n ++ kind.prep ++ quality.s ! a ;                                  
                            prep = quality.prep             
                            };
        Wine = regN "sharaab" ; 
        Cheese = regN "panir" ;
        Fish = regN "mahi" ;
        Pizza = regN "pitza" ;
        Very a = {s = \\at => "xeili" ++ a.s ! at ; prep = a.prep} ;
        Fresh = adj "taze" ;
        Warm = adj "garm" ;
        Italian = adj "Italia'i" ;
        Expensive = adj "geraan" ;
        Delicious = adj "laziz" ;
        Boring = adj "keselkonande" ;
     
     param
        Number = Sg | Pl ;
		Add = Indep | Attr ;
     oper
        det : Number -> Str -> {s: Add => Number => Str ; prep : Str} -> {s : Str ; n: Number} =
           \n,det,noun -> {s = det ++ noun.s ! Indep ! n ; n = n };
           
        noun : (x1,_,_,x4 : Str) -> {s : Add => Number => Str ; prep : Str} = \pitza, pitzaye, pitzaha,pr -> 
         {s = \\a,n => case <a,n> of
		        {<Indep,Sg> => pitza ; <Indep,Pl> => pitzaha ;
  				 <Attr,Sg>  =>pitzaye ; <Attr,Pl>  => pitzaha + "ye" };
		 prep = pr
		 };		 
         
        regN : Str -> {s: Add => Number => Str ; prep : Str} = \mard -> 
		case mard of 
		{ _ + ("a"|"e"|"i"|"o"|"u") => noun mard (mard+"ye") (mard + "ha") "";
		  _                         => noun mard mard (mard + "ha") "e"
		};
        
        adj : Str -> {s : Add => Str; prep : Str} = \taze -> 
		case taze of 
		{ _ + ("a"|"e"|"i"|"o"|"u") => mkAdj taze (taze+"ye") "" ;
		  _                         => mkAdj taze taze "e"
        };
		
		mkAdj : Str -> Str -> Str -> {s : Add => Str; prep : Str} = \taze, tazeye, pr  ->
		{s = table {Indep => taze;
		            Attr => tazeye};
		 prep = pr 			
		};
        copula : Number => Str = table {Sg => "ast"; Pl => "hastand"};
    }  
