--# -path=.:present:api:prelude

  concrete MusicEng of Music = 
    MusicI - [PropKind] 
      with
        (Syntax = SyntaxEng),
        (MusicLex = MusicLexEng) ** 
    open SyntaxEng in {
  lin
    PropKind k p = mkCN k (mkRS (mkRCl which_RP (mkVP p))) ;
  }
