--# -path=.:../scandinavian:../../prelude

--1 A Small Swedish Resource Syntax
--
-- Aarne Ranta 2002 - 2005
--
instance SyntaxSwe of SyntaxScand = TypesSwe ** 
  open Prelude, (CO = Coordination), MorphoSwe in {

  oper 

  extCommNounMasc : Subst -> CommNoun = \sb ->
    {s = \\n,b,c => sb.s ! SF n b c ; 
     g = NUtr Masc
    } ;

  npMan : NounPhrase = nameNounPhrase (mkProperName "man" (NUtr Masc)) ;
  npDet : NounPhrase = nameNounPhrase (mkProperName "det" NNeutr) ;


  mkAdjForm : Species -> Number -> NounGender -> AdjFormPos = \b,n,g -> 
    case <b,n> of {
      <Indef,Sg> => Strong (ASg (genNoun g)) ;
      <Indef,Pl> => Strong APl ;
      <Def,  Sg> => Weak (AxSg (sexNoun g)) ;
      <Def,  Pl> => Weak AxPl
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

  verbVara = vara_1200 ** {s1 = []} ;
  verbHava = hava_1198 ** {s1 = []};

  verbFinnas : Verb = deponentVerb (vFinna "finn" "fann" "funn" ** {s1 = []}) ;

  relPronForms : RelCase => GenNum => Str = table {
    RNom  => \\_ => "som" ;
    RAcc  => \\_ => variants {"som" ; []} ;
    RGen  => \\_ => "vars" ;
    RPrep => pronVilken
    } ;
  
  pronVilken = table {
      ASg Utr   => "vilken" ; 
      ASg Neutr => "vilket" ; 
      APl       => "vilka"
      } ;

  pronSådan = table {
      ASg Utr   => "sådan" ; 
      ASg Neutr => "sådant" ; 
      APl       => "sådana"
      } ;

  pronNågon = table {
      ASg Utr   => "någon" ; 
      ASg Neutr => "något" ; 
      APl       => "några"
      } ;

  specDefPhrase : Bool -> Species = \b -> 
    Def ;

  superlSpecies = Def ;

  artIndef = table {Utr => "en" ; Neutr => "ett"} ;

  artDef : Bool => GenNum => Str = table {
    True => table {
      ASg Utr => "den" ;
      ASg Neutr => "det" ;              -- det gamla huset
      APl => variants {"de" ; "dom"}
      } ;
    False => table {_ => []}            -- huset
    } ;

  auxHar = "har" ;
  auxHade = "hade" ;
  auxHa = "ha" ;
  auxSka = "ska" ;
  auxSkulle = "skulle" ;

  infinAtt = "att" ;

  varjeDet : Determiner = mkDeterminerSg (detSgInvar "varje") IndefP ;
  allaDet  : Determiner = mkDeterminerPl "alla" IndefP ;
  flestaDet : Determiner = mkDeterminerPl ["de flesta"] IndefP ;

  prepÄn = "än" ;
  negInte = "inte" ;

  conjOm = "om" ;

  pronVars = "vars" ;
  pronVem = "vem" ;
  pronVems = "vems" ;
  pronVad = "vad" ;

--- added with Nor

  conjGender : Gender -> Gender -> Gender = \m,n ->
    case <m,n> of {
      <Utr,Utr> => Utr ;
      _ => Neutr
      } ;

  mkDeterminerSgGender3 : Str -> Str -> Str -> SpeciesP -> Determiner = \en,_,ett -> 
    mkDeterminerSgGender (table {Utr => en ; Neutr => ett}) ;

-- next

  adjPastPart : Verb -> Adjective = \verb -> {
    s = \\af,c => verb.s1 ++ verb.s ! VI (PtPret af c) --- på slagen
    } ;
}
