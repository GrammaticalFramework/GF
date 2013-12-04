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
            ComplSlashPartLast,
            ClSlash, RCl, EmptyRelSlash],

  DictEngBul ** 
open ResBul, Prelude in {

flags
  literal=Symb ;
  coding = utf8 ;

lin
  CompoundCN num noun cn = {
    s = \\nf => num.s ! CFNeut Indef ++ (noun.rel ! nform2aform nf cn.g) ++ (cn.s ! (indefNForm nf)) ;
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
                      a = {gn = GSg pn.g; p = P3};
                      p = q.p
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
                                daComplex ant.a (orPol p.p vp.p) vp ! Perf ! agr)
                      Pos
                      (slashV vv vv.c2) ;

  ComplVV vv ant p vp =
      insertObj (\\agr => ant.s ++ p.s ++
                          case vv.typ of {
                            VVInf    => daComplex ant.a p.p vp ! Perf ! agr;
                            VVGerund => gerund vp ! Imperf ! agr
                          }) vp.p
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

  CompS s = {s = \\_ => "че" ++ s.s; p = Pos} ;
  CompQS qs = {s = \\_ => qs.s ! QIndir; p = Pos} ;
  CompVP ant p vp = {s = let p' = case vp.p of {
                                    Neg => Neg;
                                    Pos => p.p
                                  }
                         in \\agr => ant.s ++ p.s ++
                                     daComplex ant.a p' vp ! Perf ! agr;
                     p = Pos
                    } ;

  VPSlashVS vs vp = 
    let vp = insertObj (daComplex Simul Pos vp ! Perf) vp.p (predV vs)
    in { s  = vp.s;
         ad = vp.ad;
         compl1 = \\_ => "";
         compl2 = vp.compl;
         vtype  = vp.vtype;
         p      = vp.p;
         c2     = {s=""; c=Acc}
       } ;

  ApposNP np1 np2 = {
    s = \\role => np1.s ! role ++ comma ++ np2.s ! RSubj ;
    a = np1.a ;
    p = np1.p
  } ;

  UttAdV adv = adv;

lincat
    Feat = Str;
lin FeatN2, FeatN = \n ->
      case n.g of {
        AMasc Human    => "(м.р.л.)" ;
        AMasc NonHuman => "(м.р.)" ;
        AFem           => "(ж.р.)" ;
        ANeut          => "(ср.р.)"
      } ;
    FeatV = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ;
    FeatV2 = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<допълнение>";
    FeatV3 = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<арг1>"++
      v.c3.s ++
      "<арг2>";
    FeatV2V = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<допълнение>"++
      v.c3.s ++
      "да" ++ "<глагол>";
    FeatV2S = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<допълнение>"++
      v.c3.s ++
      "че" ++ "<изречение>";
    FeatV2Q = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<допълнение>"++
      v.c3.s ++
      "<въпрос>";
    FeatV2A = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      v.c2.s ++
      "<допълнение>"++
      "<прилагателно>";
    FeatVV = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      case v.typ of {
        VVInf => "да" ++ "<глагол>";
        VVGerund => "<деепричастие>"
      };
    FeatVS = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      "че" ++ "<изречение>";
    FeatVQ = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      "<въпрос>";
    FeatVA = \v ->
      "<подлог>" ++
      case v.vtype of {
        VNormal => "" ;
        VMedial c => reflClitics ! c ;
        VPhrasal c => personalClitics ! c ! GSg Masc ! P3
      } ++
      v.s ! Imperf ! VPres Sg P3 ++
      "<прилагателно>";
}
