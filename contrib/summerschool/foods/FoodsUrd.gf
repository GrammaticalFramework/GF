concrete FoodsUrd of Foods = {
  flags coding = utf8 ;
	  param Number = Sg | Pl ;
	  
	 oper coupla : Number -> Str =\n -> case n of {Sg => "ہے" ; Pl => "ہیں"};
	  
	 	  
      lincat
        Comment, Quality = {s : Str} ; 
		Item = {s: Str ; n: Number};
		Kind = {s: Number => Str};
  
      lin
      Pred item quality = {s = item.s ++ quality.s ++  coupla item.n} ;
	  This kind = {s = "یھ" ++ kind.s ! Sg; n= Sg} ;
	  These kind = {s = "یھ" ++ kind.s ! Pl; n = Pl} ;
      That kind = {s = "وہ"  ++ kind.s ! Sg; n= Sg} ;
      Those kind = {s = "وہ" ++ kind.s ! Pl; n=Pl} ;
      Mod quality kind = {s = \\n => quality.s ++ kind.s ! n} ;
      Wine = {s = table { Sg => "شراب" ; Pl => "شرابیں"} };
      Cheese = {s = table { Sg => "پنیر" ; Pl => "پنیریں"} };
      Fish = {s = table { Sg => "مچھلی" ; Pl => "مچھلیاں"} };
      Pizza = {s = table { Sg => "پیزہ" ; Pl => "پیزے"} };
	  Very quality = {s = "بہت" ++ quality.s} ;
      Fresh = {s = "تازہ"} ;
      Warm = {s = "گرم"} ;
      Italian = {s = "اٹا لوی"} ;
      Expensive = {s = "مہنگا"} ;
      Delicious = {s = "مزیدار"} ;
      Boring = {s = "فضول"} ;
	}  
