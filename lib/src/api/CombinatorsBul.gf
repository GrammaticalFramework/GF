--# -path=.:alltenses:prelude

resource CombinatorsBul = Combinators - [appCN, appCNc] with 
  (Cat = CatBul),
  (Structural = StructuralBul),
  (Noun = NounBul),
  (Constructors = ConstructorsBul) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
