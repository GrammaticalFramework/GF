instance LexFaceIta of LexFace = open SyntaxIta, ParadigmsIta, LexiconIta in {

oper
  like_V2 = mkV2 "amare" ;
  invitation_N = mkN "invitazione" feminine ;
  friend_N = mkN "amico" ;
  have_V2 = LexiconIta.have_V2 ;

}
