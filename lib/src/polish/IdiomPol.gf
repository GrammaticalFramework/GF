--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete IdiomPol of Idiom = CatPol ** open Prelude, ResPol, VerbMorphoPol in {

 flags optimize=all_subs ;  coding=utf8 ;

 lin
    
--     ImpersCl  : VP -> Cl ;        -- it is hot
    ImpersCl vp = {
        s = \\pol,anter,tense =>
            vp.prefix ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, NeutSg, P3>) ++ 
            vp.sufix !pol !NeutSg 
    };    

--     ImpPl1    : VP -> Utt ;       -- let's go
    ImpPl1 vp = {
        s = vp.prefix ++
            (imperative_form vp.verb vp.imienne Pos MascPersPl P1) ++ 
            vp.sufix !Pos !MascPersPl 
    };
    
--     GenericCl : VP -> Cl ;        -- one sleeps
    GenericCl vp = {
        s = \\pol,anter,tense =>
            "ktoś" ++ vp.prefix  ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, MascPersSg, P3>) ++ 
            vp.sufix !pol !MascPersSg 
    };

--     CleftNP   : NP  -> RS -> Cl ; -- it is I who did it
    CleftNP  np rs = {s=\\pol,_,_ => "to" ++ (case pol of {Neg=>"nie";Pos=>""}) ++ np.nom ++ rs.s!np.gn };

--     CleftAdv  : Adv -> S  -> Cl ; -- it is here she slept
    CleftAdv adv s = {s=\\_,_,_ => adv.s ++ s.s };

--     ExistNP   : NP -> Cl ;        -- there is a house
    ExistNP np = {s=\\pol,anter,tense => case pol of { 
        Pos=> jest_op ! <np.gn, np.p, tense, anter> ++ np.nom;
        Neg=> niema_op!<tense,anter> ++ np.dep!GenNoPrep } };
    
--     ExistIP   : IP -> QCl ;       -- which houses are there
    ExistIP ip = {s=\\pol,anter,tense => case pol of {
        Pos=>ip.nom ++ jest_op ! <ip.gn, ip.p, tense, anter>;
        Neg=>ip.dep!GenNoPrep ++ niema_op!<tense,anter>} };

--     ProgrVP   : VP -> VP ;        -- be sleeping
    ProgrVP vp = {
        prefix=vp.prefix; sufix=vp.sufix;
        imienne = vp.imienne; exp=vp.exp;
        verb= { si,sp= vp.verb.si;
            refl=vp.verb.refl;
            asp=vp.verb.asp;
            ppartp=vp.verb.pparti;
            pparti=vp.verb.pparti}
        };
} ;
