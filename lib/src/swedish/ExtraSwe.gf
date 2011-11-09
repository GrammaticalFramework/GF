--# -path=.:../scandinavian:../abstract:../common:prelude
concrete ExtraSwe of ExtraSweAbs = ExtraScandSwe - [FocAdv] ,
                                   ParadigmsSwe - [nominative] **
 open CommonScand, ResSwe, ParamX, VerbSwe, Prelude, DiffSwe, StructuralSwe, MorphoSwe,
      NounSwe, Coordination, AdjectiveSwe, SentenceSwe, RelativeSwe in {

lincat
 ReflNP  = NP ;
 PronAQ = A ; -- 'en sådan' 
 PronAD = A ; -- 'fler' 
 AdvFoc = Adv ;
 RelVSCl = {s : Agr => RCase => Str};
 
 

lin
 
  TFutKommer = {s = []} ** {t = SFutKommer} ;   --# notpresent
 
  DetNP_utr = detNP utrum Sg ;

  oper detNP : NGender -> Number -> Det -> NP  =
   \g,num,det -> let 
          m = True ;  ---- is this needed for other than Art?
      in lin NP {
        s = \\c => det.sp ! m ! g;
        a = agrP3 (ngen2gen g) num
      } ;

 lin
  RelVS s rvs = {s = \\o => s.s ! o ++ "," ++ rvs.s ! agrP3 Neutr Sg ! RPrep True} ; 
  RelSlashVS t p vs np = let vpform = VPFinite t.t t.a ;
                          cl     = PredVP np (predV vs) ; 
                          vilket = IdRP.s ! Neutr ! Sg ! (RPrep True) in
    {s = \\ag,rc => t.s ++ p.s ++ vilket ++ cl.s ! t.t ! t.a ! p.p ! Sub } ;

 
  AdvFocVP adv vp = {s = \\vpf => {fin = adv.s ++ (vp.s ! vpf).fin ;
                                 inf = (vp.s ! vpf).inf};
                   a1 = vp.a1 ; n2 = vp.n2 ; a2 = vp.a2 ; ext = vp.ext ;
                   en2 = vp.en2 ; ea2 = vp.ea2; eext = vp.eext } ;
  PredetAdvF adv = {s = \\_,_ => adv.s ; p = [] ; a = PNoAg} ;
  
  QuantPronAQ x =  
   let utr = x.s ! AF (APosit (Strong (GSg Utr))) Nom ;
       ntr = x.s ! AF (APosit (Strong (GSg Neutr))) Nom ;
       pl  =  x.s ! AF (APosit (Strong GPl)) Nom 
   in
   {s =
     table {Sg => \\_,_ => genderForms ("en"++utr) 
                                       ("ett"++ntr) ;
            Pl => \\_,_,_ => pl} ;
   sp = table {Sg => \\_,_ => genderForms utr ntr;
               Pl => \\_,_,_ => pl};
     det = DDef Indef};

  CompPronAQ x = CompAP (PositA (lin A x)) ; 

  DetPronAD x = lin Det {s,sp = \\_,_ => x.s ! AF (APosit (Strong GPl)) Nom ;
            n = Pl ; det = DDef Indef} ;

  CompPronAD x = CompAP (PositA (lin A x)) ; 

 ComplVAPronAQ v ap = insertObj (\\a => (PositA ap).s ! agrAdjNP a DIndef) (predV v) ;
 ComplVAPronAD v ap = insertObj (\\a => (UseComparA ap).s ! agrAdjNP a DIndef) (predV v) ;



lin
  FocVP vp np = {
      s = \\t,a,p =>
        let
          subj = np.s ! CommonScand.nominative ;
          agr  = np.a ;
          vps  = vp.s ! VPFinite t a ;  
          vf = case <<t,a> : STense * Anteriority> of {
            <SPres,Simul> => vps.fin
            ;<SPast,Simul> => vps.fin;  --# notpresent 
            <_    ,Simul> => vps.inf;  --# notpresent
            <SPres,Anter> => vps.inf;  --# notpresent
            <SPast,Anter> => vps.inf;  --# notpresent
            <_    ,Anter> => (vp.s ! VPFinite SPast Anter).inf   --# notpresent
            };
          verb = mkClause subj agr (predV do_V) ;                        
          comp = vp.n2 ! agr ++ vp.a2 ++ vp.ext     
        in
        vf ++ comp ++ (verb.s ! t ! a ! p ! Inv) ++ vp.a1 ! Pos 
      } ;

  oper do_V : V = mkV "göra" "gör" "gör" "gjorde" "gjort" "gjord" ;

lin
  FocAP ap np    = 
  {s = \\t,a,p => 
   let vp = UseComp ap ; 
       vps = vp.s ! VPFinite t a;
       npAgr = np.a in
    vp.n2 ! npAgr ++ vps.fin ++ np.s ! NPNom 
    ++ negation ! p++ vps.inf };


  FocVV vv vp np = 
  {s = \\t,a,p =>
    let vps = vp.s ! VPInfinit Simul ;
        vvp = UseV vv ;
        vvs = vvp.s ! VPFinite t a ; 
        always = vp.a1 ! Pos ++ vvp.a1 ! Pos ;
        already = vp.a2 ++ vvp.a2 in
   vps.inf ++ vp.n2 ! np.a ++ vvs.fin ++ np.s ! NPNom 
   ++ vv.c2.s ++ always ++ negation ! p ++ already ++ vvs.inf
   };  


lin
  PrepCN prep cn = {s = prep.s ++ cn.s ! Sg ! DIndef ! Nom } ;
 
  CompoundNomN a b = {
    s = \\n,d,c => a.s ! Sg ! Indef ! Nom ++ BIND ++ b.s ! n ! d ! c ;
    g = b.g
    } ;

  CompoundGenN a b = {
    s = \\n,d,c => a.s ! Sg ! Indef ! Gen ++ BIND ++ b.s ! n ! d ! c ;
    g = b.g
    } ;

  CompoundAdjN a b = {
    s = \\n,d,c => a.s ! AF (APosit (Strong (GSg Utr))) Nom ++ BIND ++ b.s ! n ! d ! c ;
    g = b.g
    } ;


  it8utr_Pron = MorphoSwe.regNP "den" "dess" Utr   Sg  ;
  
  this8denna_Quant = 
    {s,sp = table {
      Sg => \\_,_ => genderForms ["denna"] ["detta"] ; 
      Pl => \\_,_,_ => ["dessa"]
      } ;
    det = DDef Indef
    } 
    ;


  SupCl np vp pol = let sub = np.s ! nominative ;                     --# notpresent
                        verb = (vp.s ! VPFinite SPres Anter).inf ;    --# notpresent
                        neg  = vp.a1 ! pol.p ++ pol.s ;               --# notpresent
                        compl = vp.n2 ! np.a ++ vp.a2 ++ vp.ext in    --# notpresent
    {s = \\_ => sub ++ neg ++ verb ++ compl };                        --# notpresent
    

  PassV2 v2 = predV (depV v2);

  PassV2Be v = insertObj 
        (\\a => v.s ! VI (VPtPret (agrAdjNP a DIndef) Nom)) 
        (predV verbBecome) ;

   
 
  AdvComp comp adv = {s = \\agr => adv.s ++ comp.s ! agr} ;
 
  PPartAP v2 =
    {s     = \\aform => v2.s ! VI (VPtPret aform Nom);
     isPre = True} ; 

  ReflCN num cn = 
        let g = cn.g ;
            m = cn.isMod ;
            dd = DDef Indef ;
      in lin NP {
      s = \\c => cn.s ! num.n ! dd ! caseNP c ++ num.s ! g ; 
      a = agrP3 (ngen2gen g) num.n -- ?
      } ;

  ReflSlash vp np = let vp_l = lin VPSlash vp ;
                        np_l = lin NP np      ;
                        obj  = vp.n3 ! np.a   in
    lin VP (insertObjPost (\\a => vp.c2.s ++ reflForm a np.a ++ np.s ! NPNom++obj) vp) ; 




 oper reflForm : Agr -> Agr -> Str = \aSub,aObj   ->
    case <aSub.p,aObj.g,aObj.n> of {
     <P3,Neutr,Sg> => "sitt" ;
     <P3,Utr ,Sg>  => "sin" ;
     <P3,_   ,Pl>  => "sina" ;
     _             => reflGenPron aSub.p aSub.n aObj.n aObj.g};
  
  oper reflGenPron : Person -> (subnum,objnum : ParadigmsSwe.Number)
                     -> NGender -> Str =
   \p,subnum,objnum,g -> let pn = getPronoun p subnum
      in pn.s ! NPPoss (gennum g objnum) Nom ;



      
  this_NP : Str -> Gender -> Number -> NP =
  \denna,g,n -> lin NP {s = table {NPPoss gn c => denna+"s";
                                   _           => denna};
                           a = agrP3 g n};

  getPronoun : Person -> ParadigmsSwe.Number -> Pron = 
   \p,n ->  case <p,n> of {
      <P1,Sg>   => i_Pron ;
      <P2,Sg>   => youSg_Pron ;
      <P3,Sg>   => he_Pron ;
      <P1,Pl>   => we_Pron ;
      <P2,Pl>   => youPl_Pron ;
      <P3,Pl>   => they_Pron } ;


----------------- Predeterminers,Quantifiers,Determiners

  lin
    bara_AdvFoc = mkAdv "bara" ;

    sadana_PronAQ = mkA "sådan" ;
    fler_PronAD   = mkA "flera" "flera" "flera" "fler" "flest" ;

    hela_Predet    = {s  = \\_,_ => "hela" ; p = [] ; a = PNoAg} ;
    samma_Predet   = {s  = \\_,_ => "samma" ; p = [] ; a = PNoAg} ;

    sjaelva_Quant = {s  = \\_,_,_,_ => "själva" ;
                     sp = \\_,_,_,_ => variants {};
                     det = DDef Def } ;

    vardera_Det  = {s,sp = \\_,_ => "vardera" ; n = Sg ; det = DDef Indef};
    ena_Det      = {s  = \\_,_ => "ena" ; 
                    sp = \\_ => genderForms ["den ena"] ["det ena"] ; 
                    n = Sg ; det = DDef Def};
    baegge_Det   = {s,sp = \\_,_ => "bägge" ; n = Pl ; det = DDef Def} ;
    baada_Det    = {s,sp = \\_,_ => "båda" ; n = Pl ; det = DDef Def} ;
    varannan_Det = {s,sp = \\_,_ => "varannan" ; n = Sg ; det = DDef Indef} ;
    somliga_Det  = {s,sp = \\_,_ => "somliga" ; n = Pl ; det = DDef Indef} ;
    dylika_Det   = {s,sp = \\_,_ => "dylika" ; n = Pl ; det = DDef Indef} ;
    oovriga_Det  = {s,sp = \\_,_ => "övriga" ; n = Pl ; det = DDef Indef} ;
    samtliga_Det = {s,sp = \\_,_ => "samtliga" ; n = Pl ; det = DDef Indef} ;
    aatskilliga_Det = {s,sp = \\_,_ => "åtskilliga" ; n = Pl ; det = DDef Indef} ;
    varenda_Det     = {s  = \\_ => genderForms ["varenda"] ["vartenda"] ; 
                       sp = \\_ => genderForms ["varenda en"] ["vartenda ett"] ; 
                       n = Sg ; det = DDef Indef};

    noll_Det = {s,sp = \\_,_ => "noll" ; n = Pl ; det = DDef Indef};


}

