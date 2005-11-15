abstract QLF = {

-- by CF2GF

fun
-- SLT book, chapter 9

-- p. 164

utterance_phrase : PHRASE -> UTTERANCE ;
utterance_conj_phrase : CONJ -> PHRASE -> UTTERANCE ;
utterance_whatabout : PHRASE -> UTTERANCE ; 
utterance_howabout : PHRASE -> UTTERANCE ;

phrase_pp : PP -> PHRASE ;
phrase_advp : ADVP -> PHRASE ;
phrase_np : NP -> PHRASE ;

utterance_s_imp : S_imp -> UTTERANCE ;
utterance_s_moved : S_moved -> UTTERANCE ;
utterance_s_q : S_q -> UTTERANCE ;
utterance_s_norm_inv : S_norm_inv -> UTTERANCE ;
utterance_s_norm : S_norm -> UTTERANCE ;

-- p. 162

s_norm_NP_VP : NP_norm -> VP -> S_norm ; -- these 3 are 1 in CLE
s_q_NP_VP : NP_q -> VP -> S_q ;
s_r_NP_VP : NP_r -> VP -> S_r ;

s_imp_NP_VP : NP_imp -> VP -> S_imp ;

s_advp_s : ADVP_sent -> S -> S ;
s_s_advp : S -> ADVP_sent -> S ;
s_conj_s : S -> CONJ -> S -> S ;

-- p. 163: 6 wh-move-rules

-- p. 160

vp_vp_pp : VP -> PP -> VP ;
vp_vp_advp : VP -> ADVP -> VP ;
vp_advp_vp : ADVP -> VP -> VP ;
advp_vp_ing : VP_ing -> ADVP ;
advp_vp_to : VP_to -> ADVP ;
vp_conj_vp : VP -> CONJ -> VP -> VP ;
vp_not_vp : VP -> VP ;

np_gaps : NP_gaps ;
pp_gaps : PP_gaps ;
adjp_gaps : ADJP_gaps ;
advp_gaps : ADVP_gaps ;

-- p. 157

vp_be_comp : V_be -> COMP -> VP ; -- 1 rule VP ::= V COMPS
vp_tr : V_tr -> NP -> VP ;
vp_ditr : V_ditr -> NP -> NP -> VP ;
vp_intr : V_intr -> VP ;
vp_mod : V_mod -> VP -> VP ; -- would, could, can, may, will
vp_do : V_do -> VP -> VP ;
vp_be_pass : V_be -> VP_pass -> VP ;
vp_be_ing : V_be -> VP_ing -> VP ;
vp_part : V_part -> VP ; -- particle verb
vp_s : V_s -> S -> VP ;
vp_vp_to : V_vp -> VP_to -> VP ; -- "how much does it cost to fly..."
vp_ditrq : V_ditrq -> NP -> S_q -> VP ;
vp_ditrpp : V_ditrpp -> NP -> PP -> VP ;
vp_trq : V_trq -> S_q -> VP ;

-- p. 159

comp_np : NP -> COMP ;
comp_adjp : ADJP -> COMP ;
comp_pp : PP -> COMP ;

-- p. 156

pp_pp : PP -> PP -> PP ; -- big PP --- unnecessary ambiguity?

pp_p_np : P -> NP -> PP ;
pp_np_temporal : NP_temporal -> PP ;
pp_name_p_name : NP_name -> P -> NP_name -> PP ; -- Baltimore to Philadelpia
pp_conj_pp : PP -> CONJ -> PP -> PP ;

-- p. 157; the numeral rules are not shown

number_digit : DIGIT -> NUMBER ; --- and more
ordinal_first : ORDINAL ; --- and more
code_digit : DIGIT -> CODE ;
code_digit_code : DIGIT -> CODE -> CODE ;

digit_1 : DIGIT ;
digit_2 : DIGIT ;
digit_3 : DIGIT ;
digit_4 : DIGIT ;
digit_5 : DIGIT ;
digit_6 : DIGIT ;
digit_7 : DIGIT ;
digit_8 : DIGIT ;
digit_9 : DIGIT ;
digit_0 : DIGIT ;

-- p. 154 "recursive NPs"

np_np_pp : NP -> PP -> NP ;
np_np_rel : NP -> REL -> NP ;

np_np_vp_ing : NP -> VP_ing -> NP ; -- these 2 are 1 with \/
np_np_vp_pass : NP -> VP_pass -> NP ;

np_np_adjp : NP -> ADJP_post -> NP ; --- restr. acc to text

rel_s_rel : S_rel -> REL ;
rel_s_norm : S_normal_gap -> REL ; --- type normal=norm ??
--- they cannot be showing their real code here

adjp_nocomp : ADJ_nocomp -> ADJP ; -- ADJP ::= ADJ COMPS
adjp_np : ADJ_pp -> NP -> ADJP ; -- only "available" in corpus
-- adjp_pp : ADJ_pp -> PP -> ADJP ; -- only "available" in corpus

np_conj_np : NP -> CONJ -> NP -> NP ; --- curious analysis of conj lists...
np_np_np : NP -> NP -> NP ; -- Boston Atlanta and Denver

s_vp_inf : VP_inf -> S_norm ; -- "to get from X to Y (is...)"
np_s_q : S_q -> NP ; -- "what city they stop in (is...)"
np_s_norm : S_norm -> NP ;
np_compl_s : COMPLEMENTISER -> S_norm -> NP ; --- they don't tell what CO... is

np_np_code : NP -> CODE -> NP ; --- unnec. source of ambiguity


-- p. 150

np_det_nbar : DET -> NBAR -> NP ;
np_nbar : NBAR -> NP ; -- "information", "travel arrangements"

nbar_adjp_nbar : ADJP -> NBAR -> NBAR ;
nbar_nbar_nbar : NBAR -> NBAR -> NBAR ; --- unnec. ambiguity
nbar_name_nbar : NP_name -> NBAR -> NBAR ; -- "Delta flights"
nbar_conj_nbar : NBAR -> CONJ -> NBAR -> NBAR ;

adjp_most_adj : ADJ -> ADJP ;
adjp_least_adj : ADJ -> ADJP ;
ordinal_adjp_superl : ADJP_superlative -> ORDINAL ;

det_the_ordinal : ORDINAL -> DET ;
det_ordinal : ORDINAL -> DET ; -- common in spoken language
det_predet_det : PREDET -> DET -> DET ;
det_numer : NUMBER -> DET ; --- NUMBER in book
det_less_than : NUMBER -> DET ; --- NUMBER
det_more_than : NUMBER -> DET ; --- NUMBER
det_possessive : POSSESSIVE -> DET ;


-- p. 152 time and date NPs not given

np_code : CODE -> NP ;
np_nbar_code : NBAR -> CODE -> NP ;

-- : NUMBER -> already -> covered -> above -> CODE
--  letter codes added from corpus

np_det : DET_bare -> NP ; -- any, which, one, both, the same, the latest,...

nbar_comp : NBAR_of -> NBAR -> NBAR ; -- only ex of NBAR COMP; (kind | type) of plane

-- by pg -printer=gf

  cat ADJ ;
  cat ADJP ;
  cat ADJP_gaps ;
  cat ADJP_post ;
  cat ADJP_superlative ;
  cat ADJ_nocomp ;
  cat ADJ_pp ;
  cat ADVP ;
  cat ADVP_gaps ;
  cat ADVP_sent ;
  cat CODE ;
  cat COMP ;
  cat COMPLEMENTISER ;
  cat CONJ ;
  cat DET ;
  cat DET_bare ;
  cat DIGIT ;
  cat NBAR ;
  cat NBAR_of ;
  cat NP ;
  cat NP_gaps ;
  cat NP_imp ;
  cat NP_name ;
  cat NP_norm ;
  cat NP_q ;
  cat NP_r ;
  cat NP_temporal ;
  cat NUMBER ;
  cat ORDINAL ;
  cat P ;
  cat PHRASE ;
  cat POSSESSIVE ;
  cat PP ;
  cat PP_gaps ;
  cat PREDET ;
  cat REL ;
  cat S ;
  cat S_imp ;
  cat S_moved ;
  cat S_norm ;
  cat S_norm_inv ;
  cat S_normal_gap ;
  cat S_q ;
  cat S_r ;
  cat S_rel ;
  cat UTTERANCE ;
  cat VP ;
  cat VP_inf ;
  cat VP_ing ;
  cat VP_pass ;
  cat VP_to ;
  cat V_be ;
  cat V_ditr ;
  cat V_ditrpp ;
  cat V_ditrq ;
  cat V_do ;
  cat V_intr ;
  cat V_mod ;
  cat V_part ;
  cat V_s ;
  cat V_tr ;
  cat V_trq ;
  cat V_vp ;


{-
-- lexicon; picked from examples and explanations

possessive_my : POSSESSIVE ;

predet_all : PREDET ;
predet_only : PREDET ;
predet_just : PREDET ;

nbar_flight : NBAR ;
nbar_aircraft : NBAR ;

name_Delta : NP_name ;
name_Dallas : NP_name ;
name_Boston : NP_name ;

conj_and : CONJ ;

det_any : DET_bare ;

v_is : V_be ;
v_leave : V_intr ;
v_have : V_tr ;

nbar_of_type : NBAR_of ;

adj_cheap : ADJ ;


--- ad hoc coercions to make cf grammar work

det_bare : DET_bare -> DET ;
-}

}