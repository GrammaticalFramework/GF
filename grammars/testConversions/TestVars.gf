
-- param Num = Sg | Pl;
-- param Gen = Utr | Neu;
-- param NumGen = NG Num Gen;

concrete TestVars of TestVarsA = open TestVarsR in {

-- lincat S = { s : Str; n : Num };
-- lincat A = { s1 : Str; s2 : Num => Str ; g : Gen };
-- lincat B = { s : Str; n : Num };
-- lin a x = { s = table { Sg => "sg" ; Pl => "pl" } ! x.n ++ x.s ; n = x.n };
-- lin b x y = { s = table { Neu => variants{"neu";"NEU"} ; Utr => "utr" } ! x.g;
--               n = variants { y.n ; Sg } };
-- lin c = { s = variants{"a";"A"} ++ variants{"b";"B"} ++ variants{"c";"C"}; n = Sg };

-- lincat V = { a : { s1 : Str ; s2 : Str } };
-- lincat W = { s1 : Str ; ng:{n:Num;g:Gen} ; s2 : Str };
-- lin v = { a = variants { {s1="a1";s2="a2"} ; {s1="b1";s2=variants{}} } };
-- lin w = variants { {s1="a1";ng=variants{};s2="a2"} ; 
--       		   {s1="b1";ng=variants{{n=Pl;g=Utr};{n=Sg;g=Neu}};s2="b2"} };

-- lincat E = { a : { b : {s1:Str; s2:Str} ; c : {n:Num;g:Gen} }; d:{e:{f:{s:Str}}} };
-- lin e    = { a = { b = {s1="1"; s2="2"} ; c = {n=Sg ;g=Utr} }; d={e={f={s="s"}}} };
-- lin f x  = { a = { b = {s1=x.d.e.f.s;s2=x.a.b.s1}; c = {n=x.a.c.n;g=Neu}}; 
--       	     d={e={f={s="s"++x.a.b.s2}}} };

lincat S = { s : Str };
lin
--s = { s = variants { "a" ; "b" ; "c" } };
e = { s = variants { "e" ; "f" } };
ee x = { s = x.s ++ x.s };
f = { s = "g" };
ff x = { s = "e" ++ x.s };


-- lincat D = { s1 : Str; s2 : Str };




}

