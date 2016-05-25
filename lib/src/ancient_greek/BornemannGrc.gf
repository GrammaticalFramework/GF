--# -path=.:../abstract:../common:../prelude

-- in mkN we may write "...os" instead of "...os*"

concrete BornemannGrc of Bornemann = 
  CatGrc ** open ParadigmsGrc, (M=MorphoGrc) in {

  flags optimize=values ;

lin


-- A-declension, examples from Bornemann/Risch, Griechische Grammatik, BR 32

  idea_N = mkN "i)de'a_" ;          -- "i)de'a_"   Form, Gestalt  
  chora_N = mkN "cw'ra_" ;          -- "cw'ra_"    Land
  stratia_N = mkN "stratia_'" ;     -- "stratia_'" Heer
  doxa_N = mkN "do'xa" "do'xhs*" ; -- "do'xa."    Meinung
  glotta_N = mkN "glw~tta" "glw'tths*";        -- "glw~tta."  Zunge
  macha_N = mkN "ma'ch" ;          -- "ma.'ca_"   Kampf
  nika_N = mkN "ni'kh" "ni'khs*" "ni~kai" ;    -- "ni_'ka_" Sieg
  tima_N = mkN "timh'" ;           -- "ti_mh'"    Ehre
  thalatta_N = mkN "va'latta" "vala'tths*";    -- "va'latta."  Meer
  gephyra_N = mkN "ge'fyra" "gefy'ras*";       -- "ge'phu_ra." Bruecke

  -- Masculina ending in -a_s*, -hs*  BR 33
  neanias_N = mkN "neani'as*" ;    -- "nea_ni.'a_" Juengling
  polita_N = mkN "poli'ths*" "poli~tai" ; -- "poli_'ta_", Buerger accentChange i~ta, i~tai 
  dikasta_N = mkN "dikasth's*" ;   -- Richter
  atreida_N = mkN "A)trei='dhs*" "A)trei=~dai" ; -- Atride
  -- Contracta of the A-declension: -aa_ > a_, ea_ > h    BR 34
  athena_N = mkN "A)vhna~" ;       -- Athena
  gea_N = mkN "gh~" ;              -- Erde 
  hermea_N = mkN "E(rmh~s*" ;      -- Hermes

-- O-declension

  -- Nouns ending in -os or -on: BR 36
  logos_N = mkN "lo'gos" ;        -- Wort, Rede 
  demos_N = mkN "dh~mos" ;          -- Volk
  anthropos_N = mkN "a)'nvrwpos" "a)nvrw'poy" masculine ;  -- Mensch
  hodos_N = mkN feminine (mkN "o(do's*") ;  -- Weg 
  doron_N = mkN "dw~ron" ;                  -- Geschenk
-- ergon_N = mkN "e)'rgon" ;    -- TESTWORD

  -- 3 ending adjectives:

  dikaios_A = mkA "di'kaios*" "dikai'a_s*" ; -- gerecht
  neos_A = mkA "ne'os" ; 
  idios_A = mkA "i)'dios" ; 
  patrwos_A = mkA "patrw|~os" ;    -- vaeterlich
  aisxros_A = mkA "ai)sxro's" ;    -- haesslich
  philos_A = mkA "fi'los" ; 
  delos_A = mkA "dh~los" ;
  lithinos_A = mkA "li'vinos" ;
  oligos_A = mkA "o)li'gos" ;
  agathos_A = mkA "a)gavo's" ;             -- gut
  
  nous_N = mkN "noy~s*" ;
  osteon_N = mkN "o)stoy~n" ;               -- Knochen
  eunous_A = mkA "ey)'noys" ;

  argyrous_A = mkA "a)rgyroy~s" ; -- silvern
  chrysous_A = mkA "crysoy~s" ;   -- golden


  news_N = mkN "new's*" ; -- nounOs added 2/16
  Meneleos_PN = mkPN (mkN "Menele'os") singular ;
  ilews_A = mkA "i_('lews" ;

-- Declension III for nouns and adjectives
  -- BR 42: stem ending in -r or -l 
  krathr_N = mkN "kra_th'r" "kra_th~ros" masculine ;
  rhtwr_N = mkN "rh'twr" "rh'toros" masculine ;
  als_N = mkN "a('ls" "a(lo's" masculine ;
  vhr_N = mkN "vh'r" "vhro's" masculine ;
  -- BR 43: stem ending in -k,-g,-c or -p,-b,-f
  fylax_N = mkN "fy'lax" "fy'lakos" masculine ;
  aix_N = mkN "ai)~x" "ai)go's" feminine ;
  gyps_N = mkN "gy_'ps" "gy_po's" masculine ;
  fleps_N = mkN "fle'ps" "flebo's" feminine ;
  -- BR 44: stem ending in -t,-d,-v
  esvhs_N = mkN "e)svh's" "e)svh~tos" feminine ;
  elpis_N = mkN "e)lpi.'s" "e)lpi'dos" feminine ;
  caris_N = mkN "ca'ri.s" "ca'ritos" feminine ; -- 
  swma_N = mkN "sw~ma" "sw'matos" neuter ;
  -- BR 45: stem ending in -n
  ellhn_N = mkN "E('llhn" "E('llhnos" masculine ;
  agwn_N = mkN "a)gw'n" "a)gw~nos" masculine ;
  poimhn_N = mkN "poimh'n" "poime'nos" masculine ; -- sgVoc falsch, datPl falsch
  daimwn_N = mkN "dai'mwn" "dai'monos" masculine ; -- datPl daimousi; richtig daimosi
  -- BR 46: stem in -nt
  gigas_N = mkN "gi'ga_s" "gi'gantos" masculine ;  -- sgVoc falsch
  odoys_N = mkN "o)doy's" "o)do'ntos" masculine ;  -- 
  gerwn_N = mkN "ge'rwn" "ge'rontos" masculine ;   -- 

-- Adjectives of 3rd declension:
  -- BR 44: stem ending in -t,-d,-v
--  acaris_A = mkA "a)'caris" "a)ca'ritos" ;  -- TODO adj3
--  eyelpis_A = mkA "ey)'elpis" "ey)elpi'dos" ; -- TODO adj3
--  apolis_A = mkA "a)'polis" "a)po'lidos" ;  -- TODO adj3
--  agnws_A = mkA "a)gnw's" "a)gnw~tos" ;  -- BR 57, 1-ending  TODO adj3
--  penhs_A = mkA "pe'nhs" "pe'nhtos" ; -- TODO adj3/adjustAccent
--  fygas_A = mkA "fyga's" "fyga'dos" ; -- TODO adj3
--  apais_A = mkA "a)'pais" "a)'paidos" ; -- TODO adj3
--  makar_A = mkA "ma'kar" "ma'karos" ; -- TODO adj3
  pepaideykws_A = mkA "pepaideykw's" ;   -- BR 44.6

  -- BR 45: stem ending in -n
  eydaimwn_A = mkA "ey)dai'mwn" "ey)dai'monos"   ; -- datPl daimousi; richtig daimosi

-- BR 46.b 
  pas_A = mkA "pa~s" "panto's" ;
  ekwn_A = mkA "e(kw'n" "e(ko'ntos" ;
  lywn_A = mkA "ly_'wn" "ly_'ontos" ;
  lysas_A = mkA "ly_'sas" "ly_'santos" ;
  veis_A = mkA "vei's" "vento's" ;
  dys_A = mkA "dy_'s" "dy'ntos" ;
  carieis_A = mkA "cari'eis" "cari'entos" ;

-- BR 47: stems ending in -r with 3 ablautlevels 
  pathr_N = mkN "path'r" "patro's" "pate'ra" masculine ;
  mhthr_N = mkN "mh'thr" "mhtro's" "mhte'ra" feminine ;
  vygathr_N = mkN "vyga'thr" "vygatro's" "vygate'ra" feminine ;
  gasthr_N = mkN "gasth'r" "gastro's" feminine ;
  anhr_N = mkN "a)nh'r" "a)ndro's" "a)'ndra" masculine ;

-- BR 48: stems ending in -s
  genos_N = mkN "ge'nos" "ge'noys" neuter ;
  diogenhs_PN = mkPN "Dioge'nhs" masculine ; -- mkN "Dioge'nhs" "Dioge'noys" masculine ;
  periklhs_PN = mkPN "Periklh~s" masculine ;
  philosopher_N = mkN "filo'sofos" "filoso'foy" masculine ; -- filosofos
-- For stems ending a vowel:
-- BR 49: -i with ablaut -e:
  polis_N = mkN "po'lis" "po'lews" feminine ;
  dynamis_N = mkN "dy'namis" "dyna'mews" feminine ;
-- -y with ablaut -e:
  phcys_N = mkN "ph~cys" "ph'cews" feminine ;      -- TODO to a)'sty
  asty_N = mkN "a)'sty" "a)'stews" neuter ;
