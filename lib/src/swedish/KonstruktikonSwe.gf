
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

}
