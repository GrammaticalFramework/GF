--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete SentencePol of Sentence = CatPol ** open Prelude, ResPol, VerbMorphoPol in {

 flags optimize=all_subs ; coding=utf8 ;

lin
--     PredVP    : NP -> VP -> Cl ;         -- John walks
    PredVP np vp = {
        s = \\pol,anter,tense =>
            np.nom ++ vp.prefix !pol !np.gn ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, np.gn, np.p>) ++ 
            vp.sufix !pol !np.gn ++ vp.postfix !pol !np.gn;
    };

--     UseCl    : Temp -> Pol -> Cl  -> S ;
    UseCl temp pol cl = {
        s = temp.s ++ pol.s ++ cl.s !pol.p !temp.a !temp.t
    };

--     UseRCl   : Temp -> Pol -> RCl -> RS ;
    UseRCl temp pol rcl = {
        s = \\gn => temp.s ++ pol.s ++ rcl.s !gn !pol.p !temp.a !temp.t
    }; 

--     UseQCl    : Temp -> Pol -> QCl  -> QS ;
    UseQCl temp pol qcl = {
        s = temp.s ++ pol.s ++ qcl.s !pol.p !temp.a !temp.t
    };
    
--     UseSlash : Temp -> Pol -> ClSlash -> SSlash ;
    UseSlash temp pol cls = {
        s = temp.s ++ pol.s ++ cls.s !pol.p !temp.a !temp.t;
        c = cls.c
    };

--     SlashVP   : NP -> VPSlash -> ClSlash ;      -- (whom) he sees
    SlashVP np vps = {
        s = \\pol,anter,tense => case vps.exp of {
            True => 
              np.nom ++ vps.prefix !pol !np.gn ++
              ((indicative_form vps.verb vps.imienne pol) !<tense, anter, np.gn, np.p>) ++ 
              vps.sufix !pol !np.gn  ++ vps.postfix !pol !np.gn;
            False => 
              vps.prefix !pol !np.gn ++
              ((indicative_form vps.verb vps.imienne pol) !<tense, anter, np.gn, np.p>) ++ 
              vps.sufix !pol !np.gn  ++ vps.postfix !pol !np.gn ++ np.nom
          };
        c = vps.c
    };
    
--     AdvSlash  : ClSlash -> Adv -> ClSlash ;     -- (whom) he sees today
    AdvSlash cls adv = {
        s = \\pol,anter,tense => adv.s ++ cls.s !pol !anter !tense;
        c = cls.c
    };
    
--     SlashVS   : NP -> VS -> SSlash -> ClSlash ; -- (whom) she says that he loves
    SlashVS np vs ssl = {
        s = \\pol,anter,tense => np.nom ++
            ((indicative_form vs False pol) !<tense, anter, np.gn, np.p>) ++
            [", że"] ++ ssl.s;
        c = ssl.c
    };
    
--     ImpVP     : VP -> Imp ;              -- love yourselves
    ImpVP vp = {
        s = \\pol,num => vp.prefix !pol !MascAniSg ++
            (imperative_form vp.verb vp.imienne pol (cast_gennum!<Masc Personal, num>) P2) ++ 
            vp.sufix !pol !MascAniSg ++ vp.postfix !pol !MascAniSg
    };
    
--     AdvS     : Adv -> S  -> S ;            -- today, I will go home
    AdvS adv s = { s = adv.s ++ s.s };
    
--     SlashPrep : Cl -> Prep -> ClSlash ;         -- (with whom) he walks 
    SlashPrep c p = { s=c.s; c=p };

--     EmbedS    : S  -> SC ;               -- that she goes
    EmbedS s = s;

--     EmbedQS   : QS -> SC ;               -- who goes
    EmbedQS s = s;

--     EmbedVP   : VP -> SC ;               -- to go
    EmbedVP vp = {
        s = vp.prefix !Pos !MascPersSg ++
            (infinitive_form vp.verb vp.imienne Pos) ++ 
            vp.sufix !Pos !MascPersSg ++ vp.postfix !Pos !MascPersSg
    };

--     RelS     : S -> RS -> S ;              -- she sleeps, which is good
    RelS s rs = ss (s.s ++ rs.s!NeutSg);
    
--     PredSCVP  : SC -> VP -> Cl ;         -- that she goes is good
    PredSCVP sc vp = {
        s = \\pol,anter,tense =>
            sc.s ++ vp.prefix !pol !NeutSg ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, NeutSg, P3>) ++ 
            vp.sufix !pol !NeutSg ++ vp.postfix !pol !NeutSg;
    };
}
