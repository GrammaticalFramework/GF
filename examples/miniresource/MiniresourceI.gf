incomplete concrete MiniresourceI of Miniresource = open Grammar, Lexicon in {

-- module Grammar in GF book, Chapter 9: syntax and structural words

  lincat
    S = Grammar.S ; 
    Cl = Grammar.Cl ; 
    NP = Grammar.NP ; 
    VP = Grammar.VP ; 
    AP = Grammar.AP ; 
    CN = Grammar.CN ; 
    Det = Grammar.Det ; 
    N = Grammar.N ; 
    A = Grammar.A ; 
    V = Grammar.V ; 
    V2 = Grammar.V2 ; 
    AdA = Grammar.AdA ; 
    Tense = Grammar.Temp ; 
    Pol = Grammar.Pol ;
    Conj = Grammar.Conj ;
  lin
    UseCl = Grammar.UseCl ;
    PredVP = Grammar.PredVP ;
    ComplV2 v np = Grammar.ComplSlash (Grammar.SlashV2a v) np ;
    DetCN = Grammar.DetCN ;
    ModCN = Grammar.AdjCN ;

    CompAP ap = Grammar.UseComp (Grammar.CompAP ap) ;
    AdAP = Grammar.AdAP ;

    ConjS c x y = Grammar.ConjS c (Grammar.BaseS x y) ;
    ConjNP c x y = Grammar.ConjNP c (Grammar.BaseNP x y) ;

    UseV = Grammar.UseV ;
    UseN = Grammar.UseN ;
    UseA = Grammar.PositA ;

    a_Det = Grammar.DetQuant Grammar.IndefArt Grammar.NumSg ; 
    the_Det = Grammar.DetQuant Grammar.DefArt Grammar.NumSg ; 
    every_Det = Grammar.every_Det ;
    this_Det  = Grammar.DetQuant Grammar.this_Quant Grammar.NumSg ; 
    these_Det = Grammar.DetQuant Grammar.this_Quant Grammar.NumPl ; 
    that_Det  = Grammar.DetQuant Grammar.that_Quant Grammar.NumSg ; 
    those_Det = Grammar.DetQuant Grammar.that_Quant Grammar.NumPl  ; 
    i_NP = Grammar.UsePron Grammar.i_Pron ;
    youSg_NP = Grammar.UsePron Grammar.youSg_Pron ;
    he_NP = Grammar.UsePron Grammar.he_Pron ;
    she_NP = Grammar.UsePron Grammar.she_Pron ;
    we_NP = Grammar.UsePron Grammar.we_Pron ;
    youPl_NP = Grammar.UsePron Grammar.youPl_Pron ;
    they_NP = Grammar.UsePron Grammar.they_Pron ;
    very_AdA = Grammar.very_AdA ;

    Pos = Grammar.PPos ;
    Neg = Grammar.PNeg ;
    Pres = Grammar.TTAnt Grammar.TPres Grammar.ASimul ;
    Perf = Grammar.TTAnt Grammar.TPres Grammar.AAnter ;

    and_Conj = Grammar.and_Conj ;
    or_Conj = Grammar.or_Conj ;

-- module Test: content word lexicon for testing

    man_N = Lexicon.man_N ;
    woman_N = Lexicon.woman_N ;
    house_N = Lexicon.house_N ;
    tree_N = Lexicon.tree_N ;
    big_A = Lexicon.big_A ;
    small_A = Lexicon.small_A ;
    green_A = Lexicon.green_A ;
    walk_V = Lexicon.walk_V ;
    arrive_V = Lexicon.come_V ;  -----
    love_V2 = Lexicon.love_V2 ;
    please_V2 = Lexicon.hear_V2 ; ----

}
