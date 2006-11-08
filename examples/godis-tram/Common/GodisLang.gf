--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common

interface GodisLang = open Grammar, Prelude, PredefAbs in {

----------------------------------------------------------------------
-- different clause forms

param ClForm = HasDone | IsDoing;

oper

ClauseForm : Type;
clauseForm : ClauseForm -> ClauseForm;

hasDone : ClauseForm;
isDoing : ClauseForm;

anter : ClauseForm -> Ant;

----------------------------------------------------------------------
-- punctuation on system utterances

param Punctn = FullStop | QuestMark;

oper

Punctuation : Type;
fullStop,
questMark : Punctuation;

consText : Punctuation -> Utt -> Text -> Text;

----------------------------------------------------------------------
-- focus

emphasize : NP -> NP;
embed_NP  : Str -> Str -> NP -> NP;

----------------------------------------------------------------------
-- user utterances

UserQuestion,
UserAction,
UserAnswer,
UserShortAns,
UserProposition : Type;

askQS : QCl -> UserQuestion;
ansCl : Cl  -> UserAnswer;
ansNP : NP  -> UserShortAns;

reqVP : VP  -> UserAction;
req1  : Str -> UserAction;
req1x : Str -> Str -> UserAction;
req2x : Str -> Str -> Str -> UserAction;

not_user_prop  : UserProposition -> SS;
not_user_short : UserShortAns -> SS;

userGreet,
userQuit,
userYes,
userNo,
userOkay     : SS;

userCoordinate : SS -> SS -> SS;

thank_you_Str,
i_want_to_Str,
please_Str,
this_that_Str  : Str;

use_QCl : QCl -> SS;
use_Cl  : Cl -> SS;
use_NP  : NP -> SS;
use_VP  : VP -> SS;
use_Adv : Adv -> SS;

----------------------------------------------------------------------
-- system utterances

hello,
goodbye,
yes,
no,

is_that_correct_Post,
returning_to_Pre,
returning_to_act_Pre,
returning_to_issue_Pre,
i_dont_understand,
cant_answer_que_Pre,
not_valid_Post,

icm_acc_pos,
icm_con_neg,
icm_reraise,
icm_loadplan,
icm_accommodate : Utt;

icm_per_pos     : String -> Utt;

cncUtt          : Utt -> Utt -> Utt;

----------------------------------------------------------------------
-- interrogative phrases

which_N_sg : N -> IP;
which_N_pl : N -> IP;

----------------------------------------------------------------------
-- noun phrases

sing_NP,
plur_NP    : Str -> NP;

the_CN_sg  : CN -> NP;

the_N_sg,
the_N_pl,
indef_N_sg,
indef_N_pl,
this_N_sg,
these_N_pl,
no_N_sg,
no_N_pl,
all_N_pl   : N -> NP;

the_A_super_N_sg,
indef_A_posit_N_sg,
no_A_posit_N_sg     : A -> N -> NP;

NP_Adv     : NP -> Adv -> NP;
NP_Prep_NP : Prep -> NP -> NP -> NP;
NP_in_NP,
NP_of_NP,
NPgen_NP   : NP -> NP -> NP;
NP_Cl      : NP -> Cl;

prefix_N   : N -> N -> N;

----------------------------------------------------------------------
-- questions, q-clauses

useQCl : (QCl ** ClauseForm) -> QS;

which_N_are_AP,
which_N_is_AP             : N -> AP -> QCl;
what_is_NP                : NP -> QCl;
who_VP                    : VP -> QCl;

which_N_do_you_want_to_V2 : N -> V2 -> QCl;
which_N_has_NP_V2         : N -> NP -> V2 -> QCl;
which_N_are_AP_Adv        : N -> AP -> Adv -> QCl;

is_the_N_AP     : N -> AP -> QCl;
is_the_N_AP_Adv : N -> AP -> Adv -> QCl;

which_N_are_Adv     : N -> Adv -> QCl;
which_N_are_Adv_Adv : N -> Adv -> Adv -> QCl;

is_the_N_Adv     : N -> Adv -> QCl;
is_the_N_Adv_Adv : N -> Adv -> Adv -> QCl;

----------------------------------------------------------------------
-- adverbials

Prep_NP : Prep -> NP -> Adv;
in_NP   : NP -> Adv;

----------------------------------------------------------------------
-- clauses, sentences, answers, propositions

useCl : (Cl ** ClauseForm) -> S;

--generic_VP,
you_want_to_VP,
you_are_VPing    : VP -> Cl;
you_VV_to_VP     : VV -> VP -> Cl;
it_is_NP_who_VP  : NP -> (VP ** ClauseForm) -> Cl;
NP_is_AP         : NP -> AP -> Cl;
NP_is_AP_Adv     : NP -> AP -> Adv -> Cl;
NP_is_Adv        : NP -> Adv -> Cl;

----------------------------------------------------------------------
-- relative clauses

useRCl : (RCl ** ClauseForm) -> RS;

----------------------------------------------------------------------
-- verb phrases, actions

use_V     : V -> VP;
V2_NP     : V2 -> NP -> VP;
V2_the_N  : V2 -> N -> VP;
V2_a_N    : V2 -> N -> VP;
VPing     : (VP ** ClauseForm) -> VP;
vp2Utt    : VP -> Utt;

----------------------------------------------------------------------
-- general syntactical operations

disjunct_QCl : QCl -> QCl -> QCl;
negate_Cl    : Cl -> Cl;

----------------------------------------------------------------------
-- verbs

see_V : V;

do_V2,
have_V2,
understand_V2 : V2;

know_VQ,
wonder_VQ : VQ;

say_VS : VS;

fail_VV,
like_VV  : VV;

----------------------------------------------------------------------
-- nouns, proper nouns, common nouns and noun phrases

information_N : N;

you_NP : NP;

----------------------------------------------------------------------
-- closed word categories

of_på_Prep,
for_Prep   : Prep;

not_Predet : Predet;
no_Quant   : Quant;
all_Quant  : QuantPl;


----------------------------------------------------------------------
-- language independent implementations
----------------------------------------------------------------------

oper

----------------------------------------------------------------------
-- different clause forms

ClauseForm = {clform : ClForm};
clauseForm c = c;

hasDone = {clform = HasDone};
isDoing = {clform = IsDoing};

anter c = case c.clform of {HasDone => AAnter; IsDoing => ASimul};

----------------------------------------------------------------------
-- punctuation on system utterances

Punctuation = {punctuation : Punctn};
fullStop    = {punctuation = FullStop};
questMark   = {punctuation = QuestMark};

consText punct utt  = let txt = PhrUtt NoPConj utt NoVoc in
    case punct.punctuation of
    { FullStop => TFullStop txt; QuestMark => TQuestMark txt };

----------------------------------------------------------------------
-- focus

emphasize = embed_NP "<emphasize>" "</emphasize>";

----------------------------------------------------------------------
-- user utterances

UserAction,
UserQuestion,
UserAnswer,
UserShortAns,
UserProposition = SS;

askQS q = UttQS (UseQCl TPres ASimul PPos q);
ansCl c = UttS (UseCl TPres ASimul PPos c);
ansNP a = UttNP a;

reqVP vp = 
    PhrUtt NoPConj
           (variants{ UttImpSg PPos (ImpVP vp);
	              UttS (UseCl TPres ASimul PPos
				(PredVP (UsePron i_Pron) (ComplVV want_VV vp)));
	              UttS (UseCl TCond ASimul PPos
				(PredVP (UsePron i_Pron) (ComplVV like_VV vp))) })
           (variants{ NoVoc; please_Voc });
req1  act = req1x act [];
req1x act = req2x act act;
req2x imp inf extra = variants {
    ss ( variants { imp; i_want_to_Str ++ inf } ++ extra ++ optStr please_Str);
    ss ( variants { please_Str; userOkay.s } ++ imp ++ extra )};    

use_QCl = askQS;
use_Cl  = ansCl;
use_NP  = ansNP;
use_VP  = reqVP;
use_Adv = UttAdv;

----------------------------------------------------------------------
-- system utterances

cncUtt x y = mkUtt (x.s ++ y.s);

----------------------------------------------------------------------
-- interrogative phrases

which_N_sg n = IDetCN whichSg_IDet NoNum NoOrd (UseN n);
which_N_pl n = IDetCN whichPl_IDet NoNum NoOrd (UseN n);

----------------------------------------------------------------------
-- noun phrases

the_CN_sg cn = DetCN (DetSg (SgQuant DefArt) NoOrd) cn;

the_N_sg   n = the_CN_sg (UseN n);
the_N_pl   n = DetCN (DetPl (PlQuant DefArt) NoNum NoOrd) (UseN n);
indef_N_sg n = DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN n);
indef_N_pl n = DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n);
this_N_sg  n = DetCN (DetSg (SgQuant this_Quant) NoOrd) (UseN n);
these_N_pl n = DetCN (DetPl (PlQuant this_Quant) NoNum NoOrd) (UseN n);
no_N_sg    n = DetCN (DetSg (SgQuant no_Quant) NoOrd) (UseN n);
no_N_pl    n = DetCN (DetPl (PlQuant no_Quant) NoNum NoOrd) (UseN n);
all_N_pl   n = DetCN (DetPl all_Quant NoNum NoOrd) (UseN n);

