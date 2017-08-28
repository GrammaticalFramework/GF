resource AditzTrinkoak = open Prelude, Predef, ParamEus in {

-- Synthetic verbs are in this module

-- I have not implemented allocutive forms. 
-- For that I'd have to keep track of up to S whether there is somewhere a familiar 2nd person
-- (e.g. "I am afraid of you/your mother"; "You(r mother) is nice", "I gave an apple to you(r mother)"), 
-- and that affects the verb form of a main clause, regardless who is subject/object there.

oper

    VForms : Type = { indep : Str ; stem : Str } ;

    noVForm : VForms = { indep = Prelude.nonExist ; stem = Prelude.nonExist } ;

    -- Obs. this is pretty rough heuristic, use 2-argument version for good results
    mkVForms = overload {
      mkVForms : Str -> VForms = \du ->
        let due : Str = case du of {
            _ + "en"          => init du ;        -- zen / zen
            _ + "gu"          => du ;             -- dugu / dugu+la
            _ + "u"           => du + "e" ;       -- du / due+n
            _ + "z"           => du + "e" ;       -- naiz / naize+n
            _ + "un"          => du + "a" ;       -- dun / duna+la   
            _ + "uk"          => init du + "a" ;  -- duk / dua+la
            x + "t"           => x + "da" ;       -- dut / duda+n
            _ + "r"           => du + "re" ;      -- dator / datorre+n
         -- _ + ("e"|"i"|"o"|"a") 
         --                   => du ;             -- dio / dio+n

         -- _                 => du + "e" }      
            _                 => du }       
        in { indep = du ; stem = due } ;

      mkVForms : (_,_ : Str) -> VForms = \dut,duda ->
        { indep = dut ; stem = duda } ;
    } ;

    IntransV : Type = Tense => Agr => VForms ;  -- Agr = nori or nork
    TransV   : Type = Agr => IntransV ;         -- Agr = nor 
    DitransV : Type = Agr => TransV ;           -- Agr = nori

------------------------------------------------------------------------------

  syntIntransVerb : AuxType -> IntransV = \val ->
    case val of {
      Da Izan  => izanDa ;
      Da Egon  => egonDa ;
      Da Joan  => joanDa ;
      Da Ibili => ibiliDa ;
      Da Etorri => etorriDa ;
      _         => Predef.error "Not an intransitive verb"
    } ;

  syntTransVerb : AuxType -> TransV = \val ->
    case val of {
      Du Ukan  => ukanDu ;
      Du Jakin => jakinDu ;
      Du Eduki => edukiDu ;
      Zaio     => ukanZaio ;
      _        => Predef.error "Not a transitive verb"
    } ;

------------------------------------------------------------------------------
-- General building blocks for the forms of ukan
-- All thanks to https://upload.wikimedia.org/wikipedia/commons/3/36/Nor_Nori_Nork_taula_osoa.png

  norkUkanFirst : Agr => Str = table { -- Past, pot, cond etc.
    Ni   => "n" ; Gu => "gen" ;
    Hi _ => "h" ; 
    Zu => "zen" ; Zuek => "zen" ;
    Hau  => "z" ; Hauek => "z" } ;

  norkUkanLast : Agr => Str = table {
    Ni      => "t" ;  Gu      => "gu" ;
    Hi Masc => "k" ;  Hi Fem  => "n" ;
    Zu      => "zu" ; Zuek    => "zue" ;
    Hau     => [] ;   Hauek   => "te" } ;

  norkUkanMid : Agr => Str = table {
    Hi Masc => "a" ;  Hi Fem  => "na" ;
    Ni => "da" ; x => norkUkanLast ! x } ;

  noriUkanLast : Agr => Str = table {
    Hau => "o" ; x => norkUkanLast ! x } ;

  noriUkanMid : Agr => Str = table {
    Hau => "o" ; Hauek => "e" ; 
    x => norkUkanMid ! x } ;

  norUkanPres : Agr => Str = table {
    Ni   => "nau" ; Gu => "gaitu" ;
    Hi _ => "hau" ; 
    Zu => "zaitu" ; Zuek => "zaituzte" ;
    Hau  => "du"  ; Hauek => "ditu" } ;

  norUkanNonpres : Agr => Str = table {
    Ni => "nindu" ; Gu => "gintu" ;
    Hi _ => "hindu" ; 
    Zu => "zintu" ; Zuek => "zintuzte" ;
    Hau => nonExist ; Hauek => nonExist } ; -- formed separately

  norUkanCond : Agr => Str = table {
    Zuek => "zintu" ; x => norUkanNonpres ! x } ;

