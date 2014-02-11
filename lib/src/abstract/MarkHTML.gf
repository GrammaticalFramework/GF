abstract MarkHTML = {

-- HTML markup to be used in Markup.gf. Will have a common implementation for all languages.
-- AR 11/2/2014

cat
  Mark ;

fun
  i_Mark  : Mark ;
  b_Mark  : Mark ;
  ul_Mark : Mark ;
  li_Mark : Mark ;
  h1_Mark : Mark ;
  h2_Mark : Mark ;
  table_Mark : Mark ;
  tr_Mark : Mark ;
  td_Mark : Mark ;
  p_Mark  : Mark ;

  a_Mark  : String -> Mark ;

  stringMark : String -> String -> Mark ;  -- make your own markup

}