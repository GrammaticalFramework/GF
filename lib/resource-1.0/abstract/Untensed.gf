--1 Untensed forms of sentences, questions, and relative clauses

-- This module defines just positive and negative present tense forms.
-- Am alternative with full variation in polarity, tense, and anteriority is
-- given in [Untensed Untensed.html].

abstract Untensed = Cat ** {

  fun
    PosCl,  NegCl  : Cl  -> S ;
    PosQCl, NegQCl : QCl -> QS ;
    PosRCl, NegRCl : RCl -> RS ;

}
