--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/scandinavian:resource-1.0/swedish

instance GodisLangSwe of GodisLang = 
    open Prelude, PredefCnc, GrammarSwe, ParadigmsSwe, ConstructX,
         MorphoSwe, CommonScand, (Lex=LexiconSwe), (Irreg=IrregSwe) in {

oper

----------------------------------------------------------------------
-- focus

embed_NP a b x = {s = \\c => a ++ (x.s ! c) ++ b; a = x.a; lock_NP = <>};


----------------------------------------------------------------------
-- user utterances

userGreet = ss ["hej"];
userQuit  = ss ["hejdå"];
userNo    = ss ["nej"];
userYes   = ss ["ja"];
userOkay  = variants { ss ["okej"]; ss ["ok"]; ss ["okay"] };

userCoordinate x y = ss (x.s ++ "och" ++ optStr "sedan" ++ y.s);

thank_you_Str = variants{ "schysst"; "tack"; userOkay.s };
i_want_to_Str = variants{ "jag" ++ variants{ "vill"; ["skulle vilja"] };
                          ["kan du"] };
please_Str    = "tack";
this_that_Str = variants{ variants{"den";"det"} ++ optStr "här";
			  "denna"; "detta" };

not_user_prop  p = ss ( "inte" ++ p.s );
not_user_short a = ss ( "inte" ++ a.s );

----------------------------------------------------------------------
-- system utterances

hello           = mkUtt ["MP3 spelaren är redo"];
goodbye         = mkUtt ["Hejdå"];
yes             = mkUtt ["Ja"];
no              = mkUtt ["Nej"];

is_that_correct_Post   = mkUtt [", är det korrekt"];
returning_to_Pre       = mkUtt ["Återgår till"];
returning_to_act_Pre   = mkUtt ["Återgår till att"];
returning_to_issue_Pre = mkUtt ["Återgår till frågan om"];
what_did_you_say       = mkUtt ["Vad sa du"];
what_do_you_mean       = mkUtt ["Vad menar du"];
i_dont_understand      = mkUtt ["Jag förstår inte riktigt"];
cant_answer_que_Pre    = mkUtt ["Ledsen , jag kan inte svara på frågor om"];
not_valid_Post         = mkUtt ["går inte att välja"];

icm_acc_pos     = mkUtt thank_you_Str;
icm_con_neg     = mkUtt ["Hallå?"];
icm_reraise     = mkUtt ["Så ,"];
icm_loadplan    = mkUtt ["Få se"];
icm_accommodate = mkUtt ["Visst"];

icm_per_pos   x = mkUtt (["Jag tyckte du sa"] ++ x.s);


----------------------------------------------------------------------
-- noun phrases

sing_NP    s = regNP s (s+"s") SgUtr ** {lock_NP = <>};
plur_NP    s = regNP s (s+"s") Plg   ** {lock_NP = <>};

NPgen_NP = NP_of_NP;

NP_Cl np = {s = \\t,a,b,o => np.s ! nominative; lock_Cl = <>};

prefix_N n1 n2 = {s = \\n,s,c => n1.s!Sg!Indef!Gen ++ n2.s!n!s!c;
		  g = n2.g;
		  lock_N = <>};


----------------------------------------------------------------------
-- actions/verb phrases

VPing act = act;
vp2Utt vp = mkUtt (infVP vp (agrP3 utrum Sg));
-- UttVP vp;


----------------------------------------------------------------------
-- general syntactical operations

disjunct_QCl q q' = 
    {s = \\t,a,p,x => q.s!t!a!p!x ++ "eller" ++ q'.s!t!a!p!x;
     lock_QCl = <>};

negate_Cl c = 
    {s = \\t,a,p,o => c.s!t!a!(case p of {Neg=>Pos; Pos=>Neg})!o;
     lock_Cl = <>};

-- disjunct_Utt u u' = ss (u.s ++ "eller" ++ u'.s);
-- disjunct_VP vp vp' = 
--     insertObj (\\agr => "eller" ++ (ImpVP vp').s!Pos!(agr.gn)) vp;


----------------------------------------------------------------------
-- verbs

see_V           = Irreg.se_V;

do_V2           = Lex.do_V2;
have_V2         = Lex.have_V2;
understand_V2   = Lex.understand_V2;

know_VQ         = mkVQ Irreg.veta_V;
wonder_VQ       = Lex.wonder_VQ;

say_VS          = Lex.say_VS;

fail_VV         = mkVV (mkV "misslyckas" "misslyckas" "misslyckas" "misslyckades" "misslyckats" "misslyckad");
like_VV         = want_VV;

----------------------------------------------------------------------
-- nouns, proper nouns, common nouns and noun phrases

information_N   = mk2N "information" "informationer";

you_NP          = UsePron youSg_Pron;

----------------------------------------------------------------------
-- closed word categories

of_på_Prep      = mkPrep "på";
for_Prep        = mkPrep "för";

not_Predet      = {s = \\_ => "inte"; lock_Predet = <>};

no_Quant        = {s = table {Sg => \\_ => table {Utr => "ingen"; 
						  Neutr => "inget"};
			      Pl => \\_,_ => "inga"};
		   det = DIndef;
		   lock_Quant = <>};

all_Quant       = {s = \\_,_ => "alla";
		   det = DIndef;
		   lock_QuantPl = <>};



----------------------------------------------------------------------

i_dont_want_to = ["jag vill inte"];

}
