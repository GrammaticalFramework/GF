abstract Markup = Cat, MarkHTML ** {

-- Adding markup to sentences and their parts. By default both start and end tags.
-- For instance 
--
--  MarkupNP boldMarkup everything_NP   ==>  <b> everything </b>
--
-- AR 11/2/2014

fun
  MarkupCN   : Mark -> CN   -> CN ;
  MarkupNP   : Mark -> NP   -> NP ;
  MarkupAP   : Mark -> AP   -> AP ;
  MarkupAdv  : Mark -> Adv  -> Adv ;
  MarkupS    : Mark -> S    -> S ;
  MarkupUtt  : Mark -> Utt  -> Utt ;
  MarkupPhr  : Mark -> Phr  -> Phr ;
  MarkupText : Mark -> Text -> Text ;

}