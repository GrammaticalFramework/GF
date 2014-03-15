--# -path=.:alltenses:prelude

resource CombinatorsEng = Combinators - [ appCN, appCNc ] with 
  (Cat = CatEng),
  (Structural = StructuralEng),
  (Noun = NounEng),
  (Constructors = ConstructorsEng) ** 
  {
  	oper
	appCN : CN -> NP -> NP
           = \cn,x -> mkNP the_Art (PossNP cn x) ;
    appCNc : CN -> [NP] -> NP
           = \cn,xs -> let np : NP = mkNP and_Conj xs
                       in mkNP the_Art (PossNP cn np) ; 
  }
