--# -path=.:alltenses:prelude

resource CombinatorsCat = Combinators - [appCN, appCNc] with 
  (Cat = CatCat),
  (Structural = StructuralCat),
  (Noun = NounCat),
  (Constructors = ConstructorsCat) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
