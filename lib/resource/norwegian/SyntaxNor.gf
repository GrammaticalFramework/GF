--# -path=.:../scandinavian:../../prelude

instance SyntaxNor of SyntaxScand = TypesNor ** 
  open Prelude, (CO = Coordination), MorphoNor in {

  flags optimize=all ;

  oper 

------ mkAdjForm

-- When common nouns are extracted from lexicon, the composite noun form is ignored.

  npDet : NounPhrase = nameNounPhrase (mkProperName "det" NNeutr) ;

  mkAdjForm : Species -> Number -> NounGender -> AdjFormPos = \b,n,g -> 
    case <b,n> of {
      <Indef,Sg> => Strong (ASg (genNoun g)) ;
      <Indef,Pl> => Strong APl ;
      <Def,  _>  => Weak
      } ;

  verbFinnas : Verb = 
    mkVerb "finnes" "finner" "finnes" "fantes" "funnets" "fins" ** {s1 = []} ;
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

  infinAtt = "å" ;

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

  reflPron : Number -> Person -> Str = \n,p -> case <n,p> of {
    <Sg,P1> => "meg" ;
    <Sg,P2> => "deg" ;
    <Pl,P1> => "oss" ;
    <Pl,P2> => "jer" ;
    _ => "seg"
    } ;

  progressiveVerbPhrase : VerbPhrase -> VerbGroup = 
    complVerbVerb
      ({s = verbVara.s ; s1 = "ved" ; isAux = False}) ;

  progressiveClause : NounPhrase -> VerbPhrase -> Clause = \np,vp ->
    predVerbGroupClause np
     (complVerbVerb 
      (verbVara **
       {isAux = False} ----- {s3 = ["ved at"]}
      )
      vp) ;
}
