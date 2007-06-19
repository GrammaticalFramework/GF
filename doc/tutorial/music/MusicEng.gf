--# -path=.:present:api:prelude

  concrete MusicEng of Music = MusicEng0 - [PropKind] ** 
      open SyntaxEng in {
  lin
    PropKind k p = mkCN k (mkRS (mkRCl which_RP (mkVP p))) ;
  }
