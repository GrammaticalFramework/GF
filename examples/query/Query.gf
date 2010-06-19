abstract Query = {

flags
  startcat = Move ;

-- general query language, which can be specialized with any lexicon

cat
  Move ;     -- top-level utterance,    e.g. "give me all Bulgarian persons that work at Google"
  Query ;   
  Answer ;
  Set ;      -- the set requested,      e.g. "all persons"
  Interrogative ; -- interrog. pron.    e.g. "who" 
  Function ; -- something of something, e.g. "subregion of Bulgaria"
  Kind ;     -- type of things,         e.g. "person"
  Relation ; -- relation between things,e.g. "employed at"
  Property ; -- property of things,     e.g. "employed at Google"
  Individual ; -- one entity,           e.g. "Google"
  Name ;       -- person, company...    e.g. "Eric Schmidt"
  [Individual] {2} ; -- list of entities, e.g. "Larry Page, Sergey Brin"

fun
  MQuery  : Query -> Move ;
  MAnswer : Answer -> Move ;
 
  QSet    : Set  -> Query ;  -- (give me | what are | which are | ) (S | the names of S | S's names)
  QWhere     : Set  -> Query ;  -- where are S
  QWhat      : Interrogative -> Property -> Query ; -- who P
  QWhatWhat  : Interrogative -> Interrogative -> Relation -> Query ; -- who R what
  QWhatWhere : Interrogative -> Relation -> Query ; -- who R where --- overgenerating
  QRelWhere  : Set -> Relation -> Query ; -- where does S R --- overgenerating
  QFun       : Function -> Set -> Query ; -- what R does S have
  QFunPair   : Set -> Function -> Query ; -- S and their R's
  QInfo      : Set  -> Query ;  -- (give me | ) (information about | all about) S
  QCalled    : Individual -> Query ; -- how is X (also | otherwise) (called | named | known) ;
  QWhether   : Answer -> Query ; -- is S P --- not in the corpus, but should be ??

  AKind  : Set  -> Kind     -> Answer ; -- S is a K
  AInd   : Set  -> Individual -> Answer ; -- S is I
  AName  : Set  -> Name     -> Answer ; -- N is the name of S
  AProp  : Set  -> Property -> Answer ; -- S is P

  SAll   : Kind -> Set ;  -- all Ks | the Ks
  SFun   : Set  -> Function -> Set ;  -- S's Rs
  SOne   : Kind -> Set ;  -- one K
  SIndef : Kind -> Set ;  -- a K
  SDef   : Kind -> Set ;  -- the K
  SPlural : Kind -> Set ;  -- Ks
  SOther : Kind -> Set ;  -- other Ks
  SInd   : Individual  -> Set ;  -- X
  SInds  : [Individual] -> Set ; -- X and Y

  IWho   : Interrogative ; -- who
  IWhat  : Interrogative ; -- what
  IWhich : Kind -> Interrogative ; -- which K | what K | which Ks | what Ks

  KFunSet  : Function -> Set -> Kind ; -- R of S | S's R
  KFunsSet : Function -> Function -> Set -> Kind ; -- R and Q of S
  KFunKind : Kind -> Function -> Set -> Kind ; -- K that is R of S
  KFunPair : Kind -> Function -> Kind ; -- S's with their R's
  KProp    : Property -> Kind -> Kind ; -- P K | K that is P
  KFun     : Function -> Kind ; -- R ---??

  IName    : Name -> Individual ;

  PCalled  : Individual   -> Property ;  -- also called I
  PCalleds : [Individual] -> Property ;  -- also called I or J

  PIs      : Individual -> Property ;

  PRelation : Relation -> Set -> Property ;

-- the test lexicon

cat
  Country ;
  JobTitle ;
fun
  NCountry : Country -> Name ;
  PCountry : Country -> Property ;

  Located : Relation ;

  In : Relation ;
  HaveTitleAt : JobTitle -> Relation ;
  EmployedAt : Set -> Relation ;
  HaveTitle : Relation ;
  Employed : Relation ;

  Named : Name -> Property ;

  Start : Name -> Property ;

  Organization : Kind ;
  Company : Kind ;
  Place : Kind ;
  Person : Kind ;

  Location : Function ;
  Region : Function ;
  Subregion : Function ;

  USA : Country ;
  California : Country ;
  Bulgaria : Country ;
  OblastSofiya : Name ;

  FName     : Function ;
  FNickname : Function ;
  FJobTitle : Function ;

  SJobTitle : JobTitle -> Set ; -- a programmer

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