-- BR 51: -y_ or -y without ablaut:
  icvys_N = mkN "icvy~s" "icvy'os" masculine ;
  sys_N = mkN "sy~s" "syo's" masculine ; -- and feminine
  erinys_N = mkN "E)ri_ny_'s" "E)ri_ny'os" feminine ;
  pitys_N = mkN "pi'ty.s" "pi'tyos" feminine ;
-- BR 52: stems ending in -ey 
  basileys_N = mkN "basiley's" "basile'ws" masculine ; 
-- BR 53: -oy, -ay, -ey
  boys_N = mkN "boy~s" "boo's" masculine ; -- also: feminine
  nays_N = mkN "nay~s" "new's" feminine ;  
--  zeys_PN = mkPN (mkN "zey's" "dio's" masculine) singular ; -- TODO: zey'n > di'a ; no Pl
  zeys_PN = mkPN "Zey's*" "Dio's*" "Dii='" "Di'a" "Zey~" masculine ;
-- BR 54: -w
  peivw_N = mkN "peivw'" "peivoy~s" feminine ;
  hrws_N = mkN "h('rws" "h('rwos" masculine ;

-- W-Conjugation
-- a) verba vocalia
  paideyw_V = mkV "paidey'w" ;
  timaw_V   = mkV "tima'w" ; -- "timh'sw" ;
  poiew_V   = mkV "poie'w" ; -- "poih'sw" ;
  doylow_V  = mkV "doylo'w" ; -- "doylw'sw" ;

