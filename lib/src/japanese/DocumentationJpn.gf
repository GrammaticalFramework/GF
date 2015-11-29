--# -path=.:../abstract:../common
concrete DocumentationJpn of Documentation = CatJpn ** open
  HTML in {

lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Definition = {s : Str} ;
  Document = {s : Str} ;
  Tag      = {s : Str} ;

lin
  NoDefinition   t     = {s=t.s};
  MkDefinition   t d   = {s="<p>"++t.s++d.s++"</p>"};
  MkDefinitionEx t d e = {s="<p>"++t.s++d.s++"</p><p>"++e.s++"</p>"};

}
