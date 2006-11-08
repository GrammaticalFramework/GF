--# -path=.:prelude

abstract GodisSystem = PredefAbs ** {

cat

-- Participant;

Move; 
[Move]{1};
S;

ShortAns;

Proposition;

-- NOTE: Question means only WhQ
-- this division is for Multimodality to work
Question;
YNQ; AltQ;
[Proposition]{2};

-- special kind of proposition best linearized as a VP, 
-- only used in Y/N and Alt questions starting with "do you want to ..."
-- this is for VP aggregation to work
VPProposition; -- issue(X^p(X)) and action(a)
[VPProposition]{2};

Action;
Reason;


fun

-- usr, sys : Participant;

----------------------------------------------------------------------
-- forming Questions

action_Q,
issue_Q     : Question;

ynq         : Proposition -> YNQ;
altq        : [Proposition] -> AltQ;
-- BaseProposition : Proposition -> Proposition -> [Proposition];
-- ConsProposition : Proposition -> [Proposition] -> [Proposition];

----------------------------------------------------------------------
-- forming Propositions

not         : Proposition -> Proposition;
-- done        : Action -> Proposition;
fail        : Question -> Reason -> Proposition;
-- und      : Participant -> Proposition -> Proposition;

----------------------------------------------------------------------
-- forming VPPropositions, and associated questions

action      : Action -> VPProposition;
issue       : Question -> VPProposition;

vp_ynq      : VPProposition -> YNQ;
vp_altq     : [VPProposition] -> AltQ;
-- BaseVPProposition : VPProposition -> VPProposition -> [VPProposition];
-- ConsVPProposition : VPProposition -> [VPProposition] -> [VPProposition];

----------------------------------------------------------------------
-- short answers

notS        : ShortAns -> ShortAns;


----------------------------------------------------------------------
-- dialogue moves

answer_yes, 
answer_no   : Move;

greet, 
quit        : Move;
ask         : Question -> Move;
askYNQ      : YNQ -> Move;
askAltQ     : AltQ -> Move;
answer      : Proposition -> Move;
answerVP    : VPProposition -> Move;
shortAns    : ShortAns -> Move;

request,
confirm     : Action -> Move;
reportFailure : Action -> Reason -> Move;

answerFailure : Question -> Reason -> Move;

----------------------------------------------------------------------
-- ICM

icm_acc_pos,
icm_con_neg,
icm_per_neg,
icm_per_int,
icm_sem_neg,
icm_sem_int,
icm_und_neg,
icm_reraise,
icm_loadplan,
icm_accommodate       : Move;

icm_per_pos           : String -> Move;
icm_und_int_prop,
icm_und_pos_prop,
icm_acc_neg_prop      : Proposition -> Move;
icm_acc_neg_que       : Question -> Move;
icm_sem_pos_move      : Move -> Move;
icm_sem_pos_shortAns  : ShortAns -> Move;
icm_und_pos_vp,
icm_und_int_vp  : {- Participant -> -} VPProposition -> Move;
icm_reraise_act       : Action -> Move;

icm_reraise_whq,
icm_accommodate_whq,
icm_reaccommodate_whq : Question -> Move;
icm_reraise_ynq,
icm_accommodate_ynq,
icm_reaccommodate_ynq : YNQ -> Move;
icm_und_int_altq,
icm_reraise_altq,
icm_accommodate_altq,
icm_reaccommodate_altq: AltQ -> Move;

-- BaseMove              : Move -> [Move];
-- ConsMove              : Move -> [Move] -> [Move];

godis_utterance       : [Move] -> S;

}
