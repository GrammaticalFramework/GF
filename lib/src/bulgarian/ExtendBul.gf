--# -path=.:../abstract:../common:prelude
concrete ExtendBul of Extend = CatBul ** open Prelude, Predef, ResBul, GrammarBul, MorphoFunsBul in {

lin
  GenModNP num np cn = DetCN (DetQuant DefArt num) (AdvCN cn (PrepNP (mkPrep "на") np)) ;

  AdAdV a adv = {s = a.s ++ adv.s; p = adv.p} ;

  EmptyRelSlash slash = {
      s = \\t,a,p,agr => slash.c2.s ++ whichRP ! agr.gn ++ slash.s ! agr ! t ! a ! p ! Main ;
      role = RObj Acc
      } ;

  CompoundN n1 n2 = 
    let aform = ASg (case n2.g of {
                       AMasc _       => Masc ;
                       AFem          => Fem ;
                       ANeut         => Neut
                    }) Indef
    in {
         s   = \\nf => case n1.relPost of {
                         True  => n2.s ! nf ++ n1.rel ! nform2aform nf n2.g ;
                         False => n1.rel ! nform2aform nf n2.g ++ n2.s ! indefNForm nf
                       } ;
         rel = \\af => n1.rel ! aform ++ n2.s ! NF Sg Indef ;  relPost = n1.relPost ;
         g   = n2.g
    } ;

  CompoundAP n a = AdvAP (PositA a) (PrepNP (mkPrep "от" Acc) (MassNP (UseN n))) ;

  PositAdVAdj a = {s = a.adv; p = Pos} ;

  PresPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Imperf ! VPresPart aform ++
                          case vp.vtype of {
                            VMedial c => reflClitics ! c;
                            _           => []
                          } ++
                          vp.compl ! {gn=aform2gennum aform; p=p} ;
    in {s = ap; adv = ap ! (ASg Neut Indef) ! P3; isPre = vp.isSimple} ;

  PastPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p}
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = vp.isSimple} ;

  PastPartAgentAP vp np =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p} ++
                          "от" ++ np.s ! RObj Acc
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = False} ;

  GerundCN vp = {
    s   = \\nform => vp.ad.s ++
                     vp.s ! Imperf ! VNoun nform ++
                     vp.compl ! {gn=GSg Neut; p=P3} ;
    g = ANeut
  } ;

  GerundNP vp = {
    s  = \\_ => daComplex Simul Pos vp ! Imperf ! {gn=GSg Neut; p=P1};
    gn =GSg Neut;
    p  = NounP3 Pos
  } ;

  GerundAdv, ByVP = \vp ->
    {s = vp.ad.s ++
         vp.s ! Imperf ! VGerund ++
         vp.compl ! {gn=GSg Neut; p=P3}} ;

  InOrderToVP vp = 
    {s = "за" ++ daComplex Simul Pos vp ! Perf ! {gn=GSg Neut; p=P3}};

  iFem_Pron      = mkPron "аз" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Fem) PronP1 ;
  youFem_Pron    = youSg_Pron ;
  weFem_Pron     = we_Pron ;
  youPlFem_Pron  = youPl_Pron ;
  theyFem_Pron   = they_Pron ;
  youPolFem_Pron = youPol_Pron ;
  youPolPl_Pron  = youPol_Pron ;
  youPolPlFem_Pron = youPol_Pron ;

lin
  PassVPSlash vp = insertObj (\\a => vp.s ! Perf ! VPassive (aform a.gn Indef (RObj Acc)) ++
                                     vp.compl1 ! a ++ vp.compl2 ! a) Pos (predV verbBe) ;

  PassAgentVPSlash vp np =
    insertObj (\\_ => "от" ++ np.s ! RObj Acc) Pos
                   (insertObj (\\a => vp.s ! Perf ! VPassive (aform a.gn Indef (RObj Acc)) ++
                                      vp.compl1 ! a ++ vp.compl2 ! a) Pos (predV verbBe)) ;

  UttVPShort vp = {
    s = let agr = agrP3 (GSg Neut) ;
            clitic = case vp.vtype of {
                       VNormal    => {s=[]; agr=agr} ;
                       VMedial c  => {s=reflClitics ! c; agr=agr} ;
                       VPhrasal c => {s=personalClitics agr ! c; agr={gn=GSg Neut; p=P3}}
                     } ;
        in vp.ad.s ++ clitic.s ++
           vp.s ! Imperf ! VPres (numGenNum clitic.agr.gn) clitic.agr.p ++
           vp.compl ! agr
    } ;

