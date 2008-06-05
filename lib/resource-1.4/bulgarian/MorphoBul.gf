--# -path=.:../../prelude

--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoBul = ResBul ** open
  Predef,
  Prelude,
  CatBul
  in {

  flags optimize=all ;

oper
--2 Determiners

  mkDeterminerSg : Str -> Str -> Str -> {s : DGender => Role => Str; n : Number; countable : Bool ; spec : Species} = \vseki,vsiaka,vsiako ->
    {s = \\g,_ => table DGender [vseki;vseki;vsiaka;vsiako] ! g; n = Sg; countable = False; spec = Indef} ;
  mkDeterminerPl : Str -> {s : DGender => Role => Str ; n : Number; countable : Bool ; spec : Species} = \vsicki ->
    {s = \\_,_ => vsicki; n = Pl; countable = False; spec = Indef} ;

  mkQuant : Str -> Str -> Str -> Str -> {s : AForm => Str; spec : Species} = \tozi,tazi,towa,tezi -> {
    s = \\aform => case aform of {
                     ASg Masc _    => tozi ;
                     ASgMascDefNom => tozi ;
                     ASg Fem  _    => tazi ;
                     ASg Neut _    => towa ;
                     APl      _    => tezi
                   };
    spec = Indef
    } ;


--2 Verbs

  mkVerb : (_,_,_,_,_,_,_,_,_:Str) -> VTable = 
    \cheta,chete,chetoh,chetqh,chel,chetql,cheten,chetqst,cheti ->
        table {
          VPres      Sg P1 => cheta;
          VPres      Sg P2 => chete + "ш";
          VPres      Sg P3 => chete;
          VPres      Pl P1 => case chete of {
                                _ + ("а"|"я") => chete + "ме";
                                _             => chete + "м"
                              };
          VPres      Pl P2 => chete + "те";
          VPres      Pl P3 => case cheta of {
                                vika + "м" => case chete of {
                                                dad + "е" => dad + "ат";
                                                vika      => vika + "т"
                                              };
                                _          => cheta + "т"
                              };
          VAorist    Sg P1 => chetoh;
          VAorist    Sg _  => case chetoh of {
                                chet+"ох" => chete;
                                zova+ "х" => zova
                              };
          VAorist    Pl P1 => chetoh + "ме";
          VAorist    Pl P2 => chetoh + "те";
          VAorist    Pl P3 => chetoh + "а";
          VImperfect Sg P1 => chetqh;
          VImperfect Sg _  => case chete of {
	                        rabot + "и" => rabot + "eше";
	                        _           => chete + "ше"
                              };
          VImperfect Pl P1 => chetqh + "ме";
          VImperfect Pl P2 => chetqh + "те";
          VImperfect Pl P3 => chetqh + "а";
          VPerfect aform   =>let chel1 : Str =
                                   case chel of {
                                     pas+"ъл" => pas+"л";
                                     _        => chel
                                   }
                             in (mkAdjective chel
                                             (chel+"ия")
                                             (chel+"ият")
                                             (chel1+"a")
                                             (chel1+"ата")
                                             (chel1+"о")
                                             (chel1+"ото")
                                             (ia2e chel1+"и")
                                             (ia2e chel1+"ите")).s ! aform ;
          VPluPerfect aform => regAdjective chetql  ! aform ;
          VPassive    aform => regAdjective cheten  ! aform ;
          VPresPart   aform => regAdjective chetqst ! aform ;
          VImperative Sg => cheti;
          VImperative Pl => case cheti of {
	                      chet + "и" => chet + "ете";
	                      ela        => ela  + "те"
                            };
          VGerund => case chete of {
                       rabot + "и" => rabot + "ейки";
                       _           => chete + "йки"
                     }
        } ;


--2 Nouns

  mkNoun : Str -> Str -> Str -> Str -> DGender -> N = \sg,pl,count,voc,g -> {
    s = table {
          NF Sg Indef => sg ;
          NF Sg Def   => case sg of {
                           _+"а"=>sg+"та" ;
                           _+"я"=>sg+"та" ;
                           _+"о"=>sg+"то" ;
                           _+"е"=>sg+"то" ;
                           _+"и"=>sg+"то" ;
                           s+"й"=>s +"я"  ;
                           _+("тел"|"ар"|"яр"|"ден"
                             |"път"|"огън"|"сън"
                             |"кон"|"крал"|"цар"
                             |"зет"|"лакът"|"нокът")
                                =>sg +"я" ;
                           _    =>case g of {
                                    DFem => sg+"та" ;
                                    _    => sg+"а"
                                  }
                         } ;
          NF Pl Indef => pl ;
          NF Pl Def   => case pl of {
                           _+"а"=>pl+"та" ;
                           _+"е"=>pl+"те" ;
                           _+"и"=>pl+"те" ;
                           s+"я"=>s +"та" ;
                           s    =>s +"те"
                         } ;
          NFSgDefNom  => case sg of {
                           _+"а"=>sg+"та" ;
                           _+"я"=>sg+"та" ;
                           _+"о"=>sg+"то" ;
                           _+"е"=>sg+"то" ;
                           _+"и"=>sg+"то" ;
                           s+"й"=>s +"ят" ;
                           _+("тел"|"ар"|"яр"|"ден"
                             |"път"|"огън"|"сън"
                             |"кон"|"крал"|"цар"
                             |"зет"|"лакът"|"нокът")
                                =>sg+"ят" ;
                           _    =>case g of {
                                    DFem => sg+"та" ;
                                    _    => sg+"ът"
                                  }
                         } ;
          NFPlCount   => count ;
          NFVocative  => voc
        } ;
    g = g ;
    lock_N = <>
    } ;


--2 Adjectives
    
  mkAdjective : (_,_,_,_,_,_,_,_,_ : Str) -> A = 
          \dobyr,dobria,dobriat,dobra,dobrata,dobro,dobroto,dobri,dobrite -> {
    s = table {
          ASg Masc Indef => dobyr ;
          ASg Masc Def   => dobria ;
          ASgMascDefNom  => dobriat ;
          ASg Fem  Indef => dobra ;
          ASg Fem  Def   => dobrata ;
          ASg Neut Indef => dobro ;
          ASg Neut Def   => dobroto ;
          APl Indef      => dobri ;
          APl Def        => dobrite
        } ;
    lock_A = <>
    } ;
}