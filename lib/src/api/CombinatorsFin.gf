--# -path=.:alltenses:prelude

resource CombinatorsFin = Combinators - [appCN, appCNc] with 
  (Cat = CatFin),
  (Structural = StructuralFin),
  (Noun = NounFin), 
  (Constructors = ConstructorsFin) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}

