--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete NounPol of Noun = CatPol ** open ResPol, Prelude, PronounMorphoPol in {

  flags optimize=all_subs ;

  lin
-- CN = { s : Number => Case => Str; g : Gender };
-- Determiner : Type = { s : Case => Gender => Str; n: Number; a:Case => Case };
-- NounPhrase : Type = { s : PronForm => Str; n : Number; g: Gender; p : Person };

    DetCN kazdy facet = {
      nom = (kazdy.s ! Nom  ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,Nom, facet.g>));
      voc = (kazdy.s ! VocP ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,VocP,facet.g>));
      dep = \\cc => let c = extract_case! cc in 
        (kazdy.s ! c ! facet.g) ++ (facet.s ! kazdy.n ! (accom_case! <kazdy.a,c,facet.g>));
      gn = (accom_gennum !<kazdy.a, facet.g, kazdy.n>);
      p = P3
    } ;

--     DetNP   : Det -> NP ;  -- these five
-- unfortunately as def and indefart linearize to [] DetNP leads to placeing 
-- [] nominale phrases everywhere
-- if you want to parse with this grammar better comment this function
    DetNP kazdy = {
      nom = (kazdy.sp ! Nom  ! (Masc Personal));
      voc = (kazdy.sp ! VocP ! (Masc Personal));
      dep = \\cc => let c = extract_case! cc in 
        (kazdy.sp ! c ! (Masc Personal));
      gn = (accom_gennum !<kazdy.a, (Masc Personal), kazdy.n>);
      p = P3        
    };

-- surface structures of NP formed with MassNP, DefArt and IndefArt are identical
    MassNP piwo = {
      nom = piwo.s! Sg ! Nom;
      voc = piwo.s! Sg ! VocP;
      dep = \\cc => piwo.s ! Sg ! (extract_case! cc) ;
      gn = cast_gennum! <piwo.g, Sg>;
      p = P3 ;
    } ;
    
    UsePron p = {
      nom = p.nom;
      voc = p.voc;
      dep = p.dep;
      gn = cast_gennum! <case p.g of {
        PGen x => x;
        _ => Masc Personal
      }, p.n>;
      p = p.p;
    };
    
    AdjCN mily facet = {
      s = \\n,c =>  (mily.s ! AF (cast_gennum!<facet.g,n>) c) ++ (facet.s ! n ! c);
      g = facet.g    
    };
    
--     AdvCN   : CN -> Adv -> CN ;   -- house on the hill
    AdvCN cn a = {
      s = \\n,c =>   (cn.s ! n ! c) ++ a.s;
      g = cn.g    
    };
    
--     AdvNP   : NP -> Adv -> NP ;    -- Paris today
    AdvNP np a = {
      nom = np.nom ++ a.s;
      voc = np.voc ++ a.s;
      dep = \\c =>  np.dep!c++ a.s;
      gn = np.gn;
      p = np.p
    };

