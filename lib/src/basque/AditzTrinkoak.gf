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
            _ + "en"          => init du ;        -- zen / ze+la
            _ + "on"          => init du ;        -- zitzaion / zitzaio+la
            _ + "an"          => init du ;        -- zitzaidan / zitzaida+la
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

    IntransV : Type = AuxForm => Agr => VForms ;  -- Agr = nori or nork
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
    Ni => "da" ; Hauek => "e" ;
    x => norkUkanLast ! x } ;

  norkUkanImp : Agr => Str = table {
    Ni => nonExist ; Gu => nonExist ;
    x => norkUkanFirst ! x } ;


  noriUkanLast : Agr => Str = table {
    Hau => "o" ;  Hauek => "e" ;
    x => norkUkanLast ! x } ;

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

  norUkanZaioNonpres : Agr => Str = table {
    Ni => "nin" ; Gu => "gin" ;
    Hi _ => "hin" ; 
    Zu => "zin" ; Zuek => "zin" ;
    Hau => "zi" ; Hauek => "zi" } ; 

  norUkanCond : Agr => Str = table {
    Zuek => "zintu" ; x => norUkanNonpres ! x } ;
{-
  =============================================================================
  Izan [NOR]
  =============================================================================
-}

    -- common copula
    izanDa : IntransV =
      table {APast => table {Ni => mkVForms "nintzen" ; 
                            Hi _ => mkVForms "hintzen" ; 
                            Zu => mkVForms "zinen" ; 
                            Hau => mkVForms "zen" ; 
                            Gu => mkVForms "ginen" ; 
                            Zuek => mkVForms "zineten" ; 
                            Hauek => mkVForms "ziren" } ;

             ACond => table {Ni => mkVForms "nintzateke" ; 
                            Hi _ => mkVForms "hintzateke" ; 
                            Zu => mkVForms "zinateke" ; 
                            Hau => mkVForms "litzateke" ; 
                            Gu => mkVForms "ginateke" ; 
                            Zuek => mkVForms "zinatekete" ; 
                            Hauek => mkVForms "lirateke" } ;
	           APres => table {Ni => mkVForms "naiz" ; 
                             Hi _ => mkVForms "haiz" ; 
                             Zu => mkVForms "zara" "zare" ; 
                             Hau => mkVForms "da" "de" ; 
                             Gu => mkVForms "gara" "gare" ; 
                             Zuek => mkVForms "zarete" ; 
                             Hauek => mkVForms "dira" "dire" } ;
             AImp  => table {Ni => noVForm  ; 
                             Hi _ => mkVForms "hadi" ; 
                             Zu => mkVForms "zaitez" ; 
                             Hau => mkVForms "bedi" ; 
                             Gu => noVForm ; 
                             Zuek => mkVForms "zaitezte" ; 
                             Hauek => mkVForms "bitez" } 
       } ;