the_A_super_N_sg   a n = DetCN (DetSg (SgQuant DefArt) (OrdSuperl a)) (UseN n);
indef_A_posit_N_sg a n = DetCN (DetSg (SgQuant IndefArt) NoOrd) (AdjCN (PositA a) (UseN n));
no_A_posit_N_sg    a n = DetCN (DetSg (SgQuant no_Quant) NoOrd) (AdjCN (PositA a) (UseN n));

NP_Adv = AdvNP;
NP_Prep_NP prep np np' = AdvNP np (PrepNP prep np');

NP_in_NP = NP_Prep_NP in_Prep;
NP_of_NP = NP_Prep_NP of_på_Prep;

----------------------------------------------------------------------
-- questions

useQCl q = UseQCl TPres (anter q) PPos q;

which_N_are_AP n ap = QuestVP (which_N_pl n) (UseComp (CompAP ap));
which_N_is_AP  n ap = QuestVP (which_N_sg n) (UseComp (CompAP ap));
what_is_NP       np = QuestVP whatSg_IP (UseComp (CompNP np));
who_VP           vp = QuestVP whoSg_IP vp;

which_N_do_you_want_to_V2 n v2 = QuestSlash (which_N_sg n) (SlashVVV2 you_NP want_VV v2);
which_N_has_NP_V2      n np v2 = QuestSlash (which_N_pl n) (SlashV2 np v2);
which_N_are_AP_Adv     n ap adv= QuestVP (which_N_pl n) (AdvVP (UseComp (CompAP ap)) adv);

