--# -path=.:../abstract:../common
concrete DocumentationTha of Documentation = CatTha ** open
  HTML in {

lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Definition = {s : Str} ;
  Document = {s : Str} ;
  Tag      = {s : Str} ;

lin
  NoDefinition       = {s=""};
  MkDefinition   d   = {s="<p>"++d.s++"</p>"};
  MkDefinitionEx d e = {s="<p>"++d.s++"</p><p>"++e.s++"</p>"};

}
