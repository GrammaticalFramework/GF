abstract QueryProton = Query ** {

fun
  QCalled : Individual -> Query ; -- how is X (also | otherwise) (called | named | known) ;

  NLoc : Loc -> Name ;
  NOrg : Org -> Name ;
  NPers : Pers -> Name ;

  IName    : Name -> Individual ;
  ACalled  : [Individual] -> Activity ;

-- the test lexicon

cat
  JobTitle ;
fun
  Located : Loc -> Property ;
  Employed : Org -> Property ;

  Work : Org -> Activity ;
  HaveTitle : JobTitle -> Activity ;
  HaveTitleOrg : JobTitle -> Org -> Activity ;

  Organization : Kind ;
  Place : Kind ;
  Person : Kind ;

  Location : Relation ;
  Region : Relation ;
  Subregion : Relation ;

  RName     : Relation ;
  RNickname : Relation ;

-- JobTitles
   JobTitle1 : JobTitle ;
   JobTitle2 : JobTitle ;
   JobTitle3 : JobTitle ;
   JobTitle4 : JobTitle ;

-- Locations
   Location1 : Loc ;
   Location2 : Loc ;
   Location3 : Loc ;
   Location4 : Loc ;

-- Organizations
   Organization1 : Org ;
   Organization2 : Org ;
   Organization3 : Org ;
   Organization4 : Org ;

-- Persons
   Person1 : Pers ;
   Person2 : Pers ;
   Person3 : Pers ;
   Person4 : Pers ;
}