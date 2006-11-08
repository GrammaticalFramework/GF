--# -path=.:prelude

concrete GodisSystemSem of GodisSystem = PredefCnc ** open Prolog in {

lincat

Move,
[Move],
S,
ShortAns, 
Proposition, 
Question, 
YNQ, AltQ, 
[Proposition], 
VPProposition,
[VPProposition],
Action, 
Reason   = PStr;


lin

-- usr = ss "usr";
-- sys = ss "sys";

----------------------------------------------------------------------
-- questions

action_Q = pWhQ "action";
issue_Q  = pWhQ "issue";

ynq     q = q;
altq   qs = pp1 "set" (pBrackets qs);
BaseProposition = pSeq;
ConsProposition = pSeq;

----------------------------------------------------------------------
-- propositions

not    = pp1 "not";
-- done   = pp1 "done";
fail   = pp2 "fail";
-- und    = pp2 "und";

----------------------------------------------------------------------
-- vp-propositions

action = pp1 "action";
issue  = pp1 "issue";

vp_ynq  p  = p;
vp_altq qs = pp1 "set" (pBrackets qs);
BaseVPProposition = pSeq;
ConsVPProposition = pSeq;

----------------------------------------------------------------------
-- short answers

notS       = pp1 "not";

----------------------------------------------------------------------
-- dialogue moves

answer_yes = pp1 "answer" (pp0 "yes");
answer_no  = pp1 "answer" (pp0 "no");

greet     = pp0 "greet";
quit      = pp0 "quit";
ask       = pp1 "ask";
askYNQ    = pp1 "ask";
askAltQ   = pp1 "ask";
answer    = pp1 "answer";
answerVP  = pp1 "answer";
shortAns  = pp1 "answer";

request   = pp1 "request";
confirm a = variants{ pp1 "confirm" a; 
		      pp2 "report" a (pp0 "done") };
reportFailure a r = pp2 "report" a (pp1 "failed" r);

answerFailure q r = pp1 "answer" (pp2 "fail" q r);

----------------------------------------------------------------------
-- ICM

icm_acc_pos       = icmFeedback0 "acc" "pos";
icm_con_neg       = icmFeedback0 "con" "neg";
icm_per_neg       = icmFeedback0 "per" "neg";
icm_per_int       = icmFeedback0 "per" "int";
icm_sem_neg       = icmFeedback0 "sem" "neg";
icm_sem_int       = icmFeedback0 "sem" "int";
icm_und_neg       = icmFeedback0 "und" "neg";
icm_reraise       = icmSingle0 "reraise";
icm_loadplan      = icmSingle0 "loadplan";
icm_accommodate   = icmSingle0 "accomodate";

icm_per_pos           = icmFeedback1 "per" "pos";
icm_und_int_prop   p  = icmFeedback1 "und" "int" (pOper "*" (pp0 "usr") p);
icm_und_pos_prop   p  = icmFeedback1 "und" "pos" (pOper "*" (pp0 "usr") p);
icm_acc_neg_prop      = icmFeedback1 "acc" "neg";
icm_acc_neg_que     q = icmFeedback1 "acc" "neg" (pp1 "issue" q);
icm_sem_pos_move      = icmFeedback1 "sem" "pos";
icm_sem_pos_shortAns  = icmFeedback1 "sem" "pos";
icm_und_pos_vp      p = icmFeedback1 "und" "pos" (pOper "*" (pp0 "usr") p);
icm_und_int_vp      p = icmFeedback1 "und" "int" (pOper "*" (pp0 "usr") p);
icm_reraise_act       = icmSingle1 "reraise";

icm_und_int_altq     q = icmFeedback1 "und" "int"(pOper "*" (pp0 "usr") q);
icm_reraise_whq        = icmSingle1 "reraise";
icm_reraise_ynq        = icmSingle1 "reraise";
icm_reraise_altq       = icmSingle1 "reraise";
icm_accommodate_whq    = icmSingle1 "accomodate";
icm_accommodate_ynq    = icmSingle1 "accomodate";
icm_accommodate_altq   = icmSingle1 "accomodate";
icm_reaccommodate_whq  = icmSingle1 "reaccomodate";
icm_reaccommodate_ynq  = icmSingle1 "reaccomodate";
icm_reaccommodate_altq = icmSingle1 "reaccomodate";

BaseMove m = m;
ConsMove m = pSeq m;

godis_utterance = pBrackets;


oper

icmSingle0   : Str -> PStr  = \icm -> pStr ("icm" ++ ":" ++ icm);
icmSingle1   : Str -> PPStr = \icm -> pOper ":" (icmSingle0 icm);

icmFeedback0 : Str -> Str -> PStr  = \lvl,pol -> icmSingle0 (lvl ++ "*" ++ pol);
icmFeedback1 : Str -> Str -> PPStr = \lvl,pol -> icmSingle1 (lvl ++ "*" ++ pol);


}
