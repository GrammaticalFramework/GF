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
  Name ;       -- person, company...    e.g. "Eric Schmidt"
  [Individual] {2} ; -- list of entities, e.g. "Larry Page, Sergey Brin"

fun
  MQuery  : Query -> Move ;
  MAnswer : Answer -> Move ;
 
  QSet    : Set  -> Query ;  -- (give me | what are | which are | ) (S | the names of S | S's names)
  QWhere  : Set  -> Query ;  -- where are S
  QWhat   : Kind -> Property -> Query ; -- what K P
  QWho    : Property -> Query ; -- who P
  QRel    : Relation -> Set -> Query ; -- what R does S have
  QInfo   : Set  -> Query ;  -- (give me | ) (information about | all about) S
  QCalled : Individual -> Query ; -- how is X (also | otherwise) (called | named | known) ;
  QWhether : Answer -> Query ; -- is S P --- not in the corpus, but should be ??

  AKind  : Set  -> Kind     -> Answer ; -- S is a K
  AInd   : Set  -> Individual -> Answer ; -- S is I
  AName  : Set  -> Name     -> Answer ; -- N is the name of S
  AProp  : Set  -> Property -> Answer ; -- S is P

  SAll   : Kind -> Set ;  -- all Ks | the Ks
  SRel   : Set  -> Relation -> Set ;  -- S's Rs
  SOne   : Kind -> Set ;  -- one K
  SIndef : Kind -> Set ;  -- a K
  SDef   : Kind -> Set ;  -- the K
  SPlural : Kind -> Set ;  -- Ks
  SOther : Kind -> Set ;  -- other Ks
  SInd   : Individual  -> Set ;  -- X
  SInds  : [Individual] -> Set ; -- X and Y

  KRelSet  : Relation -> Set -> Kind ; -- R of S | S's R
  KRelsSet : Relation -> Relation -> Set -> Kind ; -- R and Q of S
  KRelKind : Kind -> Relation -> Set -> Kind ; -- K that is R of S
  KRelPair : Kind -> Relation -> Kind ; -- S's with their R's
  KProp    : Property -> Kind -> Kind ; -- P K | K that is P
  KRel     : Relation -> Kind ; -- R ---??

  IName    : Name -> Individual ;

  PCalled  : Individual   -> Property ;  -- also called I
  PCalleds : [Individual] -> Property ;  -- also called I or J

  PIs      : Individual -> Property ;

-- the test lexicon

cat
  Country ;
  JobTitle ;
fun
  NCountry : Country -> Name ;
  PCountry : Country -> Property ;

  Located : Set -> Property ;

  In : Set -> Property ;
  HaveTitleAt : JobTitle -> Set -> Property ;
  HaveTitle : JobTitle -> Property ;
  Employed : Set -> Property ;

  Named : Name -> Property ;
  Start : Name -> Property ;

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
  RJobTitle : Relation ;

  CEO : JobTitle ;
  ChiefInformationOfficer : JobTitle ;
  
  Microsoft : Name ;
  Google : Name ;

  SergeyBrin : Name ;
  LarryPage : Name ;
  EricSchmidt : Name ;
  MarissaMayer : Name ;
  UdiManber : Name ;
  CarlGustavJung : Name ;
  Jung : Name ;
  BenFried : Name ;
}


