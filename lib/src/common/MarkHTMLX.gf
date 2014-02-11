--# -path=.:../abstract

concrete MarkHTMLX of MarkHTML = open HTML, Prelude in {

lincat
  Mark = {begin,end : Str} ;

lin
  i_Mark  = mkMark "i" ;
  b_Mark  = mkMark "b" ;
  ul_Mark = mkMark "ul" ;
  li_Mark = mkMark "li" ;
  h1_Mark = mkMark "h1" ;
  h2_Mark = mkMark "h2" ;
  table_Mark = mkMark "table" ;
  tr_Mark = mkMark "tr" ;
  td_Mark = mkMark "td" ;
  p_Mark  = mkMark "p" ;

  a_Mark url = {begin = "<a href=" ++ Predef.BIND ++ url.s ++ Predef.BIND ++ ">" ;  end = "</a>"} ;

  stringMark begin end = {begin = begin.s ; end = end.s} ;

oper
  mkMark = overload {
    mkMark : Str -> Mark 
     = \s -> lin Mark {begin = tag s ; end = endtag s} ;
    mkMark : Str -> Str -> Mark 
     = \s,t -> lin Mark {begin = tag s ; end = endtag t} ;
    } ;

  appMark : {begin,end : Str} -> Str -> Str 
    = \m,s -> m.begin ++ s ++ m.end ;

}