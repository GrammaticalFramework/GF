--# -path=.:../abstract:../common:../../prelude

concrete NounTur of Noun = CatTur ** open ResTur, SuffixTur, HarmonyTur, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s =
        case det.useGen of {
          NoGen => \\c => det.s ++ cn.s ! det.n ! c ;
          YesGen a => \\c => det.s ++ cn.gen ! det.n ! a ;
          UseIndef => \\c => det.s ++ cn.s ! det.n ! Nom
        } ;
      a = agrP3 det.n
      } ;

    UsePron p = p ;

    -- TODO: look further into how correct this is.
    UsePN pn = { s = \\c => pn.s ! Sg ! c; a = {n = Sg; p = P1}} ;

    PossPron p = {s = []; useGen = YesGen p.a} ;

    DetQuant quant num = {
      s  = quant.s ++ num.s ! Sg ! Nom ;
      n  = num.n;
      useGen = quant.useGen
    } ;

    DetQuantOrd quant num o = {
      s  = quant.s ++ num.s ! Sg ! Nom ++ o.s ! num.n ! Nom ;
      n  = num.n;
      useGen = quant.useGen
    } ;

    NumSg = {s = \\num,c => []; n = Sg} ;
    NumPl = {s = \\num,c => []; n = Pl} ;

    NumCard n = n ** {n = Sg} ;

    NumNumeral numeral = {s = numeral.s ! NCard} ;

    OrdDigits  dig = {s = \\c => dig.s ! NOrd ! c} ;
    OrdNumeral num = {s = \\c => num.s ! NOrd ! c} ;
    OrdSuperl  a = {s = \\n,c => "en" ++ a.s ! n ! c} ;

    DefArt = {s = []; useGen = NoGen} ;
    IndefArt = {s = []; useGen = UseIndef} ;

    UseN n = n ;

    UseN2 n = n;

    MassNP cn = { s = cn.s ! Sg; a = { n = Sg; p = P1 } } ;

    ComplN2 f x =
      let
        h : Harmony = {vow = f.harmony.vow; con = f.harmony.con}
      in
        case f.c.c of {
          Nom => {
            s = \\n, c => x.s ! Gen ++ f.s ! n ! Acc;
            gen = \\_, _ => "TODO"
          };
          Acc => {s = \\_,_ => "TODO"; gen = \\_, _ => "TODO"};
          Gen => {
            s =
              \\n, c =>
                x.s ! Gen ++ f.gen ! n ! {n = Sg; p = P3}
                ++ BIND ++ (caseSuffixes ! c).st ! h.con ! h.vow;
            gen = \\_, _ => "TODO"
          };
          Dat => {
            s = \\n, c =>
              x.s ! Gen ++ f.gen ! n ! {n = Sg; p = P3}
                ++ datSuffixN.st ! h.con ! h.vow;
            gen = \\_, _ => "TODO"
          };
          Loc => {s = \\_,_ => "TODO"; gen = \\_, _ => "TODO"};
          Ablat => {s = \\_,_ => "TODO"; gen = \\_, _ => "TODO"};
          Abess _ => {s = \\_,_ => "TODO"; gen = \\_, _ => "TODO"}
        };


    AdjCN ap cn = {
      s = \\n,c => ap.s ! Sg ! Nom ++ cn.s ! n ! c;
      gen = \\n, a => ap.s ! Sg ! Nom ++ cn.gen ! n ! a
      } ;

    -- lin CN = {s : Number => Case => Str; gen : Number => Agr => Str} ;
    AdvCN cn adv = {
      s = \\n, c => adv.s ++ cn.s ! n ! c;
      gen = \\n, a => adv.s ++ cn.gen ! n ! a
    } ;

    AdvNP np adv = {
      s = \\c => adv.s ++ np.s ! c;
      a = np.a
    } ;
}
