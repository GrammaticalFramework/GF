concrete CatAmh of Cat = CommonX ** open ResAmh, Prelude in {

lincat


	CN,N = ResAmh.Noun ;-- {s :Number => Species => Case => Str; g : Gender} ;
	N2 = ResAmh.N2 ;--{s : Number => Case => Str ; g : Gender} ** {c2 : Str} ;
	N3 = ResAmh.N3 ;--{s : Number => Case => Str ; g : Gender} ** {c2,c3 : Str} ;
	A2V,A= ResAmh.Adjective ;--{s : Gender => Number => Species => Case => Str} ;
	V = ResAmh.Verb ; 
	V,V0,VS,VQ,VA,V2A,V2V,V2S,V2Q,VV= ResAmh.Verb ; -- = {s : VForm => Str} ;
	V2 = ResAmh.Verb ** {c2 : Prep} ;
	V3 = ResAmh.Verb ** {c2, c3 : Prep} ;
	Pron,NP = ResAmh.NP ;  --NP = {s : Case => Str ; a : Agr} ; 
	VP = ResAmh.VP ;
        Comp =ResAmh.Comp;
	PN = ResAmh.PN ; --{s : Number => Species => Case => Str ; g : Gender} ;
	Quant = ResAmh.Quant; 
	Det = ResAmh.Det;--{s : Gender => Case => Str ;  n : Number ; isDef : Bool };
	Predet = ResAmh.Predet;
	AP = ResAmh.AP; 
	Prep = ResAmh.Prep;
	Numeral = ResAmh.Numeral; --{s : CardOrd => Case => Str ; n : Number} ;
	Digits  = ResAmh.Digits;--{s : CardOrd => Case => Str ; n : Number ; tail : DTail} ;
	Ord = ResAmh.Ord ; --{ s : Case => Str } ;
	Num  = ResAmh.Num;--{s : Case => Str ; n : Number ; hasCard : Bool} ;
	Card = ResAmh.Card;--{s : Case => Str ; n : Number} ;
        Cl = ResAmh.Cl; -- {s : Tense => Pol => Str};
        QCl = ResAmh.QCl;
        Obj = ResAmh.Obj;
	VPSlash = ResAmh.VPSlash;
        ClSlash = ResAmh.ClSlash;
	Imp = ResAmh.Imp;
        S =  ResAmh.S;
	IP = ResAmh.IP;-- {s : Str ; n : ResAra.Number} ;
        IDet = ResAmh.IDet ;
	IQuant  = ResAmh.IQuant;
	Conj = ResAmh.Conj;

}




