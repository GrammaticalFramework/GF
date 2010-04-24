concrete GrammarIta of Grammar = open ResIta, Prelude in {
  lincat  
    Cl = {s : ResIta.Tense => Str} ; 
    NP = ResIta.NP ;          -- {s : Case => {clit,obj : Str} ; a : Agr} ; 
    VP = ResIta.VP ;          -- {v : Verb ; clit : Str ; obj : Str} ;
    AP = {s : Gender => Number => Str ; isPre : Bool} ;
    CN = Noun ;               -- {s : Number => Str ; g : Gender} ;
    Det = {s : Gender => Case => Str ; n : Number} ;
    N = Noun ;                -- {s : Number => Str ; g : Gender} ;
    A = Adj ;                 -- {s : Gender => Number => Str ; isPre : Bool} ;
    V = Verb ;                -- {s : VForm => Str ; aux : Aux} ;
    V2 = Verb ** {c : Case} ;

  lin
    PredVP np vp = 
      let 
        subj = (np.s ! Nom).obj ;
        obj  = vp.obj ;
        clit = vp.clit ;
        verb = table {
          Pres => agrV vp.v np.a ;
          Perf => agrV (auxVerb vp.v.aux) np.a ++ agrPart vp.v np.a 
          }
      in {
        s = \\t => subj ++ clit ++ verb ! t ++ obj
      } ;

    ComplV2 v2 np = 
      let
        nps = np.s ! v2.c
      in {
        v = {s = v2.s ; aux = v2.aux} ; 
        clit = nps.clit ; 
        obj  = nps.obj
        } ;

    UseV v = {
      v = v ; 
      clit = [] ; 
      obj = []
      } ;

    DetCN det cn = {
      s = \\c => {obj = det.s ! cn.g ! c ++ cn.s ! det.n ; clit = []} ;
      a = Ag cn.g det.n Per3
      } ;

    ModCN cn ap = {
      s = \\n => preOrPost ap.isPre (ap.s ! cn.g ! n) (cn.s ! n) ;
      g = cn.g
      } ;

    UseN n = n ;

    UseA adj = adj ;

    a_Det = adjDet (mkA "un" "una" [] [] True) Sg ;

    the_Det = {
      s = table {
        Masc => table {
          Nom | Acc => pre {"il" ; "lo" / s_impuro ; "l'" / vowel} ;
          Dat => pre {"al" ; "allo" / s_impuro ; "all'" / vowel}
          } ;
        Fem => table {
          Nom | Acc => pre {"la" ; "l'" / vowel} ;
          Dat => pre {"alla" ; "all'" / vowel}
          }
        } ;
      n = Sg
      } ;
        
    this_Det = adjDet (mkA "questo") Sg ;
    these_Det = adjDet (mkA "questo") Pl ;

    i_NP =   pronNP "io"  "mi" "mi" Masc Sg Per1 ;
    she_NP = pronNP "lei" "la" "le" Fem  Sg Per3 ;
    we_NP =  pronNP "noi" "ci" "ci" Masc Pl Per1 ;

}
