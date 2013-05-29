concrete StructuralHeb of Structural = CatHeb ** 
  open MorphoHeb, ResHeb, ParadigmsHeb, (X = ConstructX), Prelude in {

  flags optimize=all ;  coding=utf8 ;

  lin

  this_Quant =  {
     s =  table { 
              Sg => table { Masc =>  "הזה" ;  Fem => "הזאת" } ;               
              _ => table {_ => "האלה" }  
             };
     
      sp = Def ;
      isDef = True ;
       isSNum = True  -- TODO  isNum
      } ;


  that_Quant = {
  s =  table { 
              Sg => table { Masc =>  "ההוא" ;  Fem => "ההיא" } ;             -- that 
              _ => table {_ => "ההן" }                                      --  those 
             };
     
      sp = Def ;
      isDef = True ;
       isSNum = True  -- TODO  isNum

  }; 

 he_Pron = mkPron "הוא" "אותו" "שלו" Masc Sg Per3  ; 
 i_Pron = mkPron "אני" "אותי" "שלי" Masc Sg Per1 ; --both fem and masc nom, acc, gen
 it_Pron = mkPron "זה" "" "" Masc Sg Per3 ;
 she_Pron = mkPron "היא" "שלה" "שלה" Fem Sg Per3  ; 
 they_Pron = mkPron  "הם" "שלהם" "שלהם"   Masc Pl Per3  ;  -- add Fem in extra
 we_Pron = mkPron "אנחנו" "אותנו" "לנו" Masc Pl Per1; --both fem and masc 
 youSg_Pron = mkPron "את" "שלך" "שלך"  Fem Sg Per2 ; -- add Masc in extra 
 youPl_Pron = mkPron "אתן" "שלכן" "שלכן" Fem Pl Per2 ;
-- youPol_Pron = mkPron "אתן" "" "" Fem Sg Per2 ;

 above_Prep = mkPrep "מעל" False;
 after_Prep = mkPrep "אחרי" False;
 by8agent_Prep = mkPrep "על ידי" False ;
 --by8means_Prep = mkPrep "" False ;
 before_Prep = mkPrep "לפני" False ;
 behind_Prep = mkPrep "אחרי" False ;
 between_Prep = mkPrep "בין" False ;
 by8means_Prep = mkPrep "לפי פירושו" False ;
 during_Prep = mkPrep "במשך" False ;
 except_Prep = mkPrep "חוץ מן" False;
 for_Prep  = mkPrep "" False ;
 from_Prep  = mkPrep "" False ;
 through_Prep = mkPrep "דרך" False ;
 with_Prep = mkPrep "עם" False ;
 without_Prep = mkPrep "בלי" False ;
 under_Prep  = mkPrep "מתחת" False ;

 everywhere_Adv = mkAdv "במקום אחר" ;
 there_Adv = mkAdv "שמ" ;
 there7to_Adv = ss "לשמ" ;
 there7from_Adv = ss "משמ" ;
 here7from_Adv = ss "מכאן" ;
 somewhere_Adv = ss "";
--  now_Adv = ss "עכשיו";

 although_Subj = ss "למרות" ;
 because_Subj = ss "בגלל" ;
 if_Subj = ss "למרות" ;
 when_Subj = ss "כשה" ;
 that_Subj = ss "ש" ;
 
 how_IAdv = ss "איך" ;
 how8much_IAdv = ss "כמה" ;
 when_IAdv = ss "מתי" ;
 where_IAdv = ss "איפה" ;
 why_IAdv = ss "למה" ;
 whoSg_IP = ss "מי" ;
 what_IP = ss "מה" ;
 whoPl_IP = ss "מי" ;
 whatPl_IP = ss "מה" ;
 whatSg_IP = ss "מה" ;

 but_PConj = ss "אבל" ;

 how8many_IDet = ss "כמה" ; 
-- many_Det = ss "הרבה" ;
-- much_Det = ss "הרבה" ;

 no_Utt = ss "כן" ;
 yes_Utt = ss "לא" ;


  everything_NP =  regNP "הכל" ; -- should use regNP
}