is_the_N_AP     n ap     = QuestCl (NP_is_AP (the_N_sg n) ap);
is_the_N_AP_Adv n ap adv = QuestCl (NP_is_AP_Adv (the_N_sg n) ap adv);

which_N_are_Adv     n a    = QuestVP (which_N_pl n) (UseComp (CompAdv a));
which_N_are_Adv_Adv n a aa = QuestVP (which_N_pl n) (AdvVP (UseComp (CompAdv a)) aa);

is_the_N_Adv     n a    = QuestCl (PredVP (the_N_sg n) (UseComp (CompAdv a)));
is_the_N_Adv_Adv n a aa = QuestCl (PredVP (the_N_sg n) (AdvVP (UseComp (CompAdv a)) aa));

----------------------------------------------------------------------
-- adverbials

Prep_NP = PrepNP;
in_NP   = PrepNP in_Prep;

----------------------------------------------------------------------
-- clauses, sentences, answers, propositions

useCl c = UseCl TPres (anter c) PPos c;

--generic_VP = GenericCl;
you_want_to_VP     vp = PredVP you_NP (ComplVV want_VV vp);
you_are_VPing      vp = PredVP you_NP (VPing (isDoing ** vp));
you_VV_to_VP    vv vp = PredVP you_NP (ComplVV vv vp);
it_is_NP_who_VP np vp = CleftNP np (UseRCl TPres (anter vp) PPos (RelVP IdRP vp));
NP_is_AP        np ap = PredVP np (UseComp (CompAP ap));
NP_is_AP_Adv np ap adv= PredVP np (AdvVP (UseComp (CompAP ap)) adv);
NP_is_Adv       np adv= PredVP np (UseComp (CompAdv adv));

----------------------------------------------------------------------
-- relative clauses

useRCl r = UseRCl TPres (anter r) PPos r;

----------------------------------------------------------------------
-- verb phrases, actions

use_V  = UseV;
V2_NP  = ComplV2;
V2_the_N v2 n = ComplV2 v2 (the_N_sg n);
V2_a_N   v2 n = ComplV2 v2 (indef_N_sg n);

}
