--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete QuestionPol of Question = CatPol ** open ResPol, Prelude, VerbMorphoPol in {

 flags optimize=all_subs ;

lin

--     QuestCl     : Cl -> QCl ;            -- does John walk
    QuestCl cl = { s = \\p,a,t=> "czy" ++ cl.s !p !a !t };
--     QuestVP     : IP -> VP -> QCl ;      -- who walks
    QuestVP ip vp = {
        s = \\pol,anter,tense => ip.nom ++ vp.prefix !pol !ip.gn ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, ip.gn, ip.p>) ++ 
            vp.sufix !pol !ip.gn ++ vp.postfix !pol !ip.gn;
    };

--     QuestSlash  : IP -> ClSlash -> QCl ; -- whom does John love 
    QuestSlash ip cls = {
        s = \\pol,anter,tense => cls.c.s ++ ip.dep ! cls.c.c     ++ cls.s !pol !anter !tense
    };

--     QuestIAdv   : IAdv -> Cl -> QCl ;    -- why does John walk
    QuestIAdv ia cl = { s = \\p,a,t=> ia.s ++ cl.s !p !a !t };
    
--     QuestIComp  : IComp -> NP -> QCl ;   -- where is John
    QuestIComp ic np = { 
        s = \\p,a,t => 
          (imienne_form {si = \\_=>[]; sp = \\_=>[]; asp = Dual; refl = ""; ppart=\\_=>""} p !<t,a,np.gn,np.p>) ++ np.nom
    };
 
--     IdetCN    : IDet -> CN -> IP ;       -- which five songs
    IdetCN idet cn = {
        nom = idet.s !Nom  !cn.g ++ cn.s !idet.n !(accom_case! <idet.a,Nom, cn.g>);
        voc = idet.s !VocP !cn.g ++ cn.s !idet.n !(accom_case! <idet.a,Nom, cn.g>);
        dep = \\cc => let c = extract_case! cc in
          idet.s !c !cn.g ++ cn.s !idet.n ! (accom_case! <idet.a, c, cn.g>);
        gn = (accom_gennum !<idet.a, cn.g, idet.n>);
        p = P3
    };
--     IdetIP    : IDet       -> IP ;       -- which five
    IdetIP idet = {
        nom = idet.s !Nom !(Masc Personal);
        voc = idet.s !VocP !(Masc Personal);
        dep = \\cc => let c = extract_case! cc in
          idet.s !c !(Masc Personal);
        gn = cast_gennum! <Masc Personal, idet.n>;
        p = P3
    };

--     AdvIP     : IP -> Adv -> IP ;        -- who in Paris
    AdvIP ip adv = {
        nom = ip.nom ++ adv.s;
        voc = ip.voc ++ adv.s;
        dep = \\cc => ip.dep!cc ++ adv.s;
        gn = ip.gn;
        p = ip.p
    }; 

--     IdetQuant : IQuant -> Num -> IDet ;  -- which (five)
    IdetQuant iq n = {
        s = \\c,g => iq.s! AF (cast_gennum! <g,n.n>) c;
        n = n.n;
        a = NoA
    };

--     PrepIP    : Prep -> IP -> IAdv ;     -- with whom
    PrepIP prep ip = { s = prep.s ++ ip.dep !prep.c};

--     CompIAdv  : IAdv -> IComp ;          -- where (is it)
    CompIAdv ia = ia;

--     CompIP    : IP   -> IComp ;          -- who (is it)
    CompIP ip = { s = ip.dep ! InstrNoPrep };

}
