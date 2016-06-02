-- --# -path=.:alltenses:prelude

resource CombinatorsGrc = Combinators - [appCN, appCNc] with 
  (Cat = CatGrc),
  (Structural = StructuralGrc),
  (Noun = NounGrc),
  (Constructors = ConstructorsGrc) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
