concrete CatJap of Cat = CommonJap ** open ResJap, Prelude in {



flags coding = utf8 ;

  

  lincat
  
    S = {s, te, ba, subj : Particle => Style => Str ; pred, pred_te, pred_ba : Style => Str} ;
    QS = {s : Particle => Style => Str} ;
    RS = {s, te, pred, pred_te, pred_ba : Animateness => Style => Str ;
          subj : Particle => Style => Str ; missingSubj : Bool} ;
    Cl = {s : Particle => Style => TTense => Polarity => Str ;
          te, ba, subj : Particle => Style => Str ;
          pred : Style => TTense => Polarity => Str ;
          pred_te, pred_ba : Style => Str ;
          changePolar : Bool} ;
    ClSlash = {s : Style => TTense => Polarity => Str ;
               te : Style => Str ;
               subj : Particle => Style => Str ;
               pred : Style => TTense => Polarity => Str ;
               pred_te : Style => Str ;
               pred_ba : Style => Str ;
               changePolar : Bool} ;
    SSlash = {s : Style => Str ; te : Style => Str} ;
    Imp = {s : Style => Polarity => Str} ;
    QCl = {s : Particle => Style => TTense => Polarity => Str ; changePolar : Bool} ;
    IP = {s : Style => Str ; anim : Animateness ; how8many : Bool} ;
    IComp = {s : Style => Str} ;
    IDet = {s : Str ; n : Number ; how8many : Bool ; inclCard : Bool} ;
    IQuant = {s : Str} ;
    RCl = {s : Animateness => Style => TTense => Polarity => Str ;
          te : Animateness => Style => Str ;
          subj : Particle => Style => Str ;
          pred : Animateness => Style => TTense => Polarity => Str ;
          pred_te, pred_ba : Animateness => Style => Str ;
          changePolar : Bool ;
          missingSubj : Bool} ;
    RP = {s : Style => Str ; prep : Str} ;
    VP = ResJap.VP ;  -- {verb : Animateness => Style => TTense => Polarity => Str ; 
        --  te : Animateness => Style => Str; a_stem : Animateness => Style => Str ; 
        --  i_stem : Animateness => Style => Str ; ba : Animateness => Style => Str ; 
        --  prep : Str ; obj : Style => Str ; prepositive : Style => Str ; compar : ComparSense} ;
    Comp = {verb : Animateness => Style => TTense => Polarity => Str ; 
            te : Animateness => Style => Str ; a_stem : Animateness => Style => Str ; 
            i_stem : Animateness => Style => Str ; ba : Animateness => Style => Str ; 
            obj : Style => Str ; prepositive : Style => Str ; compar : ComparSense} ;
    VPSlash = Verb ** {prep : Str ; obj : Style => Str ; prepositive : Style => Str ; 
                       v2vType : Bool ; compar : ComparSense} ;
    AP = {pred : Style => TTense => Polarity => Str ; attr : Style => Str ; te : Style => Str ; 
          ba : Style => Str ; adv : Style => Str ; dropNaEnging : Style => Str ;  
          prepositive : Style => Str ; compar : ComparSense} ;
    NP = ResJap.NP ;  -- {s : Style => Str ; prepositive : Style => Str ; needPart : Bool ; 
                      --  changePolar : Bool ; Pron1Sg : Bool ; anim : Animateness} ;
    CN = Noun ** {object : Style => Str ; prepositive : Style => Str ; hasAttr : Bool} ; 
    Pron = Pronoun ;            -- {s : Style => Str ; Pron1Sg : Bool ; anim : Animateness} ;
    Det = Determiner ;          -- {quant : Style => Str ; num : Str ; postpositive : Str ; 
                                --  n : Number ; inclCard : Bool ; sp : Style => Str ; no : Bool} ;
    Predet = {s : Str ; not : Bool} ;
    Quant = {s : Style => Str ; sp : Style => Str ; no : Bool} ;
    Num = ResJap.Num ;            -- {s : Str ; postpositive : Str ; n : Number ; inclCard : Bool} ;
    Card = {s : Str ; postpositive : Str ; n : Number} ; 
    Ord = Adj ;                   -- {pred : Style => TTense => Polarity => Str ; attr : Str ; 
                                  --  te : Str ; ba : Str ; adv : Str ; dropNaEnging : Str} ;
    Numeral = {s : Str ; n : Number} ;
    Digits  = {s : Str ; n : Number} ;
    Conj = Conjunction ;          -- {s : Str ; null : Str ; type : ConjType} ;
    Subj = Subjunction ;          -- {s : Str ; type : SubjType} ;
    Prep = Preposition ;          -- {s : Str ; relPrep : Str} ;
    V = Verb ;                    -- {s : Style => TTense => Polarity => Str ; te : Str ;  
                                  --  a_stem : Str ; i_stem : Str ; ba : Str} 
    V2 = Verb ** {pass: Style => TTense => Polarity => Str ; pass_te : Str ; pass_a_stem : Str ; 
                  pass_i_stem : Str ; pass_ba : Str ; prep : Str} ;
    V3 = Verb ** {prep1 : Str ; prep2 : Str ; give : Bool} ;  -- "give" is a special case
    VV = Verb ** {sense : ModSense} ;
    VS = Verb ** {prep : Str} ;
    VQ = Verb ** {prep : Str} ;
    VA = Verb ;
    V2V = Verb ;
    V2S = Verb ;
    V2Q = Verb ;
    V2A = Verb ;
    A = Adj ;                     -- {pred : Style => TTense => Polarity => Str ; attr : Str; 
                                  --  te : Str ; ba : Str ; adv : Str ; dropNaEnging : Str} ;
    A2 = Adj2 ;                   --  Adj ** {prep : Str} ;
    N = Noun ;                    -- {s : Number => Style => Str ; anim : Animateness ; 
                                  --  counter : Str ; counterReplace : Bool} ;
    N2 = Noun ** {prep : Str; object : Style => Str} ;
    N3 = Noun ** {prep1 : Str; prep2 : Str} ;
    PN = PropNoun ;               -- {s : Style => Str} ;

}