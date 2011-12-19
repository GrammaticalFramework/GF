--# -path=.:../abstract:../common:../prelude

-- This is an API for the user of the resource grammar
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
--
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$.
--
-- The main difference with $MorphoLav.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.

resource ParadigmsLav = open
  (Predef=Predef),
  Prelude,
  ParadigmsNounsLav,
  ParadigmsAdjectivesLav,
  ParadigmsVerbsLav,
  ParadigmsPronounsLav,
  ResLav,
  CatLav
  in {

flags
  coding = utf8 ;

oper
  second_conjugation : VerbConj = C2 ;
  third_conjugation  : VerbConj = C3 ;

  nominative : Case = Nom ;
  genitive   : Case = Gen ;
  dative     : Case = Dat ;
  accusative : Case = Acc ;
  locative   : Case = Loc ;

  mkN = overload {
    mkN : (lemma : Str) -> N = \l -> lin N (mkNoun l) ;

    mkN : (lemma : Str) -> Bool -> N = \l,p -> lin N (mkNounByPal l p) ;
    mkN : (lemma : Str) -> Gender -> N = \l,g -> lin N (mkNounByGend l g) ;
    mkN : (lemma : Str) -> NounDecl -> N = \l,d -> lin N (mkNounByDecl l d) ;

    mkN : (lemma : Str) -> Gender -> Bool -> N = \l,g,p -> lin N (mkNounByGendPal l g p) ;
    mkN : (lemma : Str) -> NounDecl -> Bool -> N = \l,d,p -> lin N (mkNounByDeclPal l d p) ;
    mkN : (lemma : Str) -> Gender -> NounDecl -> N = \l,g,d -> lin N (mkNounByGendDecl l g d) ;

    mkN : (lemma : Str) -> Gender -> NounDecl -> Bool -> N = \l,g,d,p ->
      lin N (mkNounByGendDeclPal l g d p) ;
  } ;

  mkPN = overload {
    mkN : (lemma : Str) -> PN = \l -> lin PN (mkProperNoun l Sg) ;
	mkN : (lemma : Str) -> Number -> PN = \l,n -> lin PN (mkProperNoun l n) ;
  } ;

  mkN2 = overload {
	mkN2 : N -> Prep -> N2 = \n,p -> lin N2 n ** { p = p ; isPre = False } ;
	mkN2 : N -> Prep -> Bool -> N2 = \n,p,isPre -> lin N2 n ** { p = p ; isPre = isPre } ;
  } ;

  mkN3 : N -> Prep -> Prep -> N3 = \n,p1,p2 ->
    lin N3 n ** { p1 = p1 ; p2 = p2 ; isPre1 = False ; isPre2 = False } ;

  mkA = overload {
    mkA : (lemma : Str) -> A = \s -> lin A (mkAdjective s) ;
    mkA : (lemma : Str) -> AdjType -> A = \s,t -> lin A (mkAdjectiveByType s t) ;
	mkA : (v : Verb) -> A = \v -> lin A (mkAdjective_Participle v) ;
  } ;

  mkA2  : A -> Prep -> A2 = \a,p -> lin A2 (a ** { p = p }) ;	-- precējies ar ...
  mkAS  : A -> AS  =\a   -> lin A  a ;
  mkA2S : A -> Prep -> A2S =\a,p -> lin A2 (a ** { p = p }) ;
  mkAV  : A -> AV  = \a   -> lin A  a ;
  mkA2V : A -> Prep -> A2V = \a,p -> lin A2 (a ** { p = p }) ;

  AS, AV   : Type = { s : AForm => Str } ;
  A2S, A2V : Type = { s : AForm => Str ; p : Prep };

  mkV = overload {
    mkV : (lemma : Str) -> V = \l -> lin V (mkVerb_Irreg l) ;
    mkV : (lemma : Str) -> VerbConj -> V = \l,c -> lin V (mkVerb l c) ;
    mkV : (lemma : Str) -> Str -> Str -> V = \l1,l2,l3 -> lin V (mkVerbC1 l1 l2 l3) ;
  } ;

  mkV2  : V -> Prep -> V2 = \v,p -> lin V2 v ** { p = p } ;
  mkVS  : V -> Subj -> VS = \v,s -> lin VS v ** { subj = s } ;
  mkV2S : V -> Prep -> Subj -> V2S = \v,p,s -> lin V2S v ** { p = p ; subj = s } ;
  mkVA  : V -> VA = \v -> lin VA v ;
  mkV2A : V -> Prep -> V2A = \v,p -> lin V2A v ** { p = p } ;
  mkVQ  : V -> VQ = \v -> lin VQ v ;
  mkV2Q : V -> Prep -> V2Q = \v,p -> lin V2Q v ** { p = p } ;
  mkVV  : V -> VV = \v -> lin VV v ;
  mkV2V : V -> Prep -> V2V = \v,p -> lin V2V v ** { p = p } ;
  mkV3  : V -> Prep -> Prep -> V3 = \v,p1,p2 -> lin V3 v ** { p1 = p1 ; p2 = p2 } ;

  mkCAdv : Str -> Str -> Degree -> CAdv  = \s,p,d -> { s = s ; p = p ; d = d ; lock_CAdv = <> } ;

  mkPrep = overload {
    mkPrep : Str -> Case -> Case -> Prep = \prep,sg,pl ->
      lin Prep { s = prep ; c = table { Sg => sg ; Pl => pl } } ;
	mkPrep : Case -> Prep = \c -> lin Prep { s = [] ; c = table { _ => c } } ;
  } ;

  -- empty fake prepositions for valences
  -- rections that are expressed by simple cases without any prepositions
  nom_Prep = mkPrep Nom ;
  gen_Prep = mkPrep Gen ;
  dat_Prep = mkPrep Dat ;
  acc_Prep = mkPrep Acc ;
  loc_Prep = mkPrep Loc ;

  mkAdv : Str -> Adv = \x -> lin Adv (ss x) ;
  mkAdV : Str -> AdV = \x -> lin AdV (ss x) ;
  mkAdA : Str -> AdA = \x -> lin AdA (ss x) ;
  mkAdN : Str -> AdN = \x -> lin AdN (ss x) ;

  mkConj = overload {
    mkConj : Str -> Conj = \y -> mk2Conj [] y Pl ;
    mkConj : Str -> Number -> Conj = \y,n -> mk2Conj [] y n ;
    mkConj : Str -> Str -> Conj = \x,y -> mk2Conj x y Pl ;
    mkConj : Str -> Str -> Number -> Conj = mk2Conj ;
  } ;

  mk2Conj : Str -> Str -> Number -> Conj = \x,y,n -> lin Conj (sd2 x y ** { n = n }) ;

  viens = mkNumSpec "viens" "pirmais" "vien" "" Sg ;

  mkNum : Str -> Str -> Number -> { s : DForm => CardOrd => Gender => Case => Str } =
    \pieci,piektais,n -> mkNumSpec pieci piektais (cutStem pieci) (cutStem pieci) n ;

  mkNumSpec : Str -> Str -> Str -> Str -> Number -> { s : DForm => CardOrd => Gender => Case => Str } =
    \pieci,piektais,stem_teen,stem_ten,n ->
      let
        masc = mkNoun_D1 pieci ;
        fem = mkNoun_D4 pieci Fem ;
        ord = mkAdjective_Pos piektais Def ;
        padsmit = mkAdjective_Pos (stem_teen+"padsmitais") Def ;
        desmit = mkAdjective_Pos (stem_ten+"desmitais") Def ;
      in {
        s = table {
          unit => table {
            NCard => table {
              Masc => table { c => masc.s ! n ! c } ;
              Fem => table { c => fem.s ! n ! c }
            } ;
            NOrd => table {
              -- FIXME: pazaudējam kārtas skaitļu daudzskaitli - 'mēs palikām piektie'
              g => table { c => ord ! g ! Sg ! c }
            }
          } ;
          teen => table {
            NCard => table { g => table { c => stem_teen + "padsmit" } } ;
            NOrd => table { g => table { c => padsmit ! g ! Sg ! c } }
          } ;
          ten => table {
            NCard => table { g => table { c => stem_ten + "desmit" } } ;
            NOrd => table { g => table { c => desmit ! g ! Sg ! c } }
          }
        }
      } ;

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
