concrete StructuralSlv of Structural = CatSlv ** open ResSlv, ParadigmsSlv, Prelude in {

lin
  although_Subj = {s="čeprav"} ;
  and_Conj = mkConj "in" Pl ;
  because_Subj = {s="zato ker"} ;
  can_VV = {s = \\vform => case vform of {_ => "lahko"} };
  have_V2 = mkV2 (mkV "iméti" "imá") ; ----AR

  he_Pron = mkPron "òn" "njêga" "njêga" "njêmu" "njêm" "njím"
                   "njegôv"  "njegôvega" "njegôvemu" ("njegôv"|"njegôvega") "njegôvem" "njegôvim" 
                   "njegôva" "njegôvih"  "njegôvima"  "njegôva"             "njegôvih" "njegôvima"
                   "njegôvi" "njegôvih"  "njegôvim"   "njegôve"             "njegôvih" "njegôvimi"
                   "njegôva" "njegôve"   "njegôvi"    "njegôvo"             "njegôvi"  "njegôvo"
                   "njegôvi" "njegôvih"  "njegôvima"  "njegôvi"             "njegôvih" "njegôvima"
                   "njegôve" "njegôvih"  "njegôvim"   "njegôve"             "njegôvih" "njegôvimi"
                   "njegôve" "njegôvega" "njegôvemu"  "njegôvo"             "njegôvem" "njegôvim"
                   "njegôvi" "njegôvih"  "njegôvima"  "njegôvi"             "njegôvih" "njegôvima"
                   "njegôva" "njegôvih"  "njegôvim"   "njegôva"             "njegôvih" "njegôvimi" Masc Sg P3 ;
  here_Adv = {s="tukaj"} ;
  how8much_IAdv = ss "koliko" ;
  i_Pron  = mkPron "jàz" "méne" "méne" "méni" "méni" ("menój"|"máno")
                   "mój"  "mòjega" "mòjemu" ("mòj"|"mòjega") "mòjem" "mòjim" 
                   "mòja" "mòjih"  "mòjima"  "mòja"          "mòjih" "mòjima"
                   "mòji" "mòjih"  "mòjim"   "mòje"          "mòjih" "mòjimi" 
                   "mòja" "mòje"   "mòji"    "mòjo"          "mòji"  "mòjo"
                   "mòji" "mòjih"  "mòjima"  "mòji"          "mòjih" "mòjima"
                   "mòje" "mòjih"  "mòjim"   "mòje"          "mòjih" "mòjimi"
                   "mòje" "mòjega" "mòjemu"  "mòjo"          "mòjem" "mòjim"
                   "mòji" "mòjih"  "mòjima"  "mòji"          "mòjih" "mòjima"
                   "mòja" "mòjih"  "mòjim"   "mòja"          "mòjih" "mòjimi" Masc Sg P1 ;
  if_Subj = ss "če" ;
  in_Prep = mkPrep "v" locative ;
  it_Pron  = mkPron "ôno" "njêga" "njêga" "njêmu" "njêm" "njím" 
                   ("njegôv"|"njegòv")  "njegôvega" "njegôvemu" ("njegôv"|"njegôvega") "njegôvem" "njegôvim" 
                    "njegôva"           "njegôvih"  "njegôvima"  "njegôva"             "njegôvih" "njegôvima"
                    "njegôvi"           "njegôvih"  "njegôvim"   "njegôve"             "njegôvih" "njegôvimi"
                    "njegôva"           "njegôve"   "njegôvi"    "njegôvo"             "njegôvi"  "njegôvo"
                    "njegôvi"           "njegôvih"  "njegôvima"  "njegôvi"             "njegôvih" "njegôvima"
                    "njegôve"           "njegôvih"  "njegôvim"   "njegôve"             "njegôvih" "njegôvimi"
                    "njegôve"           "njegôvega" "njegôvemu"  "njegôvo"             "njegôvem" "njegôvim"
                    "njegôvi"           "njegôvih"  "njegôvima"  "njegôvi"             "njegôvih" "njegôvima"
                    "njegôva"           "njegôvih"  "njegôvim"   "njegôva"             "njegôvih" "njegôvimi" Neut Sg P3 ;
  must_VV = regV "morati" "mora" ;
  or_Conj = mkConj "ali" Sg ;

  she_Pron = variants {mkPron "ôna" "njó" "njé" "njéj" "njéj" "njó" ;
                       mkPron "ôna" "njó" "njé" "njèj" "njèj" "njó" ;
                       mkPron "ôna" "njó" "njé" "njì"  "njì"  "njó"}
                              "njén"  "njénega" "njénemu" ("njéni"|"njénega") "njénem" "njénim"
                              "njéna" "njénih"  "njénima" "njéna"            "njénih" "njénima"     
                              "njéni" "njénih"  "njénim"  "njéne"            "njénih" "njénimi"    
                              "njéna" "njéne"   "njéni"   "njéno"            "njéni"  "njéno"
                              "njéni" "njénih"  "njénima" "njéni"            "njénih" "njénima"
                              "njéne" "njénih"  "njénim"  "njéne"            "njénih" "njénimi"
                              "njéno" "njénega" "njénemu" "njéne"            "njénem" "njénim"
                              "njéni" "njénih"  "njénima" "njéni"            "njénih" "njénima"
                              "njéna" "njénih"  "njénim"  "njéna"            "njénih" "njénimi" Fem Sg P3 ;
  that_Quant = mkQuant "tîsti" "tîstega" "tîstemu" ("tîsti"|"tîstega") "tîstem" "tîstim"
                       "tîstȃ" "tîstih"  "tîstima"  "tîstȃ"            "tîstih" "tîstima"
                       "tîsti" "tîstih"  "tîstim"   "tîste"            "tîstih" "tîstimi"
                       "tîsta" "tîste"   "tîsti"    "tîsto"            "tîsti"  "tîsto"
                       "tîsti" "tîstih"  "tîstima"  "tîsti"            "tîstih" "tîstima"  
                       "tîste" "tîstih"  "tîstim"   "tîste"            "tîstih" "tîstimi"
                       "tîsto" "tîstega" "tîstemu"  "tîsto"            "tîstem" "tîstim"
                       "tîsti" "tîstih"  "tîstima"  "tîsti"            "tîstih" "tîstima"
                       "tîsta" "tîstih"  "tîstim"   "tîsta"            "tîstih" "tîstimi" Def ;
  they_Pron = mkPron "ôni" "njìh" "njìh" "njìm" "njìh" "njími" 
                     "njíhov"  "njíhovega" "njíhovemu" ("njíhov"|"njíhovega") "njíhovem" "njíhovim" 
                     "njíhova" "njíhovih"  "njíhovima"  "njíhova"             "njíhovih" "njíhovima"
                     "njíhovi" "njíhovih"  "njíhovim"   "njíhove"             "njíhovih" "njíhovimi"
                     "njíhova" "njíhove"   "njíhovi"    "njíhovo"             "njíhovi"  "njíhovo"
                     "njíhovi" "njíhovih"  "njíhovima"  "njíhovi"             "njíhovih" "njíhovima"
                     "njíhove" "njíhovih"  "njíhovim"   "njíhove"             "njíhovih" "njíhovimi"
                     "njíhove" "njíhovega" "njíhovemu"  "njíhovo"             "njíhovem" "njíhovim"
                     "njíhovi" "njíhovih"  "njíhovima"  "njíhovi"             "njíhovih" "njíhovima"
                     "njíhova" "njíhovih"  "njíhovim"   "njíhova"             "njíhovih" "njíhovimi" Masc Pl P3 ;
  this_Quant = mkQuant "tȃ" "tȇga" "tȇmu" ("tȃ"|"tȇga") "tȇm" "tȇm"
                       "tȃ" "tȇh"  "tȇma" "tȃ"          "tȇh" "tȇma"
                       "tî" "tȇh"  "tȇm"  "tȇ"          "tȇh" "tȇmi"
                       "tȃ" "té"   "tȇj"  "tȏ"          "tȇj" "tȏ"
                       "tî" "tȇh"  "tȇma" "tî"          "tȇh" "tȇma"
                       "tȇ" "tȇh"  "tȇm"  "tȇ"          "tȇh" "tȇmi"
                       "tȏ" "tȇga" "tȇmu" "tȏ"          "tȇm" "tȇm"
                       "tî" "tȇh"  "tȇma" "tî"          "tȇh" "tȇma"
                       "tȃ" "tȇh"  "tȇm"  "tȃ"          "tȇh" "tȇmi" Def ;
  very_AdA = {s = "zelo"} ; ----AR
  want_VV = regV "želeti" "želi"; 
  we_Pron = mkPron "mí" "nàs" "nàs" "nàm" "nàs" "nàmi" 
                   "nàš"  "nášega" "nášemu" ("náši"|"nášega") "nášem" "nášim"
                   "náša" "náših"  "nášima" "náša"            "náših" "nášima"     
                   "náši" "náših"  "nášim"  "náše"            "náših" "nášimi"    
                   "náša" "náše"   "náši"   "nášo"            "náši"  "nášo"
                   "náši" "náših"  "nášima" "náši"            "náših" "nášima"
                   "náše" "náših"  "nášim"  "náše"            "náših" "nášimi"
                   "náše" "nášega" "nášemu" "náše"            "nášem" "nášim"
                   "náši" "náših"  "nášima" "náši"            "náših" "nášima"
                   "náša" "náših"  "nášim"  "náša"            "náših" "nášimi" Masc Pl P1 ;
  when_IAdv = {s="kdaj"} ;
  when_Subj = {s="medtem ko"} ;
  where_IAdv = {s="kje"} ;

  whatSg_IP = mkNP "káj" "káj" "čésa" "čému" "čém" "čím" Neut Sg ; ----AR
  whoSg_IP = mkNP "kdó" "kóga" "kóga" "kómu" "kóm" "kóm" Masc Sg ; ----AR

  why_IAdv = {s="zakaj"} ;
  with_Prep = mkPrep "z" instrumental ;
  without_Prep = mkPrep "brez" genitive ; ----AR
  youSg_Pron = mkPron "tí" "tébe" "tébe" "tébi" "tébi" ("tebój"|"tábo")
                      "tvój"  "tvòjega" "tvòjemu" ("tvòj"|"tvòjega") "tvòjem" "tvòjim" 
                      "tvòja" "tvòjih"  "tvòjima"  "tvòja"           "tvòjih" "tvòjima"
                      "tvòji" "tvòjih"  "tvòjim"   "tvòje"           "tvòjih" "tvòjimi" 
                      "tvòja" "tvòje"   "tvòji"    "tvòjo"           "tvòji"  "tvòjo"
                      "tvòji" "tvòjih"  "tvòjima"  "tvòji"           "tvòjih" "tvòjima"
                      "tvòje" "tvòjih"  "tvòjim"   "tvòje"           "tvòjih" "tvòjimi"
                      "tvòje" "tvòjega" "tvòjemu"  "tvòjo"           "tvòjem" "tvòjim"
                      "tvòji" "tvòjih"  "tvòjima"  "tvòji"           "tvòjih" "tvòjima"
                      "tvòja" "tvòjih"  "tvòjim"   "tvòja"           "tvòjih" "tvòjimi" Masc Sg P2 ;
  youPl_Pron = mkPron "ví" "vàs" "vàs" "vàm" "vàs" "vàmi"
                      "vàš"  "vášega" "vášemu" ("váši"|"vášega") "vášem" "vášim"
                      "váša" "váših"  "vášima" "váša"            "váših" "vášima"
                      "váši" "váših"  "vášim"  "váše"            "váših" "vášimi"    
                      "váša" "váše"   "váši"   "vášo"            "váši"  "vášo"
                      "váši" "váših"  "vášima" "váši"            "váših" "vášima"
                      "váše" "váših"  "vášim"  "váše"            "váših" "vášimi"
                      "váše" "vášega" "vášemu" "váše"            "vášem" "vášim"
                      "váši" "váših"  "vášima" "váši"            "váših" "vášima"
                      "váša" "váših"  "vášim"  "váša"            "váših" "vášimi" Masc Pl P2 ;
  youPol_Pron = mkPron "ví" "vàs" "vàs" "vàm" "vàs" "vàmi" 
                       "vàš"  "vášega" "vášemu" ("váši"|"vášega") "vášem" "vášim"
                       "váša" "váših"  "vášima" "váša"            "váših" "vášima"     
                       "váši" "váših"  "vášim"  "váše"            "váših" "vášimi"    
                       "váša" "váše"   "váši"   "vášo"            "váši"  "vášo"
                       "váši" "váših"  "vášima" "váši"            "váših" "vášima"
                       "váše" "váših"  "vášim"  "váše"            "váših" "vášimi"
                       "váše" "vášega" "vášemu" "váše"            "vášem" "vášim"
                       "váši" "váših"  "vášima" "váši"            "váših" "vášima"
                       "váša" "váših"  "vášim"  "váša"            "váših" "vášimi" Masc Pl P2 ;
  somebody_NP = mkNP "nekdo" "nekóga" "nekóga" "nekómu" "nekóm" "nekóm" Masc Sg ;
  something_NP = mkNP "nekaj" "nekaj" "nečésa" "nečému" "nečém" "nečīm" Neut Sg ;
  nobody_NP = mkNP "nihčè" "nikȏgar" "nikȏgar" "nikȏmur" "nikȏmer" "nikȏmer" Masc Sg ;
  nothing_NP = mkNP "nìč" "nìč" "ničȇsar" "ničȇmur" "ničȇmer" "ničîmer" Masc Sg ;

}