{-
  =============================================================================
  Izan [NOR]
  =============================================================================
-}

    -- common copula
    izanDa : IntransV =
      table {Past => table {Ni => mkVForms "nintzen" ; 
                            Hi _ => mkVForms "hintzen" ; 
                            Zu => mkVForms "zinen" ; 
                            Hau => mkVForms "zen" ; 
                            Gu => mkVForms "ginen" ; 
                            Zuek => mkVForms "zineten" ; 
                            Hauek => mkVForms "ziren" } ;

             Cond => table {Ni => mkVForms "nintzateke" ; 
                            Hi _ => mkVForms "hintzateke" ; 
                            Zu => mkVForms "zinateke" ; 
                            Hau => mkVForms "litzateke" ; 
                            Gu => mkVForms "ginateke" ; 
                            Zuek => mkVForms "zinatekete" ; 
                            Hauek => mkVForms "lirateke" } ;
             -- Present and future are identical
	           _     => table {Ni => mkVForms "naiz" ; 
                             Hi _ => mkVForms "haiz" ; 
                             Zu => mkVForms "zara" "zare" ; 
                             Hau => mkVForms "da" "de" ; 
                             Gu => mkVForms "gara" "gare" ; 
                             Zuek => mkVForms "zarete" ; 
                             Hauek => mkVForms "dira" "dire" }
       } ;

{-
  =============================================================================
  Ukan [NOR] [NORK]
  =============================================================================
-}

  ukanDu : TransV = \\nor,tns,nork => mkVForms (
    case tns of {
      Past => 
        case nor of { -- Special forms for past when nor is Hau or Hauek
          Hau   => norkPast_norHau ! nork ;
          Hauek => norkPast_norHauek ! nork ;
          _     => let nindu : Str = norPast ! nor ;
                       te    : Str = norkPast ! nork ;
                    in nindu + te + "n" } ;

      Cond => 
        case nor of { -- Special forms for conditional when nor is Hau or Hauek
          Hau   => norkCond_norHau ! nork ;
          Hauek => norkCond_norHauek ! nork ;

          _     => let gintu : Str = norCond ! nor ;
                       z     : Str = norCondZ ! nor ;
                       te    : Str = norkCond ! nork ;
                    in gintu + z + "ke" + te } ;

      pres => let gaitu : Str = norPres ! nor ;
                  zte   : Str = norkPres ! nork ;
               in gaitu + zte  

     }) where {

      norkCond : Agr => Str = \\nork => case <nor,nork> of {
        <Zuek,y> => "te" + norkUkanLast ! y ;  -- zintu z ke te t
        <_,x>    => norkUkanLast ! x } ;

      norkPres : Agr => Str = \\nork => case <nor,nork> of {
        <Gu,Hauek>    => "zte" ; -- If Nork is Hauek and Nor is plural,
        <Zu,Hauek>    => "zte" ; -- the morpheme "te" changes into "zte"
        <Hauek,Hauek> => "zte" ;
        <_,x>         => norkUkanLast ! x } ; 

      norkPast : Agr => Str = \\nork => case <nor,nork> of {
        <Zuek,Hau> => "" ; 
        <_,Hau>    => "e" ;
        <Gu,Hauek>    => "zte" ;
        <Zu,Hauek>    => "zte" ;
        <Hauek,Hauek> => "zte" ;
        <_,x>      => norkUkanMid ! x } ;

      norPres : Agr => Str = norUkanPres ;    
      
      norPast : Agr => Str = norUkanNonpres ;

      norCond : Agr => Str = norUkanCond ;

      norCondZ : Agr => Str = table { 
        (Gu|Zu|Zuek) => "z" ; _ => [] } ;

      norkPast_norHau = table { Ni => "nuen" ; Gu => "genuen" ;
                                Hi _ => "huen" ;        
                                Zu => "zenuen" ; Zuek => "zenuten" ;
                                Hau => "zuen" ; Hauek => "zuten" } ;

      norkPast_norHauek = table { Ni => "nituen" ; Gu => "genituen" ;
                                  Hi _ => "hituen" ;
                                  Zu => "zenituen" ; Zuek => "zenituzten" ;
                                  Hau => "zituen" ; Hauek => "zituzten" } ;

      norkCond_norHau = table { Hi _ => "hinduke" ; Zuek => "zenukete" ; 
                                Hau => "luke" ; Hauek => "lukete" ; 
                                x => (tk 2 (norkPast_norHau ! x)) + "ke" } ; -- zu+en -> nu+ke

      norkCond_norHauek = table { Hi _ => "hindukete" ; Zuek => "zenituzkete" ;
                                  Hau => "lituzke" ;  Hauek => "lituzkete" ; 
                                  x => (tk 2 (norkPast_norHauek ! x)) + "zke" } --nitu+en -> nitu+zke
  } ;