{-
  =============================================================================
  Ukan [NOR] [NORK]
  =============================================================================
-}

  ukanDu : TransV = \\nor,tns,nork => mkVForms (
    case tns of {
      APast => 
        case nor of { -- Special forms for past when nor is Hau or Hauek
          Hau   => norkPast_norHau ! nork ;
          Hauek => norkPast_norHauek ! nork ;
          _     => let nindu : Str = norPast ! nor ;
                       te    : Str = norkPast ! nork ;
                    in nindu + te + "n" } ;

      ACond => 
        case nor of { -- Special forms for conditional when nor is Hau or Hauek
          Hau   => norkCond_norHau ! nork ;
          Hauek => norkCond_norHauek ! nork ;

          _     => let gintu : Str = norCond ! nor ;
                       z     : Str = case nor of {(Gu|Zu|Zuek) => "z" ; _ => [] } ;
                       te    : Str = norkCond ! nork ;
                    in gintu + z + "ke" + te } ;
      APres => let gaitu : Str = norPres ! nor ;
                  zte   : Str = norkPres ! nork ;
               in gaitu + zte ;

      AImp => let ga = norImp ! nor ;
                  it = case nor of { (Gu|Hauek) => "it" ; _ => [] } ;
                  k  = norkImp ! nork ;
               in ga + it + "za" + k 

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

      norkImp : Agr => Str = norkUkanImp ;

      norPres : Agr => Str = norUkanPres ;    
      
      norPast : Agr => Str = norUkanNonpres ;

      norCond : Agr => Str = norUkanCond ;

      norImp : Agr => Str = table { Ni => "na" ; Gu => "ga" ;
                                    Hau => "be" ; Hauek => "b" ; 
                                    _ => nonExist } ;

      --norCondZ : Agr => Str = table { 
      --  (Gu|Zu|Zuek) => "z" ; _ => [] } ;

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
                                x => (tk 2 (norkPast_norHau ! x)) + "ke" } ; -- nu+en -> nu+ke

      norkCond_norHauek = table { Hi _ => "hindukete" ; Zuek => "zenituzkete" ;
                                  Hau => "lituzke" ;  Hauek => "lituzkete" ; 
                                  x => (tk 2 (norkPast_norHauek ! x)) + "zke" } --nitu+en -> nitu+zke
  } ;


