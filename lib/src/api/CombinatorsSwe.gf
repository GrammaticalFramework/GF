--# -path=.:alltenses:prelude

resource CombinatorsSwe = Combinators - [appCN, appCNc] with 
  (Cat = CatSwe),
  (Structural = StructuralSwe),
  (Noun = NounSwe),
  (Constructors = ConstructorsSwe) ** 
{
oper
appCN : CN -> NP -> NP
       = \cn,x -> mkNP the_Art (PossNP cn x) ;
appCNc : CN -> [NP] -> NP
       = \cn,xs -> let np : NP = mkNP and_Conj xs
                   in mkNP the_Art (PossNP cn np) ; 
}