{-
  =============================================================================
  Ukan [NOR] [NORI]
  =============================================================================
-}


  ukanZaio : TransV = table {   --TODO: add all forms
     -- Nori,Nor
      Hau   => table { 
                 Pres => table {
                          Ni => mkVForms "zait" ;
                          Hi Fem => mkVForms "zain" ; 
                          Hi Masc => mkVForms "zaik" ; 
                          Zu => mkVForms "zaizu" ;
                          Hau => mkVForms "zaio" ;
                          Gu => mkVForms "zaigu" ;
                          Zuek => mkVForms "zaizue" ;
                          Hauek => mkVForms "zaie" 
                        } ;
                 _    => \\agr => noVForm 
               } ;
      Hauek => table {
                 Pres => table {
                           Ni => mkVForms "zaizkit" ;
                           Hi Fem => mkVForms "zaizkin" ;
                           Hi Masc => mkVForms "zaizkik" ;
                           Zu => mkVForms "zaizkizu" ;
                           Hau => mkVForms "zaizkio" ;
                           Gu => mkVForms "zaizkigu" ;
                           Zuek => mkVForms "zaizkizue" ;
                           Hauek => mkVForms "zaizkie" 
                        } ;
                 _    => \\agr => noVForm 
               } ;
      _     => table { 
                 tns => table {
                           agr => noVForm 
                        }
               }
  } where {
    -- For Nor-Nori inflection, map from Agr to prefix morpheme in Nor position
    norTableZaio : Agr => Str =
      table { Ni    => "na" ;
              Hi _  => "ha" ;
              Gu    => "ga" ;
              Zu    => "za" ;
              Zuek  => "za" ;
              _     => []  --Hau and Hauek
            } 
  } ;


{-
  =============================================================================
  Ukan [NOR] [NORI] [NORK]
  =============================================================================
-}

  ukanDio : DitransV =  -- TODO test properly /IL 2017-07
   \\nori,nor,tns,nork => mkVForms (
    case tns of {
      Cond => "TODO:conditional" ;
      Past => let zen = norkPast ! nork ;
                  izki = norPast ! getNum nor ;
                  da = noriPast ! nori ;
                  te = norkPastTe ! nork ;
               in zen + izki + da + te + "n" ;

      _    => let dizki = norPres ! getNum nor ;
                  da    = noriPres ! nori ; --form of nori depends on nork
                  zue   = norkPres ! nork 
               in dizki + da + zue })

   where { 
    -- Map from Number to prefix morpheme in Nor position.
    -- Specific to Nor-Nori-Nork, different forms in other auxiliaries.
    norPres : Number => Str = table { Sg => "di" ;
                                      Pl => "dizki" } ;
    norPast : Number => Str = \\tns => drop 1 (norPres ! tns) ;

    ------
    -- Map from Agr to morpheme in Nori position.

    noriPres : Agr => Str = \\nori => case <nork,nori> of {
      <Hau,Ni> => "t" ; -- If nork is Hau, then the form ends in "t"
      <_,x>    => noriUkanMid ! x } ;

    noriPast : Agr => Str = noriUkanMid ;

    ------
    -- Map from Agr to morpheme in Nork position            
    norkPres : Agr => Str = norkUkanLast ;

    norkPast : Agr => Str = norkUkanFirst ;

    norkPastTe : Agr => Str = table { 
      (Zuek|Hauek) => "te" ; _ => [] } 

  } ;