lincat
  VPS   = {s : Agr => Str} ;
  [VPS] = {s : Bool => Ints 3 => Agr => Str} ;

lin
  BaseVPS x y = {s  = \\d,t,a=>x.s!a++linCoord!t++y.s!a} ;
  ConsVPS x xs = {s  = \\d,t,a=>x.s!a++(linCoordSep bindComma)!d!t++xs.s!d!t!a} ;

  PredVPS np vps = {s = np.s ! RSubj ++ vps.s ! personAgr np.gn np.p} ;

  MkVPS t p vp = {
    s = \\a => 
          let verb  = vpTenses vp ! t.t ! t.a ! p.p ! a ! False ! Perf ;
              compl = vp.compl ! a
          in t.s ++ p.s ++ verb ++ compl
    } ;
      
  ConjVPS conj vps = {
    s = \\a => conj.s++(linCoordSep [])!conj.distr!conj.conj++vps.s!conj.distr!conj.conj!a;
    } ;

lin
  ComplBareVS = ComplVS ;
  ComplSlashPartLast = ComplSlash ;

lincat
  RNP = {s : Role => Str; gn : GenNum} ;

lin
  ReflRNP slash rnp = {
    s   = slash.s ;
    ad  = slash.ad ;
    clitics = slash.clitics ;
    compl = \\a => slash.compl1 ! a ++ slash.c2.s ++ rnp.s ! RObj slash.c2.c ++ slash.compl2 ! agrP3 rnp.gn ;
    vtype = slash.vtype ;
    p     = slash.p ;
    isSimple = False
  } ;

  ReflPron =
      { s  = \\role => "себе си";
        gn = GSg Masc
      } ;

  ReflPoss num cn =
      { s = \\role => 
                let nf = case num.nn of {
                           NNum Sg => case role of {
				                        RVoc  => NFVocative ;
				                        _     => NF Sg Indef
                                      } ;
                           NNum Pl => NF Pl Indef;
                           NCountable => case cn.g of {
                                           AMasc Human => NF Pl Indef;
                                           _           => NFPlCount
                                         }
                         } ;
                    s = reflPron ! aform (gennum cn.g (numnnum num.nn)) Def (RObj Acc) ++ num.s ! dgenderSpecies cn.g Indef role ++ cn.s ! nf
                in case role of {
                     RObj c => linCase c Pos ++ s;
                     _      => s
                   } ;
        gn = gennum cn.g (numnnum num.nn)
      } ;

  PredetRNP pred rnp = {
    s  = \\c => pred.s ! rnp.gn ++ rnp.s ! c ;
    gn = rnp.gn
  } ;

lin
  ApposNP np1 np2 = {s = \\role => case role of {
                                     RObj c => linCase c (personPol np1.p) ++ np1.s ! RObj CPrep ;
                                     role   => np1.s ! role
                                   } ++ bindComma ++ np2.s ! role;
                     gn = np1.gn;
                     p  = NounP3 (personPol np1.p)
                    } ;

  DetNPMasc det = {
    s  = \\role => let s = det.s ! False ! (AMasc Human) ! role
                   in case role of {
                        RObj c => linCase c det.p ++ s;
                        _      => s
                      } ;
    gn = gennum (AMasc Human) (numnnum det.nn);
    p  = NounP3 det.p
    } ;

  DetNPFem det = {
    s = \\role => let s = det.s ! False ! AFem ! role
                  in case role of {
                       RObj c => linCase c det.p ++ s;
                       _      => s
                     } ;
    gn = gennum AFem (numnnum det.nn);
    p = NounP3 det.p
    } ;

}

