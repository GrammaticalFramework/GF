concrete StructuralCmn of Structural = CatCmn ** 
  open ParadigmsCmn, ResCmn, Prelude in {

  flags coding = utf8 ;

lin
    every_Det = mkDet "mei3" Sg ;
        
    this_Quant = mkQuant "zhe4" ;
    that_Quant = mkQuant "na3" ;

    i_Pron = pronNP "wo3" ;
    youSg_Pron = pronNP "ni3"  ;
    he_Pron = pronNP "ta1" ;
    she_Pron = pronNP "ta1" ;
    we_Pron = pronNP "wo3men" ;
    youPl_Pron = pronNP "ni3men" ;
    they_Pron = pronNP "ta1men" ;

    very_AdA = ssword "fei1chang2" ;    

    by8means_Prep = mkPrep "pang2bian1" [] ;
    in_Prep = mkPrep "li3" [];
    possess_Prep = mkPrep "de" [];
    with_Prep = mkPrep "yi1qi3" "he2"; 
 
and_Conj = {s = table {
                    CPhr CNPhrase => mkConjForm "he2" ;
                    CPhr CAPhrase => mkConjForm "er2" ;
                    CPhr CVPhrase => mkConjForm "you4" ;
                    CSent =>  mkConjForm []
                          }
                } ;
 or_Conj  = {s = table {
                    CPhr _ => mkConjForm "huo4" ;
                    CSent => mkConjForm "hai2shi4"
                          }
                } ;

    although_Subj = mkSubj "sui1ran2" "dan4";
    because_Subj = mkSubj "yin1wei2" "suo3yi3" ;
    when_Subj = mkSubj [] "deshi2hou4" ; 

here_Adv = mkAdv "zhe4li3" ;
there_Adv = mkAdv "na3li3" ;
whoSg_IP, whoPl_IP = mkIPL "shei2" ;
whatSg_IP, whatPl_IP = mkIPL " shen2ma" ;
where_IAdv = mkIAdvL "na3li3" ;
when_IAdv = mkIAdvL "shen2mashi2hou4" ;
how_IAdv = mkIAdvL "ru2he2" ;
all_Predet = ssword "suo3you3" ;
many_Det = mkDet (word "hen3duo1") DTPoss ;
someSg_Det = mkDet (word "yi1xie1") Sg ;
somePl_Det = mkDet (word "yi1xie1") Sg ;
few_Det = mkDet "shao3" Pl ;
other_A = mkA "qi2ta1" ;

oper
  mkIPL, mkIAdvL, mkAdA, mkIDetL, mkPConjL, mkCAdv, mkIQuant = ssword ;

-- hsk

lin


above_Prep = mkPrep "shang4bian1" ;
after_Prep = mkPrep "yi3hou4" ;
under_Prep = mkPrep "xia4" ;
why_IAdv = mkIAdvL "wei2shen2ma" ;
too_AdA = mkAdA "tai4" ;

before_Prep = mkPrep "cong1qian2" ; 
between_Prep = mkPrep "zhi1jian1" ; 
but_PConj = mkPConjL "dan4shi4" ; 


    can_VV  = mkVerb "neng2"  [] [] [] [] "bu4" ;
    must_VV = mkVerb "bi4xu1" [] [] [] [] "bu4" ;  ---- False "bu4neng2"
    want_VV = mkVerb "xiang3" [] [] [] [] "bu4" ;

can8know_VV = mkV "hui4" [] [] [] [] "bu4" ; ----


except_Prep = mkPrep "chu2le" "yi3wai4" ; 
for_Prep = mkPrep "wei2le" ; 
from_Prep = mkPrep "cong1" ; 
in8front_Prep = mkPrep "qian2bian1" ; 
it_Pron = pronNP "ta1" ; 
much_Det = mkDet "duo1" Sg ; 
no_Quant = mkQuant "bu4" ; 
not_Predet = ssword "bu4" ;
otherwise_PConj = mkPConjL "hai2shi4" ; 
to_Prep = mkPrep "wang3" ; 

have_V2 = mkV2 "you3" ;

yes_Utt = ss "dui4" ;
no_Utt = ss neg_s ;

oper
  mkConjForm : Str -> {s1,s2 : Str} = \s -> {s1 = [] ; s2 = word s} ;

-- manually by AR, Jolene

lin
  always_AdV = ssword "yi1zhi2" ;
  part_Prep = mkPrep possessive_s ;  
  language_title_Utt = ssword "zhong1wen2" ;  
  please_Voc = ss "qing3" ;
  quite_Adv = mkAdA "de2hen3" ;

-- just missing

lin
almost_AdA = ssword "ji1hu1" ;  
almost_AdN = ssword "ji1hu1" ;  
--as_CAdv = ssword "shen2ma" ;   -- as good as X
at_least_AdN = ssword "zui4shao3" ;  -- at least five
at_most_AdN = ssword "zui4duo1" ;
behind_Prep = mkPrep "hou4mian4" "zai4";  
--both7and_DConj = ssword "shen2ma" ;  -- both - and
by8agent_Prep = mkPrep "bei4" ;    -- by for agent in passive 
                                  -- [mark] 被
during_Prep = mkPrep "qi1jian1" "zai4" ;  -- [mark] often equivalent to nothing
                                   -- translation for "he swam during this summer. " and "he swam this summer." are often the same
--either7or_DConj = ssword "shen2ma" ;  
everybody_NP = ssword "mei3ge4ren2" ;  -- [mark] "mei3ge4ren2": 每(every)+个(classifier)+人(person)
everything_NP = ssword "mei3jian4shi4" ;  -- [mark] "mei3jian4shi4": 每(every)+件(classifier)+事(thing)
everywhere_Adv = mkAdv "dao4chu3" ;  
here7from_Adv = mkAdv "cong1zhe4li3" ;  -- from here
here7to_Adv = mkAdv "dao4zhe4li3" ;    -- to here
							    -- [mark] "cong1zhe4li3" 从(from) 这里(here)
								--        "dao4zhe4li3" 到( to ) 这里(here)
how8many_IDet = ssword "duo1shao3" ;  
how8much_IAdv = ssword "duo1shao3" ;  
if_Subj = mkSubj "ru2guo3" "jiu4" ;  -- [mark] "jiu4" often comes between NP and VP
--less_CAdv = ssword "shen2ma" ;  -- less good than
--more_CAdv = ssword "shen2ma" ;  
most_Predet = ssword "da4duo1shu3" ;  
nobody_NP = ssword "mei2ren2" ;  
nothing_NP = ssword "mei2you3shen2ma" ;  
on_Prep = mkPrep "shang4" "zai4" ;    
only_Predet = ssword "qi2you3" ;  -- only John
so_AdA = ssword "ru2ci3" ;  
somebody_NP = ssword "mou3ren2" ;  
something_NP = ssword "mou3shi4" ;  -- [mark] in sent, it depends on the context
somewhere_Adv = mkAdv "mou3chu3" ;  
that_Subj = mkSubj [] chcomma ;  -- that + S [mark] comma
there7from_Adv = mkAdv "cong1na3li3" ;  -- from there
there7to_Adv = mkAdv "dao4na3li3" ;  
therefore_PConj = ssword "yin1ci3" ;  
through_Prep = mkPrep "tong1guo4" ;  
which_IQuant = mkIQuant "na3" ; 
--which_IQuant = ssword [] ;  -- [mark] in sent, it depends on the context
without_Prep = mkPrep "mei2you3" []; 
youPol_Pron = ssword "nin2" ;  -- polite you 

}