{-
  =============================================================================
  Egon
  =============================================================================
-}
    -- stative copula, like Spanish estar
  egonDa : IntransV =
    table { Past => table {
                     Ni => mkVForms "nengoen" ; 
                     Hi _ => mkVForms "hengoen" ; 
                     Zu => mkVForms "zeunden" ; 
                     Hau => mkVForms "zegoen" ; 
                     Gu => mkVForms "geunden" ; 
                     Zuek => mkVForms "zeundeten" ; 
                     Hauek => mkVForms "zeuden" } ;
	           _ =>  table {
                     Ni => mkVForms "nago" ; 
                     Hi _ => mkVForms "hago" ; 
                     Zu => mkVForms "zaude" ; 
                     Hau => mkVForms "dago" ; 
                     Gu => mkVForms "gaude" ; 
                     Zuek => mkVForms "zaudete" ; 
                     Hauek => mkVForms "daude" }
          } ;


{-
  =============================================================================
  Eduki
  =============================================================================
-}

   edukiDu : TransV = table {
       -- Nor,Nork
              Ni => table {
                    Pres => table {
                              Gu => noVForm ;
                              Hauek => mkVForms "naukate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "naukazue" ;
                              Hau => mkVForms "nauka" ;
                              Hi Masc => mkVForms "naukak" ;
                              Hi Fem  => mkVForms "naukan" ;
                              Zu => mkVForms "naukazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 

              } ;
              Gu => table {
                    Pres => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gauzkate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gauzkazue" ;
                              Hau => mkVForms "gauzka" ;
                              Hi _ => noVForm ;
                              Zu => mkVForms "gauzkazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Hauek => table {
                    Pres => table { -- Pres
                              Gu => mkVForms "dauzkagu" ;
                              Hauek => mkVForms "dauzkate" ;
                              Ni => mkVForms "dauzkat" ;
                              Zuek => mkVForms "dauzkazue" ;
                              Hau => mkVForms "dauzka" ;
                              Hi Masc => mkVForms "dauzkak" ; 
                              Hi Fem => mkVForms "dauzkan" ;
                              Zu => mkVForms "dauzkazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Zuek => table {
                    Pres => table { 
                              Gu => mkVForms "zauzkategu" ;
                              Hauek => mkVForms "zauzkatete" ;
                              Ni => mkVForms "zauzkatet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzkate" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr
              } ;
              Hau => table {
                    Pres => table { 
                              Gu => mkVForms "daukagu" ;
                              Hauek => mkVForms "daukate" ;
                              Ni => mkVForms "daukat" ;
                              Zuek => mkVForms "daukazue" ;
                              Hau => mkVForms "dauka" ;
                              Hi Masc => mkVForms "daukak" ; 
                              Hi Fem => mkVForms "daukan" ;
                              Zu => mkVForms "daukazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Hi _ => table {
                    Pres => table { 
                              Gu => mkVForms "haukagu" ;
                              Hauek => mkVForms "haukate" ;
                              Ni => mkVForms "haukat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hauka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Zu => table {
                    Pres => table { 
                              Gu => mkVForms "zauzkagu" ;
                              Hauek => noVForm ;
                              Ni => mkVForms "zauzkat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              }
   } ;

{-
  =============================================================================
  Etorri 
  =============================================================================
-}

  etorriDa : IntransV = 
    \\tns,subjAgr => 
      case <tns,subjAgr> of {
        <Pres,Ni>    => mkVForms "nator" ;
        <Pres,Hi _>  => mkVForms "hator" ;
        <Pres,Zu>    => mkVForms "zatoz" ;
        <Pres,Hau>   => mkVForms "dator" ;
        <Pres,Gu>    => mkVForms "gatoz" ;
        <Pres,Zuek>  => mkVForms "zatozte" ;
        <Pres,Hauek> => mkVForms "datoz" ;
        _            => izanDa ! tns ! subjAgr 
      } ;

{-
  =============================================================================
  Joan
  =============================================================================
-}
  joanDa : IntransV = 
    \\tns,subjAgr => 
      case <tns,subjAgr> of {
        <Pres,Ni>    => mkVForms "noa" ;
        <Pres,Hi _>  => mkVForms "hoa" ;
        <Pres,Zu>    => mkVForms "zoaz" ;
        <Pres,Hau>   => mkVForms "doa" ;
        <Pres,Gu>    => mkVForms "goaz" ;
        <Pres,Zuek>  => mkVForms "zoazte" ;
        <Pres,Hauek> => mkVForms "doaz" ;
        <Past,Ni>    => mkVForms "nindoan" ;
        <Past,Hi _>  => mkVForms "hindoan" ;
        <Past,Zu>    => mkVForms "zindoazen" ;
        <Past,Hau>   => mkVForms "zihoan" ;
        <Past,Gu>    => mkVForms "gindoazen" ;
        <Past,Zuek>  => mkVForms "zindoazten" ;
        <Past,Hauek> => mkVForms "zihoazen" ;

        _            => izanDa ! tns ! subjAgr 
      } ;



{-
  =============================================================================
  Ekarri 
  =============================================================================
-}

{-
  =============================================================================
  Ibili
  =============================================================================
-}


  ibiliDa : IntransV =    --TODO: check forms
    table {
        Past => table {
                    Ni => mkVForms "nenbilen" ; 
                    Hi _ => mkVForms "henbilen" ; 
                    Zu => mkVForms "zenbiltzan" ; 
                    Hau => mkVForms "zebilen" ; 
                    Gu => mkVForms "genbiltzan" ; 
                    Zuek => mkVForms "zenbiltzaten" ; 
                    Hauek => mkVForms "zebiltzan" } ;

             -- Present and future are identical
        Cond => table {
                    Ni => mkVForms "nenbilke" ; 
                    Hi _ => mkVForms "henbilke" ; 
                    Zu => mkVForms "zenbilzke" ; 
                    Hau => mkVForms "lebilke" ; 
                    Gu => mkVForms "genbiltzke" ; 
                    Zuek => mkVForms "zenbiltzketen" ; 
                    Hauek => mkVForms "lebilzke" } ;

        Pres => table {
                    Ni => mkVForms "nabil" ; 
                    Hi _ => mkVForms "habil" ; 
                    Zu => mkVForms "zabiltza" ; 
                    Hau => mkVForms "dabil" ; 
                    Gu => mkVForms "gabiltza" ; 
                    Zuek => mkVForms "zabiltzate" ; 
                    Hauek => mkVForms "dabiltza" } ;
        Fut => izanDa ! Fut 
       } ;


{-
  =============================================================================
  Jakin
  =============================================================================
-}
  jakinDu : TransV = 
    \\dobjAgr,tns,subjAgr => 
      case <dobjAgr,tns,subjAgr> of {
        <Hau,Pres,Ni>    => mkVForms "dakit" ;
        <Hau,Pres,Zu>    => mkVForms "dakizu" ;
        <Hau,Pres,Hau>   => mkVForms "daki" ;
        <Hau,Pres,Gu>    => mkVForms "dakigu" ;
        <Hau,Pres,Zuek>  => mkVForms "dakizue" ;
        <Hau,Pres,Hauek> => mkVForms "dakite" ;

        <Hau,Past,Ni>    => mkVForms "nekien" ;
        <Hau,Past,Zu>    => mkVForms "zenekien" ;
        <Hau,Past,Hau>   => mkVForms "zekien" ;
        <Hau,Past,Gu>    => mkVForms "genekien" ;
        <Hau,Past,Zuek>  => mkVForms "zenekiten" ;
        <Hau,Past,Hauek> => mkVForms "zekiten" ;

        _                => ukanDu ! dobjAgr ! tns ! subjAgr 
      } ;



{-
  =============================================================================
  Ibili
  =============================================================================
-}

{-
  =============================================================================
  Eman
  =============================================================================
-}

{-
  =============================================================================
  Esan
  =============================================================================
-}

{-
  =============================================================================
  Ikusi
  =============================================================================
-}

{-
  =============================================================================
  Erabili
  =============================================================================
-}

{-
  =============================================================================
  Egin
  =============================================================================
-}

}