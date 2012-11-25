--# -path=alltenses:.:../english
concrete ParseEngFre of ParseEngAbs = 
  TenseFre,
  NounFre - [PPartNP],
  AdjectiveFre,
  NumeralFre,
  SymbolFre [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionFre,
  VerbFre - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbFre,
  PhraseFre,
  SentenceFre,
  QuestionFre,
  RelativeFre,
  IdiomFre [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraFre [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
             VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash],
            
  DictEngFre ** 
open MorphoFre, ResFre, ParadigmsFre, SyntaxFre, Prelude, (CR = CommonRomance) in {

flags literal=Symb ; coding = utf8 ;

lin
    ComplVV v ant p vp = insertComplement 
                    (\\a => prepCase v.c2.c ++ specVP vp ant p a) (predV v) ;

    PPartNP np vp = heavyNP {  
      s = \\c => (np.s ! c).comp ++ 
                 (vp.s).s ! CR.VPart np.a.g np.a.n ++ 
                  vp.comp ! np.a ++ vp.ext ! RPos ;
      a = np.a
      } ;

  CompoundCN num noun cn = {
    s = \\n => num.s ! noun.g ++ glue (noun.s ! num.n) (cn.s ! n) ;
    g = cn.g
  } ;


  DashCN noun1 noun2 = { 
    s = \\n => noun1.s ! Sg ++ "-" ++ noun2.s ! n ;
    g = noun2.g
  } ;

  GerundN v = {
    s = \\n => v.s ! VGer ;
    g = CR.Masc
  } ;
  
  GerundAP v = {
    s = \\c => case c of 
                 {CR.AF gg nn => v.s ! CR.VGer;
                  _           => "NONEXISTENT" };
    isPre = False} ;

  PastPartAP v = {
    s = \\c => case c of 
                 {CR.AF gg nn => v.s ! CR.VPart gg nn ;
                  _           => v.s ! CR.VPart CR.Masc Sg};
    isPre = False} ;

  OrdCompar a = {s = \\c => a.s ! Compar ! AF c.g c.n} ; 

  PositAdVAdj a = {s = a.s ! Posit ! AA } ; 

  UseQuantPN q pn = heavyNP{ 
      s = \\c => q.s ! False ! Sg ! pn.g ! c ++ 
                pn.s ; 
      a = CR.agrP3 pn.g Sg} ; 


  SlashV2V v ant p vp = 
       (insertComplement 
         (\\a => prepCase v.c3.c ++ specVP vp ant p a) 
         (predV v)) ** {c2 = v.c2} ;

  -- PredVPosV np vp
  -- PredVPosv np vp TO DO : ask what they are ?
         


  CompS s = {s = \\_ => "que" ++ s.s ! CR.Indic} ; 
  CompVP ant pol vp = {s = \\a => specVP vp ant pol a} ; 


lin
  that_RP = which_RP ;

  UttAdV adv = adv;

oper   
 specVP : VP -> Ant -> Pol -> Agr -> Str = \vp,ant,pp,agr ->
      let
        iform = False ;                    ---- meaning: no clitics
        pol : CR.RPolarity  = CR.RPos;
        inf   = vp.s.s ! VInfin iform ;         -- TO DO: fix anteriority    
        neg   = vp.neg ! pol ;             --- Neg not in API
        obj   = neg.p2 ++ vp.comp ! agr ++ vp.ext ! pol ; ---- pol
        refl  = case vp.s.vtyp of {
            VRefl => reflPron agr.n agr.p Acc ; ---- case ?
            _ => [] 
            } ;
      in
      neg.p1 ++ clitInf iform (refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3) inf ++ obj ;
      

}
