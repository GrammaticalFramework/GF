abstract Theory = {

  cat
    Chapter ;
    Jment ;
    [Jment] {0} ;
    Decl ;
    [Decl] {0} ;
    Prop ;
    Proof ;
    [Proof] {2} ;
    Branch ;
    Typ ;
    Obj ;
    Label ;
    Ref ;
    [Ref] ;
    Adverb ;
    Number ;
    
  fun
    Chap       : Label -> [Jment] -> Chapter ;          -- title, text

    JDefObj    : [Decl] -> Obj -> Obj -> Jment ;        -- a = b (G)
    JDefObjTyp : [Decl] -> Typ -> Obj -> Obj -> Jment ; -- a = b : A (G)
    JDefProp   : [Decl] -> Prop -> Prop -> Jment ;      -- A = B : Prop (G)
    JThm       : [Decl] -> Prop -> Proof -> Jment ;     -- p : P (G)

    DProp      : Prop  -> Decl ;                        -- assume P
    DPropLabel : Label -> Prop -> Label ;               -- assume P (h)
    DTyp       : Obj   -> Typ -> Decl ;                 -- let x,y be T

    PProp      : Prop -> Proof ;                        -- P.
    PAdvProp   : Adverb -> Prop -> Proof ;              -- Hence, P.
    PDecl      : Decl -> Proof ;                        -- Assume P.
    PBranch    : Branch -> [Proof] -> Proof ;           -- By cases: P1 P2

    BCases     : Number -> Branch ;                     -- We have n cases.
    
    ARef       : Ref -> Adverb ;                        -- by Thm 2
    AHence     : Adverb ;                               -- therefore
    AAFort     : Adverb ;                               -- a fortiori

    RLabel     : Label -> Ref ;                         -- Thm 2
    RMany      : [Ref] -> Ref ;                         -- Thm 2 and Lemma 4

}
