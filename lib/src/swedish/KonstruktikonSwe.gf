
concrete KonstruktikonSwe of Konstruktikon = LangSwe ** 
  open
    SyntaxSwe,
    (P = ParadigmsSwe),
    Prelude,
    CommonScand, ResSwe  
  in {

lin
  reflexiv_resultativVP v ap = 
    insertObj (\\a => reflPron a ++ ap.s ! agrAdjNP a DIndef) (predV v) ;
  indirekt_kausativ_bortVP v np =
    insertObj (\\a => "bort" ++ np.s ! accusative) (predV v) ;
  verba_pa_fortsVP v =
    mkVP (mkVP (lin V v)) (P.mkAdv "på") ;
  adjektiv_som_nom_abstraktNP ap = {
    s = \\c => ap.s ! (AF (APosit (Weak Sg)) (caseNP c)) ;
    a = agrP3 Neutr Sg
    } ;
  adjektiv_som_nom_anaforiskNP npa ap = {
    s = \\c => artDef (gennum npa.g npa.n) ++ npa.s ++ ap.s ! (AF (APosit (Weak npa.n)) (caseNP c)) ;
    a = agrP3 npa.g npa.n
    } ;
  adjektiv_som_nom_folkNP ap = {
    s = \\c => artDef (gennum Utr Pl) ++ ap.s ! (AF (APosit (Weak Pl)) (caseNP c)) ;
    a = agrP3 Utr Pl
    } ;

----  ellips_samordningNP conj det1 ap1 det2 ap2 cn = -- : Conj -> Det -> AP -> Det -> AP -> CN -> NP
----    mkNP conj (mkNP de11 (mkCN ap1 cn)) (mkNP det2 (mkCN ap2 cn)) ;

  saa_gradAP ap s = {
      s = \\a => "så" ++ ap.s ! a ++ (mkSC (lin S s)).s ;
      isPre = False ----
      } ;
  saa_gradAdv adv s = {
      s = "så" ++ adv.s ++ (mkSC (lin S s)).s ;
      } ;
    
  unikhetQuant = {
      s,sp = \\n,bm,bn,g => artDef (gennum (ngen2gen g) n) ++ "enda" ;
      det = DDef Def
      } ;

  i_adjaste_lagetComp a = {
      s = \\_ => "i" ++ a.s ! AF (ASuperl SupWeak) Nom ++ "laget"
      } ;

  progpart_saettVP v w = insertAdv (w.s ! VI (VPtPres Sg Indef Nom)) (predV v) ;
  progpart_addVP v w   = insertAdv (w.s ! VI (VPtPres Sg Indef Nom)) (predV v) ;

  reaktiv_dubbel_auxUtt vv np pol = 
    let 
       verb = vv.s ! VF (VPres Act) ;
       subj = np.s ! NPNom ;
       inte = negation ! pol.p
    in 
    {s = verb ++ verb ++ subj ++ "väl" ++ inte} ;  
  reaktiv_x_och_xUtt u = {
    s = u.s ++ "och" ++ u.s
    } ;

  juxt_redupl_adj2AP a = {
      s = \\ap => let adj = a.s ! AF (APosit ap) Nom in adj ++ adj ;
      isPre = True
      } ;

  juxt_redupl_adj3AP a = {
      s = \\ap => let adj = a.s ! AF (APosit ap) Nom in adj ++ adj ++ adj ;
      isPre = True
      } ;

  koord_redupl_adv2Adv ad =
    let adv = lin Adv ad in
    mkAdv and_Conj adv adv ;

  koord_redupl_adv3Adv ad =
    let adv = lin Adv ad in
    mkAdv and_Conj adv (mkAdv and_Conj adv adv) ;

  juxt_redupl_intj i =
    {s = i.s ++ i.s} ;


  redupl_VP2cVP v = predV verb where {
    verb = {
      s = table VForm {f => v.s ! f ++ "och" ++ v.s ! f} ;
      part = v.part ;
      vtype = v.vtype
      }
    } ;
  redupl_VP3cVP v = predV verb where {
    verb = {
      s = table VForm {f => v.s ! f ++ "och" ++ v.s ! f ++ "och" ++ v.s ! f} ;
      part = v.part ;
      vtype = v.vtype
      }
    } ;
  redupl_VP3VP v = predV verb where {
    verb = {
      s = table VForm {f => v.s ! f ++ v.s ! f ++ v.s ! f} ;
      part = v.part ;
      vtype = v.vtype
      }
    } ;

  pred_somAdv t ap np =
    P.mkAdv (ap.s ! agrAdjNP np.a DIndef ++ (mkRS (lin Temp t) positivePol (mkRCl which_RP (lin NP np) (P.mkV2 verbBe))).s ! np.a ! RNom) ;

  hur_AP_som_helstAP a = {
      s = \\ap => "hur" ++ a.s ! AF (APosit ap) Nom ++ "som helst" ;
      isPre = False ---- en näsa hur stor som helst ?
      } ;
  hur_AP_som_helstAdv a = {
      s = "hur" ++ a.s ! adverbForm ++ "som helst" 
      } ;
  hur_AP_som_helstCN a cn = 
    mkCN (mkCN (mkAP (P.mkAdA "hur") (lin A a)) (lin CN cn)) (P.mkAdv "som helst") ;

  vokativ_m_possessivVoc pron cn =
    mkVoc (SyntaxSwe.mkNP (mkQuant pron) cn) ;

  haalla_naket_NVP n =
    mkVP (P.mkV2 (P.mkV "hålla" "höll" "hållit")) (SyntaxSwe.mkNP n) ;


  multiplicering_dimensionCard x y = {
    s = \\g => x.s ! g ++ "gånger" ++ y.s ! g ;
    n = Pl  ---- en gånger en ?
    } ;

  multiplicering_maengdNP x y =
    let ggr_Conj = lin Conj {s1 = [] ; s2 = "gånger" ; n = Pl} in
    SyntaxSwe.mkNP ggr_Conj (lin NP x) (lin NP y) ;
    
  maatt_plus_adjAP c cn a = 
    mkAP (lin AdA (mkUtt (SyntaxSwe.mkNP c cn))) a ;

  maatt_plus_PPComp c cn adv = 
    mkComp (SyntaxSwe.mkNP (SyntaxSwe.mkNP c cn) adv) ;


lincat
  NPAgr = {s : Str ; g : Gender ; n : Number} ;
  NPGender = {s : Str ; g : Gender} ;
lin
  UtrNPGender = {s = [] ; g = Utr} ;
  NeutrNPGender = {s = [] ; g = Neutr} ;
  MkNPAgr npg nu = {s = npg.s ++ nu.s ! npg.g ; g = npg.g ; n = nu.n} ;

  DetNPGender npg det = {
        s = \\c => npg.s ++ det.sp ! True ! npg.g ;   ---- case of det!
        a = agrP3 npg.g det.n
      } ;

  man_NP = {
    s = table {NPNom => "man" ; NPAcc => "en" ; NPPoss _ _ => "ens"} ;
    a = agrP3 Utr Sg
    } ;
  
  menUtt u v = 
    {s = u.s ++ "men" ++ v.s} ;

  UttBareVP vp = 
    {s = infVP vp (agrP3 Utr Sg)} ;

  tack_Interj = P.mkInterj "tack" ;
  goddag_Interj = P.mkInterj "goddag" ;



}
