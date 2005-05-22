--# -path=.:../abstract:../../prelude

incomplete concrete RulesRomance of Rules = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

lin 
  UseN = noun2CommNounPhrase ;
  UsePN = nameNounPhrase ;

  SymbPN i = {s = i.s ; g = Masc} ; --- cannot know gender
  SymbCN cn s =
    {s = \\n => cn.s ! n ++ s.s ; 
     g = cn.g} ;
  IntCN cn i =
    {s = \\n => cn.s ! n ++ i.s ; 
     g = cn.g} ;

  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum ;

  DetNP = detNounPhrase ;
  NDetNP = numDetNounPhrase ;
  NDetNum = justNumDetNounPhrase ; 
  MassNP = partitiveNounPhrase singular ;

  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseN2 = funAsCommNounPhrase ; -- [SyntaxFra.noun2CommNounPhrase]

  ModAP = modCommNounPhrase ;
  CNthatS = nounThatSentence ;

  ModGenOne = npGenDet singular ;
  ModGenNum = npGenDetNum ;

  UseInt i = {s = \\_ => i.s ; n = Pl ; isNo = False} ; ---- n
  NoNum = noNum ;

  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;
  ComplAV v x = complVerbAdj v x ;
  ComplObjA2V v x y = complVerbAdj2 True v x y ;

  PositADeg  = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlADeg = superlAdjPhrase ;

  PredAS = predAdjSent ;
  PredV0 rain = predVerb0 rain ;

-- Partial saturation.

  UseV2 = transAsVerb ;

  ComplA2S = predAdjSent2 ; ---- clitics get lost

  AdjPart = adjPastPart ;

  UseV2V x = x ** {isAux = False} ;
  UseV2S x = x ;
  UseV2Q x = x ;
  UseA2S x = x ;
  UseA2V x = x ;

-- Formation of fixed-tense fixed-polarity clauses.

  UseCl tp cl = 
    {s = \\m => tp.s ++ cl.s ! tp.b ! useClForm tp.t tp.a m} ;
  UseRCl tp cl = 
    {s = \\m,g,n,p => tp.s ++ cl.s ! tp.b ! useClForm tp.t tp.a m ! g ! n ! p} ;
  UseQCl tp cl = 
    {s = \\q => tp.s ++ cl.s ! tp.b ! useClForm tp.t tp.a Ind ! q} ;

  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = Present} ;
  TPast        = {s = [] ; t = Past} ;
  TFuture      = {s = [] ; t = Future} ;
  TConditional = {s = [] ; t = Condit} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

-- Adverbs.

  AdjAdv a = {s = a.s ! AA} ;
----  AdvVP = adVerbPhrase ;
  AdvPP p = p ;

  PrepNP = prepNounPhrase ;

  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;
  AdvAdv = cc2 ;

--3 Sentences and relative clauses
--

  SlashV2  = slashTransVerb ;
  SlashVV2 = slashVerbVerb ;
  SlashAdv = slashAdverb ;

  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelSlash = relSlash ;
  ModRS = modRelClause ;
  RelCl = relSuch ;

--!
--3 Questions and imperatives
--

  IDetCN d n = let np = detNounPhrase d n in {
    s = \\c => np.s ! case2pform c ;
    g = pgen2gen np.g ;
    n = np.n
    } ;
  FunIP = funIntPron ;

  QuestCl = questClause ;
  IntSlash = intSlash ;
  QuestAdv = questAdverbial ;

  PosImpVP = imperVerbPhrase True ;
  NegImpVP = imperVerbPhrase False ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  AdvCl  = advClause ;
  AdvVPI = advVerbPhrase ;

  AdCPhr = advSentence ;
  AdvPhr = advSentence ;

  TwoS = twoSentence ;
  ConsS = consSentence ;
  ConjS = conjunctSentence ;
  ConjDS = conjunctDistrSentence ; -- [Coordination.conjunctDistrTable]

  TwoAP = twoAdjPhrase ;
  ConsAP = consAdjPhrase ;
  ConjAP = conjunctAdjPhrase ;
  ConjDAP = conjunctDistrAdjPhrase ;

  TwoNP = twoNounPhrase ;
  ConsNP = consNounPhrase ;
  ConjNP = conjunctNounPhrase ;
  ConjDNP = conjunctDistrNounPhrase ;

  TwoAdv = twoAdverb ;
  ConsAdv = consAdverb ;
  ConjAdv = conjunctAdverb ;
  ConjDAdv = conjunctDistrAdverb ;

  SubjS = subjunctSentence ;       -- stack
  SubjImper = subjunctImperative ; 
  SubjQS = subjunctQuestion ;
 ----- SubjVP = subjunctVerbPhrase ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;
  PhrVPI = verbUtterance ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

-----------------------
-- special constructions

  OneNP = nounPhraseOn ;

  ExistCN A = existNounPhrase (indefNounPhrase Sg A) ;

  ExistNumCN nu A = existNounPhrase (indefNounPhraseNum nu A) ;

}
