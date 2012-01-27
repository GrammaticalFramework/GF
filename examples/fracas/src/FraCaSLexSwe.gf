--# -path=.:alltenses

-- FraCaSLexSwe: Concrete lexicon for the FraCaS test suite

concrete FraCaSLexSwe of FraCaSLex = CatSwe **
  open ParadigmsSwe, (I=IrregSwe), Prelude, MorphoSwe, ResSwe, (G=GrammarSwe) in {

lin
-- NOUNS
  accountant_N = mkN "bokförare" Utr ; -- för att skilja från 'auditor'-'revisor'
  agenda_N = mkN "dagordning" Utr ;
  animal_N = mkN "djur" Neutr ;
  apcom_contract_N = mkN "APCOM-kontrakt" Neutr ;
  apcom_manager_N = mkN "APCOM-direktör" "APCOM-direktörer" ;
  auditor_N = mkN "revisor" "revisorer" ;
  authority_N = mkN "fackman" "fackmannen" "fackmän" "fackmännen" ;
  board_meeting_N = mkN "styrelsemöte" Neutr ;
  boss_N = mkN "chef" "chefer" ;
  business_N = mkN "affärsverksamhet" "affärsverksamheter" ;
  businessman_N = mkN "affärsman" "affärsmannen" "affärsmän" "affärsmännen" ;
  car_N = mkN "bil" Utr ;
  case_N = mkN "fall" Neutr ;
  chain_N = mkN "kedja" Utr ;
  chairman_N = mkN "ordförande" "ordföranden" "ordförande" "ordförandena" ;
  chairman_N2 = mkN2 chairman_N (mkPrep "för") ;
  charity_N = mkN "välgörenhet" "välgörenheter" ;
  clause_N = mkN "paragraf" "paragrafer" ;
  client_N = mkN "klient" "klienter" ;
  colleague_N = mkN "kollega" Utr ;
  commissioner_N = mkN "ombud" Neutr ;
  committee_N = mkN "kommitté" "kommittén" "kommittéer" "kommittéerna" ;
  committee_member_N = mkN "kommittémedlem" "kommittémedlemmen" "kommittémedlemmar" "kommittémedlemmarna" ;
  company_N = mkN "företag" Neutr ;
  company_car_N = mkN "tjänstebil" Utr ;
  company_director_N = mkN "företagsledare" Utr ;
  computer_N = mkN "dator" "datorer" ;
  concert_N = mkN "konsert" "konserter" ;
  conference_N = mkN "konferens" "konferenser" ;
  continent_N = mkN "kontinent" "kontinenter" ;
  contract_N = mkN "kontrakt" Neutr ;
  copy_N = mkN "kopia" Utr ;
  country_N = mkN "land" "landet" "länder" "länderna" ;
  cover_page_N = mkN "förstasida" Utr ;
  customer_N = mkN "kund" "kunder" ;
  day_N = mkN "dag" Utr ;
  delegate_N = mkN "delegat" "delegater" ;
  demonstration_N = mkN "presentation" "presentationer" ;
  department_N = mkN "avdelning" Utr ;
  desk_N = mkN "skrivbord" Neutr ;
  diamond_N = mkN "diamant" "diamanter" ;
  editor_N = mkN "redigerare" Utr ;
  elephant_N = mkN "elefant" "elefanter" ;
  european_N = mkN "europé" "europén" "européer" "européerna" ;
  executive_N = mkN "företagsledare" Utr ;
  factory_N = mkN "fabrik" "fabriker" ;
  fee_N = mkN "arvode" Neutr ;
  file_N = mkN "fil" "filer" ;
  greek_N = mkN "grek" "greker" ;
  group_N2 = mkN2 (mkN "grupp" "grupper") noPrep ;
  hard_disk_N = mkN "hårddisk" Utr ;
  heart_N = mkN "hjärta" "hjärtat" "hjärtan" "hjärtana" ;
  hour_N = mkN "timme" Utr ;
  house_N = mkN "hus" Neutr ;
  individual_N = mkN "individ" "individer" ;
  inhabitant_N2 = mkN2 (mkN "invånare" "invånare") (mkPrep "i") ;
  invoice_N = mkN "faktura" Utr ;
  irishman_N = mkN "irländare" Utr ;
  italian_N = mkN "italienare" "italienare" ;
  itel_computer_N = mkN "ITEL-dator" "ITEL-datorer" ;
  itelxz_N = mkN "ITEL-XZ" "ITEL-XZ:an" "ITEL-XZ:ar" "ITEL-XZ:arna" ;
  itelzx_N = mkN "ITEL-ZX" "ITEL-ZX:an" "ITEL-ZX:ar" "ITEL-ZX:arna" ;
  itelzy_N = mkN "ITEL-ZY" "ITEL-ZY:an" "ITEL-ZY:ar" "ITEL-ZY:arna" ;
  item_N = mkN "punkt" "punkter" ;
  job_N = mkN "jobb" Neutr ;
  labour_mp_N = mkN "Labour-ledamot" "Labour-ledamöter" ;
  laptop_computer_N = mkN "laptop" Utr ;
  law_lecturer_N = mkN "juridiklärare" "juridiklärare" ;
  lawyer_N = mkN "jurist" "jurister" ;
  line_N = mkN "linje" "linjer" ;
  literature_N = mkN "litteratur" "litteraturer" ;
  lobby_N = mkN "vestibul" "vestibuler" ;
  loss_N = mkN "förlust" "förluster" ;
  machine_N = mkN "maskin" "maskiner" ;
  mammal_N = mkN "däggdjur" Neutr ;
  man_N = mkN "man" "mannen" "män" "männen" ;
  meeting_N = mkN "möte" Neutr ;
  member_N = mkN "medlem" "medlemmen" "medlemmar" "medlemmarna" ;
  member_state_N = mkN "medlemsstat" "medlemsstater" ;
  memoir_N = mkN "memoar" "memoarer" ;
  mips_N = mkN "MIPS" "MIPS" "MIPS" "MIPS" ;
  moment_N = mkN "ögonblick" Neutr ;
  mortgage_interest_N = mkN "hypoteksränta" Utr ;
  mouse_N = mkN "mus" "musen" "möss" "mössen" ;
  newspaper_N = mkN "tidning" Utr ;
  nobel_prize_N = mkN "nobelpris" Neutr ;
  nobel_prize_N2 = mkN2 nobel_prize_N (mkPrep "i") ;
  note_N = mkN "anteckning" Utr ;
  novel_N = mkN "roman" "romaner" ;
  office_building_N = mkN "kontorsbyggnad" "kontorsbyggnader" ;
  one_N = mkN "en" Utr ; 
  order_N = mkN "order" "ordern" "order" "orderna" ;
  paper_N = mkN "uppsats" "uppsatser" ;
  payrise_N = mkN "löneförhöjning" Utr ;
  pc6082_N = mkN "PC-6082" "PC-6082:an" "PC-6082:or" "PC-6082:orna" ;
  performance_N = mkN "utförande" Neutr ;
  person_N = mkN "människa" Utr ;
  philosopher_N = mkN "filosof" "filosofer" ;
  phone_N = mkN "telefon" Utr ;
  politician_N = mkN "politiker" "politikern" "politiker" "politikerna" ;
  popular_music_N = mkN "populärmusik" "populärmusiken" "populärmusik" "populärmusiken" ;
  program_N = mkN "program" "programmet" "program" "programmen" ;
  progress_report_N = mkN "statusrapport" "statusrapporter" ;
  project_proposal_N = mkN "projektförslag" Neutr ;
  proposal_N = mkN "förslag" Neutr ;
  report_N = mkN "rapport" "rapporter" ;
  representative_N = mkN "representant" "representanter" ;
  resident_N = mkN "invånare" "invånare" ;
  resident_in_N2 = mkN2 resident_N (mkPrep "i") ;
  resident_on_N2 = mkN2 resident_N (mkPrep "på") ;
  result_N = mkN "resultat" Neutr ;
  right_N = mkN "rätt" "rätten" "rättigheter" "rättigheterna" ;
  sales_department_N = mkN "försäljningsavdelning" Utr ;
  scandinavian_N = mkN "skandinav" "skandinaver" ;
  secretary_N = mkN "sekreterare" Utr ;
  service_contract_N = mkN "servicekontrakt" Neutr ;
  shore_N = mkN "strand" "stränder" ;
  software_fault_N = mkN "programvarufel" "programvarufel" ;
  species_N = mkN "art" "arter" ;
  station_N = mkN "station" "stationer" ;
  stock_market_trader_N = mkN "aktiehandlare" "aktiehandlare" ;
  stockmarket_trader_N = mkN "aktiehandlare" Utr ;
  story_N = mkN "berättelse" "berättelser" ;
  student_N = mkN "student" "studenter" ;
  survey_N = mkN "undersökning" Utr ;
  swede_N = mkN "svensk" Utr ;
  system_N = mkN "system" Neutr ;
  system_failure_N = mkN "systemkrasch" "systemkrascher" ;
  taxi_N = mkN "taxi" "taxin" "taxibilar" "taxibilarna" ;
  temper_N = mkN "humör" Neutr ;
  tenor_N = mkN "tenor" "tenorer" ;
  time_N = mkN "tid" "tider" ;	-- 'tidpunkt' behövs ev. också
  today_N = mkN "idag" ;
  traffic_N = mkN "trafik" "trafiken" "trafik" "trafiken" ;
  train_N = mkN "tåg" Neutr ;
  university_graduate_N = (mkN "universitetsakademiker" "universitetsakademikern" 
			     "universitetsakademiker" "universitetsakademikerna") ;
  university_student_N = mkN "universitetsstudent" "universitetsstudenter" ;
  week_N = mkN "vecka" Utr ;
  wife_N = mkN "fru" "fruar" ;
  woman_N = mkN "kvinna" Utr ;
  workstation_N = mkN "arbetsstation" "arbetsstationer" ;
  world_N = mkN "värld" Utr ;
  year_N = mkN "år" Neutr ;

-- PROPER NOUNS
  --march_PN = mkPN "mars" ;
  --may_PN = mkPN "maj" ;
  alan_PN = mkPN "Alan" ;
  anderson_PN = mkPN "Anderson" ;
  apcom_PN = mkPN "APCOM" ;
  berlin_PN = mkPN "Berlin" ;
  bill_PN = mkPN "Bill" ;
  birmingham_PN = mkPN "Birmingham" ;
  bt_PN = mkPN "BT" ;
  bug_32985_PN = mkPN "Bug # 32-985" ;
  cambridge_PN = mkPN "Cambridge" ;
  carl_PN = mkPN "Carl" ;
  dumbo_PN = mkPN "Dumbo" ;
  europe_PN = mkPN "Europa" ;
  fido_PN = mkPN "Fido" ;
  florence_PN = mkPN "Florens" ;
  frank_PN = mkPN "Frank" ;
  gfi_PN = mkPN "GFI" ;
  helen_PN = mkPN "Helen" ;
  icm_PN = mkPN "ICM" ;
  itel_PN = mkPN "ITEL" ;
  john_PN = mkPN "John" ;
  jones_PN = mkPN "Jones" ;
  katmandu_PN = mkPN "Katmandu" ;
  kim_PN = mkPN "Kim" ;
  luxembourg_PN = mkPN "Luxemburg" ;
  mary_PN = mkPN "Mary" ;
  mfi_PN = mkPN "MFI" ;
  mickey_PN = mkPN "Mickey" ;
  mtalk_PN = mkPN "MTALK" ;
  paris_PN = mkPN "Paris" ;
  pavarotti_PN = mkPN "Pavarotti" ;
  peter_PN = mkPN "Peter" ;
  portugal_PN = mkPN "Portugal" ;
  r95103_PN = mkPN "R-95-103" ;
  scandinavia_PN = mkPN "Skandinavien" ;
  smith_PN = mkPN "Smith" ;
  southern_europe_PN = mkPN "södra Europa" ;
  sue_PN = mkPN "Sue" ;
  sweden_PN = mkPN "Sverige" ;
  the_cia_PN = mkPN "CIA" ;
  the_m25_PN = mkPN "M25:an" ;
  
-- PRONOUNS
  anyone_Pron = regNP "någon" "någons" Utr Sg ;
  everyone_Pron = regNP "alla" "allas" Utr Pl ;
  no_one_Pron = regNP "ingen" "ingens" Utr Sg ;
  nobody_Pron = regNP "ingen" "ingens" Utr Sg ;
  someone_Pron = regNP "någon" "någons" Utr Sg ;
  sheRefl_Pron = mkNP "hon" "sig" "sin" "sitt" "sina"  Utr Sg P3 ;
  heRefl_Pron = mkNP "han" "sig" "sin" "sitt" "sina"  Utr Sg P3 ;
  theyRefl_Pron = mkNP "de" "sig" "sin" "sitt" "sina"  Utr Pl P1 ;
  itRefl_Pron = mkNP "det" "sig" "sin" "sitt" "sina"  Neutr Sg P3 ;

-- RELATIVE PRONOUNS
  that_RP = G.IdRP ;

-- ADJECTIVES
  ambitious_A = compoundA (mkA "ärelysten" "ärelystet") ;
  ancient_A = compoundA (mkA "antik") ;
  asleep_A = compoundA (mkA "sovande") ;
  blue_A = mkA "blå" "blått" ;
  british_A = compoundA (mkA "brittisk") ;
  broke_A = mkA "pank" ;
  canadian_A = compoundA (mkA "kanadensisk") ;
  clever_A = mkA "smart" "smart" ;
-- mkA "begåvad" "begåvat" "begåvade" "begåvade" "mer begåvad" "mest begåvad" "mest begåvade" ;
  competent_A = compoundA (mkA "kompetent" "kompetent") ;
  crucial_A = compoundA (mkA "kritisk") ;
  dedicated_A = mkA "särskild" "särskilt" ;
  different_A = compoundA (mkA "olik") ;
  employed_A = compoundA (mkA "anställd" "anställt") ;
  excellent_A = mkA "förträfflig" ;
  false_A = mkA "inte sann" "inte sant" ;
  fast_A = mkA "snabb" ;
  fat_A = mkA "fet" "fett" ;
  female_A = mkA "kvinnlig" ;
  former_A = compoundA (mkA "före detta") ;
  fourlegged_A = mkA "fyrbent" "fyrbent" ;
  free_A = mkA "fri" "fritt" ;
  furious_A = compoundA (mkA "rasande") ;
  genuine_A = compoundA (mkA "äkta") ;
  german_A = mkA "tysk" ;
  great_A = compoundA (mkA "framstående") ;
  important_A = mkA "viktig" ;
  impressed_by_A2 = mkA2 (mkA "imponerad" "imponerat" "imponerade" "imponerade" "mer imponerad" "mest imponerad" "mest imponerade") (mkPrep "av") ;
  indispensable_A = mkA "oumbärlig" ;
  interesting_A = mkA "intressant" "intressant" ;
  irish_A = compoundA (mkA "irländsk") ;
  italian_A = compoundA (mkA "italiensk") ;
  known_A = mkA "känd" "känt" ;	-- jfr 'noted'
  large_A = mkA "stor" "större" "störst" ;
  leading_A = compoundA (mkA "ledande") ;
  legal_A = compoundA (mkA "juridisk") ;
  likely_A = compoundA (mkA "sannolik") ; 
  major_A = mkA "större" "större" "större" "större" "större" "större" "större" ;
  male_A = mkA "manlig" ;
  many_A = mkA "mycken" "mycket" "myckna" "mer" "mest" ;
  missing_A = compoundA (mkA "försvunnen" "försvunnet" "försvunna" "försvunnare" "försvunnast") ;
  modest_A = mkA "blygsam" "blygsamt" "blygsamma" "blygsamma" "blygsammare" "blygsammast" "blygsammaste" ;
  national_A = compoundA (mkA "nationell") ;
  new_A = mkA "ny" "nytt" ;
  north_american_A = compoundA (mkA "nordamerikansk") ;
  noted_A = compoundA (mkA "välkänd") ;
  own_A = mkA "egen" "eget" ;
  poor8bad_A = mkA "dålig" "sämre" "sämst" ;
  poor8penniless_A = mkA "fattig" ;
  portuguese_A = compoundA (mkA "portugisisk") ;
  present8attending_A = compoundA (mkA "närvarande") ;
  present8current_A = compoundA (mkA "nuvarande") ;
  previous_A = compoundA (mkA "förra") ;
  red_A = mkA "röd" "rött" ;
  resident_A = compoundA (mkA "bosatt") ;
  scandinavian_A = compoundA (mkA "skandinavisk") ;
  serious_A = mkA "seriös" ;
  slow_A = mkA "långsam" "långsamt" "långsamma" "långsamma" "långsammare" "långsammast" "långsammaste" ;
  small_A = mkA "liten" "litet" "lilla" "små" "mindre" "minst" "minsta" ;
  successful_A = compoundA (mkA "framgångsrik") ;
  swedish_A = mkA "svensk" ;
  true_A = mkA "sann" "sant" ;
  unemployed_A = compoundA (mkA "arbetslös") ;
  western_A = compoundA (mkA "västerländsk") ;

-- VERBS
oper taga_V : V = mkV "ta" "tar" "ta" "tog" "tagit" "tagen" ;
lin
  accept_V2 = mkV2 (mkV "godkänna" "godkände" "godkänt") ;
  allow_V2V = mkV2V (mkV "tillåta" "tillät" "tillåtit") noPrep noPrep ;
  answer_V2 = mkV2 "svarar" (mkPrep "i") ;
  appoint_V2 = mkV2 "utnämner" ;
  arrive_in_V2 = mkV2 (mkV "anländer") (mkPrep "till") ;
  attend_V2 = mkV2 "närvarar" (mkPrep "vid") ;
  award_V3 = mkV3 (mkV "tilldelar") ;
--  be_on_V2 = mkV2 I.ligga_V (mkPrep "på") ;
--  be_over_V = partV be_V "over" ;
  beat_V = I.slå_V ;
  become_V2 = mkV2 I.bliva_V ;
  believe_VS = mkVS (mkV "tror") ;
  blame1_V2 = mkV2 "beskyller" ;
  blame2_V2 = mkV2 "skyller" ;
--  blame_for_V3 = mkV3 (mkV "anklagar") (mkPrep "för") ;
--  blame_on_V3 = mkV3 (mkV "skyller") (mkPrep "på") ;
  bring_V2V = mkV2V (partV taga_V "med") noPrep noPrep ;
  build_V2 = mkV2 "tillverkar" ;
  buy_V2 = mkV2 "köper" ;
  catch_V2 = mkV2 (partV I.komma_V "med") ;
  chair_V2 = mkV2 (mkV "leda" "ledde" "lett") ;
  claim_VS = mkVS (mkV "påstå" "påstod" "påstått") ;
  come_cheap_VP = G.UseComp (G.CompAP (G.PositA (mkA "billig"))) ;
  come_in_V = partV I.komma_V "in" ;
  continue_V = mkV "fortsätta" "fortsätter" "fortsätt" "fortsatte" "fortsatt" "fortsatt" ;
  contribute_to_V3 = mkV3 I.giva_V (mkPrep "till") ;
  cost_V2 = mkV2 "kostnadsberäknar" ;
  crash_V = mkV "kraschar" ;
  cross_out_V2 = mkV2 (partV (mkV "stryka" "strök" "strukit") "över") ;
  deliver_V2 = mkV2 "lämnar" ;
  deliver_V3 = mkV3 I.giva_V ;
  destroy_V2 = mkV2 (mkV "förstöra" "förstör" "förstör" "förstörde" "förstört" "förstörd") ;
  develop_V2 = mkV2 "utvecklar" ;
  discover_V2 = mkV2 "upptäcker" ;
  discover_VS = mkVS (mkV "upptäcker") ;
  dupe_V2 = mkV2 "lurar" ;
  exist_V = depV I.finna_V ;
  expand_V = mkV "expanderar" ;
  find_V2 = mkV2 "hittar" ;
  finish_V2 = mkV2 (mkV "slutföra" "slutförde" "slutfört") ;
  finish_VV = mkVV (mkV "slutar") ;
  found_V2 = mkV2 "grundar" ;
  gamble_V = mkV "spelar" ;
  get_V2 = mkV2 (mkV "få" "fick" "fått") ;
  go8travel_V = mkV "åker" ;
  go8walk_V = I.gå_V ;
  graduate_V = depV (mkV "utexamineras") ;
  hate_V2 = mkV2 "hatar" ;
  hurt_V2 = mkV2 "skadar" ;
  increase_V = mkV "ökar" ;
  know_VQ = mkVQ (mkV "veta" "vet" "vet" "visste" "vetat" "känd") ;
  know_VS = mkVS (mkV "veta" "vet" "vet" "visste" "vetat" "känd") ;
  last_V2 = mkV2 (mkV "varar") ;
  leave_V = I.gå_V ;
  leave_V2 = mkV2 "lämnar" ;
  like_V2 = mkV2 "gillar" ;
  live_V = mkV "bor" ;
  lose_V2 = mkV2 "förlorar" ;
  maintain_V2 = mkV2 (mkV "servar") ; -- (mkV "underhålla" "underhöll" "underhållit") ;
  make8become_V2 = mkV2 I.bliva_V ;
  make8do_V2 = mkV2 I.göra_V ;
  manage_VV = mkVV (depV (mkV "lyckas")) ;
  meet_V = depV (mkV "träffas") ;
  need_V2 = mkV2 "behöver" ;
  need_VV = mkV "behöver" ** {c2 = mkComplement [] ; lock_VV = <>} ;
  obtain_from_V3 = mkV3 I.erhålla_V (mkPrep "från") ;
  open_V2 = mkV2 "öppnar" ;
  own_V2 = mkV2 "äger" ;
  pay_V2 = mkV2 "betalar" ;
  publish_V2 = mkV2 "publicerar" ;
  put_in_V3 = mkV3 (mkV "ställer") (mkPrep "i") ;
  read_V2 = mkV2 "läser" ;
  read_out_V2 = mkV2 (partV (mkV "läser") "upp") ;
  remove_V2 = mkV2 "avlägsnar" ;
  rent_from_V3 = mkV3 (mkV "hyra" "hyrde" "hyrt") (mkPrep "från") ;
  represent_V2 = mkV2 "representerar" ;
  revise_V2 = mkV2 "granskar" ;
  run_V2 = mkV2 I.driva_V ;
  say_VS = mkVS I.säga_V ;
  see_V2V = I.se_V ** {c2,c3 = mkComplement ""} ;
  sell_V2 = mkV2 (mkV "sälja" "sålde" "sålt") ;
  send_V2 = mkV2 "skickar" ;
  shall_VV = mkV "böra" "bör" "bör" "borde" "bort" "bord" 
    ** {c2 = mkComplement [] ; lock_VV = <>} ;
  sign_V2 = mkV2 "undertecknar" ;
  sing_V2 = mkV2 I.sjunga_V ;
  speak_to_V2 = mkV2 "talar" (mkPrep "med") ;
  spend_V2 = mkV2 "tillbringar" ;
  start_V = mkV "börjar" ;
  start_VV = mkV "börjar" ** {c2 = mkComplement [] ; lock_VV = <>} ;
  stop_V = mkV "slutar" ;
  -- suggest_VS = mkVS (mkV "föreslå" "föreslog" "föreslagit") ;
  suggest_to_V2S = mkV2S (mkV "föreslå" "föreslog" "föreslagit") (mkPrep "för") ;
  swim_V = mkV "simmar" ;
  take_V2 = mkV2 taga_V ;
  take_part_in_V2 = mkV2 (mkV "delta" "deltog" "deltagit") (mkPrep "i") ;
  tell_about_V3 = mkV3 (mkV "berättar") (mkPrep "för") (mkPrep "om") ;
  travel_V = mkV "reser" ;
  try_VV = mkVV (mkV "försöker") ;
  update_V2 = mkV2 "uppdaterar" ;
  use_V2 = mkV2 "använder" ;
  -- use_VV = mkVV (mkV "brukar") ;
  use_VV = mkV "brukar" ** {c2 = mkComplement [] ; lock_VV = <>} ;
  vote_for_V2 = mkV2 (mkV "röstar") (mkPrep "för") ;
  win_V2 = mkV2 I.vinna_V ;
  work_V = mkV "arbetar" ;
  work_in_V2 = mkV2 (mkV "arbetar") (mkPrep "på") ;
  write_V2 = mkV2 I.skriva_V ;
  write_to_V2 = mkV2 I.skriva_V (mkPrep "till") ;

  do_VV = I.göra_V ** {c2 = mkComplement [] ; lock_VV = <>} ;
  going_to_VV = mkVV I.komma_V ;
  take_V2V = mkV2V taga_V noPrep noPrep ;

  award_and_be_awarded_V2 = mkV2 (mkV "tilldela och tilldelas" 
				    "tilldelar och tilldelas" 
				    "tilldela och tilldelas" 
				    "tilldelade och tilldelades"
				    "tilldelat och tilldelats"
				    "tilldelad och bliven tilldelad") ;

-- DETERMINERS
  a_few_Det = {s,sp = \\_,_ => "ett fåtal" ; n = Pl ; det = DIndef} ;
  a_lot_of_Det = {s,sp = \\_,_ => "mycket" ; n = Sg ; det = DIndef} ;
  another_Det = {s,sp = \\_ => genderForms "en annan" "ett annat" ; n = Sg ; det = DIndef} ;
  anyPl_Det = G.somePl_Det ;
  anySg_Det = G.someSg_Det ;
  both_Det = {s,sp = \\b,_ => "båda" ++ if_then_Str b "de" "" ; 
	      n = Pl ; det = DDef Def} ;
  each_Det = G.every_Det ;
  either_Det = {s,sp = \\b,g => genderForms "någon av" "något av" ! g ++ if_then_Str b "de" "" ; 
		n = Pl ; det = DDef Def} ;
  neither_Det = {s,sp = \\b,g => genderForms "ingen av" "inget av" ! g ++ if_then_Str b "de" "" ; 
		 n = Pl ; det = DDef Def} ;
  one_or_more_Det = {s,sp = \\_ => genderForms "en eller flera" "ett eller flera" ; 
		     n = Pl ; det = DIndef} ;
  several_Det = {s,sp = \\_,_ => "flera" ; n = Pl ; det = DIndef} ;
  twice_as_many_Det = {s,sp = \\_,_ => "dubbelt så många" ; n = Pl ; det = DIndef} ;

  half_a_Card = {s = table {Utr => "en halv"; Neutr => "ett halvt"} ; n = Sg} ;

  the_other_Q = {s,sp = table {Sg => \\_,_ => genderForms ["den andra"] ["det andra"]; 
			       Pl => \\_,_,_ => ["de andra"]};
		 det = DDef Def} ;

-- NUMERALS

oper
  selectSub20 : {s : DForm => CardOrd => Str} -> DForm -> Numeral ;
  selectSub20 num dform = lin Numeral {s = num.s ! dform; n = plural} ;

  prefixNumeral : Str -> {s : CardOrd => Str; n : MorphoSwe.Number} -> Numeral ;
  prefixNumeral prefix num = lin Numeral {s = \\o => prefix + num.s ! o; n = num.n} ;

lin
  N_one = G.num (G.pot2as3 (G.pot1as2 (G.pot0as1 G.pot01))) ; -- {s = G.pot01.s ! ental; n = singular} ;
  N_two = selectSub20 G.n2 ental ;
  N_three = selectSub20 G.n3 ental ;
  N_four = selectSub20 G.n4 ental ;
  N_five = selectSub20 G.n5 ental ;
  N_six = selectSub20 G.n6 ental ;
  N_eight = selectSub20 G.n8 ental ;
  N_ten = G.num (G.pot2as3 (G.pot1as2 G.pot110)) ; -- selectSub20 G.pot01 tiotal ;
  N_eleven = G.num (G.pot2as3 (G.pot1as2 G.pot111)) ;
  N_sixteen = selectSub20 G.n6 ton ;
  N_twenty = selectSub20 G.n2 tiotal ;
  N_fortyfive = {s = \\o => "fyrtio" + N_five.s ! o; n = plural} ;

  N_2 = G.D_2 ;
  N_4 = G.D_4 ;
  N_8 = G.D_8 ;
  N_10 = prefixNumeral "1" G.D_0 ;
  N_13 = prefixNumeral "1" G.D_3 ;
  N_14 = prefixNumeral "1" G.D_4 ;
  N_15 = prefixNumeral "1" G.D_5 ;
  N_99 = prefixNumeral "9" G.D_9 ;
  N_100 = prefixNumeral "10" G.D_0 ;
  N_150 = prefixNumeral "15" G.D_0 ;
  N_500 = prefixNumeral "50" G.D_0 ;
  N_2500 = prefixNumeral "250" G.D_0 ;
  N_3000 = prefixNumeral "300" G.D_0 ;
  N_5500 = prefixNumeral "550" G.D_0 ;


-- ADVERBS
  anywhere_Adv = mkAdv "var som helst" ;
  at_home_Adv = mkAdv "hemma" ;
  at_some_time_Adv = mkAdv "vid någon tidpunkt" ;
  at_the_same_time_Adv = mkAdv "samtidigt" ;
  ever_since_Adv = mkAdv "ända sedan dess" ;
  -- freely_Adv = mkAdv "fritt" ;
  in_the_past_Adv = mkAdv "tidigare" ;
  late_Adv = mkAdv "sent" ;
  long_Adv = mkAdv "länge" ;
  -- now_Adv = mkAdv "nu" ;
  on_time_Adv = mkAdv "i tid" ;
  part_time_Adv = mkAdv "deltid" ;
  -- seriously_Adv = mkAdv "på allvar" ;
  together_Adv = mkAdv "tillsammans" ;
  too_Adv = mkAdv "också" ;
  twice_Adv = mkAdv "två gånger" ;
  yesterday_Adv = mkAdv "igår" ;
  -- four_times_Adv = mkAdv "fyra gånger" ;
  over_Adv = mkAdv "slut" ;

  all_AdV = mkAdV "alla" ;
  already_AdV = mkAdV "redan" ;
  also_AdV = mkAdV "även" ;
  currently_AdV = mkAdV "för närvarande" ;
  ever_AdV = mkAdV "någonsin" ;
  never_AdV = mkAdV "aldrig" ;
  now_AdV = mkAdV "nu" ;
  still_AdV = mkAdV "fortfarande" ;

  really_AdA = mkAdA "verkligt" ;

  more_than_AdN = ss "mer än" ;
  less_than_AdN = ss "mindre än" ;

  -- exactly_AdN = mkAdA "exakt" ;
  -- just_AdN = mkAdA "endast" ;

-- TIME & DATE EXPRESSIONS
  at_8_am_Adv = mkAdv "klockan 8" ;
  at_a_quarter_past_five_Adv = mkAdv "kvart över fem" ;
  at_five_oclock_Adv = mkAdv "klockan fem" ;
  at_four_oclock_Adv = mkAdv "klockan fyra" ;
  at_least_four_times = mkAdv "minst fyra gånger" ;
  by_11_am_Adv = mkAdv "klockan 11" ;
  every_month_Adv = mkAdv "varje månad" ;
  every_week_Adv = mkAdv "varje vecka" ;
  for_8_years_Adv = mkAdv "i 8 år" ;
  for_a_total_of_15_years_or_more_Adv = mkAdv "i totalt 15 år eller mer" ;
  for_a_year_Adv = mkAdv "i ett år" ;
  for_an_hour_Adv = mkAdv "i en timme" ;
  for_exactly_a_year_Adv = mkAdv "i exakt ett år" ;
  for_more_than_10_years_Adv = mkAdv "i mer än 10 år" ;
  for_more_than_two_years_Adv = mkAdv "i mer än två år" ;
  for_three_days_Adv = mkAdv "i tre dagar" ;
  for_two_hours_Adv = mkAdv "i två timmar" ;
  for_two_years_Adv = mkAdv "i två år" ;
  friday_13th_Adv = mkAdv "fredagen den 13:e" ;
  from_1988_to_1992_Adv = mkAdv "från 1988 till 1992" ;
  in_1990_Adv = mkAdv "1990" ;
  in_1991_Adv = mkAdv "1991" ;
  in_1992_Adv = mkAdv "1992" ;
  in_1993_Adv = mkAdv "1993" ;
  in_1994_Adv = mkAdv "1994" ;
  in_a_few_weeks_Adv = mkAdv "om några veckor" ;
  in_a_months_time_Adv = mkAdv "om en månad" ;
  in_july_1994_Adv = mkAdv "i juli 1994" ;
  in_march_1993_Adv = mkAdv "i mars 1993" ;
  in_march_Adv = mkAdv "i mars" ;
  in_one_hour_Adv = mkAdv "på en timme" ;
  in_the_coming_year_Adv = mkAdv "under det kommande året" ;
  in_two_hours_Adv = mkAdv "på två timmar" ;
  last_week_Adv = mkAdv "förra veckan" ;
  on_friday_Adv = mkAdv "på fredagen" ;
  on_july_4th_1994_Adv = mkAdv "4:e juli 1994" ;
  on_july_8th_1994_Adv = mkAdv "8:e juli 1994" ;
  on_monday_Adv = mkAdv "på måndagen" ;
  on_the_5th_of_may_1995_Adv = mkAdv "den 5:e maj 1995" ;
  on_the_7th_of_may_1995_Adv = mkAdv "den 7:e maj 1995" ;
  on_thursday_Adv = mkAdv "på torsdagen" ;
  on_tuesday_Adv = mkAdv "på tisdagen" ;
  on_wednesday_Adv = mkAdv "på onsdagen" ;
  saturday_july_14th_Adv = mkAdv "lördagen den 14 juli" ;
  since_1992_Adv = mkAdv "sedan 1992" ;
  the_15th_of_may_1995_Adv = mkAdv "den 15 maj 1995" ;
  two_years_from_now_Adv = mkAdv "om två år" ;
  year_1996_Adv = mkAdv "1996" ;
  
-- PREPOSITIONS
  at_Prep = mkPrep "på" ;
  out_of_Prep = mkPrep "av" ;
  outside_Prep = mkPrep "utanför" ;
  than_Prep = mkPrep "än" ;
  within_Prep = mkPrep "inom" ;
  
-- PREDETERMINERS
  at_least_Predet = {s = \\_,_ => "minst" ; p = [] ; a = PNoAg} ;
  at_most_Predet = {s = \\_,_ => "högst" ; p = [] ; a = PNoAg} ;
  exactly_Predet = {s = \\_,_ => "exakt" ; p = [] ; a = PNoAg} ;
  just_Predet = {s = \\_,_ => "endast" ; p = [] ; a = PNoAg} ;
  most_of_Predet = {s = \\_,_ => "de flesta" ; p = "av" ; a = PNoAg} ;

-- CONJUNCTIONS
  andSg_Conj = {s1 = [] ; s2 = "och" ; n = Sg} ;
  comma_and_Conj = {s1 = [] ; s2 = ", och" ; n = Pl} ;
  if_comma_then_Conj = {s1 = "om" ; s2 = "så" ; n = Sg} ;
  semicolon_and_Conj = {s1 = [] ; s2 = "; och" ; n = Pl} ;

  after_Subj = ss "efter det att" ;
  before_Subj = ss "innan" ;
  since_Subj = ss "sedan" ;
  than_Subj = ss "än" ; 
  until_Subj = ss "förrän" ;
  while_Subj = ss "medan" ;

  that_is_PConj = ss "det vill säga ,";
  and_PConj = ss "och" ;
  then_PConj = ss "sedan" ;

}
