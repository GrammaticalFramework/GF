incomplete concrete LogicI of Logic = 
  open 
    LexTheory,
    Prooftext, 
    Grammar, 
    Constructors, 
    Combinators,
    ParamX ---
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

  Disj A B = coord or_Conj A B ;
  Impl A B = coord ifthen_DConj A B ;

  Abs = mkS (pred have_V2 (mkNP we_Pron) (mkNP (mkDet IndefArt) contradiction_N)) ;

  Univ A B = 
    AdvS 
      (mkAdv for_Prep (mkNP all_Predet 
        (mkNP (mkDet (PlQuant IndefArt)) (mkCN A (symb B.$0)))))
      B ;

  DisjIl A B a = proof a (proof afortiori (coord or_Conj A B)) ;
  DisjIr A B b = proof b (proof afortiori (coord or_Conj A B)) ;

  DisjE A B C c b1 b2 =
    appendText
      c 
      (appendText
        (appendText
           (cases (mkNum n2)) 
           (proofs 
             (appendText (assumption A) b1)
             (appendText (assumption B) b2)))
        (proof therefore C)) ;

  ImplI A B b = 
    proof (assumption A) (appendText b (proof therefore (coord ifthen_DConj A B))) ;

  Hypoth A h = proof hypothesis A ;


--- this should not be here, but is needed for variables
lindef
  Elem s = {s = \\_ => s ; a = {n = Sg ; p = P3} ; lock_NP = <>} ;

}