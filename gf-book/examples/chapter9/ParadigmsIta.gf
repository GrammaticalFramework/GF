resource ParadigmsIta = GrammarIta [N,A,V] ** 
  open ResIta, GrammarIta, Prelude in {

oper
  masculine : Gender = Masc ;
  feminine : Gender = Fem ;

  accusative : Case = Acc ;
  dative : Case = Dat ;

  mkN = overload {
    mkN : (vino : Str) -> N 
      = \n -> lin N (regNoun n) ;
    mkN : (uomo, uomini : Str) -> Gender -> N 
      = \s,p,g -> lin N (mkNoun s p g) ;
    } ;

  mkA = overload {
    mkA : (nero : Str) -> A 
      = \a -> lin A (regAdj a) ;
    mkA : (buono,buona,buoni,buone : Str) -> Bool -> A 
      = \sm,sf,pm,pf,p -> lin A (mkAdj sm sf pm pf False) ;
    } ;

  preA : A -> A
      = \a -> lin A {s = a.s ; isPre = True} ;

  mkV = overload {
    mkV : (finire : Str) -> V 
      = \v -> lin V (regVerb v) ;
    mkV : (andare,vado,vadi,va,andiamo,andate,vanno,andato : Str) -> V 
      = \i,p1,p2,p3,p4,p5,p6,p -> lin V (mkVerb i p1 p2 p3 p4 p5 p6 p Avere) ;
    } ;

  essereV : V -> V
    = \v -> lin V {s = v.s ; aux = Essere} ;

  mkV2 = overload {
    mkV2 : Str -> V2
      = \s -> lin V2 (regVerb s ** {c = accusative}) ;
    mkV2 : V -> V2
      = \v -> lin V2 (v ** {c = accusative}) ;
    mkV2 : V -> Case -> V2
      = \v,c -> lin V2 (v ** {c = c}) ;
    } ;

}
