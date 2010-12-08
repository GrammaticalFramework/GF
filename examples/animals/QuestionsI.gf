-- to compile: 
-- echo "eb -probs=probs -api -file=QuestionsI.gfe" | gf $GF_LIB_PATH/present/LangEng.gfo
-- or use directly gf <mkAnimals.gfs

incomplete concrete QuestionsI of Questions = open Syntax in {
  lincat
    Phrase = Utt ;
    Entity = N ;
    Action = V2 ;

  lin 
    Who  love_V2 man_N           = (
mkUtt (mkQCl    (mkQCl whoSg_IP (mkVP (mkVPSlash love_V2) (mkNP a_Art plNum man_N))))  -- 4.548068040131532e-11
)
 ;
    Whom man_N love_V2           = (
--- WARNING: ambiguous example whom does the man love
mkUtt (mkQCl    (mkQCl whoPl_IP (mkClSlash (mkNP the_Art  man_N) (mkVPSlash love_V2))))  -- 2.8425425250822075e-11
  --- mkUtt (mkQCl    (mkQCl whoSg_IP (mkClSlash (mkNP the_Art  man_N) (mkVPSlash love_V2))))  -- 2.8425425250822075e-11
)
 ;
    Answer woman_N love_V2 man_N = (
--- WARNING: ambiguous example the woman loves men
mkUtt (mkCl    (mkCl (mkNP the_Art  woman_N) (mkVP (mkVPSlash love_V2) (mkNP a_Art plNum man_N))))  -- 3.273034657650043e-14
  --- mkUtt (mkNP the_Art  (mkCN (mkCN (mkCN woman_N) (mkNP a_Art plNum love_N)) (mkNP a_Art plNum man_N)))  -- 1.6623594622841657e-20
  --- mkUtt (mkNP the_Art  (mkCN (mkCN woman_N) (mkNP a_Art plNum (mkCN (mkCN love_N) (mkNP a_Art plNum man_N)))))  -- 1.6623594622841657e-20
)
 ;

}
