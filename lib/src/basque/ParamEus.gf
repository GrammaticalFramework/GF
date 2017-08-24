resource ParamEus = ParamX ** open Prelude in {

	
param 

  ClType = Stat | Indir | Qst ;


  -- Every verb has some fully inflecting part:
  -- if the whole verb is one of these synthetic verbs, then there won't be a participle
  -- (or it's only in some tenses/persons/something).
  -- AditzTrinkoak has all the inflection tables fully spelt out, 
  -- and here we just make nice neat set of parameters that go into the verbs.
  SyntVerb1 = Izan | Egon | Ibili | Etorri | Joan ;
  SyntVerb2 = Ukan | Jakin | Eduki ; --TODO others


  AuxType = Da SyntVerb1 
          | Du SyntVerb2 
          | Zaio | Dio ;  --always Ukan ?



{-
   Type of adjectival phrase, e.g.
 
      kale txiki+a [APType = Bare]
      itsaso+ra+ko kale+a [APType = Ko]
-}
  APType = Ko | Bare ; 

  AForm = AF Degree | AAdv ;

  Bizi = Inan | Anim ;

  Case = Abs | Erg | Dat | Par  -- Core argument cases
       | Gen | Soc | Ins | Ine -- Irregular stems
       | LocStem ;  -- LocStem is inessive without -an; many other cases use same stem!


--    Degree = Posit | Compar | Superl | Excess ;
  CardOrd = NCard | NOrd ;

  Gender = Masc | Fem ;

  Agr = Ni | Hi Gender | Zu | Hau | Gu | Zuek | Hauek ;

  Phono = FinalA | FinalR | FinalCons | FinalVow ; 


oper 
 -- Opers to manipulate params.

  sgAgr : Agr -> Agr = \agr ->
       case agr of { Gu    => Ni ;
                     Zuek  => Zu ;
                     Hauek => Hau ;
                     agr   => agr } ;

  plAgr : Agr -> Agr = \agr ->
    case agr of { Ni  => Gu ;
                  Zu  => Zuek ;
                  Hi _ => Zuek ;
                  Hau => Hauek ;
                  agr => agr } ;

  getNum : Agr -> Number = \np ->
    case np of {
        (Ni|Hi _|Zu|Hau) => Sg ;
        (Gu|Zuek|Hauek)  => Pl 
    } ;

  getPers : Agr -> Person = \np ->
    case np of {
        (Ni|Gu)      => P1 ;
        (Hi _ |Zu|Zuek) => P2 ;
        (Hau|Hauek)  => P3
    } ;

  subjCase : AuxType -> Case = \val ->
    case val of {
      Da _  => Abs ;
      Zaio  => Dat ;
      _     => Erg } ;


  isSynthetic : AuxType -> Bool = \val -> 
    case val of {
      Da Izan => False ;
      Du Ukan => False ;
      Zaio    => False ;
      Dio     => False ;
      _       => True } ;

  defaultAux : AuxType -> AuxType = \val -> 
    case val of {
      Da _ => Da Izan ;
      Du _ => Du Ukan ;
      x    => x } ;

}