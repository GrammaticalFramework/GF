{-# LANGUAGE OverloadedStrings #-}
module Main where

import GF.Predictability

main = defaultMain
  [ englishNouns, englishVerbs
  -- , finnishNouns, finnishVerbs ]
  , frenchVerbs
  , swedishNouns, swedishVerbs ]

englishNouns, englishVerbs :: Experiment
englishNouns = Experiment
  { title = "English nouns"
  , lexicon = "lib/src/english/DictEng.gf"
  , category = "N"
  , nforms        = 4
  , morphology = "lib/src/english/ParadigmsEng.gf"
  , smartparadigm = "mkN"
  , setup = \(man:_:men:_:_) -> [ [esc man], [esc man,esc men] ] }
englishVerbs = Experiment
  { title = "English verbs"
  , lexicon = "lib/src/english/DictEng.gf"
  , category = "V"
  , nforms        = 5
  , morphology = "lib/src/english/ParadigmsEng.gf"
  , smartparadigm = "mkV"
  , setup = \(blow:blows:blown:blowing:blew:_) ->
    [ [ esc blow ]
    , [ esc blow, esc blew ]
    , [ esc blow, esc blew, esc blown ]
    , [ esc blow, esc blows, esc blew, esc blown, esc blowing ] ] }

  -- ~~~ Finnish ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
finnishNouns, finnishVerbs :: Experiment
finnishNouns = Experiment
  { title = "Finnish nouns"
  , lexicon = "lib/src/finnish/DictFin.gf"
  , category = "NK"
  , nforms        = 10
  , morphology = "lib/src/finnish/ParadigmsFin.gf"
  , smartparadigm = "mkN"
  , setup = \(talo:talon:taloa:talona:taloon:talojen:taloja:taloina:taloissa:taloihin:_) ->
      map (map esc )
        [ [ talo ]
        , [ talo, taloja ]
        , [ talo, talon, taloja ]
        , [ talo, talon, taloja, taloa ]
        , [ talo,talon,taloa,talona,taloon,talojen,taloja,taloina,taloissa,taloihin ] ] }

finnishVerbs = Experiment
  { title = "Finnish verbs"
  , lexicon = "lib/src/finnish/DictFin.gf"
  , category = "VK"
  , nforms        = 12
  , morphology = "lib/src/finnish/ParadigmsFin.gf"
  , smartparadigm = "mkV"
  , setup = \(panna:panen:panee:panevat:pankaa:pannaan:panin:pani:panisi:pannut:pantu:pannee:_) ->
      map (map esc )
        [ [ panna ]
        , [ panna, pani ]
        , [ panna, panen, pani ]
        , [ panna, panen, panee, panevat, pankaa, pannaan, panin, pani, panisi, pannut, pantu, pannee ] ]}
  
-- ~~~ French ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
frenchVerbs :: Experiment
frenchVerbs = Experiment
  { title         = "French verbs"
  , lexicon       = "lib/src/french/DictFre.gf"
  , category      = "V"
  , nforms        = 51
  , morphology    = "lib/src/french/ParadigmsFre.gf"
  , smartparadigm = "mkV"
  , setup         = \vForms ->
      let jeter = vForms!!0
          jette = vForms!!3
          jettera = vForms!!33
          tenir = vForms!!0
          tiens = vForms!!1
          tient = vForms!!3
          tenons = vForms!!4
          tenez = vForms!!5
          tiennent = vForms!!6
          tienne = vForms!!7
          tenions = vForms!!10
          tiensI = vForms!!43
          tint = vForms!!27
          tiendra = vForms!!33
          tenu = vForms!!46
      in map (map esc )
        [ [ jeter ]
        , [ jeter, jette, jettera ]
        , [ tenir, tiens, tenons, tiennent, tint, tiendra, tenu ]
        , [ tenir,tiens,tient,tenons,tenez,tiennent,tienne,tenions,tiensI,tint,tiendra,tenu ]
        ] }
  -- ~~~ Swedish ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
swedishNouns, swedishVerbs :: Experiment
swedishNouns = Experiment
  { title = "Swedish nouns"
  , lexicon = "lib/src/swedish/DictSwe.gf"
  , category = "N"
  , nforms        = 8
  , morphology = "lib/src/swedish/ParadigmsSwe.gf"
  , smartparadigm = "mkN"
  , setup = \(gurka:gurkas:gurkan:gurkans:gurkor:gurkors:gurkorna:gurkornas:_) ->
      [ [ esc gurka ]
      , [ esc gurka, esc gurkor ]
      , [ esc gurka, esc gurkan , esc gurkor, esc gurkorna ] ] }

swedishVerbs = Experiment
  { title = "Swedish verbs"
  , lexicon = "lib/src/swedish/DictSwe.gf"
  , category = "V"
  , nforms        = 17
  , morphology = "lib/src/swedish/ParadigmsSwe.gf"
  , smartparadigm = "mkV"
  , setup = \(gaar:gaas:gick:gicks:gaa_imp:gaa_inf:gaas_inf:gaatt:gaatts:gaangen:gaangens:gaanget:gaangets:gaangna_undef:gaangnas_undef:gaangna_def:gaangnas_def:_) ->
      [ [ esc gaa_inf ]
      , [ esc gaa_inf, esc gick, esc gaatt ]
      , [ esc gaa_inf, esc gaar, esc gaa_imp, esc gick, esc gaatt, esc gaangen ] ] }
