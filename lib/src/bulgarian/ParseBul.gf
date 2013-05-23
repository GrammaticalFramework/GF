--# -path=alltenses:../english
concrete ParseBul of ParseEngAbs = 
  TenseX - [IAdv, CAdv],
  CatBul,
  NounBul - [PPartNP],
  AdjectiveBul,
  NumeralBul,
  SymbolBul [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionBul,
  VerbBul - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbBul,
  PhraseBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  IdiomBul [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraBul [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash],

  DictEngBul ** 
open ResBul, Prelude in {

flags
  literal=Symb ;
  beam_size=0.95 ;
  coding = utf8 ;

lin
  CompoundCN num noun cn = {
    s = \\nf => (noun.rel ! nform2aform nf cn.g) ++ (cn.s ! (indefNForm nf)) ;
    g = cn.g
  } ;

  GerundN v = {
    s   = \\nform => v.s ! Imperf ! VNoun nform ;
    rel = \\aform => v.s ! Imperf ! VPresPart aform ++
                     case v.vtype of {
                       VMedial c => reflClitics ! c;
                       _         => []
                     };
    g = ANeut
  } ;
  
  GerundAP v = {
    s = \\aform => v.s ! Imperf ! VPresPart aform ++
                   case v.vtype of {
                     VMedial c => reflClitics ! c;
                     _         => []
                   };
    adv = v.s ! Imperf ! VPresPart (ASg Neut Indef);
    isPre = True
  } ;

  PastPartAP v = {
    s = \\aform => v.s ! Perf ! VPassive aform ;
    adv = v.s ! Perf ! VPassive (ASg Neut Indef);
    isPre = True
  } ;

  PositAdVAdj a = {s = a.adv} ;
  
  that_RP = {
    s = whichRP
  } ;

  UseQuantPN q pn = { s = table {
                            RObj Dat => "на" ++ pn.s; 
                            _        => pn.s
                          } ;
                      a = {gn = GSg pn.g; p = P3}
                    } ;

  PastPartRS ant pol vp = {
      s = \\agr => 
             ant.s ++ pol.s ++
             vp.ad.s ++
             case pol.p of {Pos   => ""; Neg => "не"} ++
             case ant.a of {Simul => ""; Anter => auxBe ! VPerfect (aform agr.gn Indef (RObj Acc))} ++
             vp.s ! Perf ! VPassive (aform agr.gn Indef (RObj Acc)) ++
             case vp.vtype of {
               VMedial c => reflClitics ! c;
               _         => []
             } ++
             vp.compl1 ! agr ++ vp.compl2 ! agr ;
  } ;

  PresPartRS ant pol vp = {
      s = \\agr => 
             ant.s ++ pol.s ++
             vp.ad.s ++
             case pol.p of {Pos   => ""; Neg => "не"} ++
             case ant.a of {Simul => ""; Anter => auxBe ! VPerfect (aform agr.gn Indef (RObj Acc))} ++
             vp.s ! Imperf ! VPresPart (aform agr.gn Indef (RObj Acc)) ++
             case vp.vtype of {
               VMedial c => reflClitics ! c;
               _         => []
             } ++
             vp.compl ! agr ;
  } ;

  SlashV2V vv ant p vp =
      insertSlashObj2 (\\agr => ant.s ++ p.s ++ vv.c3.s ++
                                daComplex ant.a p.p vp ! Perf ! agr)
                      (slashV vv vv.c2) ;

  ComplVV vv ant p vp =
      insertObj (\\agr => ant.s ++ p.s ++
                          case vv.typ of {
                            VVInf    => daComplex ant.a p.p vp ! Perf ! agr;
                            VVGerund => gerund vp ! Imperf ! agr
                          })
                (predV vv) ;

  PredVPosv np vp = {
      s = \\t,a,p,o => 
        let
          subj = np.s ! (case vp.vtype of {
                                        VNormal    => RSubj ;
                                        VMedial  _ => RSubj ;
                                        VPhrasal c => RObj c}) ;
          verb  : Bool => Str
                = \\q => vpTenses vp ! t ! a ! p ! np.a ! q ! Perf ;
          compl = vp.compl ! np.a
        in case o of {
             Main  => compl ++ subj ++ verb ! False  ;
             Inv   => verb ! False ++ compl ++ subj ;
             Quest => compl ++ subj ++ verb ! True
           }
    } ;

  CompS s = {s = \\_ => "че" ++ s.s} ;
  CompQS qs = {s = \\_ => qs.s ! QIndir} ;
  CompVP ant p vp = {s = \\agr => ant.s ++ p.s ++
                                  daComplex ant.a p.p vp ! Perf ! agr} ;

  VPSlashVS vs vp = 
    let vp = insertObj (daComplex Simul Pos vp ! Perf) (predV vs)
    in { s  = vp.s;
         ad = vp.ad;
         compl1 = \\_ => "";
         compl2 = vp.compl;
         vtype  = vp.vtype;
         c2     = {s=""; c=Acc}
       } ;

  ApposNP np1 np2 = {
    s = \\role => np1.s ! role ++ "," ++ np2.s ! RSubj ;
    a = np1.a
  } ;
  
  UncNeg = {s = ""; p = Neg} ;

  UttAdV adv = adv;

}
