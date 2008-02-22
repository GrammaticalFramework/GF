--# -path=.:../abstract:../common:../../prelude

--1 Bulgarian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResBul = ParamX ** open Prelude in {

  flags optimize=all ;

-- Some parameters, such as $Number$, are inherited from $ParamX$.

--2 For $Noun$

-- This is the worst-case $Case$ needed for pronouns.

  param
    Case = Nom | Acc ;

    NForm = 
        NF Number Species
      | NFSgDefNom
      | NFPlCount
      | NFVocative
      ;

    GenNum = GSg Gender | GPl ;

-- Agreement of $NP$ is a record. We'll add $Gender$ later.

  oper
    Agr = {gn : GenNum ; p : Person} ;

  param
    Gender = Masc | Fem | Neut ;
    
    Species = Indef | Def ;
 
-- The plural never makes a gender distinction.

--2 For $Verb$

    VForm = 
       VPres      Number Person
     | VAorist    Number Person
     | VImperfect Number Person
     | VPerfect    AForm
     | VPluPerfect AForm
     | VPassive    AForm
     | VPresPart   AForm
     | VImperative Number
     | VGerund
     ;

-- The order of sentence is needed already in $VP$.

    Order = ODir | OQuest ;

--2 For $Adjective$

    AForm = 
       ASg Gender Species
     | ASgMascDefNom
     | APl Species
     ;

--2 For $Numeral$

    DGender =
       DMasc
     | DMascPersonal
     | DFem
     | DNeut
     ;
    
    DGenderSpecies = 
       DMascIndef
     | DMascDef
     | DMascDefNom
     | DMascPersonalIndef
     | DMascPersonalDef
     | DMascPersonalDefNom
     | DFemIndef
     | DFemDef
     | DNeutIndef
     | DNeutDef
     ;

    CardOrd = NCard DGenderSpecies | NOrd AForm ;
    DForm = unit | teen | ten | hundred ;

--2 Transformations between parameter types

  oper
    gennum : DGender -> Number -> GenNum = \g,n ->
      case n of {
        Sg => GSg (case g of {
                     DMasc         => Masc ;
                     DMascPersonal => Masc ;
                     DFem          => Fem ;
                     DNeut         => Neut
                   }) ;
        Pl => GPl
        } ;

    numGenNum : GenNum -> Number = \gn -> 
      case gn of {
        GSg _  => Sg ;
        GPl    => Pl
      } ;

    aform : GenNum -> Species -> Case -> AForm = \gn,spec,c -> 
      case gn of {
        GSg g  => case <g,spec,c> of {
                    <Masc,Def,Nom> => ASgMascDefNom ;
                    _              => ASg g spec
                  } ;
        GPl    => APl spec
      } ;

    dgenderSpecies : DGender -> Species -> Case -> DGenderSpecies =
      \g,spec,c -> case <g,spec> of {
                     <DMasc,Indef> => DMascIndef ;
                     <DMasc,Def>   => case c of {
                                        Nom => DMascDefNom ;
                                        _   => DMascDef
                                      } ;
                     <DMascPersonal,Indef> => DMascPersonalIndef ;
                     <DMascPersonal,Def>   => case c of {
                                                Nom => DMascPersonalDefNom ;
                                                _   => DMascPersonalDef
                                              } ;
                     <DFem ,Indef> => DFemIndef ;
                     <DFem ,Def>   => DFemDef ;
                     <DNeut,Indef> => DNeutIndef ;
                     <DNeut,Def>   => DNeutDef
                   } ;

    nform2aform : NForm -> DGender -> AForm
      = \nf,g -> case nf of {
                   NF n spec  => aform (gennum g n) spec Acc ;
                   NFSgDefNom => aform (gennum g Sg) Def Nom ;
                   NFPlCount  => APl Indef ;
                   NFVocative => aform (gennum g Sg) Indef Acc
                 } ;

    indefNForm : NForm -> NForm
      = \nf -> case nf of {
                 NF n spec  => NF n  Indef ;
                 NFSgDefNom => NF Sg Indef ;
                 NFPlCount  => NFPlCount ;
                 NFVocative => NFVocative
               } ;

  oper
-- For $Verb$.

    Verb : Type = {
      s : VForm => Str ;
    } ;

    VP : Type = {
      s   : Tense => Anteriority => Polarity => Agr => Str ;
      imp : Polarity => Number => Str ;
      s2  : Agr => Str
    } ;

    predV : Verb -> VP =
      \verb -> 
        let pol : Polarity -> Str -> Str = \p,vf -> case p of { Pos => vf ; Neg => "не" ++ vf }
        in { s = \\t,a,p,agr => let present = verb.s ! (VPres   (numGenNum agr.gn) agr.p) ;
                                    aorist  = verb.s ! (VAorist (numGenNum agr.gn) agr.p) ;
                                    perfect = verb.s ! (VPerfect (aform agr.gn Indef Acc)) ;
                                    vf = case <t,a> of {
                                           <Pres,Simul> => present ;
                                           <Pres,Anter> => auxBe.s ! (VPres (numGenNum agr.gn) agr.p) ++ perfect ;
                                           <Past,Simul> => aorist ;
                                           <Past,Anter> => auxBe.s ! (VAorist (numGenNum agr.gn) agr.p) ++ perfect ;
                                           <Fut, Simul> => "ще" ++ present ;
                                           <Fut, Anter> => "ще" ++ auxBe.s ! (VPres (numGenNum agr.gn) agr.p) ++ perfect ;
                                           <Cond,Simul> => auxWould.s ! (VAorist (numGenNum agr.gn) agr.p) ++ perfect ;
                                           <Cond,Anter> => auxWould.s ! (VAorist (numGenNum agr.gn) agr.p) ++ auxBe.s ! (VPerfect (aform agr.gn Indef Acc)) ++ perfect
                                         } ;
                                in pol p vf ;
             imp = \\p,n => pol p (verb.s ! VImperative n) ;
             s2 = \\_ => []
           } ;

    insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
      s = vp.s ;
      imp = vp.imp ;
      s2 = \\a => vp.s2 ! a ++ obj ! a
      } ;

    auxBe : Verb = {
      s = table {
            VPres      Sg P1 => "съм" ; 
            VPres      Sg P2 => "си" ;
            VPres      Sg P3 => "е" ; 
            VPres      Pl P1 => "сме" ; 
            VPres      Pl P2 => "сте" ;
            VPres      Pl P3 => "са" ;
            VAorist    Sg P1 => "бях" ; 
            VAorist    Sg _  => "беше" ;
            VAorist    Pl P1 => "бяхме" ; 
            VAorist    Pl P2 => "бяхте" ;
            VAorist    Pl P3 => "бяха" ;
            VImperfect Sg P1 => "бях" ; 
            VImperfect Sg _  => "беше" ;
            VImperfect Pl P1 => "бяхме" ; 
            VImperfect Pl P2 => "бяхте" ;
            VImperfect Pl P3 => "бяха" ;
            VPerfect    aform => (regAdjective "бил").s ! aform ;
            VPluPerfect aform => (regAdjective "бил").s ! aform ;
            VPassive    aform => (regAdjective "бъден").s ! aform ;
            VPresPart   aform => (regAdjective "бъдещ").s ! aform ;
            VImperative Sg => "бъди" ;
            VImperative Pl => "бъдете" ;
            VGerund        => "бидейки"
          }
      } ;

    auxWould : Verb = {
      s = table {
            VPres      Sg P1 => "бъда" ; 
            VPres      Sg P2 => "бъдеш" ;
            VPres      Sg P3 => "бъде" ; 
            VPres      Pl P1 => "бъдем" ; 
            VPres      Pl P2 => "бъдете" ;
            VPres      Pl P3 => "бъдат" ;
            VAorist    Sg P1 => "бих" ; 
            VAorist    Sg _  => "би" ;
            VAorist    Pl P1 => "бихме" ; 
            VAorist    Pl P2 => "бихте" ;
            VAorist    Pl P3 => "биха" ;
            VImperfect Sg P1 => "бъдех" ; 
            VImperfect Sg _  => "бъдеше" ;
            VImperfect Pl P1 => "бъдехме" ; 
            VImperfect Pl P2 => "бъдехте" ;
            VImperfect Pl P3 => "бъдеха" ;
            VPerfect    aform => (regAdjective "бил").s ! aform ;
            VPluPerfect aform => (regAdjective "бъдел").s ! aform ;
            VPassive    aform => (regAdjective "бъден").s ! aform ;
            VPresPart   aform => (regAdjective "бъдещ").s ! aform ;
            VImperative Sg => "бъди" ;
            VImperative Pl => "бъдете" ;
            VGerund        => "бъдейки"
          }
      } ;

    ia2e : Str -> Str =           -- to be used when the next syllable has vowel different from "а","ъ","о" or "у"
      \s -> case s of {
              x@(_*+_) + "я" + y@(("б"|"в"|"г"|"д"|"ж"|"з"|"к"|"л"|"м"|"н"|"п"|"р"|"с"|"т"|"ф"|"х"|"ц"|"ч"|"ш"|"щ")*)
                => x+"e"+y;
              _ => s
            };

    mkAdjective : (_,_,_,_,_,_,_,_,_ : Str) -> {s : AForm => Str} = 
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
        }
      } ;

    regAdjective : Str -> {s : AForm => Str} = 
      \base -> mkAdjective base 
                           (base+"ия")
                           (base+"ият")
                           (base+"a")
                           (base+"ата")
                           (base+"о")
                           (base+"ото")
                           (ia2e base+"и")
                           (ia2e base+"ите") ;

    mkVerb : (_,_,_,_,_,_,_,_,_:Str) -> Verb = 
      \cheta,chete,chetoh,chetqh,chel,chetql,cheten,chetqst,cheti -> {
      s = table {
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
            VPluPerfect aform => (regAdjective chetql ).s ! aform ;
            VPassive    aform => (regAdjective cheten ).s ! aform ;
            VPresPart   aform => (regAdjective chetqst).s ! aform ;
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
    } ;  
    
-- For $Sentence$.

    Clause : Type = {
      s : Tense => Anteriority => Polarity => Order => Str
      } ;

    mkClause : Str -> Agr -> VP -> Clause =
      \subj,agr,vp -> {
        s = \\t,a,b,o => 
          let 
            verb  = vp.s ! t ! a ! b ! agr ;
            compl = vp.s2 ! agr
          in case o of {
              ODir   => subj ++ verb ++ compl ;
              OQuest => subj ++ verb ++ "ли" ++ compl
             }
      } ;
      
-- For $Numeral$.

    mkDigit : Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} =
      \dva, dvama, dve, vtori, dvesta ->
      {s = table {
             unit                  => mkCardOrd dva dvama dve vtori ;
             teen                  => mkCardOrd (dva+"надесет") (dva+"надесетима") (dva+"надесет") (dva+"надесети") ;
             ten                   => mkCardOrd (dva+"десет")   (dva+"десетима")   (dva+"десет")   (dva+"десети") ;
             hundred               => let dvesten : Str
                                                  = case dvesta of {
                                                      dvest+"а"        => dvest+"ен" ;
                                                      chetiristot+"ин" => chetiristot+"ен"
                                                    }
                                      in mkCardOrd dvesta dvesta dvesta dvesten
           }
      } ;

    mkCardOrd : Str -> Str -> Str -> Str -> CardOrd => Str =
      \dva, dvama, dve, vtori ->
               table {
                 NCard dg   => digitGenderSpecies dva dvama dve ! dg ;
                 NOrd aform => let vtora = init vtori + "а" ;
                                   vtoro = init vtori + "о"
                               in (mkAdjective vtori
                                               (vtori+"я")
                                               (vtori+"ят")
                                               vtora
                                               (vtora+"та")
                                               vtoro
                                               (vtoro+"то")
                                               vtori
                                               (vtori+"те")).s ! aform
               } ;

    digitGenderSpecies : Str -> Str -> Str -> DGenderSpecies => Str =
      \dva, dvama, dve
            -> let addDef : Str -> Str =
                     \s -> case s of {
		             dves+"та" => dves+"тате" ;
		             dv+"а"    => dv+"ата" ;
		             x         => x+"те"
                           }
               in table {
                    DMascIndef          => dva ;
                    DMascDef            => addDef dva ;
                    DMascDefNom         => addDef dva ;
                    DMascPersonalIndef  => dvama ;
                    DMascPersonalDef    => addDef dvama ;
                    DMascPersonalDefNom => addDef dvama ;
                    DFemIndef           => dve ;
                    DFemDef             => addDef dve ;
                    DNeutIndef          => dve ;
                    DNeutDef            => addDef dve
                  } ;

    mkIP : Str -> Str -> GenNum -> {s : Case => Str ; gn : GenNum} =
      \koi,kogo,gn -> {
      s = table {
            Nom => koi ;
            Acc => kogo
          } ;
      gn = gn
      } ;

    mkNP : (az,men,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite : Str) -> GenNum -> Person -> {s : Case => Str; gen : AForm => Str; a : Agr} =
      \az,men,moj,moia,moiat,moia_,moiata,moe,moeto,moi,moite,gn,p -> {
      s = table {
            Nom => az ;
            Acc => men           
          } ;
      gen = (mkAdjective moj moia moiat moia_ moiata moe moeto moi moite).s ;
      a = {
           gn = gn ;
           p = p
          }
      } ;

    mkQuestion : 
      {s : Str} -> Clause -> 
      {s : Tense => Anteriority => Polarity => QForm => Str} = \wh,cl ->
      {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p ;
                why = wh.s
            in table {
                 QDir   => why ++ cls ! OQuest ;
                 QIndir => why ++ cls ! ODir
               }
      } ;
}
