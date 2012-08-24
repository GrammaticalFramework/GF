resource ParadigmsIta = GrammarIta [N,A,V] ** 
  open ResIta, GrammarIta, Prelude in {

oper
  masculine : Gender = Masc ;
  feminine : Gender = Fem ;

  accusative : Case = Acc ;
  dative : Case = Dat ;
 
  indicative : Mood = Ind ;
  conjunctive : Mood = Con ;

  mkN = overload {
    mkN : (vino : Str) -> N 
      = \n -> lin N (regNoun n) ;
    mkN : (uomo, uomini : Str) -> Gender -> N 
      = \s,p,g -> lin N (mkNoun s p g) ;
    } ;

  mkPN = overload {
    mkPN : (anna : Str) -> PN
      = \p -> let n = regNoun p in lin PN {s = p ; g = n.g} ;
    mkPN : Str -> Gender -> PN
      = \s,g -> lin PN {s = s ; g = g} ;
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
    mkV : (andare,vado,vadi,va,andiamo,andate,vanno,andava,andro,vada,andassi,andato : Str) -> V 
      = \i,p1,p2,p3,p4,p5,p6,imp,fut,con,conp,p -> 
         lin V (mkVerb i p1 p2 p3 p4 p5 p6 imp fut con conp p Avere) ;
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

  mkVS : V -> Mood -> VS = \v,m ->
    lin VS (v ** {m = m}) ;
  mkVQ : V -> VQ = \v ->
    lin VQ v ;
  mkVV : V -> VV = \v ->
    lin VV v ;
}
