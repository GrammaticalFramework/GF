

concrete ConjunctionAmh of Conjunction = 
CatAmh ** open ResAmh, Coordination, Prelude,ParamX, CommonX in {

 flags optimize=all_subs ;
	 coding = utf8;

  lin

	ConjS = conjunctDistrSS ;
	ConjAdv = conjunctDistrSS ;
	ConjNP conj ss = conjunctDistrTable Case conj ss ** { a = {png= conjAgr (agrP3 conj.n) ss.a.png ;isPron =False}};
	ConjAP conj ss = conjunctDistrTable4 Gender Number Species Case conj ss ;



	BaseS = twoSS ;
	ConsS = consrSS "፣" ;
	BaseAdv = twoSS ;
	ConsAdv = consrSS "፣"  ;
	BaseNP x y = twoTable Case x y ** {a = {png =conjAgr x.a.png y.a.png ;isPron = False}} ;
	ConsNP xs x = consrTable Case "፣" xs x ** {a = { png = conjAgr xs.a.png x.a.png ;isPron =False} }; 
	BaseAP x y = twoTable4 Gender Number Species Case x y  ;
	ConsAP xs x = consrTable4 Gender Number Species Case "፤"   xs x  ;

 lincat
	[S]  = {s1,s2 : Str} ;
	[Adv]= {s1,s2 : Str} ;
	[NP] = {s1,s2 : Case => Str ; a : Agr} ;
	[AP] = {s1,s2 : Gender => Number => Species => Case => Str} ;

}