-- b) verba muta
-- labial
  leipw_V   = mkV "lei'pw" "lei'qw" "e)'lipa" "le'loipa" "le'leipmai" "e)lei'fvhn" "leipto's" ;
  elleipw_V = prefixV "e)'n" -- gf does not permit to reuse leipw_V: prefixV "e)'n" leipw_V ; 
              (mkV "lei'pw" "lei'qw" "e)'lipa" "le'loipa" "le'leipmai" "e)lei'fvhn" "leipto's") ;
-- 1. simple ones (present stem = verbal stem)
  trepw_V = mkV "tre'pw" ;
  grafw_V = mkV "gra'fw" ;
  tribw_V = mkV "tri_'bw" ;
  diwkw_V = mkV "diw'kw" ;
  arcw_V  = mkV "a)'rcw" ;
  legw_V  = mkV "le'gw" ;
  anytw_V = mkV "a(ny'tw" ;
  peivw_V = mkV "pei'vw" ;
  pseydw_V = mkV "psey'dw" ;

  typtw_V = mkV "ty'ptw" ;
  kryptw_V = mkV "kry'ptw" ;
  blabtw_V = mkV "bla'ptw" ;  -- stem blab !
  fylattw_V = mkV "fyla'ttw" ; -- stem fylak ! BUG with mC: tt>st

  ktizw_V = mkV "kti'zw" ;   -- j-stem cannot be guessed, need a good mkVerbW7mut !
  nomizw_V = mkV "nomi'zw" "nomiw~" "e)no'misa" "neno'mika" "neno'mismai" "e)nomi'svhn" "nomisto's" ; 
  swzw_V = mkV "sw|'zw" ;
  scizw_V = mkV "sci'zw" ;
  evize_V = "e)vi'zw" ;

-- c) verba liquida
  derw_V    = mkV "de'rw" ;
  menw_V    = mkV "me'nw" ;
  nemw_V    = mkV "ne'mw" ;
  angellw_V = mkV "a)gge'llw" ;
  fainw_V   = mkV "fai'nw" ;
--  fainw_V   = mkV "fai'nw" "fanw~" "e)'fhna" "pe'fagka" "pe'fasmai" "e)fa'nhn" "fanto's";

--deponents 
  veaomai_V = mkV "vea'omai" depMed ;
  acvomai_V = mkV "acvomai" depPass ;

-- Mi-Conjugation, present stem with reduplication:
  tivhmi_V  = mkV "ti'vhmi" "vh'sw" "e)'vhka" "te'vhka" "kei~mai" "e)te'vhn" "veto's" ;
--  ihmi_V    = mkV "i('hmi" "h('sw" "h(~ka" "ei(~ka" "ei(~mai" "ei('vhn" "e(to's" ;
  didwmi_V  = mkV "di'dwmi" "dw'sw" "e)'dwka" "de'dwka" "de'domai" "e)do'vhn" "doto's" ; 
--  isthmi_V  = mkV "i('svhmi" "svh'sw" "e)'svhsa"
-- Mi-Conjugation, present stem with -ny-
  deiknymi_V = mkV "dei'knymi" "dei'xw" "e)'deixa" "de'deica" "de'deigmai" "e)dei'cvhn" "deikto's" ;
-- Mi-Conjugation, present stem as verbal root:
-- "ei)mi'"

-- Example sentence: Greek school tablet, F.G.Kenyon
-- Pyvagoras filosofos apobas kai grammata didaskwn syneboyleyen tois eaytoy mavhtais enaimonwn apecesvai.
-- Pythagoras the philospher when going away and teaching letters advised his students to abstain from meat.

  pythagoras_PN = mkPN (mkN "Pyva'goras") singular ;
--  advise_V = prefixV "sy'n" (mkV "boyley'w") ;
  advise_V2V = mkV2V (prefixV "sy'n" (mkV "boyley'w")) datPrep ;
  abstain_V2 = mkV2 (prefixV "a)po'" (mkV "e)'cw")) genPrep ;  -- apecw tina tinos + apecomai tinos V3/Vrefl?
  -- leave_V2 = dirV2 (prefixV "a)po'" (mkV "bai'nw")) ; -- LexiconGrc
  -- student_N = mkN masculine (mkN "mavhth's*") ; -- LexiconGrc, TODO check
   -- teach_V2 = mkV2 "dida'skw" ;  -- LexiconGrc
  letter_N = mkN "gra'mma" "gra'mmatos" neuter ;
  eimi_V = lin V (MorphoGrc.eimi_V) ;

  pistos_A2 = mkA2 (mkA "pisto's") datPrep ;
} ;


