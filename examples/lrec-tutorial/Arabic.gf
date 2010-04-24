resource Arabic = {
oper
  Root    : Type = {F,C,L : Str} ;
  Pattern : Type = {F,FC,CL,L : Str} ;

  appPattern : Root -> Pattern -> Str = \r,p ->
    p.F + r.F + p.FC + r.C + p.CL + r.L + p.L ;

  getRoot : Str -> Root = \s -> case s of {
    F@? + C@? + L => {F = F ; C = C ; L = L} ;
    _ => Predef.error ("cannot get root from" ++ s)
    } ;

  getPattern : Str -> Pattern = \s -> case s of {
    F + "F" + FC + "C" + CL + "L" + L => {F = F ; FC = FC ; CL = CL ; L = L} ;
    _ => Predef.error ("cannot get pattern from" ++ s)
    } ;

  getWord : Str -> Str -> Str = \r,p ->
    appPattern (getRoot r) (getPattern p) ;

param
  Number = Sg | Dl | Pl ;
  Gender = Masc | Fem ;
  Tense  = Perf | Impf ;

  VPer = Vp3 Number Gender | Vp2Sg Gender | Vp2Dl | Vp2Pl Gender | Vp1Sg | Vp1Pl ;

oper
  Verb : Type = {s : Tense => VPer => Str} ;  

  pattV_u : Tense -> VPer -> Pattern = \t,v -> getPattern (case t of {
    Perf => case v of {
      Vp3 Sg Masc => "FaCaLa" ;
      Vp3 Sg Fem  => "FaCaLat" ;
      Vp3 Dl Masc => "FaCaLaA" ;
      Vp3 Dl Fem  => "FaCaLataA" ;
      Vp3 Pl Masc => "FaCaLuwA" ;
      Vp3 Pl Fem  => "FaCaLona" ;

      Vp2Sg  Masc => "FaCaLota" ;
      Vp2Sg  Fem  => "FaCaLoti" ;
      Vp2Dl       => "FaCaLotumaA" ;
      Vp2Pl  Masc => "FaCaLotum" ;
      Vp2Pl  Fem  => "FaCaLotunv2a" ;
       
      Vp1Sg       => "FaCaLotu" ;
      Vp1Pl       => "FaCaLonaA"
      } ;
    Impf => case v of {
      Vp3 Sg Masc => "yaFoCuLu" ;
      Vp3 Sg Fem  => "taFoCuLu" ;
      Vp3 Dl Masc => "yaFoCuLaAni" ;
      Vp3 Dl Fem  => "taFoCuLaAni" ;
      Vp3 Pl Masc => "yaFoCuLuwna" ;
      Vp3 Pl Fem  => "yaFoCuLna" ;

      Vp2Sg  Masc => "taFoCuLu" ;
      Vp2Sg  Fem  => "taFoCuLiyna" ;
      Vp2Dl       => "taFoCuLaAni" ;
      Vp2Pl  Masc => "taFoCuLuwna" ;
      Vp2Pl  Fem  => "taFoCuLona" ;
       
      Vp1Sg       => "A?aFoCuLu" ;
      Vp1Pl       => "naFoCuLu"
      }
   }) ;

  u_Verb : Str -> Verb = \s -> {
    s = \\t,p => appPattern (getRoot s) (pattV_u t p)
    } ;

-- for html

  tag : Str -> Str = \t -> "<" + t + ">" ;
  etag : Str -> Str = \t -> "</" + t + ">" ;
  atag : Str -> Str -> Str = \t,a -> "<" + t ++ a + ">" ;

  intag : Str -> Str -> Str = \t,s -> tag t ++ s ++ etag t ;
  intagAttr : Str -> Str -> Str -> Str = \t,a,s -> atag t a ++ s ++ etag t ;

  verbTable : Verb -> Str = \v -> 
    let 
      vsp = v.s ! Perf ;
      vsi = v.s ! Impf ;
      tr : Str -> Str = intag "tr" ;
      td : Str -> Str = intag "td" ;
      ts : Str -> Str = \s -> td ("\"" ++ s ++ "\"") ;
      trs : Str -> Str -> VPer -> Str = \s,n,v -> 
        tr (td s ++ td n ++ ts (vsp ! v) ++ ts (vsi ! v))
    in 
    intagAttr "table" "border=1" (
       tr ((td "Persona") ++ (td "Numerus") ++ (td "Perfectum") ++ (td "Imperfectum")) ++
       trs "3. masc." "sing." (Vp3 Sg Masc) ++
       trs "3. fem."  "sing." (Vp3 Sg Fem) ++
       trs "2. masc." "sing." (Vp2Sg Masc) ++
       trs "2. fem."  "sing." (Vp2Sg Fem) ++
       trs "1."       "sing." (Vp1Sg) ++
       trs "3. masc." "dual." (Vp3 Dl Masc) ++
       trs "3. fem."  "dual." (Vp3 Dl Fem) ++
       trs "2."       "dual." (Vp2Dl) ++
       trs "3. masc." "plur." (Vp3 Pl Masc) ++
       trs "3. fem."  "plur." (Vp3 Pl Fem) ++
       trs "2. masc." "plur." (Vp2Pl Masc) ++
       trs "2. fem."  "plur." (Vp2Pl Fem) ++
       trs "1."       "plur." (Vp1Pl)
      ) ;


}
