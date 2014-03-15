--# -path=.:alltenses:prelude

resource CombinatorsGer = Combinators - [appCN, appCNc] with 
  (Cat = CatGer),
  (Structural = StructuralGer),
  (Noun = NounGer),
  (Constructors = ConstructorsGer) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
