abstract Query = {

flags
  startcat = Move ;

-- general query language, which can be specialized with any lexicon

cat
  Move ;     -- top-level utterance,    e.g. "give me all Bulgarian persons that work at Google"
  Query ;   
  Answer ;
  Set ;      -- the set requested,      e.g. "all persons"
  Relation ; -- something of something, e.g. "subregion of Bulgaria"
  Kind ;     -- type of things,         e.g. "person"
  Property ; -- property of things,     e.g. "employed at Google"
  Individual ; -- one entity,           e.g. "Google"
  Activity ;   -- action property,      e.g. "work at Google"
  Name ;       -- person, company...    e.g. "Eric Schmidt"
  [Individual] {2} ; -- list of entities, e.g. "Larry Page, Sergey Brin"

fun
  MQuery  : Query -> Move ;
  MAnswer : Answer -> Move ;
 
  QSet    : Set  -> Query ;  -- (give me | what are | which are | ) (S | the names of S | S's names)
  QWhere  : Set  -> Query ;  -- where are S
  QInfo   : Set  -> Query ;  -- (give me | ) (information about | all about) S
  QCalled : Individual -> Query ; -- how is X (also | otherwise) (called | named | known) ;

  AKind  : Set  -> Kind     -> Answer ; -- S is a K
  AProp  : Set  -> Property -> Answer ; -- S is P
  AAct   : Set  -> Activity -> Answer ; -- S As

  SAll   : Kind -> Set ;  -- all Ks | the Ks
  SOne   : Kind -> Set ;  -- one K
  SIndef : Kind -> Set ;  -- a K
  SPlural : Kind -> Set ;  -- Ks
  SOther : Kind -> Set ;  -- other Ks
  SInd   : Individual  -> Set ;  -- X
  SInds  : [Individual] -> Set ; -- X and Y

  KRelSet  : Relation -> Set -> Kind ; -- R of S | S's R
  KRelsSet : Relation -> Relation -> Set -> Kind ; -- R and Q of S
  KRelKind : Kind -> Relation -> Set -> Kind ; -- K that is R of S
  KRelPair : Kind -> Relation -> Kind ; -- S's with their R's
  KProp    : Property -> Kind -> Kind ; -- P K | K that is P
  KAct     : Activity -> Kind -> Kind ; -- K that Ps
  KRel     : Relation -> Kind ; -- R ---??

  IName    : Name -> Individual ;

  ACalled  : [Individual] -> Activity ;


-- the test lexicon

cat
  Country ;
  JobTitle ;
fun
  NCountry : Country -> Name ;
  PCountry : Country -> Property ;

  Located : Individual -> Property ;
  Employed : Individual -> Property ;

  Work : Individual -> Activity ;
  HaveTitle : JobTitle -> Individual -> Activity ;

  Organization : Kind ;
  Place : Kind ;
  Person : Kind ;

  Location : Relation ;
  Region : Relation ;
  Subregion : Relation ;

  USA : Country ;
  California : Country ;
  Bulgaria : Country ;
  OblastSofiya : Name ;

  RName     : Relation ;
  RNickname : Relation ;

  CEO : JobTitle ;
  
  Microsoft : Name ;
  Google : Name ;

  SergeyBrin : Name ;
  LarryPage : Name ;
  EricSchmidt : Name ;
  MarissaMayer : Name ;
  UdiManber : Name ;

}


