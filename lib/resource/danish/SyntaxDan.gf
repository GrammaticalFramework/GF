--# -path=.:../scandinavian:../../prelude

instance SyntaxDan of SyntaxScand = TypesDan ** 
  open Prelude, (CO = Coordination), MorphoDan in {

  flags optimize=all ;

  oper 
------ mkAdjForm

-- When common nouns are extracted from lexicon, the composite noun form is ignored.

  extCommonNounMasc = extCommNoun ;

  npMan : NounPhrase = nameNounPhrase (mkProperName "man" NUtr) ;
  npDet : NounPhrase = nameNounPhrase (mkProperName "det" NNeutr) ;

  mkAdjForm : Species -> Number -> NounGender -> AdjFormPos = \b,n,g -> 
    case <b,n> of {
      <Indef,Sg> => Strong (ASg (genNoun g)) ;
      <Indef,Pl> => Strong APl ;
      <Def,  _>  => Weak
      } ;

  verbFinnas : Verb = 
    deponentVerb (mkVerb "finde" "finder" "findes" "fandt" "fundet" "find" ** {s1 = []}) ;
  verbVara = mkVerb "være" "er" nonExist "var" "været" "vær" ** {s1 = []} ;
  verbHava = mkVerb "have" "har" "haves" "havde" "haft" "hav" ** {s1 = []} ;

  relPronForms : RelCase => GenNum => Str = table {
    RNom  => \\_ => "som" ;
    RAcc  => \\_ => variants {"som" ; []} ;
    RGen  => \\_ => "hvis" ;
    RPrep => pronVilken
    } ;
  
  pronVilken = table {
      ASg Utr   => "hvilken" ; 
      ASg Neutr => "hvilket" ; 
      APl       => "hvilke"
      } ;

  pronSådan = table {
      ASg Utr   => "sådan" ; 
      ASg Neutr => "sådant" ; 
      APl       => "sådanne"
      } ;

  pronNågon = table {
      ASg Utr   => "nogen" ; 
      ASg Neutr => "noget" ; 
      APl       => "nogle"
      } ;

  specDefPhrase : Bool -> Species = \b -> 
    if_then_else Species b Indef Def ;

  superlSpecies = Indef ;

  artIndef = table {Utr => "en" ; Neutr => "et"} ;

  artDef : Bool => GenNum => Str = table {
    True => table {
      ASg Utr => "den" ;
      ASg Neutr => "det" ;              -- det gamla huset
      APl => variants {"de"}
      } ;
    False => table {_ => []}            -- huset
    } ;

  auxHar = "har" ;
  auxHade = "havde" ;
  auxHa = "have" ;
  auxSka = "vil" ;
  auxSkulle = "ville" ;

  infinAtt = "at" ;

  varjeDet : Determiner = mkDeterminerSg (detSgInvar "hver") IndefP ;
  allaDet  : Determiner = mkDeterminerPl "alle" IndefP ;
  flestaDet : Determiner = mkDeterminerPl ["de fleste"] IndefP ;

  prepÄn = "end" ;
  negInte = "ikke" ;

  conjOm = "hvis" ;

  pronVars = "hvis" ;
  pronVem = "hvem" ;
  pronVems = "hvis" ; ---- ??
  pronVad = "hvad" ;

--- added with Nor

  conjGender : Gender -> Gender -> Gender = \m,n ->
    case <m,n> of {
      <Utr,Utr> => Utr ;
      _ => Neutr
      } ;

  mkDeterminerSgGender3 : Str -> Str -> Str -> SpeciesP -> Determiner = \en,_,ett -> 
    mkDeterminerSgGender (table {Utr => en ; Neutr => ett}) ;

  reflPron : Number -> Person -> Str = \n,p -> case <n,p> of {
    <Sg,P1> => "mig" ;
    <Sg,P2> => "dig" ;
    <Pl,P1> => "os" ;
    <Pl,P2> => "seg" ; --- ? dere ?
    _ => "seg"
    } ;

  progressiveVerbPhrase : VerbPhrase -> VerbGroup = 
    complVerbVerb
      {s = verbVara.s ; s1 = "ved" ; isAux = False} ;

  progressiveClause : NounPhrase -> VerbPhrase -> Clause = \np,vp ->
    predVerbGroupClause np
     (complVerbVerb 
      (verbVara **
       {isAux = False} ----- {s3 = ["ved at"]}
      )
      vp) ;

}