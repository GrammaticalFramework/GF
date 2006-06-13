--# -path=.:present:prelude

  concrete MusicEng of Music = MusicEng0 - [PropKind] ** open GrammarEng in {
    lin
      PropKind k p = 
        RelCN k (UseRCl TPres ASimul PPos (RelVP IdRP (UseComp (CompAP p)))) ;
    }
