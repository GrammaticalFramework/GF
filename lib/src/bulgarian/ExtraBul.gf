concrete ExtraBul of ExtraBulAbs = CatBul ** 
  open ResBul, Coordination, Prelude in {
  flags coding=cp1251 ;


  lin
    PossIndefPron p = {
      s = \\_,aform => p.gen ! (indefAForm ! aform) ;
      nonEmpty = True;
      spec = Indef
      } ;
      
    ReflQuant = {
      s = \\_,aform => reflPron ! aform ;
      nonEmpty = True;
      spec = Indef
    } ;

    ReflIndefQuant = {
      s = \\_,aform => reflPron ! (indefAForm ! aform) ;
      nonEmpty = True;
      spec = Indef
    } ;

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
                       CFMasc Indef _ | CFFem Indef | CFNeut Indef            => "едни" ;
                       CFMasc Def _ | CFMascDefNom _ | CFFem Def | CFNeut Def => "едните"
                     } ;
                 n = Pl;
                 nonEmpty = True
                } ;

    UttImpSg8fem  pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Fem} ;
    UttImpSg8neut pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Fem} ;
    
  oper
    reflPron : AForm => Str =
      table {
        ASg Masc Indef => "свой" ;
        ASg Masc Def   => "своя" ;
        ASgMascDefNom  => "своят" ;
        ASg Fem  Indef => "своя" ;
        ASg Fem  Def   => "своята" ;
        ASg Neut Indef => "свое" ;
        ASg Neut Def   => "своето" ;
        APl Indef      => "свои" ;
        APl Def        => "своите"
      } ;
      
    indefAForm : AForm => AForm =
      table {
        ASg g _       => ASg g Indef ;
        ASgMascDefNom => ASg Masc Indef ;
        APl _         => APl Indef
      } ;
} 
