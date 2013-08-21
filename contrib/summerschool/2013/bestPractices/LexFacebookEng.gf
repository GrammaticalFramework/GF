instance LexFacebookEng of LexFacebook = 
       open SyntaxEng,
            ParadigmsEng,
            --ExtraEng,
            IrregEng in
{
oper 
  nounFromS s = mkNP (mkNP the_Det (mkCN (mkN "fact"))) (SyntaxEng.mkAdv that_Subj s) ;
  
  checkIn np = mkVP (mkV2 (partV (mkV "check") "in") (mkPrep "to")) np ;

  beFriends np = mkVP (mkVP (dirV2 become_V) (mkNP a_Art plNum (mkCN (mkN "friend")))) (SyntaxEng.mkAdv (mkPrep "with") np) ;
 
  like np1 np2 = mkS (mkCl np1 (mkVP (dirV2 (mkV "like")) np2)) ;

}