--# -path=present
concrete LogicEng of Logic = open (Eng=GrammarEng), ParadigmsEng, ResEng in {

lincat
  Ind = {s : Str};
  Prop = {s:Str};

lin
  john = {s="john"};
  mary = {s="mary"};
  boy x = {s="boy"++"("++x.s++")"};
  smart x = {s="smart"++"("++x.s++")"};
  love x y = {s="love"++"("++x.s++","++y.s++")"};
  leave x = {s="leave"++"("++x.s++")"};
  and  x y = {s=x.s++"&&"++y.s};
  or   x y = {s=x.s++"||"++y.s};
  impl x y = {s=x.s++"=>"++y.s};
  forall f = {s="forall"++f.$0++"."++"("++f.s++")"};
  exists f = {s="exists"++f.$0++"."++"("++f.s++")"};
  not p = {s="not"++"("++p.s++")"};
  eq x y = {s=x.s++"="++y.s};

}
