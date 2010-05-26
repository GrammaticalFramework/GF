--# -path=.:../prelude:../common
--# -coding=utf8

-- A Polish adjective Resource Morphology 

-- Adam Slaski, 2009 <adam.slaski@gmail.com>


resource AdjectiveMorphoPol = ResPol ** open Prelude, (Predef=Predef) in {

     flags  coding=utf8; 

-- Polish adjectives and adverbs have three degrees. Some of them have
-- comparative and superlative forms compound of the adverb 'bardzo' (in
-- proper degree) and the positive form like this: 
-- chory / bardziej chory / najbardziej chory (ill / more ill / most ill).
-- The others have simple forms: 
-- miły / milszy / najmilszy (kind / kinder / kindest).

-- Polish adjective in particular degree is inflected by case, number and 
-- gender, however each of them has at most only 11 different forms, 
-- as ilustrated on the following table from 
-- the article by Zygmunt Saloni ("Rygorystyczny opis polskiej deklinacji
-- przymiotnikowej" [in:] "Zeszyty naukowe Wydziału Humanistycznego 
-- Uniwersytetu Gdańskiego. Filologia polska. Prace językoznawcze" nr 16
-- year 1992).

-- m1, m2 and m3 mean respectivly masculine personal, masculine animate
-- and masculine inanimate. -m1 means all genders but m1.

--           sg               pl
--      m1 m2 m3 n  f      m1   -m1
--      ---------------------------
--   N |1  1  1  5  6      9     5
--   G |2  2  2  2  7      10    10
--   D |3  3  3  3  7      4     4
--   A |2  2  1  5  8      10    5
--   I |4  4  4  4  8      11    11
--   L |4  4  4  4  7      10    10
--   (V = N)
  
  
--   oper adj11forms : Type = { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 : Str };
-- 
--   oper Adj : Type = {
--     pos : adj11forms;
--     comp : adj11forms;
--     super : adj11forms;
--     advpos : Str;
--     advcomp : Str;
--     advsuper : Str;
--   };
  
  -- temat na spółgłoskę miękką
  
  oper model1 : Str -> adj11forms = \form -> -- glupi
    let stem = Predef.tk 1 form in 
    {
      s1=stem + "i"; s2=stem + "iego"; s3=stem + "iemu"; s4=stem + "im";
      s5=stem + "ie"; s6=stem + "ia"; s7=stem + "iej"; s8=stem + "ią";
      s9=stem + "i"; s10=stem + "ich"; s11=stem + "imi"
    };
    
  oper model1l : Str -> adj11forms = \form -> -- chocholi
    let stem = Predef.tk 1 form in 
    {
      s1=stem + "i"; s2=stem + "ego"; s3=stem + "emu"; s4=stem + "im";
      s5=stem + "e"; s6=stem + "a"; s7=stem + "ej"; s8=stem + "ą";
      s9=stem + "i"; s10=stem + "ich"; s11=stem + "imi"
    };
    
  oper model1j : Str -> adj11forms = \form -> -- żmii
    let stem = Predef.tk 1 form in 
    {
      s1=stem + "i"; s2=stem + "jego"; s3=stem + "jemu"; s4=stem + "im";
      s5=stem + "je"; s6=stem + "ja"; s7=stem + "jej"; s8=stem + "ją";
      s9=stem + "i"; s10=stem + "ich"; s11=stem + "imi"
    };
    
-- temat na spłgłoskę stwardniałą
    
  oper model2 : Str -> adj11forms = \form -> -- wilczy
    let stem = Predef.tk 1 form in 
    {
      s1=stem + "y"; s2=stem + "ego"; s3=stem + "emu"; s4=stem + "ym";
      s5=stem + "e"; s6=stem + "a"; s7=stem + "ej"; s8=stem + "ą";
      s9=stem + "y"; s10=stem + "ych"; s11=stem + "ymi"
    };
    
-- temat na spółgłoskę tylnojęzykową (k lub g)

  oper model3k : Str -> adj11forms = \form -> -- dziki
    let stem = Predef.tk 2 form in 
    {
      s1=stem + "ki"; s2=stem + "kiego"; s3=stem + "kiemu"; s4=stem + "kim";
      s5=stem + "kie"; s6=stem + "ka"; s7=stem + "kiej"; s8=stem + "ką";
      s9=stem + "cy"; s10=stem + "kich"; s11=stem + "kimi"
    };

  oper model3g : Str -> adj11forms = \form -> -- ubogi
    let stem = Predef.tk 2 form in 
    {
      s1=stem + "gi"; s2=stem + "giego"; s3=stem + "giemu"; s4=stem + "gim";
      s5=stem + "gie"; s6=stem + "ga"; s7=stem + "giej"; s8=stem + "gą";
      s9=stem + "dzy"; s10=stem + "gich"; s11=stem + "gimi"
    };
    
-- temat na spółgłoskę twardą TODO
    
  oper model4 : Str -> Str -> adj11forms = \form,form9 -> -- glupi
    let stem = Predef.tk 1 form in 
    {
      s1=stem + "y"; s2=stem + "ego"; s3=stem + "emu"; s4=stem + "ym";
      s5=stem + "e"; s6=stem + "a"; s7=stem + "ej"; s8=stem + "ą";
      s9=form9; s10=stem + "ych"; s11=stem + "ymi"
    };
    
  oper model_comp : Str -> adj11forms = \comp -> model4 comp ((Predef.tk 2 comp)+"i");
  
  oper guess_model : Str -> adj11forms = \form ->
    case form of {
      x + ("pi"|"bi"|"fi"|"wi"|"mi"|"si"|"zi"|"ci"|"dzi"|"ni") => model1 form;
      x + "li" => model1l form;
      x + ("ii"|"yi"|"ai"|"ei"|"oi"|"ui"|"ói") => model1j form;
      x + ("czy"|"dży"|"rzy"|"cy"|"dzy") => model2 form;
      x + "ki" => model3k form;
      x + "gi" => model3g form;
      x + "smy" => model4 form (x+"śmi");
      x + "zmy" => model4 form (x+"źmi");
      x + "sty" => model4 form (x+"śći");
      x + "ty" => model4 form (x+"ci");
      x + "zdy" => model4 form (x+"ździ");
      x + "dy" => model4 form (x+"dzi");
      x + "szy" => model4 form (x+"si");
      x + "smy" => model4 form (x+"śmi");
      x + "ży" => model4 form (x+"zi");
      x + "ry" => model4 form (x+"rzy");
      x + "rzły" => model4 form (x+"źli"); --obmierzły - obmierźli (probably misprint in the article)
      x + "szły" => model4 form (x+"szli");
      x + "zły" => model4 form (x+"źli");
      x + "ły" => model4 form (x+"li");
      x + "sny" => model4 form (x+"śni");
      x + "zny" => model4 form (x+"źni");
      x + "chy" => model4 form (x+"si");
      x + "hy" => model4 form (x+"zi"); -- błahy - błazi (not really in use)
      x + y@("py"|"by"|"fy"|"wy"|"my"|"sy"|"zy"|"ny") => model4 form ((Predef.tk 1 form)+"i")
    };
  
  -- oper for simple forms
  
  oper mkRegAdj = overload {
    mkRegAdj : Str -> Str -> Str -> Str -> Adj =
    \pos, comp, advpos, advcomp -> {
      pos = guess_model pos;
      comp = model_comp comp;
      super = model_comp ("naj" + comp);
      advpos = advpos;
      advcomp = advcomp;
      advsuper = "naj" + advcomp;
    };
    mkRegAdj : Str -> Str -> Adj =
    \pos, comp -> {
      pos = guess_model pos;
      comp = model_comp comp;
      super = model_comp ("naj" + comp);
      advpos = "["++pos ++ [": the adverb positive form does not exist]"];
      advcomp = "["++pos ++ [": the adverb comparative form does not exist]"];
      advsuper = "["++pos ++ [": the adverb superlative form does not exist]"]
    };
  };
  
  oper mkCompAdj = overload {
    mkCompAdj : Str -> Str -> Adj =
    \pos, advpos -> {
      pos = guess_model pos;
      comp = guess_model ("bardziej" ++ pos);
      super = guess_model ("najbardziej" ++ pos);
      advpos = advpos;
      advcomp = ("bardziej" ++ advpos);
      advsuper = ("najbardziej" ++ advpos);
    };
    mkCompAdj : Str -> Adj =
    \pos -> {
      pos = guess_model pos;
      comp = guess_model ("bardziej" ++ pos);
      super = guess_model ("najbardziej" ++ pos);
      advpos = "["++pos ++ [": the adverb positive form does not exist]"];
      advcomp = "["++pos ++ [": the adverb comparative form does not exist]"];
      advsuper = "["++pos ++ [": the adverb superlative form does not exist]"]
    };
  };
  
  addComplToAdj : Adj -> Str -> Case -> (Adj ** { c:Complement });
  addComplToAdj a s c = { pos = a.pos; comp=a.comp; super=a.super;
    advpos=a.advpos; advcomp=a.advcomp; advsuper=a.advsuper;
    c = mkCompl s c
  };  
}
