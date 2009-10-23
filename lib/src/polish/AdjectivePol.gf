--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete AdjectivePol of Adjective = CatPol ** open ResPol, Prelude in {
flags  coding=utf8 ;

  lin

    PositA  a = { s = mkAtable a.pos; adv = a.advpos};
    
    UseComparA a = { s = mkAtable a.comp; adv=a.advcomp};
    
    ComparA a np = { s = \\af => (mkAtable a.comp) ! af ++ "niż" ++ np.nom ; adv=a.advcomp };
    
    AdjOrd o = {s=o.s; adv="["++o.s!AF MascPersSg Nom ++ [": the adverb form does not exist (fun AdjOrd)]"]};
    
    AdAP ada ap = { s = \\af => ada.s ++ ap.s ! af; adv = ada.s ++ ap.adv};
    
--     CAdvAP  : CAdv -> AP -> NP -> AP ; -- as cool as John
    CAdvAP c a n = {
        s = \\af=> c.s ++ a.s!af ++ c.p ++ n.nom;
        adv = c.s ++ a.adv ++ c.p ++ n.nom;
    };

--     ComplA2 : A2 -> NP -> AP ;  -- married to her
    ComplA2 a n = { 
        s = \\af=>(mkAtable a.pos)!af ++ a.c.s ++ n.dep!a.c.c;
        adv = a.advpos ++ a.c.s ++ n.dep!a.c.c
        };

--     ReflA2  : A2 -> AP ;        -- married to itself
    ReflA2 a = { 
        s = \\af=>(mkAtable a.pos)!af ++ a.c.s ++ siebie!(extract_case!a.c.c);
        adv = a.advpos ++ a.c.s ++ siebie!(extract_case!a.c.c) 
    };

--     UseA2   : A2 -> AP ;        -- married
    UseA2 a = { s = mkAtable a.pos; adv=a.advpos};

--     SentAP  : AP -> SC -> AP ;  -- good that she is here -- I have bad feelling about this function
    SentAP a s = {s=\\_=>a.adv ++ s.s; adv=a.adv ++ s.s };

};

