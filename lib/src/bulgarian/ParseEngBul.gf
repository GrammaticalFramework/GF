--# -path=alltenses:../english
concrete ParseEngBul of ParseEngAbs = 
  TenseX - [IAdv, CAdv],
  CatBul,
  NounBul - [PPartNP],
  AdjectiveBul,
  NumeralBul,
  SymbolBul [PN, Symb, MkSymb, SymbPN],
  ConjunctionBul,
  VerbBul - [SlashV2V, PassV2, UseCopula],
  AdverbBul,
  PhraseBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  IdiomBul [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraBul [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV],

  DictEngBul ** 
open ResBul, Prelude in {

flags
  literal=Symb ;

lin
  GerundN v = {
    s = \\nform => v.s ! Imperf ! VNoun nform ;
    g = ANeut
  } ;
  
  GerundAP v = {
    s = \\aform => v.s ! Imperf ! VPresPart aform ;
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

  PPartNP np vps = {
      s = \\c => np.s ! c ++ 
                 vps.s ! Perf ! VPassive (aform np.a.gn Indef c) ++
                 vps.compl1 ! np.a ++ vps.compl2 ! np.a;
      a = np.a
      } ;

  SlashV2V vv p vp =
      insertSlashObj2 (daComplex vp ! Perf) (slashV vv vv.c2) ;

}
