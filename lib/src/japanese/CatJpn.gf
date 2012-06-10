concrete CatJpn of Cat = CommonJpn ** open ResJpn, Prelude in {

flags coding = utf8 ;

  lincat
  
    S = {s, te, ba, subj : Particle => Style => Str ; pred, pred_te, pred_ba : Style => Str} ;
    QS = {s : Particle => Style => Str ; s_plain_pred : Particle => Style => Str} ;
    RS = {s, te, pred, pred_te, pred_ba : Animateness => Style => Str ;
          subj : Particle => Style => Str ; missingSubj : Bool} ;
    Cl = {s : Particle => Style => TTense => Polarity => Str ; subj : Particle => Style => Str ; 
         te, ba : Particle => Style => Polarity => Str ; pred : Style => TTense => Polarity => Str ;
         pred_te, pred_ba : Style => Polarity => Str ; changePolar : Bool} ;
    ClSlash = {s, pred : Style => TTense => Polarity => Str ; subj : Particle => Style => Str ;
               te, pred_te, pred_ba : Style => Polarity => Str ; changePolar : Bool} ;
    SSlash = {s : Style => Str ; te : Style => Str} ;
    Imp = {s : Style => Polarity => Str} ;
    QCl = {s : Particle => Style => TTense => Polarity => Str ; 
           s_plain_pred : Particle => Style => TTense => Polarity => Str ; changePolar : Bool} ;
    IP = {s_subj, s_obj : Style => Str ; anim : Animateness ; how8many : Bool} ;
    IComp = {s : Style => Str ; wh8re : Bool} ;
    IDet = {s : Str ; n : Number ; how8many : Bool ; inclCard : Bool} ;
    IQuant = {s : Str} ;
    RCl = {s, pred : Animateness => Style => TTense => Polarity => Str ;
          te, pred_te, pred_ba : Animateness => Style => Polarity => Str ;
          subj : Particle => Style => Str ; changePolar : Bool ; missingSubj : Bool} ;
    RP = {s : Style => Str ; null : Bool} ;
    VP = ResJpn.VP ;  -- {verb : Speaker => Animateness => Style => TTense => Polarity => Str ; 
                      --  a_stem, i_stem : Speaker => Animateness => Style => Str ; 
                      --  te, ba : Speaker => Animateness => Style => Polarity => Str ;
                      --  prep : Str ; obj : Style => Str ; prepositive : Style => Str ; 
                      --  needSubject : Bool} ;
    Comp = {verb : Animateness => Style => TTense => Polarity => Str ; a_stem, i_stem : 
            Animateness => Style => Str ; te, ba : Animateness => Style => Polarity => Str ;
            obj : Style => Str ; prepositive : Style => Str ; needSubject : Bool} ;
    VPSlash = {s : Speaker => Style => TTense => Polarity => Str ; 
               a_stem, i_stem : Speaker => Str ; te, ba : Speaker => Polarity => Str ;
               prep : Str ; obj : Style => Str ; prepositive : Style => Str ; v2vType : Bool} ;
    AP = {pred : Style => TTense => Polarity => Str ; attr, adv, dropNaEnging, prepositive : 
          Style => Str ; te, ba : Style => Polarity => Str ; needSubject : Bool} ;
    NP = ResJpn.NP ;  -- {s : Style => Str ; prepositive : Style => Str ; needPart : Bool ; 
                      --  changePolar : Bool ; meaning : Speaker ; anim : Animateness} ;
    CN = Noun ** {object : Style => Str ; prepositive : Style => Str ; hasAttr : Bool} ; 
    Pron = Pronoun ;              -- {s : Style => Str ; Pron1Sg : Bool ; anim : Animateness} ;
    Det = Determiner ;            -- {quant : Style => Str ; num : Str ; postpositive : Str ; 
               --  n : Number ; inclCard : Bool ; sp : Style => Str ; no : Bool ; tenPlus : Bool} ;
    Predet = {s : Str ; not : Bool} ;
    Quant = {s : Style => Str ; sp : Style => Str ; no : Bool} ;
    Num = ResJpn.Num ;            -- {s : Str ; postpositive : Str ; n : Number ; inclCard : Bool ; 
                                  --  tenPlus : Bool} ;
    Card = {s : Str ; postpositive : Str ; n : Number ; tenPlus : Bool} ; 
    Ord = Adj ;                   -- {pred : Style => TTense => Polarity => Str ; attr, adv,
                                  --  dropNaEnging : Str ; te, ba : Polarity => Str} ;
    Numeral = {s : Str ; n : Number ; tenPlus : Bool} ;
    Digits  = {s : Str ; n : Number ; tenPlus : Bool ; tail : DTail} ;
    Conj = Conjunction ;          -- {s : Str ; null : Str ; type : ConjType} ;
    Subj = Subjunction ;          -- {s : Str ; type : SubjType} ;
    Prep = Preposition ;          -- {s : Str ; null : Str} ;
    V = Verb ;                    -- {s : Style => TTense => Polarity => Str ; a_stem, i_stem : 
                                  --  Str ; te, ba : Polarity => Str ; needSubject : Bool} 
    V2 = Verb2 ;                  -- {s, pass : Style => TTense => Polarity => Str ; a_stem, i_stem, 
                                  --  pass_a_stem, pass_i_stem, prep : Str ; te, ba, pass_te, 
                                  --  pass_ba : Polarity => Str ; needSubject : Bool} ;
    V3 = Verb3 ;                  -- {s : Speaker => Style => TTense => Polarity => Str ; a_stem, 
                                  --  i_stem : Speaker => Str ; te, ba : Speaker => Polarity => 
                                  --  Str ; prep1, prep2 : Str} ;
    VV = ResJpn.VV ;              -- {s : Speaker => Style => TTense => Polarity => Str ; te,  
                                  --  a_stem, i_stem, ba, te_neg, ba_neg : Speaker => Str ; 
                                  --  sense : ModSense} ;
    VS = Verb2 ;
    VQ = Verb2 ;
    VA = Verb ;
    V2V = Verb ;
    V2S = Verb ;
    V2Q = Verb ;
    V2A = Verb ;
    A = Adj ;                     -- {pred : Style => TTense => Polarity => Str ; attr,  
                                  --  dropNaEnging : Str ; te, ba, adv : Polarity => Str} ;
    A2 = Adj2 ;                   --  Adj ** {prep : Str} ;
    N = Noun ;                    -- {s : Number => Style => Str ; anim : Animateness ; 
                                  --  counter : Str ; counterReplace : Bool ; counterTsu : Bool} ;
    N2 = Noun ** {prep : Str; object : Style => Str} ;
    N3 = Noun ** {prep1 : Str; prep2 : Str} ;
    PN = PropNoun ;               -- {s : Style => Str ; anim : Animateness} ;

}
