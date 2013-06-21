--# -path=.:abstract:common:prelude

resource ParadigmsLav = open
  ParadigmsVerbsLav,
  ParadigmsNounsLav,
  ParadigmsPronounsLav,
  ParadigmsAdjectivesLav,
  ResLav,
  CatLav,
  Prelude,
  Predef
in {

flags coding = utf8 ;

oper

  -- Parameters

  masculine : Gender = Masc ;
  feminine  : Gender = Fem  ;

  singular : Number = Sg ;
  plural   : Number = Pl ;

  nominative : Case = Nom ;
  genitive   : Case = Gen ;
  dative     : Case = Dat ;
  accusative : Case = Acc ;
  locative   : Case = Loc ;

  second_conjugation : Conjugation = C2 ;
  third_conjugation  : Conjugation = C3 ;

  active_voice  : Voice = Act  ;
  passive_voice : Voice = Pass ;

  -- Nouns

  mkN = overload {
    mkN : (lemma : Str) ->                                 N = \l       -> lin N (mkNoun l) ;
    mkN : (lemma : Str) ->                         Bool -> N = \l,p     -> lin N (mkNounByPal l p) ;
    mkN : (lemma : Str) -> Gender ->                       N = \l,g     -> lin N (mkNounByGend l g) ;
    mkN : (lemma : Str) ->           Declension ->         N = \l,d     -> lin N (mkNounByDecl l d) ;
    mkN : (lemma : Str) -> Gender ->               Bool -> N = \l,g,p   -> lin N (mkNounByGendPal l g p) ;
    mkN : (lemma : Str) ->           Declension -> Bool -> N = \l,d,p   -> lin N (mkNounByDeclPal l d p) ;
    mkN : (lemma : Str) -> Gender -> Declension ->         N = \l,g,d   -> lin N (mkNounByGendDecl l g d) ;
    mkN : (lemma : Str) -> Gender -> Declension -> Bool -> N = \l,g,d,p -> lin N (mkNounByGendDeclPal l g d p) ;
  } ;

  mkPN = overload {
    mkN : (lemma : Str) ->           PN = \l   -> lin PN (mkProperNoun l Sg) ;
    mkN : (lemma : Str) -> Number -> PN = \l,n -> lin PN (mkProperNoun l n) ;
  } ;

  mkN2 = overload {
    mkN2 : N -> Prep ->         N2 = \n,p     -> lin N2 (n ** {prep = p ; isPre = True}) ;
    mkN2 : N -> Prep -> Bool -> N2 = \n,p,pos -> lin N2 (n ** {prep = p ; isPre = pos}) ;
  } ;

  mkN3 : N -> Prep -> Prep -> N3 = \n,p1,p2 ->
    lin N3 (n ** {prep1 = p1 ; prep2 = p2 ; isPre1 = False ; isPre2 = False}) ;

  -- Adjectives

  mkA = overload {
    mkA : (lemma : Str) ->          A = \s   -> lin A (mkAdjective s) ;
    mkA : (lemma : Str) -> AType -> A = \s,t -> lin A (mkAdjectiveByType s t) ;

    mkA : (v : V) -> Voice -> A = \v,p -> lin A (mkAdjective_Participle v p) ;
  } ;

  AS, AV = A ;
  mkAS : A -> AS = \a -> lin A a ;
  mkAV : A -> AV = \a -> lin A a ;

  mkA2 : A -> Prep -> A2 = \a,p -> lin A2 (a ** {prep = p}) ;

  A2S, A2V = A2 ;
  mkA2S : A -> Prep -> A2S = \a,p -> lin A2 (a ** {prep = p}) ;
  mkA2V : A -> Prep -> A2V = \a,p -> lin A2 (a ** {prep = p}) ;

  -- Verbs

  mkV = overload {
    mkV : Str ->         V = \s   -> lin V (mkVerb_Irreg s Nom) ;
    mkV : Str -> Case -> V = \s,c -> lin V (mkVerb_Irreg s c) ;

    mkV : Str -> Conjugation ->         V = \s,conj   -> lin V (mkVerb s conj Nom) ;
    mkV : Str -> Conjugation -> Case -> V = \s,conj,c -> lin V (mkVerb s conj c) ;

    mkV : Str -> Str -> Str ->         V = \s1,s2,s3   -> lin V (mkVerbC1 s1 s2 s3 Nom) ;
    mkV : Str -> Str -> Str -> Case -> V = \s1,s2,s3,c -> lin V (mkVerbC1 s1 s2 s3 c) ;
  } ;

  mkV2 = overload {
    --mkV2 : V ->         V2 = \v   -> lin V2 (v ** {rightVal = acc_Prep}) ;
    --mkV2 : V -> Prep -> V2 = \v,p -> lin V2 (v ** {rightVal = p}) ;
    mkV2 : V ->         V2 = \v   -> lin V2 {s = v.s ; leftVal = v.leftVal ; rightVal = acc_Prep} ;
    mkV2 : V -> Prep -> V2 = \v,p -> lin V2 {s = v.s ; leftVal = v.leftVal ; rightVal = p} ;
  } ;

  mkVS = overload {
    mkVS : V -> Subj ->         VS = \v,c   -> lin VS {s = v.s ; leftVal = Nom ; conj = c} ;
    mkVS : V -> Subj -> Case -> VS = \v,c,s -> lin VS {s = v.s ; leftVal = s   ; conj = c} ;
  } ;

  mkVQ = overload {
    mkVQ : V ->         VQ = \v   -> lin VQ {s = v.s ; leftVal = Nom} ;
    mkVQ : V -> Case -> VQ = \v,c -> lin VQ {s = v.s ; leftVal = c} ;
  } ;

  mkVV = overload {
    mkVV : V ->         VV = \v   -> lin VV {s = v.s ; leftVal = Nom} ;
    mkVV : V -> Case -> VV = \v,c -> lin VV {s = v.s ; leftVal = c} ;
  } ;

  mkV3 = overload {
    mkV3 : V ->                 V3 = \v       -> lin V3 (v ** {rightVal1 = acc_Prep ; rightVal2 = dat_Prep}) ;
    mkV3 : V -> Prep -> Prep -> V3 = \v,p1,p2 -> lin V3 (v ** {rightVal1 = p1       ; rightVal2 = p2}) ;
  } ;

  mkVA : V -> VA = \v -> lin VA v ;

  mkV2A : V -> Prep -> V2A = \v,p -> lin V2A (v ** {rightVal = p}) ;
  mkV2Q : V -> Prep -> V2Q = \v,p -> lin V2Q (v ** {rightVal = p}) ;
  mkV2V : V -> Prep -> V2V = \v,p -> lin V2V (v ** {rightVal = p}) ;

  mkV2S : V -> Subj -> Prep -> V2S = \v,c,p -> lin V2S (v ** {conj = c ; rightVal = p}) ;

  -- Prepositions

  mkPrep = overload {
    mkPrep : Str -> Case -> Case -> Prep = \p,sg,pl -> lin Prep {s = p  ; c = table {Sg => sg ; Pl => pl}} ;
    mkPrep :                Case -> Prep = \c       -> lin Prep {s = [] ; c = \\_ => c} ;
  } ;

  nom_Prep : Prep = mkPrep Nom ;
  gen_Prep : Prep = mkPrep Gen ;
  dat_Prep : Prep = mkPrep Dat ;
  acc_Prep : Prep = mkPrep Acc ;
  loc_Prep : Prep = mkPrep Loc ;

  -- Adverbs

  mkAdv : Str -> Adv = \x -> lin Adv (ss x) ;
  mkAdV : Str -> AdV = \x -> lin AdV (ss x) ;
  mkAdA : Str -> AdA = \x -> lin AdA (ss x) ;
  mkAdN : Str -> AdN = \x -> lin AdN (ss x) ;

  mkCAdv : Str -> Str -> Degree -> CAdv = \s,p,d -> lin CAdv {s = s ; prep = p ; deg = d} ;

  -- Conjunctions

  mkConj = overload {
    mkConj : Str ->           Conj = \c   -> mk2Conj [] c Pl ;
    mkConj : Str -> Number -> Conj = \c,n -> mk2Conj [] c n ;

    mkConj : Str -> Str ->           Conj = \c1,c2 -> mk2Conj c1 c2 Pl ;
    mkConj : Str -> Str -> Number -> Conj = mk2Conj ;
  } ;

  mk2Conj : Str -> Str -> Number -> Conj = \c1,c2,n -> lin Conj (sd2 c1 c2 ** {num = n}) ;

  -- Numerals: need review (TODO)

  mkNumReg : Str -> Str -> Number -> { s : DForm => CardOrd => Gender => Case => Str } =
    \pieci,piektais,n -> mkNumSpec pieci piektais (cutStem pieci) (cutStem pieci) n ;

  mkNumSpec : Str -> Str -> Str -> Str -> Number -> { s : DForm => CardOrd => Gender => Case => Str } =
    \pieci,piektais,stem_teen,stem_ten,n ->
      let
        masc = mkNoun_D1 pieci ;
        fem = mkNoun_D4 pieci Fem ;
        ord = mkAdjective_Pos piektais Def ;
        padsmit = mkAdjective_Pos (stem_teen + "padsmitais") Def ;
        desmit = mkAdjective_Pos (stem_ten + "desmitais") Def ;
      in {
        s = table {
          DUnit => table {
            NCard => table {
              Masc => table { c => masc.s ! n ! c } ;
              Fem => table { c => fem.s ! n ! c }
            } ;
            NOrd => table {
              -- FIXME: pazaudējam kārtas skaitļu daudzskaitli - 'mēs palikām piektie'
              g => table { c => ord ! g ! Sg ! c }
            }
          } ;
          DTeen => table {
            NCard => table { g => table { c => stem_teen + "padsmit" } } ;
            NOrd => table { g => table { c => padsmit ! g ! Sg ! c } }
          } ;
          DTen => table {
            NCard => table { g => table { c => stem_ten + "desmit" } } ;
            NOrd => table { g => table { c => desmit ! g ! Sg ! c } }
          }
        }
      } ;

  viens = mkNumSpec "viens" "pirmais" "vien" "" Sg ;

  simts : CardOrd => Gender => Number => Case => Str =
    let
      card = mkNoun_D1 "simts" ;
      ord = mkAdjective_Pos "simtais" Def ;
    in table {
      NCard => table {
        _ => table { n => table { c => card.s ! n ! c } }
      } ;
      NOrd => table {
        g => table { n => table { c => ord ! g ! n ! c } }
      }
    } ;

  tuukstotis : CardOrd => Gender => Number => Case => Str =
    let
      card = mkNoun_D2 "tūkstotis" True ;
      ord = mkAdjective_Pos "tūkstošais" Def ;
    in table {
      NCard => table {
        _ => table { n => table { c => card.s ! n ! c } }
      } ;
      NOrd => table {
        g => table { n => table { c => ord ! g ! n ! c } }
      }
    } ;

}
