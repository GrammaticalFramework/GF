--# -path=.:alltenses:prelude

resource CombinatorsPor = Combinators - [appCN, appCNc] with 
  (Cat = CatPor),
  (Structural = StructuralPor),
  (Noun = NounPor),
  (Constructors = ConstructorsPor) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
