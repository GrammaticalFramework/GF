--# -path=.:../scandinavian:../../prelude

instance SyntaxNor of SyntaxScand = TypesNor ** 
  open Prelude, (CO = Coordination), MorphoNor in {

  oper 

------ mkAdjForm

-- When common nouns are extracted from lexicon, the composite noun form is ignored.

  extCommonNounMasc = extCommNoun ;

  npMan : NounPhrase = nameNounPhrase (mkProperName "man" (NUtr Masc)) ;
  npDet : NounPhrase = nameNounPhrase (mkProperName "det" NNeutr) ;


  mkAdjForm : Species -> Number -> NounGender -> AdjFormPos = \b,n,g -> 
    case <b,n> of {
      <Indef,Sg> => Strong (ASg (genNoun g)) ;
      <Indef,Pl> => Strong APl ;
      <Def,  _>  => Weak
      } ;

  deponentVerb : Verb -> Verb = \finna -> {
    s = table {
      VF (Pres m _) => finna.s ! VF (Pres m Pass) ;
      VF (Pret m _) => finna.s ! VF (Pret m Pass) ;
      VI (Inf _)    => finna.s ! VI (Inf Pass) ;
      VI (Supin _)  => finna.s ! VI (Supin Pass) ;
      v             => finna.s ! v --- Imper !
      } ;
    s1 = finna.s1
    } ;

  verbFinnas : Verb = 
    deponentVerb (mkVerb "finne" "finner" "finnes" "fant" "funnet" "finn" ** {s1 = []}) ;
  verbVara = mkVerb "være" "er" nonExist "var" "vært" "vær" ** {s1 = []} ;
  verbHava = mkVerb "ha" "ha" "has" "hadde" "hatt" "ha" ** {s1 = []} ;

  relPronForms : RelCase => GenNum => Str = table {
    RNom  => \\_ => "som" ;
    RAcc  => \\_ => variants {"som" ; []} ;
    RGen  => \\_ => "hvis" ;
    RPrep => pronVilken
    } ;
  
  pronVilken = table {
      ASg (Utr Masc)   => "hvilken" ;   --- cannot reduce patter _ in Rules
      ASg (Utr NoMasc)   => "hvilken" ; 
      ASg Neutr => "hvilket" ; 
      APl       => "hvilke"
      } ;

  pronSådan = table {
      ASg (Utr _)   => "sådan" ; 
      ASg Neutr => "sådant" ; 
      APl       => "sådanne"
      } ;

  pronNågon = table {
      ASg (Utr _)   => "noen" ; 
      ASg Neutr => "noe" ; 
      APl       => "noen"
      } ;

  specDefPhrase : Bool -> Species = \b -> 
    Def ;

  superlSpecies = Def ;

  artIndef = table {Utr Masc => "en" ; Utr NoMasc => "ei" ; Neutr => "et"} ;

  artDef : Bool => GenNum => Str = table {
    True => table {
      ASg (Utr _) => "den" ;
      ASg Neutr => "det" ;              -- det gamla huset
      APl => variants {"de"}
      } ;
    False => table {_ => []}            -- huset
    } ;

  auxHar = "har" ;
  auxHade = "hadde" ;
  auxHa = "ha" ;
  auxSka = "vil" ;
  auxSkulle = "ville" ;

  infinAtt = "at" ;

  varjeDet : Determiner = mkDeterminerSg (detSgInvar "hver") IndefP ;
  allaDet  : Determiner = mkDeterminerPl "alle" IndefP ;
  flestaDet : Determiner = mkDeterminerPl ["de fleste"] IndefP ;

  prepÄn = "enn" ;
  negInte = "ikke" ;

  conjOm = "hvis" ;

  pronVars = "hvis" ;
  pronVem = "hvem" ;
  pronVems = "hvis" ; ---- ??
  pronVad = "hva" ;

--- added with Nor

  conjGender : Gender -> Gender -> Gender = \m,n -> Neutr ;
    ----  case <m,n> of {
    ---- _ => Neutr ----- bug in type check <Utr _, Utr _>
    ---- } ;

  mkDeterminerSgGender3 : Str -> Str -> Str -> SpeciesP -> Determiner = \en,ei,ett -> 
    mkDeterminerSgGender (table {Utr Masc => en ; Utr NoMasc => ei ; Neutr => ett}) ;

  adjPastPart : Verb -> Adjective = \verb -> {
    s = \\af,c => verb.s1 ++ verb.s ! VI (PtPret c) ---- af
    } ;

  reflPron : Number -> Person -> Str = \n,p -> case <n,p> of {
    <Sg,P1> => "meg" ;
    <Sg,P2> => "deg" ;
    <Pl,P1> => "oss" ;
    <Pl,P2> => "jer" ;
    _ => "seg"
    } ;

  progressiveVerbPhrase : VerbGroup -> VerbGroup = \verb -> 
    complVerbVerb
      (verbVara **
       {s3 = ["ved at"]}
      )
      (predVerbGroup True Simul verb) ;  

}
