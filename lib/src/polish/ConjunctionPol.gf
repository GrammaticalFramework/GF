--# -path=.:../abstract:../common:../../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete ConjunctionPol of Conjunction = 
  CatPol ** open ResPol, Coordination, Prelude in {

  flags optimize=all_subs ;  coding=utf8 ;

  lin

    ConjS conj list = {
        s = conj.sent1 ++ list.s1 ++ conj.sent2 ++ list.s2;
    };

    ConjAdv conj list = {
        s = conj.s1 ++ list.s1 ++ conj.s2 ++ list.s2;
    };

                                                    
    ConjNP conj list ={
        nom = conj.s1 ++ list.np1.nom ++ conj.s2 ++ list.np2.nom;
        voc = conj.s1 ++ list.np1.voc ++ conj.s2 ++ list.np2.voc;
        dep = \\c => conj.s1 ++ list.np1.dep !c ++ conj.s2 ++ list.np2.dep !c;
        gn  = case <list.np1.gn,list.np2.gn> of {
            <(MascPersSg|MascPersPl), _> => MascPersPl;
            <_, (MascPersSg|MascPersPl)> => MascPersPl;
            <_,_>                        => OthersPl
        };
        p = case <list.np1.p,list.np2.p> of {
            <P1, _> => P1;
            <_, P1> => P1;
            <P2, _> => P2;
            <_, P2> => P2;
            <_,_>   => P3
        }
    };

    ConjAP conj list = {
        adv = conj.s1 ++ list.ap1.adv ++ conj.s2 ++ list.ap2.adv;
        s = \\af=>conj.s1 ++ list.ap1.s!af ++ conj.s2 ++ list.ap2.s!af;
    };
    ConjRS = conjunctDistrTable GenNum;


-- ---- These fun's are generated from the list cat's.
-- 
    BaseS   = twoSS ;
    ConsS   = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseRS  = twoTable GenNum ;
    ConsRS  = consrTable GenNum comma;

    BaseNP np1 np2 = { np1=np1; np2=np2 };
    ConsNP np npl = { np2=npl.np2; 
        np1 = {
            nom = np.nom ++ "," ++ npl.np1.nom;
            voc = np.voc ++ "," ++ npl.np1.voc;
            dep = \\c => np.dep !c ++ "," ++ npl.np1.dep !c;
            gn  = case <np.gn,npl.np1.gn> of {
                <(MascPersSg|MascPersPl), (MascPersSg|MascPersPl)> => MascPersPl;
                <_,_>                          => OthersPl
            };
            p = case <np.p,npl.np1.p> of {
                <P1, _> => P1;
                <_, P1> => P1;
                <P2, _> => P2;
                <_, P2> => P2;
                <_,_>   => P3
            }
        }
    };
    
    BaseAP  ap1 ap2 =  { ap1=ap1; ap2=ap2 };
    ConsAP  ap apl = { ap2=apl.ap2; ap1={
        s = \\af=> ap.s!af ++ "," ++ apl.ap1.s!af;
        adv = ap.adv ++ "," ++ apl.ap1.adv
    } };
  
  lincat

    [S]   = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP]  = {np1,np2 : NounPhrase} ;
    [AP]  = {ap1,ap2 : AdjPhrase} ;
    [RS]  = {s1,s2 : GenNum => Str} ;

}
