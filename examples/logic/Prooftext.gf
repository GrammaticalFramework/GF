interface Prooftext = open 
  Grammar, 
  LexTheory,
  Symbolic,
  Symbol, 
  (C=ConstructX),
  Constructors, 
  Combinators 
  in {

oper
  Chapter  = Text ;
  Section  = Text ;
  Sections = Text ;
  Decl     = Text ;
  Decls    = Text ;
  Prop     = S ;
  Branching= S ;
  Proof    = Text ;
  Proofs   = Text ;
  Typ      = CN ;
  Object   = NP ;
  Label    = NP ;
  Adverb   = PConj ;
  Ref      = NP ;
  Refs     = [NP] ;
  Number   = Num ;

  chapter : Label -> Sections -> Chapter 
    = \title,jments -> 
        appendText (mkText (mkPhr (mkUtt title)) TEmpty) jments ;

  definition : Decls -> Object -> Object -> Section 
    = \decl,a,b -> 
        appendText decl (mkUtt (mkS (pred b a))) ;

  theorem : Prop -> Proof -> Section 
    = \prop,prf -> appendText (mkText (mkPhr prop) TEmpty) prf ;

  assumption : Prop -> Decl 
    = \p -> 
        mkText (mkPhr (mkUtt (mkImp (mkVP assume_VS p)))) TEmpty ;

  declaration : Object -> Typ -> Decl
    = \a,ty ->
        mkText (mkPhr (mkUtt (mkImp (mkVP assume_VS (mkS (pred ty a)))))) TEmpty ;

  proof = overload {
    proof : Prop -> Proof 
      = \p -> mkText (mkPhr p) TEmpty ;
    proof : Str -> Proof
      = \s -> {s = s ++ "." ; lock_Text = <>} ;
    proof : Adverb -> Prop -> Proof
      = \a,p -> mkText (mkPhr a (mkUtt p) NoVoc) TEmpty ;
    proof : Decl -> Proof
      = \d -> d ;
    proof : Proof -> Proof -> Proof
      = \p,q -> appendText p q ;
    proof : Branching -> Proofs -> Proof
      = \b,ps -> mkText (mkPhr b) ps
    } ;

  proofs : Proof -> Proof -> Proofs 
    = appendText ;

  cases : Num -> Branching 
    = \nu -> 
        mkS (pred have_V2 (mkNP we_Pron) (mkNP (mkDet nu) case_N)) ;

  by : Ref -> Adverb 
    = \h -> mkAdv by8means_Prep h ;
  therefore : Adverb
    = therefore_PConj ;
  afortiori : Adverb
    = C.mkPConj ["a fortiori"] ;
  hypothesis : Adverb
    = mkAdv by8means_Prep (mkNP (mkDet DefArt) hypothesis_N) ;

  ref : Label -> Ref
    = \h -> h ;
  refs : Refs -> Ref
    = \rs -> mkNP and_Conj rs ;

  mkLabel : Str -> Label ;

}
