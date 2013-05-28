concrete StructuralChi of Structural = CatChi **
  open ParadigmsChi, ResChi, Prelude in {

  flags coding = utf8 ;

lin
    every_Det = mkDet "每" Sg ;
        
    this_Quant = mkQuant "这" ;
    that_Quant = mkQuant "那" ;

    i_Pron = pronNP "我" ;
    youSg_Pron = pronNP "你" ;
    he_Pron = pronNP "他" ;
    she_Pron = pronNP "她" ;
    we_Pron = pronNP "我们" ;
    youPl_Pron = pronNP "你们" ;
    they_Pron = pronNP "他们" ;

    very_AdA = ssword "非常" ;

    by8means_Prep = mkPrep "旁边" [] ;
    in_Prep = mkPrep "里" [];
    possess_Prep = mkPrep "的" [];
    with_Prep = mkPrep "一起" "和";
----    with_Prep = mkPrep [] "和"; -- an alternative for some uses
 
and_Conj = {s = table {
                    CPhr CNPhrase => mkConjForm "和" ;
                    CPhr CAPhrase => mkConjForm "而" ;
                    CPhr CVPhrase => mkConjForm "又" ;
                    CSent => mkConjForm "并且"             --modified by chenpneg 11.19
                          }
                } ;
 or_Conj = {s = table {
                    CPhr _ => mkConjForm "或" ;
                    CSent => mkConjForm "还是"
                          }
                } ;

    although_Subj = mkSubj "虽然" "但";
    because_Subj = mkSubj "因为" "所以" ;
    when_Subj = mkSubj [] "的时候" ;

here_Adv = mkAdv "这里" ;
there_Adv = mkAdv "那里" ;
whoSg_IP, whoPl_IP = mkIPL "谁" ;
whatSg_IP, whatPl_IP = mkIPL " 什么" ;
where_IAdv = mkIAdvL "哪里" ;
when_IAdv = mkIAdvL "什么时候" ;
how_IAdv = mkIAdvL "如何" ;
all_Predet = ssword "所有" ;
many_Det = mkDet (word "很多") DTPoss ;
someSg_Det = mkDet (word "一些") Sg ;
somePl_Det = mkDet (word "一些") Sg ;
few_Det = mkDet "少" Pl ;
other_A = mkA "其他" ;

oper
  mkIPL, mkIAdvL, mkAdA, mkIDetL, mkPConjL, mkIQuant = ssword ;

-- hsk

lin


above_Prep = mkPrep "上边" ;
after_Prep = mkPrep "以后" ;
under_Prep = mkPrep "下" ;
why_IAdv = mkIAdvL "为什么" ;
too_AdA = mkAdA "太" ;

before_Prep = mkPrep "从前" ;
between_Prep = mkPrep "之间" ;
but_PConj = mkPConjL "但是" ;


    can_VV = mkVerb "能" [] [] [] [] "不" ;
    must_VV = mkVerb "必须" [] [] [] [] "不" ; ---- False "不能"
    want_VV = mkVerb "想" [] [] [] [] "不" ;

can8know_VV = mkV "会" [] [] [] [] "不" ; ----


except_Prep = mkPrep "除了" "以外" ;
for_Prep = mkPrep "为了" ;
from_Prep = mkPrep "从" ;
in8front_Prep = mkPrep "前边" zai_s ;
it_Pron = pronNP "它" ;
much_Det = mkDet "多" Sg ;
no_Quant = mkQuant "不" ;
not_Predet = ssword "不" ;
otherwise_PConj = mkPConjL "还是" ;
to_Prep = mkPrep "往" ;

have_V2 = mkV2 "有" ;

yes_Utt = ss "对" ;
no_Utt = ss neg_s ;


lin
  always_AdV = ssword "一直" ;
  part_Prep = mkPrep possessive_s ;
  language_title_Utt = ssword "中文" ;
  please_Voc = ss "请" ;
  quite_Adv = mkAdA "得很" ;

-- just missing

lin
almost_AdA = ssword "几乎" ;
almost_AdN = ssword "几乎" ;
as_CAdv = {s = word "和" ; p = word "一样" } ; -- modified by chenpeng 11.24
at_least_AdN = ssword "最少" ; -- at least five
at_most_AdN = ssword "最多" ;
behind_Prep = mkPrep "后面" "在";
  
both7and_DConj = {s = table { -- modified by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm2 "包括" "和" ;
                    CPhr CAPhrase => mkConjForm2 "即" "又" ;
                    CPhr CVPhrase => mkConjForm2 "不但" "而且" ;
                    CSent => mkConjForm2 "不但" "而且"
                    }
                } ;

by8agent_Prep = mkPrep "被" ; -- by for agent in passive
                                  -- [mark] 被
during_Prep = mkPrep "期间" "在" ; -- [mark] often equivalent to nothing
                                   -- translation for "he swam during this summer. " and "he swam this summer." are often the same

either7or_DConj = {s = table { -- modified by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm2 "或者" "或者" ;
                    CPhr CAPhrase => mkConjForm2 "要么" "要么" ;
                    CPhr CVPhrase => mkConjForm2 "要么" "要么" ;
                    CSent => mkConjForm2 "要么" "要么"
                    }
                } ;

everybody_NP = ssword "每个人" ; -- [mark] "每个人": 每(every)+个(classifier)+人(person)
everything_NP = ssword "每件事" ; -- [mark] "每件事": 每(every)+件(classifier)+事(thing)
everywhere_Adv = mkAdv "到处" ;
here7from_Adv = mkAdv "从这里" ; -- from here
here7to_Adv = mkAdv "到这里" ; -- to here
-- [mark] "从这里" 从(from) 这里(here)
-- "到这里" 到( to ) 这里(here)
how8many_IDet = ssword "多少" ;
how8much_IAdv = ssword "多少" ;
if_Subj = mkSubj "如果" [] ; --"就" ; -- [mark] "就" often comes between NP and VP
less_CAdv = {s = than_s ; p = word "没更"} ; -- modified by chenpeng 11.24
more_CAdv = {s = than_s ; p = word "更"} ; -- modified by chenpeng 11.24
most_Predet = ssword "大多数" ;
if_then_Conj = {s = table { -- added by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm [] ;
                    CPhr CAPhrase => mkConjForm [] ;
                    CPhr CVPhrase => mkConjForm [] ;
                    CSent => mkConjForm2 "如果" "那么"
                    }
                } ;
nobody_NP = ssword "没人" ;
nothing_NP = ssword "没有什么" ;
on_Prep = mkPrep "上" "在" ;
only_Predet = ssword "只有" ; -- only John
so_AdA = ssword "如此" ;
somebody_NP = ssword "某人" ;
something_NP = ssword "某事" ; -- [mark] in sent, it depends on the context
somewhere_Adv = mkAdv "某处" ;
that_Subj = mkSubj [] chcomma ; -- that + S [mark] comma
there7from_Adv = mkAdv "从那里" ; -- from there
there7to_Adv = mkAdv "到那里" ;
therefore_PConj = ssword "因此" ;
through_Prep = mkPrep "通过" ;
which_IQuant = mkIQuant "哪" ;
--which_IQuant = ssword [] ; -- [mark] in sent, it depends on the context
without_Prep = mkPrep "没有" [];
youPol_Pron = ssword "您" ; -- polite you

}
