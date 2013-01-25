concrete StructuralHeb of Structural = CatHeb ** 
  open MorphoHeb, ResHeb, ParadigmsHeb, Prelude in {

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
  there_Adv = mkAdv "שמ" ;
  there7to_Adv = ss "לשמ" ;
  there7from_Adv = ss "משמ" ;
  somewhere_Adv = ss "";
--  now_Adv = ss "עכשיו";

  but_PConj = ss "אבל" ;
}
