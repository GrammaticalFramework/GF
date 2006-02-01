--# -path=.:../romance:../abstract:../common:prelude

instance DiffIta of DiffRomance = open CommonRomance, PhonoIta, BeschIta, Prelude in {

  param 
    Prep = P_di | P_a | P_da | P_in | P_su | P_con ;
    VType = VHabere | VEsse | VRefl ;

  oper
    dative   : Case = CPrep P_a ;
    genitive : Case = CPrep P_di ;

    prepCase = \c -> case c of {
      Nom | Acc => [] ;
      CPrep p => case p of {
        P_di => "di" ;
        P_a  => "a" ;
        P_da => "da" ;
        P_in => "in" ;
        P_su => "su" ;
        P_con => "con"
        }
      } ;

    artDef : Gender -> Number -> Case -> Str = \g,n,c ->
      case <g,n,c> of {
        <_, _, CPrep P_di>  => prepArt "de" ;
        <_, _, CPrep P_da>  => prepArt "da" ;
        <_, _, CPrep P_a>   => prepArt "a" ;
        <_, _, CPrep P_in>  => prepArt "ne" ;
        <_, _, CPrep P_su>  => prepArt "su" ;
        <_, _, CPrep P_con> => prepArt "co" ;
        <Masc,Sg, Nom| Acc> => elision "il" "l'" "lo" ;
        <Fem ,Sg, _>        => elision "la" "l'" "la" ;
        <Masc,Pl, _>        => elision "i" "gli" "gli" ;
        <Fem ,Pl, _>        => "le"
        } 
       where {
         prepArt : Tok -> Tok = \de -> case <g,n> of {
           <Masc,Sg> => elision (de + "l")   (de + "ll'") (de + "llo") ;
           <Masc,Pl> => elision (de + "i")   (de + "gli") (de + "gli") ;
           <Fem, Sg> => elision (de + "lla") (de + "ll'") (de + "lla") ;
           <Fem, Pl> => de + "lle"
           }
         } ;


-- In these two, "de de/du/des" becomes "de".

    artIndef = \g,n,c -> case <n,c> of {
      <Sg,_>   => prepCase c ++ 
                  genForms (elision "un" "un" "uno") (elision "una" "un'" "una") ! g ;
      _        => prepCase c 
      } ;

    partitive = \g,c -> case c of {
      CPrep P_de => "di" ;
      _ => prepCase c ++ artDef g Sg (CPrep P_di)
      } ;

    conjunctCase : NPForm -> NPForm = \c -> case c of {
      Ton Nom | Aton Nom => Ton Nom ;
      _ => Ton Acc 
      } ;

    auxVerb : VType -> (VF => Str) = \vtyp -> case vtyp of {
      VHabere => avere_V.s ;
      _ => copula.s
      } ;

    partAgr : VType -> VPAgr = \vtyp -> case vtyp of {
      VHabere => vpAgrNone ;
      _ => VPAgrSubj
      } ;

    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

    negation : Polarity => (Str * Str) = table {
      Pos => <[],[]> ;
      Neg => <"non",[]>
      } ;

    conjThan = "che" ; --- di
    conjThat = "che" ;

    clitInf cli inf = inf ++ cli ; --- contraction of inf

    relPron : Bool => AAgr => Case => Str = \\b,a,c => 
      case c of {
        Nom => "che" ;
        CPrep P_de => "cui" ;
        _ => prepCase c ++ "cui" --- ilquale
        } ;

    pronSuch : AAgr => Str = aagrForms "tale" "tale" "tali" "tali" ;

    quelPron : AAgr => Str = aagrForms "quale" "quale" "quali" "quali" ;

    partQIndir = "ciò" ;

    reflPron : Number => Person => Case => Str = 
      let 
        cases : (x,y : Str) -> (Case => Str) = \me,moi -> table {
          Acc | CPrep P_a => me ;
          _ => moi
          } ;
      in 
      \\n,p => case <n,p> of { 
        <Sg,P1> => cases "mi" "me" ;
        <Sg,P2> => cases "ti" "te" ;
        <Pl,P1> => cases "ci" "noi" ; -- unlike French with just one alt!
        <Pl,P2> => cases "vi" "voi" ;
        _ => cases "si" "se"
        } ;

    vRefl   : VType = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

    auxPassive : Verb = venire_V ;

    copula = essere_V ;

-- machine-generated GF code (from Functional Morphology)

  essere_V : Verb = verbBesch
  {s = table {
    Inf => "essere" ;
    InfClit => "essr" ;
    Indi Pres Sg P1 => "sono" ;
    Indi Pres Sg P2 => "sei" ;
    Indi Pres Sg P3 => "è" ;
    Indi Pres Pl P1 => "siamo" ;
    Indi Pres Pl P2 => "siete" ;
    Indi Pres Pl P3 => "sono" ;
    Indi Imperf Sg P1 => "ero" ;
    Indi Imperf Sg P2 => "eri" ;
    Indi Imperf Sg P3 => "era" ;
    Indi Imperf Pl P1 => "eravamo" ;
    Indi Imperf Pl P2 => "eravate" ;
    Indi Imperf Pl P3 => "erano" ;
    Pass Sg P1 => "fui" ;
    Pass Sg P2 => "fosti" ;
    Pass Sg P3 => "fu" ;
    Pass Pl P1 => "fummo" ;
    Pass Pl P2 => "foste" ;
    Pass Pl P3 => "furono" ;
    Fut Sg P1 => "sarò" ;
    Fut Sg P2 => "sarai" ;
    Fut Sg P3 => "sarà" ;
    Fut Pl P1 => "saremo" ;
    Fut Pl P2 => "sarete" ;
    Fut Pl P3 => "saranno" ;
    Cong Pres Sg P1 => "sia" ;
    Cong Pres Sg P2 => "sia" ;
    Cong Pres Sg P3 => "sia" ;
    Cong Pres Pl P1 => "siamo" ;
    Cong Pres Pl P2 => "siate" ;
    Cong Pres Pl P3 => "siano" ;
    Cong Imperf Sg P1 => "fossi" ;
    Cong Imperf Sg P2 => "fossi" ;
    Cong Imperf Sg P3 => "fosse" ;
    Cong Imperf Pl P1 => "fossimo" ;
    Cong Imperf Pl P2 => "foste" ;
    Cong Imperf Pl P3 => "fossero" ;
    Cond Sg P1 => "sarei" ;
    Cond Sg P2 => "saresti" ;
    Cond Sg P3 => "sarebbe" ;
    Cond Pl P1 => "saremmo" ;
    Cond Pl P2 => "sareste" ;
    Cond Pl P3 => "sarebbero" ;
    Imper SgP2 => "sii" ;
    --Imper IPs3 => "sia" ;
    Imper PlP1 => "siamo" ;
    Imper PlP2 => "siate" ;
    --Imper IPp3 => "siano" ;
    Ger => "essendo" ;
    Part PresP Masc Sg => variants {} ;
    Part PresP Masc Pl => variants {} ;
    Part PresP Fem Sg => variants {} ;
    Part PresP Fem Pl => variants {} ;
    Part PassP Masc Sg => "stato" ;
    Part PassP Masc Pl => "stati" ;
    Part PassP Fem Sg => "stata" ;
    Part PassP Fem Pl => "state"
    }} ** {
    vtyp = VHabere
  } ;

  avere_V : Verb = verbBesch
  {s = table {
    Inf => "avere" ;
    InfClit => "aver" ;
    Indi Pres Sg P1 => "ho" ;
    Indi Pres Sg P2 => "hai" ;
    Indi Pres Sg P3 => "ha" ;
    Indi Pres Pl P1 => "abbiamo" ;
    Indi Pres Pl P2 => "avete" ;
    Indi Pres Pl P3 => "hanno" ;
    Indi Imperf Sg P1 => "avevo" ;
    Indi Imperf Sg P2 => "avevi" ;
    Indi Imperf Sg P3 => "aveva" ;
    Indi Imperf Pl P1 => "avevamo" ;
    Indi Imperf Pl P2 => "avevate" ;
    Indi Imperf Pl P3 => "avevano" ;
    Pass Sg P1 => "ebbi" ;
    Pass Sg P2 => "avesti" ;
    Pass Sg P3 => "ebbe" ;
    Pass Pl P1 => "avemmo" ;
    Pass Pl P2 => "aveste" ;
    Pass Pl P3 => "ebbero" ;
    Fut Sg P1 => "avrò" ;
    Fut Sg P2 => "avrai" ;
    Fut Sg P3 => "avrà" ;
    Fut Pl P1 => "avremo" ;
    Fut Pl P2 => "avrete" ;
    Fut Pl P3 => "avranno" ;
    Cong Pres Sg P1 => "abbia" ;
    Cong Pres Sg P2 => "abbia" ;
    Cong Pres Sg P3 => "abbia" ;
    Cong Pres Pl P1 => "abbiamo" ;
    Cong Pres Pl P2 => "abbiate" ;
    Cong Pres Pl P3 => "abbiano" ;
    Cong Imperf Sg P1 => "avessi" ;
    Cong Imperf Sg P2 => "avessi" ;
    Cong Imperf Sg P3 => "avesse" ;
    Cong Imperf Pl P1 => "avessimo" ;
    Cong Imperf Pl P2 => "aveste" ;
    Cong Imperf Pl P3 => "avessero" ;
    Cond Sg P1 => "avrei" ;
    Cond Sg P2 => "avresti" ;
    Cond Sg P3 => "avrebbe" ;
    Cond Pl P1 => "avremmo" ;
    Cond Pl P2 => "avreste" ;
    Cond Pl P3 => "avrebbero" ;
    Imper SgP2 => "abbi" ;
    --Imper IPs3 => "abbia" ;
    Imper PlP1 => "abbiamo" ;
    Imper PlP2 => "abbiate" ;
    --Imper IPp3 => "abbiano" ;
    Ger => "avendo" ;
    Part PresP Masc Sg => "avente" ;
    Part PresP Masc Pl => "aventi" ;
    Part PresP Fem Sg => "avente" ;
    Part PresP Fem Pl => "aventi" ;
    Part PassP Masc Sg => "avuto" ;
    Part PassP Masc Pl => "avuti" ;
    Part PassP Fem Sg => "avuta" ;
    Part PassP Fem Pl => "avute"
    }} ** {
  vtyp = VEsse
  } ;

  venire_V : Verb = verbBesch
  {s = table {
    Inf => "venire" ;
    InfClit => "venir" ;
    Indi Pres Sg P1 => "vengo" ;
    Indi Pres Sg P2 => "vieni" ;
    Indi Pres Sg P3 => "viene" ;
    Indi Pres Pl P1 => "veniamo" ;
    Indi Pres Pl P2 => "venite" ;
    Indi Pres Pl P3 => "vengono" ;
    Indi Imperf Sg P1 => "venivo" ;
    Indi Imperf Sg P2 => "venivi" ;
    Indi Imperf Sg P3 => "veniva" ;
    Indi Imperf Pl P1 => "venivamo" ;
    Indi Imperf Pl P2 => "venivate" ;
    Indi Imperf Pl P3 => "venivano" ;
    Pass Sg P1 => "venni" ;
    Pass Sg P2 => "venisti" ;
    Pass Sg P3 => "venne" ;
    Pass Pl P1 => "venimmo" ;
    Pass Pl P2 => "veniste" ;
    Pass Pl P3 => "vennero" ;
    Fut Sg P1 => "verrò" ;
    Fut Sg P2 => "verrai" ;
    Fut Sg P3 => "verrà" ;
    Fut Pl P1 => "verremo" ;
    Fut Pl P2 => "verrete" ;
    Fut Pl P3 => "verranno" ;
    Cong Pres Sg P1 => "venga" ;
    Cong Pres Sg P2 => "venga" ;
    Cong Pres Sg P3 => "venga" ;
    Cong Pres Pl P1 => "veniamo" ;
    Cong Pres Pl P2 => "veniate" ;
    Cong Pres Pl P3 => "vengano" ;
    Cong Imperf Sg P1 => "venissi" ;
    Cong Imperf Sg P2 => "venissi" ;
    Cong Imperf Sg P3 => "venisse" ;
    Cong Imperf Pl P1 => "venissimo" ;
    Cong Imperf Pl P2 => "veniste" ;
    Cong Imperf Pl P3 => "venissero" ;
    Cond Sg P1 => "verrei" ;
    Cond Sg P2 => "verresti" ;
    Cond Sg P3 => "verrebbe" ;
    Cond Pl P1 => "verremmo" ;
    Cond Pl P2 => "verreste" ;
    Cond Pl P3 => "verrebbero" ;
    Imper SgP2 => "vieni" ;
    Imper PlP1 => "veniamo" ;
    Imper PlP2 => "venite" ;
    Ger => "venendo" ;
    Part PresP Masc Sg => "veniente" ;
    Part PresP Masc Pl => "venienti" ;
    Part PresP Fem Sg => "veniente" ;
    Part PresP Fem Pl => "venienti" ;
    Part PassP Masc Sg => "venuto" ;
    Part PassP Masc Pl => "venuti" ;
    Part PassP Fem Sg => "venuta" ;
    Part PassP Fem Pl => "venute"
    }} ** {
  vtyp = VEsse
  } ;
}
