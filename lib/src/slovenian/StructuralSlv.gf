concrete StructuralSlv of Structural = CatSlv ** open ResSlv, ParadigmsSlv in {

lin
  he_Pron = mkPron "òn" "njêga" "njêga" "njêmu" "njêm" "njím" Masc Sg P3 ;
  i_Pron  = mkPron "jàz" "méne" "méne" "méni" "méni" ("menój"|"máno") Masc Sg P1 ;
  it_Pron  = mkPron "ôno" "njêga" "njêga" "njêmu" "njêm" "njím" Neut Sg P3 ;
  she_Pron = variants {mkPron "ôna" "njó" "njé" "njéj" "njéj" "njó" Fem Sg P3 ;
                       mkPron "ôna" "njó" "njé" "njèj" "njèj" "njó" Fem Sg P3 ;
                       mkPron "ôna" "njó" "njé" "njì"  "njì"  "njó" Fem Sg P3 } ;
  they_Pron = mkPron "ôni" "njìh" "njìh" "njìm" "njìh" "njími" Masc Pl P3 ;
  we_Pron = mkPron "mí" "nàs" "nàs" "nàm" "nàs" "nàmi" Masc Pl P1 ;
  youSg_Pron = mkPron "tí" "tébe" "tébe" "tébi" "tébi" ("tebój"|"tábo") Masc Sg P2 ;
  youPl_Pron = mkPron "ví" "vàs" "vàs" "vàm" "vàs" "vàmi" Masc Pl P2 ;
  youPol_Pron = mkPron "ví" "vàs" "vàs" "vàm" "vàs" "vàmi" Masc Pl P2 ;
  somebody_NP = mkNP "nekdo" "nekóga" "nekóga" "nekómu" "nekóm" "nekóm" Masc Sg ;
  something_NP = mkNP "nekaj" "nekaj" "nečésa" "nečému" "nečém" "nečīm" Neut Sg ;
  nobody_NP = mkNP "nihčè" "nikȏgar" "nikȏgar" "nikȏmur" "nikȏmer" "nikȏmer" Masc Sg ;
  nothing_NP = mkNP "nìč" "nìč" "ničȇsar" "ničȇmur" "ničȇmer" "ničîmer" Masc Sg ;

}
