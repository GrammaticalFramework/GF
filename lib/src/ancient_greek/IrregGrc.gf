--# -path=.:prelude:../abstract:../common

concrete IrregGrc of IrregGrcAbs = CatGrc ** open ParadigmsGrc in {

-- BR 121 (partial) TODO: uncomment IrregGrc in LexiconGrc.gf

lin
  -- verba vocalia, simple ones
  paideyw_V = mkV "paidey'w" "paidey'sw" "e)pai'deysa" "pepai'deyka" "pepai'deymai" "e)paidey'vhn" "paideyto's" ;     -- educate
  mhnyw_V   = mkV "mhny_'w" "mhny_'sw" "e)mh'ny_sa" "memh'ny_ka" "memh'ny_mai" "emhny_'vhn" "mhny_to's" ;  -- zeige an
  payw_V    = mkV "pay'w" "pay'sw" "e)'paysa" "pe'payka" "pe'paymai" "e)pay'vhn" "payste'on" ;             -- mache aufhoeren
  vhraw_V   = mkV "vhra'w" "vhra_'sw" "e)vh'ra_sa" "tevh'ra_ka" "tevh'ra_mai" "e)vhra_'vhn" "vhra_vo's" ;  -- jage
  timaw_V   = mkV "ti_ma'w" "ti_mh'sw" "e)ti_'mhsa" "teti_'mhka" "teti_'mhmai" "e)ti_mh'vhn" "ti_mhto's" ; -- ehre
  poiew_V   = mkV "poie'w" "poih'sw" "e)poi'hsa" "pepoi'hka" "pepoi'hmai" "e)poih'vhn" "poihto's" ;        -- tue
  doylow_V  = mkV "doylo'w" "doylw'sw" "e)doy'lwsa" "dedoy'lwka" "dedoy'lwmai" "e)doylw'vhn" "doylwto's" ; -- knechte
  -- verba vocalia, with exceptions
  eaw_V     = mkV "e)a'w" "ea_'sw" "ei)'a_sa" "ei)'a_ka" "ei)'a_mai" "ei)a_'vhn" "e)a_to's" ;              -- lasse zu
  dew_V     = mkV "de'w" "dh'sw" "e)'dhsa" "de'deka" "de'demai" "e)de'vhn" "deto's" ;                      -- binde
  lyw_V     = mkV "ly_'w" "ly_'sw" "e)'ly_sa" "le'ly.ka" "le'ly.mai" "e)ly.'vhn" "ly.vo's" ;               -- loese
  vyw_V     = mkV "vy_'w" "vy_'sw" "e)'vy_sa" "ve'vy.ka" "ve'vy.mai" "e)ty.'vhn" "vy.te'on" ;              -- opfere
  dyw_V     = mkV "dy'w" "dy_'sw" "e)'dvy_sa" "de'dy.ka" "de'dy.mai" "e)dy.'vhn" "dy.to's" ;               -- versenke
  --  med.               "dy_'somai" "e)'dy_n" "de'dy_ka"                                                  -- versinke
--  fyw_V     = mkV "fy_'w" "fy_'sw" "e)'fy_sa" nonExists nonExists nonExists "fy.to'n" ;                    -- erzeuge
  --  med.                "fy_'somai" "e)'fy_n" "pe'fy_ka"                                                 -- entstehe
  epainew_V = prefixV "e)p" 
             (mkV "ai)ne'w" "ai)ne'somai" "h|)'nesa" "h|)'neka" "h|)'nhmai" "h|)ne'vhn" "ai)neto's") ;     -- lobe
--  crhsvai_V = mkV "crh~svai" "crh'somai" "e)crhsa'mhn" nonExists "ke'crhmai" " e)crh'svhn" "crhsto's" ;    -- gbrauche
  spaw_V    = mkV "spa'w" "spa'sw" "e)'spasa" "e)'spaka" "e)'spasmai" "e)spa'svhn" "spasvo's" ;            -- ziehe
--  gelaw_V   = mkV "gela'w" "gela'somai" "e)ge'lasa" nonExists "gege'lasmai" "e)gela'svhn" "gelasvo's" ;    -- lache aus
  telew_V   = mkV "tele'w" "telw~" "e)te'lesa" "tete'leka" "tete'lesmai" "e)tele'svhn" "telesto's" ;       -- vollende
--  aideomai_V = mkV "ai)de'omai" "ai)de'somai" nonExists nonExists "h|)'desmai" "h|)de'svhn" nonExists ;    -- scheue mich
--  arkew_V   = mkV "a)rke'w" "a)rke'sw" "h)'rkesa" nonExists nonExists nonExists nonExists ;                -- genuege
  kalew_V   = mkV "kale'w" "kalw~" "e)ka'lhsa" "ke'klhka" "ke'klhmai" "e)klh'vhn" "klhto's" ;              -- rufe, nenne
  keleyw_V  = mkV "keley'w" "keley'sw" "e)ke'leysa" "keke'leyka" "keke'leysmai" "e)keley'svhn" "keleyso's" ; -- befehle
  kleiw_V   = mkV "klei'w" "klei'sw" "e)'kleisa" "ke'kleika" "ke'kleimai" "e)klei'svhn" "kleisto's" ;      -- schliesse
  criw_V    = mkV "cri_'w" "cri_'sw" "e)'cri_sa" "ke'cri_ka" "ke'cri_mai" "e)cri_'svhn" "cri_sto's" ;      -- salbe
  akoyw_V   = mkV "a)koy'w" "a)koy'somai" "h)'koysa" "a)kh'koa" "h)'koysmai" "h)koy'svhn" "a)koysto's" ;   -- hoere
--   kaiw_V    = mkV2 "kai'w" "kay'sw" "e)'kaysa" "ke'kayka" "ke'kaymai" "e)kay'vhn" 
--                                                                    (variants {"kaysto's"; "kayto's"}) ;    -- brenne
--   klaiw_V   = mkV "klai'w" "klay'somai" "e)'klaysa" nonExists "ke'klaymai" "e)klay'vn" "klaysto's" ;       -- weine
--   plew_V    = mkV "ple'w" "pley'somai" "e)'pleysa" "pe'pleyka" nonExists nonExists nonExists ;             -- fahre zur See
--   pnew_V    = mkV "pne'w" "pney'somai" "e)'pneysa" "pe'pneyka" nonExists nonExists nonExists ;             -- hauche
--   rew_V     = mkV "re'w" "ryh'somai" "e)rry'hn" "e)rry'hka" nonExists nonExists nonExists ;                -- fliesse
  cew_V     = mkV "ce'w" "ce'w" "e)'cea" "ke'cyka" "ke'cymai" "e)cy'vhn" "cyto's" ;                        -- giesse 
  -- verba muta, labialia 32-42
  pempw_V   = mkV "pe'mpw" "pe'mqw" "e)'pemqa" "pe'pompa" "pepemmai" "e)pemfvhn" "pempto's" ;              -- schicke
  grafw_V   = mkV "gra'fw" "gra'qw" "e)'grafa" "ge'grafa" "ge'grammai" "e)gra'fhn" "grapto's" ;            -- schreibe
  -- verba muta, gutturalia 43-55
  -- verba muta, dentalia 56-65
  -- verba liquida, 66-80
  -- BR 123, nasal class, 1-17
--  temnw_V   = mkV "te'mnw" "temw~" "e)'temon" "te'tmhka" "te'tmhmai" "e)tmh'vhn" "tmhto's" ;               -- schneide
  -- BR 124, -skw -class, 1-9
  -- BR 125, reduplication class 1-7
  -- BR 126, E-class, 1-11
  -- BR 127, mix class 1-17

oper nonExists : Str = "BUG" ;
}



