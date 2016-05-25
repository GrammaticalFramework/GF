abstract Bornemann = Cat ** {

fun 
-- A-declension of nouns and adjectives

-- Femina ending in -a_, -h, -a.  BR 32

  idea_N : N ;     -- Form, Gestalt
  chora_N : N ;    -- Land
  stratia_N : N ;  -- Heer
  doxa_N : N ;     -- Meinung
  glotta_N : N ;   -- Zunge

  macha_N : N ;    -- Kampf
  nika_N : N ;     -- Sieg
  tima_N : N ;     -- Ehre
  thalatta_N : N ; -- Meer
  gephyra_N : N ;  -- Bruecke

-- Masculina ending in -a_s*, -hs*  BR 33

  neanias_N : N ;  -- Juengling
  polita_N : N ;   -- Buerger
  dikasta_N : N ;  -- Richter
  atreida_N : N ;  -- Atride

-- Contracta of the A-declension

  athena_N : N ;   -- Athena
  gea_N : N ;      -- Erde 
  hermea_N : N ;   -- Hermes

-- O-declension

-- Nouns ending in -os* (Masc of Fem), -on (Neutr)

  logos_N : N ;    -- Wort, Rede
  demos_N : N ;    -- Volk
  anthropos_N : N ;  -- Mensch
  hodos_N : N ;    -- Weg
  doron_N : N ;    -- Geschenk
--  ergon_N : N ;

-- Adjectives of A- or O-declination
 
  dikaios_A : A ;    -- gerecht
  neos_A : A ;       -- neu
  idios_A : A ;      -- eigen
  dikaios_A : A ;    -- gerecht
  patrwos_A : A ;    -- vaeterlich
  aisxros_A : A ;    -- haesslich
  philos_A : A ;     -- lieb
  delos_A : A ;      -- offenbar
  lithinos_A : A ;   -- steinern
  oligos_A : A ;     -- wenig
  agathos_A : A ;    -- gut

-- Contracta of the O-declension

-- Nouns and adjectives of 2 endings

  nous_N : N ;
  osteon_N : N ;
  eunous_A : A ;

-- Adjectives (3-ending) of A- and O-declension

  argyrous_A : A ;
  chrysous_A : A ;

-- Attical O-declension

  news_N : N ;
  Meneleos_PN : PN ;
  ilews_A : A ;

-- Noun declension III 

  krathr_N : N ; -- stem in -r, -l   BR 42
  rhtwr_N : N ;
  als_N : N ;
  vhr_N : N ;
  fylax_N : N ;  -- gutturals -k, -g, -x   BR 43
  aix_N : N ;
  gyps_N : N ;   -- labials -p, -b, -f
  fleps_N : N ;
  esvhs_N : N ;  -- dentals -t, -d, -v   BR 44
  elpis_N : N ; 
  caris_N : N ;
  swma_N : N ;
  ellhn_N : N ;  -- stem in -n   BR 45
  agwn_N : N ;
  poimhn_N : N ;
  daimwn_N : N ;
  gigas_N : N ;  -- stem in -nt   BR 46
  odoys_N : N ;
  gerwn_N : N ;

-- stems ending in -r with 3 ablautlevels  BR 47
  pathr_N : N ;
  mhthr_N : N ;
  vygathr_N : N ;
  gasthr_N : N ;
  anhr_N : N ;

-- stems ending in -s  BR 48
  genos_N : N ;
  eugenhs_A : A ;
  diogenhs_PN : PN ;
  periklhs_PN : PN ;
  philosopher_N : N ; -- filosofos_N : N ; 

-- stems ending in i with ablaut e  BR 49
  polis_N : N ;
  dynamis_N : N ;

-- stems ending in y with ablaut
  phcys_N : N ;
  asty_N : N ;
  hdys_A : A ;

-- pure stems ending in y
  icvys_N : N ; 
  sys_N : N ;
  erinys : N ;
  pitys_N : N ;

-- stems ending in ey  BR 52
  basileys_N : N ;

-- monosyllabic stems ending in ou, au, eu  BR 53
  boys_N : N ;
  nays_N : N ;
  zeys_PN : PN ;

-- stems ending in oi and w  BR 54
  peivw_N : N ;
  hrws_N : N ;

-- Adjectives of the 3rd declension:

  -- BR 44: stem ending in -t,-d,-v
  acaris_A : A ;   -- BR 44.5
  eyelpis_A : A ;  
  apolis_A : A ;
  agnws_A : A ;    -- BR 57, 1-ending
  penhs_A : A ;
  fygas_A : A ;
  apais_A : A ;
  makar_A : A ;
  pepaideykws_A : A ; -- BR 44.6

  -- BR 45: stem ending in -n
  eydaimwn_A : A ;

  -- BR 46: stem ending in -nt
  pas_A : A ;
  ekwn_A : A ;
  lywn_A : A ;
  lysas_A : A ;
  veis_A : A ;
  dys_A : A ;
  carieis_A : A ;

-- Verbs
-- w-conjugation:
-- a) verba vocalia, i.e. verbal stem ends in a vowel
  paideyw_V : V ;  -- BR 91
  timaw_V : V ;    -- BR 93, with contraction
  poiew_V : V ;    
  doylow_V : V ;

-- b) verba muta, i.e. verbal stem ends in muta consonant (p,b,f | t,d,v | k,g,c)
  leipw_V : V ;     -- BR 99 - BR 102
  elleipw_V : V ;   -- prefix-verb en+leipw
  trepw_V : V ;     -- BR 99.1
  grafw_V : V ;
  tribw_V : V ;
  diwkw_V : V ;
  arcw_V : V ;
  legw_V : V ;
  anytw_V : V ;
  peivw_V : V ;
  pseydw_V : V ;

  typtw_V : V ;
  kryptw_V : V ; 
  blabtw_V : V ;
  fylattw_V : V ;

  ktizw_V : V ;
  nomizw_V : V ;
  swzw_V : V ;
  scizw_V : V ;
  evizw_V : V ;

-- c) verba liquida, i.e. verbal stem ends in liq.consonant (l,r) or nasal (m,n,(n)g) 
  derw_V : V ;
  menw_V : V ;
  nemw_V : V ;   
  angellw_V : V ;
  fainw_V : V ;

-- deponents
  veaomai_V : V ;
  acvomai_V : V ;

-- mi-conjugation:
  tivhmi_V : V ; -- BR 129 mi-verbs with reduplication in the present stem
  ihmi_V : V ;
  didwmi_V : V ;
--  isthmi_V : V ;

  deiknymi_V : V ;

-- Greek tablets:
  pythagoras_PN : PN ;
  advise_V2V : V2V ;
  abstain_V2 : V2 ;
  letter_N : N ;
  eimi_V : V ;

  pistos_A2 : A2 ;
} ;
