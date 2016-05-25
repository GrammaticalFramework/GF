--# -path=.:../abstract:../common:../prelude

concrete ExtraGrc of ExtraGrcAbs = CatGrc, NumeralGrc[Sub1000000,tenthousand] ** 
  open ResGrc, Coordination, Prelude, (M=MorphoGrc), (Ph=PhonoGrc), 
       (P=ParadigmsGrc), (Rel=RelativeGrc) in {
  lincat 
    DemPron = { s : Gender => Number => Case => Str } ;

    CNRefl = 
      { s : Number => Case => Str ;           -- noun only
        s2 : Agr => Number => Case => Str ;   -- attributes (pre- or postnominal)
        isMod : Bool ;                        -- attribute nonempty?
        rel : Number => Str ;                 -- relative clause (dep. on Agr ?)
        g : Gender } ; 

    NPRefl = 
      {s : Agr => Case => Str ;     -- reflexive and reflexive possessive use
       isPron : Bool ;
       e : Case => Str ; -- emphasized pronoun, or ignored
       a : Agr } ;    -- We need: isPron: PronTon | PronAton | None

    -- not used yet (reflexive possessive, specific participle?):
    APRefl = { s : Agr => AForm => Str } ; 

  lin
    NumDl = {s = \\_,_ => [] ; n = Dl ; isCard = False} ;

    DetCNpost det cn = { -- o anvrwpos o agavos
      s = let n = det.n ; g = cn.g in
        \\c => det.s ! g ! c ++ cn.s ! n ! c ++ det.s ! g ! c ++ cn.s2 ! n ! c ++ cn.rel ! n ;
      isPron = False ; 
      e = \\_ => [] ;
      a = Ag cn.g det.n P3
      } ;  -- overgenerates since det may not be DefArt !

    DetCNRefl det cn = { 
      s = \\r,c => let n = det.n ; g = cn.g 
        in det.s ! g ! c ++ cn.s2 ! r ! n ! c ++ cn.s ! n ! c ++ cn.rel ! n ; 
      isPron = False ; 
      e = \\_ => [] ;
      a = Ag cn.g det.n P3
      } ;

    AdvNPRefl np adv = {
      s = \\r,c => np.s ! r ! c ++ adv.s ;
      isPron = False ; 
      e = \\c => [] ;
      a = np.a
      } ;

    RelNPRefl np rs = {
      s = \\r,c => np.s ! r ! c ++ "," ++ rs.s ! np.a ;
      isPron = False ;
      e = \\c => [] ;
      a = np.a
      } ;

    ComplN2Refl n2 np = { 
      s  = n2.s ; 
      s2 = -- noun + (refl) object + indir obj ; -- attribute 
           \\a,n,c => (appPrep n2.c2 np) ++ n2.obj ! a ;  
      isMod = True ;
      rel = \\n => [] ;
      g = n2.g
      } ;

          -- BR 67 2a (ensure that the unemphasized pronoun follows then n)
    PossNPRefl cn np = {      -- house of mine    -- BR 67 2 a (unemphasized pronoun only)
      s = \\n,c => cn.s ! n ! c  ++ case <np.isPron, np.a> of { 
        <True,Ag g na p> => (M.mkPersPron g na p) ! Aton ! Gen ; _ => [] } ;
      s2= \\a,n,c => case <np.isPron, np.a> of { <True,Ag g na p> => [] ;
                                                 _ => np.s ! a ! Gen } ++ cn.s2 ! a ! n ! c ;   
      isMod = True ; 
      rel = cn.rel ;
      g = cn.g
      } ;

    PossCNRefl p cn = { -- BR 67 TODO: distinguish between Emph|UnEmph possessive ?
       s  = cn.s ; 
       s2 = \\a,n,c => case p.a of { Ag g' Sg _ => (cn.s2 ! a ! n ! c) ++ (p.s ! NPCase Ton Gen) ;
                                   _ => (p.s ! NPPoss cn.g n c) ++ (cn.s2 ! a ! n ! c) } ;
       isMod = True ;
       rel = cn.rel ;
       g = cn.g
       } ;

    ComplSlashRefl vp np = insertObj (\\a => appPrepRefl vp.c2 np a) vp ;   

    --  Memo: AForm = AF Gender Number Case ;
    --  Agr = Ag Gender Number Person ;   -- BR 257: also Case, for AcI, AcP

    -- PartVP = PartPresVP PPos ; 

    -- adjectival attributive use of participle : Pol -> VP -> AP 
    -- (nonreflexive: vp.obj ! DefaultAgr)
    PartPresVP p vp = { s = \\af => (partTmpVP GPres p vp) ! (Ag Masc Sg P3) ! af } ;
    PartAorVP p vp = { s = \\af => (partTmpVP GAor p vp) ! (Ag Masc Sg P3) ! af } ;
    PartPerfVP p vp = { s = \\af => (partTmpVP GPerf p vp) ! (Ag Masc Sg P3) ! af } ;
    PartFutVP p vp = { s = \\af => (partTmpVP GFut p vp) ! (Ag Masc Sg P3) ! af } ;

    -- A more general ParticpleNP depending on Temp and Pol seems inappropriate,
    -- since the participle leaves the relation to the main verb open; via the aspect of
    -- the main tenses, one roughly has (BR 220)
    -- PartPres = TSimul, PartAor = TAnter, PartPerf = TSimul, PartFut = inverse TAnter

    -- adverbial use of participle : NP -> Pol -> VP -> NP  (reflexive: vp.obj  ! np.a)
    -- CHECK: position of negation and vp.adv? 
    PartPresNP np p vp = partNP np GPres p vp ;
    PartAorNP np p vp = partNP np GAor p vp ;
    PartFutNP np p vp = partNP np GFut p vp ;
    PartPerfNP np p vp = partNP np GPerf p vp ;

    SlashV2VNPRefl vv np vp = 
      insertObjPre (\\a => vv.c2.s ++ np.s ! a ! vv.c2.c) 
        (insertObjc (\\a => infVP vp a) (predV2 vv)) ** {c2 = vp.c2} ;

    ACP v2 np p vp = -- accusative cum (pres.) participle (if v2.c2 = Acc!)
      let g = genderAgr np.a ;   -- Sketch only ! 
          n = numberAgr np.a ;
          v2p = predV v2 ;
      in insertObj (\\agr => np.s ! Acc ++ (PartPresVP p vp).s ! (AF g n Acc)) v2p ;

    -- Additional pronouns are needed since ReflPron agrees with the subject in gender.

    iFem_Pron      = M.mkPron Fem Sg P1 ;
    youSgFem_Pron  = M.mkPron Fem Sg P2 ;
    weFem_Pron     = M.mkPron Fem Pl P1 ;
    youPlFem_Pron  = M.mkPron Fem Pl P2 ;
    theyFem_Pron   = M.mkPron Fem Pl P3 ;
    theyNeutr_Pron = M.mkPron Neutr Pl P3 ;

    -- Additional NP-constructions:
{-
    UsePronEmph p = 
      { s = \\o,c => p.s ! NPCase Ton c ;  -- emphasized personal pronoun
        isPron = True ; 
        a = p.a } ;

    UsePronUnEmph p = 
      { s = \\o,c => p.s ! NPCase Aton c ;  -- unemphasized personal pronoun
        isPron = True ; 
        a = p.a } ;
-}
    -- DefArt + Inf|Adv|AP ... Nominalizations  (TODO: dependencies on Subj.agr)

    InfPres vp = { s= \\c => artDef ! Neutr ! Sg ! c ++ vp.obj ! (Ag Neutr Sg P3) 
                                                     ++ vp.s ! VPInf GPres ;
                   isPron = False ;
                   e = \\c => [] ;
                   a = Ag Neutr Sg P3 } ;

    InfAor  vp = { s = \\c => artDef ! Neutr ! Sg ! c ++ vp.obj ! (Ag Neutr Sg P3) 
                                                      ++ vp.s ! VPInf GAor ;
                   isPron = False ;
                   e = \\c => [] ;
                   a = Ag Neutr Sg P3 } ;

    InfPerf vp = { s = \\c => artDef ! Neutr ! Sg ! c ++ vp.obj ! (Ag Neutr Sg P3) 
                                                      ++ vp.s ! VPInf GPerf ;
                   isPron = False ;
                   e = \\c => [] ;
                   a = Ag Neutr Sg P3 } ;

    ApposPN pn cn = let ag = cn.g ;  -- cn.g = ag ??
                        an = pn.n ;
     in {s = \\c => pn.s ! c ++ ho_Quantifier.s ! an ! ag ! c 
                               ++ cn.s2 ! an ! c 
                               ++ cn.s ! an ! c 
                               ++ cn.rel ! an ;   
        isPron = False ;
        e = \\c => [] ;
        a = Ag ag an P3 } ;

    ApposPron pr cn = let ag = cn.g ;  -- cn.g = pn.g ??
                          an = numberAgr pr.a ;
                     in {s = \\c => pr.s ! NPCase Ton c ++ ho_Quantifier.s ! an ! ag ! c  --TODO aytoys?? 
                                           ++ cn.s2 ! an ! c 
                                           ++ cn.s ! an ! c ++ cn.rel ! an ; 
                         isPron = False ;
                         e = \\c => [] ;
                         a = Ag ag an P3} ;            

    -- the greek possessive pronoun is an adjective rather than a determiner
    PossCN p cn = {                     -- BR 67 TODO: distinguish between Emph|UnEmph possessive ?
       s  = cn.s ; 
       s2 = \\n,c => case p.a of { Ag g' Sg _ => (cn.s2 ! n ! c) ++ (p.s ! NPCase Ton Gen) ;
                                   _ => (p.s ! NPPoss cn.g n c) ++ (cn.s2 ! n ! c) } ;
       isMod = True ;
       rel = cn.rel ;
       g = cn.g
       } ;

   -- the reflexive possessive relation, i.e. CN of one's own = eautoy CN, is implemented by
   -- the following ReflCN : CN -> CN; note that reflPron is not a Pron or NP.

    ReflCN cn = { -- TODO: ensure that relfPron comes before n ??
                  -- had been: s = \\a,n,c => M.reflPron ! a ! Gen ++ cn.s ! a ! n ! c ;
       s = cn.s ;         
       s2 = \\a,n,c => cn.s2 ! n ! c ++ M.reflPron ! a ! Gen ; 
       isMod = True ;
       rel = cn.rel ;
       g = cn.g 
       } ;


    DemNumPre dem num cn = let g = cn.g ; n = num.n ; art = M.artDef 
        in { s = \\c => dem.s!g!n!c ++ art!g!n!c ++ num.s!g!c ++ cn.s2!n!c ++ cn.s!n!c ;
             isPron = False ;
             e = \\_ => [] ;
             a = Ag g n P3
         } ;
    DemNumPost dem num cn = let g = cn.g ; n = num.n ; art = M.artDef 
        in { s = \\c => art!g!n!c ++ cn.s2!n!c ++ cn.s!n!c ++ dem.s!g!n!c ;
             isPron = False ;
             e = \\_ => [] ;
             a = Ag g n P3
         } ;

    -- Relative Clauses 
    -- TODO: preposition stranding and empty relative, if they exist

    -- Additional VP-constructions:

    -- in many languages, combine a V2 (resp.V3) with a reciprocal to get a V (resp.V2)
    -- with plural subject (resp.object) [TODO: enforce the plural - we use refl for Sg]:

    ReciVP v = insertObj (table { Ag g Pl p => v.c2.s ++ M.reciPron ! g ! v.c2.c ;
                                        agr => v.c2.s ++ M.reflPron !agr! v.c2.c } ) v ;  

    -- Additional structural words:

    so8big_AP = { s = table { AF g n c => M.tosoytos.s ! g ! n ! c } } ;  -- tosoytos BR 68 6
    such_AP   = { s = table { AF g n c => M.toioytos.s ! g ! n ! c } } ;  -- toioytos BR 68 6

    -- Demonstrative pronouns: BR 68
    this_Pron =                                                -- BR 68 1  o'de
      { s = \\g,n,c => let ho : Str = (artDef ! g ! n ! c) 
                        in case ho of { #Ph.vowel + _ =>  M.a2 ho + "de" ;
                                        toys + "*"    =>  toys + "de" ;
                                        _             =>  ho   + "de" } 
       } ;
    that_Pron =                                                -- BR 68 2 oy~tos 
      { s = \\g,n,c => case c of { 
                          ResGrc.Voc => M.a2 (artDef!g!n!Nom + "te") ;  -- HL 
                          _   => let ton : Str = M.dA (artDef ! g ! n ! c) 
                                  in case ton of { "o("  => "oy('tos*" ;
                                                   "h("  => "ay('th" ;
                                                   "oi(" => "oy(~toi" ;
                                                   "ai(" => "ay(~tai" ;
                                                   t+("a"|"h")+n => M.a2 ("tay" + ton) ;
                                                   _             => M.a2 ("toy" + ton) } 
                       }
       } ;
    yonder_Pron =                                              -- BR 68 3 ekei~nos 
        let autos = adjAO "e)kei~nos" ;
         in {s = \\g,n,c => case <g,n,c> of {<Neutr,Sg,Nom|Acc> => "e)kei~no" ;
                                              _ => autos.s ! AF g n c} 
            };
    tosoytos_Pron = M.tosoytos ; -- { s = M.tosoutos } ;    -- that big
    toioytos_Pron = M.toioytos ; -- { s : M.toioutos } ;    -- of that kind

    -- Additional Adverbs:

    immediately_Adv = ss "ey)vy's*" ;       -- BR 63 1
    near_Adv        = ss "pe'las*" ;        -- BR 63
    hardly_Adv      = ss "mo'lis*" ; -- mo'gis
    enough_Adv      = ss "a('lis*" ;
    for8free_Adv    = ss ("dwrea'n" | "proi~ka") ; -- umsonst 
    in8vain_Adv     = ss "ma'thn" ; 
    too8much_Adv    = ss ("a)'gan" | "li'an") ;

    nowhere_Adv     = ss "oy)damoy~" ;
    together_Adv    = ss "koinh|~" ;

    elsewhere_Adv       = ss "a)'llovi" ;       -- BR 63 3
    elsewhere_from_Adv  = ss "a)'lloven" ;      -- -kis, -vi, -ven, -se
    elsewhere_to_Adv    = ss "a)'llose" ;
    same_there_Adv      = ss "ay)to'vi" ;
    same_there_from_Adv = ss "ay)to'ven" ;
    same_there_to_Adv   = ss "ay)to'se" ;
    samePlace_Adv       = ss "o(moy~" ;
    samePlace_from_Adv  = ss "o(mo'ven" ;
    samePlace_to_Adv    = ss "o(mo'se" ;
    home_Adv            = ss "oi)'koi" ;
    home_from_Adv       = ss "oi)'koven" ;
    home_to_Adv         = ss "oi)'kade" ;
    outside_Adv         = ss "vy'rasi" ;
    outside_from_Adv    = ss "vy'raven" ;
    outside_to_Adv      = ss "vy'raze" ;
    ground_at_Adv       = ss "camai'" ;
    ground_from_Adv     = ss "cama~ven" ;
    ground_to_Adv       = ss "cama~ze" ;

    how8often_IAdv  = ss "posa'kis*" ;      -- BR 73 4

    one8times_Adv   = ss "a('pax" ;
    two8times_Adv   = ss "di's*" ;
    three8times_Adv = ss "tri's*" ;
    four8times_Adv  = ss "tetra'kis*" ;
    five8times_Adv  = ss "penta'kis*" ;
    six8times_Adv   = ss "e(xa'kis*" ;
    seven8times_Adv = ss "e(pta'kis*" ;
    eight8times_Adv = ss "o)kta'kis*" ;
    nine8times_Adv  = ss "e)na'kis*" ;
    ten8times_Adv   = ss "deka'kis*" ;
    
    initially_Adv   = { s = variants{ "prw~ton" ; "th'n" ++ "prw'thn" } } ; -- BR 174
    somehow_Adv     = ss "ti" ;             -- BR 174

    in_order_to_Subj = ss "i('na" ;         -- BR 276 : ws, o'pws

--2 Numeral

  -- number nouns: BR 73.4   dis myriades anvrwpwn

    unit_N2 = P.mkN2 (P.mkN "mona's" "mona'dos" Fem) P.genPrep ;
    ten_N2 = P.mkN2 (P.mkN "deka's" "deka'dos" Fem) P.genPrep ;
    hundred_N2 = P.mkN2 (P.mkN "e(katosty's" "e(katosty'os" Fem) P.genPrep ;
    thousand_N2 = P.mkN2 (P.mkN "cilia's" "cilia'dos" Fem) P.genPrep ;
    tenthousand_N2 = P.mkN2 (P.mkN "myria's" "myria'dos" Fem) P.genPrep ;

  lincat
    Sub10000 = {s : CardOrd => Str ; n : Number} ;   -- TODO: constructors

  lin                                                -- d * 10000
    pot4 d = { s = \\f => d.s ! NAdv ++ (tenthousand ! f) ; n = Pl } ;
    pot4plus d m = {
         s = \\f => d.s ! NAdv ++ tenthousand ! f ++ "kai`" ++ m.s ! f ; n = Pl} ;


{- Maybe add some transformations to the Lang-fragment, cf abstract/Transfer.gf:
   In particular, what about Medium voice? Or do we need a verbtype, and
   - select the form depending on the verbtype? 
   - choose the voice depending on the reflexive pronoun
-}
    MedVP v = predVmed v ;
    MedV2 v = { act = v.med ;
                med = v.med ; pass = v.pass ;
                vadj1 = v.vadj1 ; vadj2 = v.vadj2 ;
                vtype = DepMed ;
                c2 = v.c2 } ;
                

oper 
  predVmed : Verb -> ResGrc.VP = \v -> 
  {
    s = table { VPFin t n p              => v.med ! Fin t n p ;
                VPInf tmp                => v.med ! Inf tmp ;  
                VPPart tmp af            => v.med ! (Part tmp af) ; 
                VPImp (M.ImpF IPres n_p) => v.med ! M.Imp IPres n_p ;          
                VPImp (M.ImpF IAor  n_p) => v.med ! M.Imp IAor  n_p ;          
                VPImp (M.ImpF IPerf n_p) => v.med ! M.Imp IPerf n_p ;          
                VPAdj1 a                 => v.vadj1.s ! a ;
                VPAdj2 a                 => v.vadj2.s ! a
      } ;
    neg = Pos ;
    obj = \\_ => [] ;
    adj = \\_,_ => [] ;
    adv = [] ;
    ext = [] 
  } ;


  -- TODO: add whoeverSgFem : RP etc.   whoever + ClSlash : Cl

  whoever : Number => Gender => Case => Str =    -- BR 69 2
    let uncanonize : Str -> Str = \str -> case str of { s + "*" => s ; _ => str } 
     in
     \\n,g,c => case <n,g,c> of { 
                  <Sg,Neutr,Nom|Acc> => 
                       uncanonize (Rel.relPron ! n ! g ! c) ++ (M.dA (M.indefPron ! n ! g ! c)) ;
                  _ => uncanonize (Rel.relPron ! n ! g ! c) +  (M.dA (M.indefPron ! n ! g ! c)) 
                } ;

  appPrepRefl : Preposition -> { s : Agr => Case => Str ; 
                             e : Case => Str ; 
                             isPron : Bool } -> Agr -> Str = 
    \p,np,a -> if_then_Str np.isPron (p.s ++ np.e ! p.c) (p.s ++ np.s ! a ! p.c) ;

  -- TODO: reflexive arguments (and those with a possessive) depend on agreement parameters
  --       add this to emphasized forms!

  oper  -- (nonreflexive) adjectival attributive use of participle
    partTmpVP : VTmp -> Pol -> CatGrc.VP -> Agr => AForm => Str = \vtmp,pol,vp -> 
      let neg = negation ! pol.p ++ pol.s 
      in \\agr,af => vp.obj ! agr ++ vp.adv ++ neg ++ vp.s ! VPPart vtmp af ;

    -- (reflexive) adverbial use of particple 
    partNP : NP -> VTmp -> Pol -> CatGrc.VP -> NP = \np,vtmp,pol,vp ->
        let 
          ap : AForm => Str = partTmpVP vtmp pol vp ! np.a ; 
          g = genderAgr np.a ; n = numberAgr np.a ;
        in lin NP {  
          s = \\c => (if_then_Str np.isPron (np.e ! c) (np.s ! c)) ++ ap ! AF g n c ; 
          isPron = False ;
          e = \\c => [];
          a = np.a
        } ;

  -- lincat
  --   PartP = { s : VTmp => Polarity => Agr => AForm => Str } ;
  -- lin UsePart : VTmp -> Pol -> Part -> APRefl 
  -- lin PartTmpVP vp = 
  --       { s = \\vtmp,pol,agr,af => vp.obj ! agr ++ negation ! pol ++ vp.s ! VPPart vtmp af  } ;

}
