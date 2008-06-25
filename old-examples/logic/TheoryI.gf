incomplete concrete TheoryI of Theory = 
  open 
    LexTheory,
    Grammar, 
    Symbolic, 
    Symbol,
    Combinators, 
    Constructors, 
    (C=ConstructX),
    Prelude 
  in {

lincat
  Chapter = Text ;
  Jment   = Text ;
  Decl    = Text ;
  Prop    = S ;
  Branch  = S ;
  Proof   = Text ;
  [Proof] = Text ;
  Typ     = CN ;
  Obj     = NP ;
  Label   = NP ;
  Adverb  = PConj ;
  Ref     = NP ;
  [Ref]   = [NP] ;
  Number  = Num ;

lin
  Chap title jments = 
    appendText (mkText (mkPhr (mkUtt title)) TEmpty) jments ;

  JDefObj decl a b = 
    appendText decl (mkUtt (mkS (pred b a))) ;

  DProp p = 
    mkText (mkPhr (mkUtt (mkImp (mkVP assume_VS p)))) TEmpty ;
  DTyp a ty = --- x pro a: refresh bug
    mkText (mkPhr (mkUtt (mkImp (mkVP assume_VS (mkS (pred ty a)))))) TEmpty ;

  PProp p = mkText (mkPhr p) TEmpty ;
  PAdvProp a p = mkText (mkPhr a (mkUtt p) NoVoc) TEmpty ;
  PDecl d = d ;
  PBranch b ps = mkText (mkPhr b) ps ;

  BCases n = 
    mkS (pred have_V2 (mkNP we_Pron) (mkNP (mkDet (mkNum n2)) case_N)) ;

  ARef h = mkAdv by8means_Prep h ;
  AHence = therefore_PConj ;
  AAFort = C.mkPConj ["a fortiori"] ;

  RLabel h = h ;
  RMany rs = mkNP and_Conj rs ;

}