{-
  =============================================================================
  Ukan [NOR] [NORI]
  =============================================================================
-}
  ukanZaio : TransV = \\nor,tns,nori => mkVForms (tenses ! tns)  

   where {
    norPast : Agr => Str = norUkanZaioNonpres ;
    noriPast : Agr => Str = noriUkanMid ;

    norCond : Agr => Str = table {
      Hau => "li" ; Hauek => "li" ;
      x => norPast ! x } ;
    noriCond : Agr => Str = noriPast ;

    norPres : Agr => Str = table { 
      Ni    => "na" ; Gu    => "ga" ;
      Hi _  => "ha" ;                
      Zu    => "za" ; Zuek  => "za" ;
      Hau   => []   ; Hauek => [] } ;

    noriPres : Agr => Str = \\nori => case <nor,nori> of {
      <Zuek,Ni> => "da" ; -- zai+t, zai+zki+t etc., but `za+tzai+zki_da_te', if nor is Zuek
      <_,x>     => noriUkanLast ! x } ;
 
    ---
 
    te  : Str = case nor of { Zuek => "te" ; _ => [] } ;
    zki : Str = case nor of { (Zu|Zuek|Gu|Hauek) => "zki" ; _ => [] } ;

    tenses : AuxForm => Str = table {
      APast => let zin : Str = norPast ! nor ;
                  da : Str = noriPast ! nori ;
              in zin + "tzai" + zki + da + te + "n" ;

      ACond => let zin : Str = norCond ! nor ;
                  da : Str = noriCond ! nori ;
              in zin + "tzai" + zki + da + "ke" + te ;

      aPres => let za : Str = norPres ! nor ;
                  tzai : Str = case getPers nor of { P3 => "zai" ; _ => "tzai" } ;
                  da   : Str = noriPres ! nori ;
              in za + tzai + zki + da + te } ;

  } ;

{-
  =============================================================================
  Ukan [NOR] [NORI] [NORK]
  =============================================================================
-}

  ukanDio : DitransV = \\nori,nor,tns,nork => mkVForms (tenses ! tns)
   where { 
    -- Map from Number to prefix morpheme in Nor position.
    -- Specific to Nor-Nori-Nork, different forms in other auxiliaries.
    norPres : Number => Str = table { Sg => "di" ;
                                      Pl => "dizki" } ;
    norPast : Number => Str = \\n => drop 1 (norPres ! n) ;

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

    norkCond : Agr => Str = table { (Hau|Hauek) => "l" ; 
                                    x => norkPast ! x } ;

    ---
    te = case nork of { (Zuek|Hauek) => "te" ; _ => [] } ;

    tenses : AuxForm => Str = table {
      ACond => let zen = norkCond ! nork ;
                  izki = norPast ! getNum nor ; -- same forms for past and cond
                  da = noriPast ! nori ;        -- same forms for past and cond
               in zen + izki + da + "ke" + te ;

      APast => let zen = norkPast ! nork ;
                  izki = norPast ! getNum nor ;
                  da = noriPast ! nori ;
               in zen + izki + da + te + "n" ;

      aPres => let dizki = norPres ! getNum nor ;
                  da    = noriPres ! nori ; --form of nori depends on nork
                  zue   = norkPres ! nork 
               in dizki + da + zue } 

  } ;

{-
  =============================================================================
  Egon
  =============================================================================
-}
    -- stative copula, like Spanish estar
  egonDa : IntransV =
    table { APast => table {
                     Ni => mkVForms "nengoen" ; 
                     Hi _ => mkVForms "hengoen" ; 
                     Zu => mkVForms "zeunden" ; 
                     Hau => mkVForms "zegoen" ; 
                     Gu => mkVForms "geunden" ; 
                     Zuek => mkVForms "zeundeten" ; 
                     Hauek => mkVForms "zeuden" } ;
	          APres =>  table {
                     Ni => mkVForms "nago" ; 
                     Hi _ => mkVForms "hago" "hagoe" ; 
                     Zu => mkVForms "zaude" ; 
                     Hau => mkVForms "dago" "dagoe" ; 
                     Gu => mkVForms "gaude" ; 
                     Zuek => mkVForms "zaudete" ; 
                     Hauek => mkVForms "daude" } ;
            AImp  =>  table {
                     (Ni|Gu) => noVForm ;
                     Hi _ => mkVForms "hago" "hagoe" ; 
                     Zu => mkVForms "zaude" ; 
                     Hau => mkVForms "bego" "begoe" ; 
                     Zuek => mkVForms "zaudete" ; 
                     Hauek => mkVForms "beude" } ;
            ACond => \\_ => mkVForms "TODO" 

          } ;


{-
  =============================================================================
  Eduki
  =============================================================================
-}

   edukiDu : TransV = table {
       -- Nor,Nork
              Ni => table {
                    APres => table {
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
                    APres => table { -- Pres
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
                    APres => table { -- Pres
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
                    APres => table { 
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
                    APres => table { 
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
                    APres => table { 
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
                    APres => table { 
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
        <APres,Ni>    => mkVForms "nator" ;
        <APres,Hi _>  => mkVForms "hator" ;
        <APres,Zu>    => mkVForms "zatoz" ;
        <APres,Hau>   => mkVForms "dator" ;
        <APres,Gu>    => mkVForms "gatoz" ;
        <APres,Zuek>  => mkVForms "zatozte" ;
        <APres,Hauek> => mkVForms "datoz" ;

        <AImp,(Ni|Gu)> => noVForm ;        
        <AImp,Hi _>   => mkVForms "hator" ;
        <AImp,Zu>     => mkVForms "zatoz" ;
        <AImp,Zuek>   => mkVForms "zatozte" ;
        <AImp,Hau>    => mkVForms "betor" ;
        <AImp,Hauek>  => mkVForms "betoz" ;
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
        <APres,Ni>    => mkVForms "noa" ;
        <APres,Hi _>  => mkVForms "hoa" ;
        <APres,Zu>    => mkVForms "zoaz" ;
        <APres,Hau>   => mkVForms "doa" ;
        <APres,Gu>    => mkVForms "goaz" ;
        <APres,Zuek>  => mkVForms "zoazte" ;
        <APres,Hauek> => mkVForms "doaz" ;

        <APast,Ni>    => mkVForms "nindoan" ;
        <APast,Hi _>  => mkVForms "hindoan" ;
        <APast,Zu>    => mkVForms "zindoazen" ;
        <APast,Hau>   => mkVForms "zihoan" ;
        <APast,Gu>    => mkVForms "gindoazen" ;
        <APast,Zuek>  => mkVForms "zindoazten" ;
        <APast,Hauek> => mkVForms "zihoazen" ;

        <AImp,(Ni|Gu)> => noVForm ;
        <AImp,Hi _>   => mkVForms "hoa" ;
        <AImp,Zu>     => mkVForms "zoaz" ;
        <AImp,Zuek>   => mkVForms "zoazte" ;
        <AImp,Hau>    => mkVForms "bihoa" ;
        <AImp,Hauek>  => mkVForms "bihoaz" ;

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
        APast => table {
                    Ni => mkVForms "nenbilen" ; 
                    Hi _ => mkVForms "henbilen" ; 
                    Zu => mkVForms "zenbiltzan" ; 
                    Hau => mkVForms "zebilen" ; 
                    Gu => mkVForms "genbiltzan" ; 
                    Zuek => mkVForms "zenbiltzaten" ; 
                    Hauek => mkVForms "zebiltzan" } ;

        ACond => table {
                    Ni => mkVForms "nenbilke" ; 
                    Hi _ => mkVForms "henbilke" ; 
                    Zu => mkVForms "zenbilzke" ; 
                    Hau => mkVForms "lebilke" ; 
                    Gu => mkVForms "genbiltzke" ; 
                    Zuek => mkVForms "zenbiltzketen" ; 
                    Hauek => mkVForms "lebilzke" } ;

        APres => table {
                    Ni => mkVForms "nabil" ; 
                    Hi _ => mkVForms "habil" ; 
                    Zu => mkVForms "zabiltza" ; 
                    Hau => mkVForms "dabil" ; 
                    Gu => mkVForms "gabiltza" ; 
                    Zuek => mkVForms "zabiltzate" ; 
                    Hauek => mkVForms "dabiltza" } ;

        AImp  => table {
                    Ni => noVForm ; 
                    Hi _ => mkVForms "habil" ; 
                    Zu => mkVForms "zabiltza" ; 
                    Hau => mkVForms "bebil" ; 
                    Gu => noVForm ; 
                    Zuek => mkVForms "zabiltzate" ; 
                    Hauek => mkVForms "bebiltza" } 
       } ;


{-
  =============================================================================
  Jakin
  =============================================================================
-}
  jakinDu : TransV = 
    \\dobjAgr,tns,subjAgr => 
      case <dobjAgr,tns,subjAgr> of {
        <Hau,APres,Ni>    => mkVForms "dakit" ;
        <Hau,APres,Zu>    => mkVForms "dakizu" ;
        <Hau,APres,Hau>   => mkVForms "daki" ;
        <Hau,APres,Gu>    => mkVForms "dakigu" ;
        <Hau,APres,Zuek>  => mkVForms "dakizue" ;
        <Hau,APres,Hauek> => mkVForms "dakite" ;

        <Hau,APast,Ni>    => mkVForms "nekien" ;
        <Hau,APast,Zu>    => mkVForms "zenekien" ;
        <Hau,APast,Hau>   => mkVForms "zekien" ;
        <Hau,APast,Gu>    => mkVForms "genekien" ;
        <Hau,APast,Zuek>  => mkVForms "zenekiten" ;
        <Hau,APast,Hauek> => mkVForms "zekiten" ;

        <_,AImp,(Ni|Gu)>   => noVForm ;
        <Hau,AImp,Hau>     => mkVForms "beki" ;
        <Hauek,AImp,Hau>   => mkVForms "bekizki" ;
        <Hau,AImp,Hauek>   => mkVForms "bekite" ;
        <Hauek,AImp,Hauek> => mkVForms "bekizkite" ;

        _                 => ukanDu ! dobjAgr ! tns ! subjAgr 
      } ;



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
  Erabili
  =============================================================================
-}

{-
  =============================================================================
  Egin
  =============================================================================
-}

}