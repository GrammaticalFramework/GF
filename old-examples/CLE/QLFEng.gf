--# -path=resource/abstract:resource/english:prelude

concrete QLFEng of QLF = open ResourceEng, VerbphraseEng in {

-- by CF2GF

lin
-- SLT book, chapter 9

-- p. 164

utterance_phrase p = p ;
----utterance_conj_phrase : CONJ -> Phrase -> UTTERANCE ;
----utterance_whatabout : PHRASE -> UTTERANCE ; 
----utterance_howabout : PHRASE -> UTTERANCE ;

----phrase_pp : PP -> PHRASE ;
----phrase_advp : ADVP -> PHRASE ;
phrase_np = PhrNP ;

utterance_s_imp = ImperMany ; --- ImperOne
utterance_s_moved = QuestPhrase ;
utterance_s_q = QuestPhrase ;
----utterance_s_norm_inv = QuestPhrase ;
utterance_s_norm = IndicPhrase ;

-- p. 162

s_norm_NP_VP np vp = UseCl  (PosTP TPresent ASimul) (PredVP np vp) ;
s_q_NP_VP ip vp    = UseQCl (PosTP TPresent ASimul) (IntVP ip vp) ;
s_r_NP_VP rp vp    = UseRCl (PosTP TPresent ASimul) (RelVP rp vp) ;

----s_imp_NP_VP npimp = PosImpVP ;

---- s_advp_s : ADVP_sent -> S -> S ;
---- s_s_advp : S -> ADVP_sent -> S ; -- AdvCl  : Cl  -> Adv -> Cl ;
s_conj_s a conj b = ConjS and_Conj (TwoS a b) ;

-- p. 163: 6 wh-move-rules

-- p. 160

---- vp_vp_pp : VP -> PP -> VP ;
---- vp_vp_advp : VP -> ADVP -> VP ;
---- vp_advp_vp : ADVP -> VP -> VP ;
---- advp_vp_ing : VP_ing -> ADVP ;
---- advp_vp_to : VP_to -> ADVP ;
---- vp_conj_vp : VP -> CONJ -> VP -> VP ;
---- vp_not_vp : VP -> VP ;

--np_gaps : NP_gaps ;
--pp_gaps : PP_gaps ;
--adjp_gaps : ADJP_gaps ;
--advp_gaps : ADVP_gaps ;

-- p. 157

---- vp_be_comp : V_be -> COMP -> VP ; -- 1 rule VP ::= V COMPS
vp_tr = ComplV2 ;
vp_ditr = ComplV3 ;
vp_intr = UseV ;
vp_mod vv vp = ComplVV vv (UseVCl PNeg ASimul (UseVP vp)) ;
-- vp_do : V_do -> VP -> VP ;
---- vp_be_pass : V_be -> VP_pass -> VP ; -- UsePassV : V   -> VP ;
---- vp_be_ing : V_be -> VP_ing -> VP ;
-- vp_part : V_part -> VP ; -- particle verb
vp_s = ComplVS ;
---- vp_vp_to : V_vp -> VP_to -> VP ; -- "how much does it cost to fly..."
vp_ditrq = ComplV2Q ;
-- vp_ditrpp : V_ditrpp -> NP -> PP -> VP ;
vp_trq = ComplVQ ;

-- p. 159

---- comp_np : NP -> COMP ;
---- comp_adjp : ADJP -> COMP ;
---- comp_pp : PP -> COMP ;

-- p. 156

---- pp_pp : PP -> PP -> PP ; -- big PP --- unnecessary ambiguity?

pp_p_np = PrepNP ;
---- pp_np_temporal : NP_temporal -> PP ;
---- pp_name_p_name : NP_name -> P -> NP_name -> PP ; -- Baltimore to Philadelpia
---- pp_conj_pp : PP -> CONJ -> PP -> PP ;

-- p. 157; the numeral rules are not shown
{-
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
-}
-- p. 154 "recursive NPs"

np_np_pp np pp = AdvNP np (AdvPP pp) ;
---- np_np_rel : NP -> REL -> NP ;

---- np_np_vp_ing : NP -> VP_ing -> NP ; -- these 2 are 1 with \/
---- np_np_vp_pass : NP -> VP_pass -> NP ; --- AdjPart : V -> A

---- np_np_adjp : NP -> ADJP_post -> NP ; --- restr. acc to text

-- rel_s_rel : S_r -> REL ;
rel_s_norm s = UseRCl (PosTP TPresent ASimul) (RelSlash IdRP s) ;
--- they cannot be showing their real code here

adjp_nocomp = UseA ;
adjp_np = ComplA2 ;

np_conj_np x conj y = ConjNP conj (TwoNP x y) ;
-- np_np_np : NP -> NP -> NP ; -- Boston Atlanta and Denver

---- s_vp_inf : VP_inf -> S_norm ; -- "to get from X to Y (is...)"
---- np_s_q : S_q -> NP ; -- "what city they stop in (is...)"
---- np_s_norm : S_norm -> NP ;
---- np_compl_s : COMPLEMENTISER -> S_norm -> NP ; --- they don't tell what CO... is

---- np_np_code : NP -> CODE -> NP ; --- unnec. source of ambiguity


-- p. 150

np_det_nbar = DetNP ;
np_nbar = MassNP ; --- also pl. "travel arrangements"

nbar_adjp_nbar = ModAP ;
---- nbar_nbar_nbar : NBAR -> NBAR -> NBAR ; --- unnec. ambiguity
---- nbar_name_nbar : NP_name -> NBAR -> NBAR ; -- "Delta flights"
---- nbar_conj_nbar : NBAR -> CONJ -> NBAR -> NBAR ;

adjp_most_adj = SuperlADeg ;
---- adjp_least_adj : ADJ -> ADJP ;
---- ordinal_adjp_superl : ADJP_superlative -> ORDINAL ;

---- det_the_ordinal : ORDINAL -> DET ;
---- det_ordinal : ORDINAL -> DET ; -- common in spoken language
---- det_predet_det : PREDET -> DET -> DET ;
---- det_numer : NUMBER -> DET ; --- NUMBER in book
---- det_less_than : NUMBER -> DET ; --- NUMBER
---- det_more_than : NUMBER -> DET ; --- NUMBER
---- det_possessive : POSSESSIVE -> DET ;


-- p. 152 time and date NPs not given

---- np_code : CODE -> NP ;
---- np_nbar_code : NBAR -> CODE -> NP ;

-- : NUMBER -> already -> covered -> above -> CODE
--  letter codes added from corpus

---- np_det : DET_bare -> NP ; -- any, which, one, both, the same, the latest,...

---- nbar_comp : NBAR_of -> NBAR -> NBAR ; -- only ex (kind | type) of plane

lincat
  ADJ = ADeg ;
  ADJP = AP ;
--  ADJP_gaps ;
--  ADJP_post ;
--  ADJP_superlative ;
  ADJ_nocomp = A ;
  ADJ_pp = A2 ;
  ADVP = Adv ;
--  ADVP_gaps ;
  ADVP_sent = AdC ;
----  CODE = String ;
----  COMP ; NP ADJP PP
--  COMPLEMENTISER ;
  CONJ = Conj ;
  DET = Det ;
----  DET_bare ;
--  DIGIT ;
  NBAR = CN ;
  NBAR_of = N2 ;
  NP = NP ;
--  NP_gaps ;
--  NP_imp ;
  NP_name = PN ;
  NP_norm = NP ;
  NP_q = IP ;
  NP_r = RP ;
  NP_temporal = NP ;
  NUMBER = Numeral ;
  ORDINAL = A ;
  P = Prep ;
  PHRASE = Phr ;
--  POSSESSIVE ;
  PP = PP ;
--  PP_gaps ;
----  PREDET ;
  REL = RS ;
  S = S ;
  S_imp = Imp ;
  S_moved = QS ;
  S_norm = S ;
--  S_norm_inv ;
  S_normal_gap = Slash ;
  S_q = QS ;
  S_r = RS ;
  UTTERANCE = Phr ;
  VP = VP ;
  VP_inf = VPI ;
--  VP_ing ;
--  VP_pass ;
--  VP_to ;
--  V_be ;
  V_ditr = V3 ;
  V_ditrpp = V3 ;
  V_ditrq = V2Q ;
--  V_do ;
  V_intr = V ;
  V_mod = VV ;
  V_part = V ;
  V_s = VS ;
  V_tr = V2 ;
  V_trq = VQ ;
  V_vp = VV ;


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