-- surface structures of NP formed with MassNP, DefArt and IndefArt are identical
    DefArt =   {s = \\_=>[] ; sp = (demPronTen "ten").sp ; c=Nom; g = PNoGen }; 
    IndefArt = {s = \\_=>[] ; sp = jaki ;                  c=Nom; g = PNoGen };

    UseN  sb = {
      s = \\n,c => sb.s ! SF n c; 
      g = sb.g
    } ;

    PossPron p = {
      s,sp = p.sp
    };
    
    NumSg = { s = \\_,_ => ""; a = NoA; n = Sg; hasCard = False };
    NumPl = { s = \\_,_ => ""; a = NoA; n = Pl; hasCard = False };
    
    DetQuant q num = {
      s = \\c,g => q.s ! AF (cast_gennum!<g,num.n>) (accom_case!<num.a,c,g>) ++ num.s !c !g;
      sp = \\c,g => case num.hasCard of { 
        True  => q.s  ! AF (cast_gennum!<g,num.n>) (accom_case!<num.a,c,g>) ++ num.s !c !g;
        False => q.sp ! AF (cast_gennum!<g,num.n>) (accom_case!<num.a,c,g>) ++ num.s !c !g
      };
      n = num.n;
      a = num.a
    };
    
    DetQuantOrd q num ord = {
      s,sp = \\c,g => q.s ! AF (cast_gennum!<g,num.n>) (accom_case!<num.a,c,g>)  
        ++ num.s !c !g
        ++ ord.s ! AF (cast_gennum!<g,num.n>) (accom_case! <num.a,c,g>);
      n = num.n;
      a = num.a
    };
    
    OrdSuperl a = {
        s = mkAtable a.super
    };

    ComplN2 n2 np = {  
      s = \\n,c =>
        n2.s ! SF n c ++ n2.c.s ++ np.dep ! n2.c.c;
      g = n2.g
    };
    
    ComplN3 n3 np = {
      s =
        \\sf => n3.s ! sf ++ n3.c.s ++ np.dep ! n3.c.c ;
      c = n3.c2;
      g = n3.g
    };

    UseN2 n2 = {
      s = \\n,c => n2.s ! SF n c;
      g = n2.g
    };
    
    Use2N3 n3 = {
      s = n3.s;
      g = n3.g;
      c = n3.c
    };

    Use3N3 n3 = {
      s = n3.s;
      g = n3.g;
      c = n3.c2
    };
    
    RelNP np rs = {
      nom = np.nom ++ rs.s ! np.gn ;
      voc = np.voc ++ rs.s ! np.gn ;
      dep = \\cc => np.dep !cc ++ rs.s ! np.gn ;
      gn = np.gn;  
      p = np.p   
    };

    RelCN cn rs = {
      s = \\n,c => cn.s !n !c ++ rs.s ! (cast_gennum!<cn.g,n>);
      g = cn.g
    } ;
    
--     PPartNP : NP -> V2  -> NP ;    -- the man seen
    PPartNP np v2 = {
      nom = np.nom ++ (mkAtable (table2record v2.ppartp)) ! AF np.gn Nom;
      voc = np.voc ++ (mkAtable (table2record v2.ppartp)) ! AF np.gn VocP;
      dep = \\cc => np.dep !cc ++ (mkAtable (table2record v2.ppartp)) ! AF np.gn (extract_case!cc) ;
      gn = np.gn;
      p = np.p
    };
    

--     NumNumeral : Numeral -> Card ;  -- fifty-one
    NumNumeral n = { s=n.s; a=n.a; n=n.n };
    
--     NumDigits  : Digits  -> Card ;  -- 51
    NumDigits n =  { s=\\_,_ => n.s; a=n.a; n=n.n };
    
--     NumCard : Card -> Num ;
    NumCard c = c ** { hasCard = True };

--     OrdDigits  : Digits  -> Ord ;  -- 51st
    OrdDigits n = { s=\\_=>n.o };

--     OrdNumeral : Numeral -> Ord ;  -- fifty-first
    OrdNumeral n = { s=n.o };
    
--     AdNum : AdN -> Card -> Card ;   -- almost 51
    AdNum ad c = { s = \\x,y=>ad.s ++ c.s!x!y; a=c.a; n=c.n };

--     PredetNP : Predet -> NP -> NP; -- only the man 
    PredetNP p np = case p.adj of {
      False => { 
        voc = p.np.voc ++ np.dep!GenNoPrep; 
        nom = p.np.nom ++ np.dep!GenNoPrep; 
        dep = \\c=> p.np.dep!c ++ np.dep!GenNoPrep; 
        n   = p.np.n; 
        gn  = p.np.gn; p=p.np.p };
      True => {
        voc = p.s!AF np.gn VocP ++ np.dep!GenNoPrep; 
        nom = p.s!AF np.gn Nom  ++ np.dep!GenNoPrep; 
        dep = \\c=> p.s!AF np.gn (extract_case!c) ++ np.dep!c; 
        n   =np.n; 
        gn  =np.gn; p=np.p }
      };

    UsePN n = n;
    
--     ApposCN : CN -> NP -> CN ;    -- city Paris (, numbers x and y)
    ApposCN cn np = {
        s= \\n,c=> cn.s!n!c ++ np.nom;
        g= cn.g
    };

--     SentCN  : CN -> SC  -> CN ;   -- question where she sleeps
    SentCN cn sc = {
        s= \\n,c=> cn.s!n!c ++ sc.s;
        g= cn.g
    };
}
