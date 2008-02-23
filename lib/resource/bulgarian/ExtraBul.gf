concrete ExtraBul of ExtraBulAbs = CatBul ** 
  open ResBul, Coordination, Prelude in {

  lin
    GenNP np = {s = \\gn => np.s ! Gen (aform gn Def Nom); spec=Indef} ;
    
    GenNPIndef np = {s = \\gn => np.s ! Gen (aform gn Indef Nom); spec=Indef} ;
    
    i8fem_Pron  = mkPron "аз" "мен" "ми" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Fem)  P1 ;
    i8neut_Pron = mkPron "аз" "мен" "ми" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Neut) P1 ;
    
    whatSg8fem_IP  = mkIP "каква" "каква" (GSg Fem) ;
    whatSg8neut_IP = mkIP "какво" "какво" (GSg Neut) ;

    whoSg8fem_IP  = mkIP "коя" "кого" (GSg Fem) ;
    whoSg8neut_IP = mkIP "кое" "кого" (GSg Neut) ;
    
    youSg8fem_Pron  = mkPron "ти" "теб" "ти" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Fem) P2 ;
    youSg8neut_Pron = mkPron "ти" "теб" "ти" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Neut) P2 ;
    
    youPol8fem_Pron  = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" (GSg Fem) P2 ;
    youPol8neut_Pron = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" (GSg Neut) P2 ;

    onePl_Num = {s = table {
                       DMascIndef | DMascPersonalIndef | DFemIndef | DNeutIndef                             => "едни" ;
                       DMascDef | DMascDefNom | DMascPersonalDef | DMascPersonalDefNom | DFemDef | DNeutDef => "едните"
                     } ;
                 n = Pl;
                 empty = False
                } ;

    UttImpSg8fem  pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Fem} ;
    UttImpSg8neut pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Fem} ;
} 
