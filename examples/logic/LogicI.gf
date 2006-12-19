incomplete concrete LogicI of Logic = 
  open 
    LexTheory,
    Prooftext, 
    Grammar, 
    Constructors, 
    Combinators
  in {

lincat 
  Prop  = Prooftext.Prop ;
  Proof = Prooftext.Proof ;
  Dom   = Typ ;
  Elem  = Object ;
  Hypo  = Label ;
  Text  = Section ;

lin
  ThmWithProof = theorem ;

  Conj = coord and_Conj ;
  Disj = coord or_Conj ;
  Impl = coord ifthen_DConj ;

  Abs = 
    mkS (pred have_V2 (mkNP we_Pron) (mkNP (mkDet IndefArt) contradiction_N)) ;

  Univ A B = 
    AdvS 
      (mkAdv for_Prep (mkNP all_Predet 
        (mkNP (mkDet (PlQuant IndefArt) NoNum NoOrd) (mkCN A (symb B.$0)))))
      B ;

  DisjIl A B a = proof a (proof afortiori (coord or_Conj A B)) ;
  DisjIr A B b = proof b (proof afortiori (coord or_Conj A B)) ;

  DisjE A B C c d e =
    appendText
      c 
      (appendText
        (appendText
           (cases (mkNum n2)) 
           (proofs 
             (appendText (assumption A) d)
             (appendText (assumption B) e)))
        (proof therefore C)) ;

  ImplI A B b = 
    proof 
      (assumption A) 
      (appendText b (proof therefore (coord ifthen_DConj A B))) ;

  Hypoth A h = proof hypothesis A ;


lindef
  Elem = defNP ;

}
