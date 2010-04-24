--# -path=.:present

concrete FaceIta of Face = FaceI - [Like] with
  (Syntax = SyntaxIta), 
  (LexFace = LexFaceIta) ** open SyntaxIta in {
lin Like p o = 
  mkCl (mkNP this_Quant o) like_V2 p ;
}
