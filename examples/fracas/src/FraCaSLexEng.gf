--# -path=.:alltenses

-- FraCaSLexEng: Concrete lexicon for the FraCaS test suite

concrete FraCaSLexEng of FraCaSLex = CatEng **
  open ParadigmsEng, (I=IrregEng), Prelude, MorphoEng, ResEng, (G=GrammarEng), (E=ExtraEng), (X=ConstructX) in {

lin
-- NOUNS
  accountant_N = mkN human (mkN "accountant") ;
  agenda_N = mkN "agenda" ;
  animal_N = mkN "animal" ;
  apcom_contract_N = mkN "APCOM contract" ;
  apcom_manager_N = mkN human (mkN "APCOM manager") ;
  auditor_N = mkN human (mkN "auditor") ;
  authority_N = mkN human (mkN "authority") ;
  board_meeting_N = mkN "board meeting" ;
  boss_N = mkN human (mkN "boss") ;
  business_N = mkN "business" ;
  businessman_N = mkN human (mkN "businessman" "businessmen") ;
  car_N = mkN "car" ;
  case_N = mkN "case" ;
  chain_N = mkN "chain" ;
  chairman_N = mkN human (mkN "chairman" "chairmen") ;
  chairman_N2 = mkN2 (mkN human (mkN "chairman" "chairmen")) (mkPrep "of") ;
  charity_N = mkN "charity" ;
  clause_N = mkN "clause" ;
  client_N = mkN human (mkN "client") ;
  colleague_N = mkN human (mkN "colleague") ;
  commissioner_N = mkN human (mkN "commissioner") ;
  committee_N = mkN "committee" ;
  committee_member_N = mkN human (mkN "committee member") ;
  company_N = mkN "company" ;
  company_car_N = mkN "company car" ;
  company_director_N = mkN human (mkN "company director") ;
  computer_N = mkN "computer" ;
  concert_N = mkN "concert" ;
  conference_N = mkN "conference" ;
  continent_N = mkN "continent" ;
  contract_N = mkN "contract" ;
  copy_N = mkN "copy" ;
  country_N = mkN "country" ;
  cover_page_N = mkN "cover page" ;
  customer_N = mkN human (mkN "customer") ;
  day_N = mkN "day" ;
  delegate_N = mkN human (mkN "delegate") ;
  demonstration_N = mkN "demonstration" ;
  department_N = mkN "department" ;
  desk_N = mkN "desk" ;
  diamond_N = mkN "diamond" ;
  editor_N = mkN human (mkN "editor") ;
  elephant_N = mkN "elephant" ;
  european_N = mkN human (mkN "European") ;
  executive_N = mkN human (mkN "executive") ;
  factory_N = mkN "factory" ;
  fee_N = mkN "fee" ;
  file_N = mkN "file" ;
  greek_N = mkN human (mkN "Greek") ;
  group_N2 = mkN2 (mkN "group") ;
  hard_disk_N = mkN "hard disk" ;
  heart_N = mkN "heart" ;
  hour_N = mkN "hour" ;
  house_N = mkN "house" ;
  individual_N = mkN human (mkN "individual") ;
  inhabitant_N2 = mkN2 (mkN human (mkN "inhabitant")) (mkPrep "of") ;
  invoice_N = mkN "invoice" ;
  irishman_N = mkN human (mkN "Irishman" "Irishmen") ;
  italian_N = mkN human (mkN "Italian") ;
  itel_computer_N = mkN "ITEL computer" ;
  itelxz_N = mkN "ITEL-XZ" ;
  itelzx_N = mkN "ITEL-ZX" ;
  itelzy_N = mkN "ITEL-ZY" ;
  item_N = mkN "item" ;
  job_N = mkN "job" ;
  labour_mp_N = mkN human (mkN "Labour MP") ;
  laptop_computer_N = mkN "laptop computer" ;
  law_lecturer_N = mkN human (mkN "law lecturer") ;
  lawyer_N = mkN human (mkN "lawyer") ;
  line_N = mkN "line" ;
  literature_N = mkN "literature" ;
  lobby_N = mkN "lobby" ;
  loss_N = mkN "loss" ;
  machine_N = mkN "machine" ;
  mammal_N = mkN "mammal" ;
  man_N = mkN human (mkN "man" "men") ;
  meeting_N = mkN "meeting" ;
  member_N = mkN human (mkN "member") ;
  member_state_N = mkN "member state" ;
  memoir_N = mkN "memoir" ;
  mips_N = mkN "MIPS" "MIPS" "MIPS'" "MIPS'" ;
  moment_N = mkN "moment" ;
  mortgage_interest_N = mkN "mortgage interest" ;
  mouse_N = mkN "mouse" "mice" ;
  newspaper_N = mkN "newspaper" ;
  nobel_prize_N = mkN "Nobel prize" ;
  nobel_prize_N2 = mkN2 (mkN "Nobel prize") (mkPrep "for") ;
  note_N = mkN "note" ;
  novel_N = mkN "novel" ;
  office_building_N = mkN "office building" ;
  one_N = mkN "one" ; 
  order_N = mkN "order" ;
  paper_N = mkN "paper" ;
  payrise_N = mkN "payrise" ;
  pc6082_N = mkN "PC-6082" ;
  performance_N = mkN "performance" ;
  person_N = mkN human (mkN "person" "people") ;
  philosopher_N = mkN human (mkN "philosopher") ;
  phone_N = mkN "phone" ;
  politician_N = mkN human (mkN "politician") ;
  popular_music_N = mkN "popular music" ;
  program_N = mkN "program" ;
  progress_report_N = mkN "progress report" ;
  project_proposal_N = mkN "project proposal" ;
  proposal_N = mkN "proposal" ;
  report_N = mkN "report" ;
  representative_N = mkN human (mkN "representative") ;
  resident_N = mkN human (mkN "resident") ;
  resident_in_N2 = mkN2 (mkN human (mkN "resident")) (mkPrep "of") ;
  resident_on_N2 = mkN2 (mkN human (mkN "resident")) (mkPrep "of") ;
  result_N = mkN "result" ;
  right_N = mkN "right" ;
  sales_department_N = mkN "sales department" ;
  scandinavian_N = mkN human (mkN "Scandinavian") ;
  secretary_N = mkN human (mkN "secretary") ;
  service_contract_N = mkN "service contract" ;
  shore_N = mkN "shore" ;
  software_fault_N = mkN "software fault" ;
  species_N = mkN "species" "species" ;
  station_N = mkN "station" ;
  stock_market_trader_N = mkN human (mkN "stock market trader") ;
  stockmarket_trader_N = mkN human (mkN "stock-market trader") ;
  story_N = mkN "story" ;
  student_N = mkN human (mkN "student") ;
  survey_N = mkN "survey" ;
  swede_N = mkN human (mkN "Swede") ;
  system_N = mkN "system" ;
  system_failure_N = mkN "system failure" ;
  taxi_N = mkN "taxi" ;
  temper_N = mkN "temper" ;
  tenor_N = mkN human (mkN "tenor") ;
  time_N = mkN "time" ;
  today_N = mkN "today" ;
  traffic_N = mkN "traffic" ;
  train_N = mkN "train" ;
  university_graduate_N = mkN human (mkN "university graduate") ;
  university_student_N = mkN human (mkN "university student") ;
  week_N = mkN "week" ;
  wife_N = mkN human (mkN "wife" "wives") ;
  woman_N = mkN human (mkN "woman" "women") ;
  workstation_N = mkN "workstation" ;
  world_N = mkN "world" ;
  year_N = mkN "year" ;
  
-- PROPER NOUNS
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
  europe_PN = mkPN "Europe" ;
  fido_PN = mkPN "Fido" ;
  florence_PN = mkPN "Florence" ;
  frank_PN = mkPN "Frank" ;
  gfi_PN = mkPN "GFI" ;
  helen_PN = mkPN "Helen" ;
  icm_PN = mkPN "ICM" ;
  itel_PN = mkPN "ITEL" ;
  john_PN = mkPN "John" ;
  jones_PN = mkPN (mkN "Jones" "-" "Jones'" "-") ;
  katmandu_PN = mkPN "Katmandu" ;
  kim_PN = mkPN "Kim" ;
  luxembourg_PN = mkPN "Luxembourg" ;
  mary_PN = mkPN "Mary" ;
  mfi_PN = mkPN "MFI" ;
  mickey_PN = mkPN "Mickey" ;
  mtalk_PN = mkPN "MTALK" ;
  paris_PN = mkPN (mkN "Paris" "-" "Paris'" "-") ;
  pavarotti_PN = mkPN "Pavarotti" ;
  peter_PN = mkPN "Peter" ;
  portugal_PN = mkPN "Portugal" ;
  r95103_PN = mkPN "R-95-103" ;
  scandinavia_PN = mkPN "Scandinavia" ;
  smith_PN = mkPN "Smith" ;
  southern_europe_PN = mkPN "southern Europe" ;
  sue_PN = mkPN "Sue" ;
  sweden_PN = mkPN "Sweden" ;
  the_cia_PN = mkPN "the CIA" ;
  the_m25_PN = mkPN "the M25" ;
  
-- PRONOUNS
  anyone_Pron = mkPron "anyone" "anyone" "anyone's" "anyone's" singular P3 human ;
  everyone_Pron = mkPron "everyone" "everyone" "everyone's" "everyone's" singular P3 human ;
  no_one_Pron = mkPron "no one" "no one" "no one's" "no one's" singular P3 human ;
  nobody_Pron = mkPron "nobody" "nobody" "nobody's" "nobody's" singular P3 human ;
  someone_Pron = mkPron "someone" "someone" "someone's" "someone's" singular P3 human ;
  sheRefl_Pron = G.she_Pron ;
  heRefl_Pron = G.he_Pron ;
  theyRefl_Pron = G.they_Pron ;
  itRefl_Pron = G.it_Pron ;

-- RELATIVE PRONOUNS
  that_RP = E.that_RP ;
  
-- ADJECTIVES
  ambitious_A = mkA "ambitious" ;
  ancient_A = compoundA (mkA "Ancient") ;
  asleep_A = mkA "asleep" ;
  blue_A = mkA "blue" ;
  british_A = mkA "British" ;
  broke_A = compoundA (mkA "broke") ;
  canadian_A = mkA "Canadian" ;
  clever_A = mkA "clever" "cleverer" ;
  competent_A = mkA "competent" ;
  crucial_A = mkA "crucial" ;
  dedicated_A = mkA "dedicated" ;
  different_A = mkA "different" ;
  employed_A = mkA "employed" ;
  excellent_A = mkA "excellent" ;
  false_A = mkA "false" ;
  fast_A = mkA "fast" ;
  fat_A = mkA "fat" ;
  female_A = mkA "female" ;
  former_A = mkA "former" ;
  fourlegged_A = mkA "four-legged" ;
  free_A = mkA "free" ;
  furious_A = mkA "furious" ;
  genuine_A = mkA "genuine" ;
  german_A = mkA "German" ;
  great_A = mkA "great" ;
  important_A = mkA "important" ;
  impressed_by_A2 = mkA2 "impressed" (mkPrep "by") ;
  indispensable_A = mkA "indispensable" ;
  interesting_A = mkA "interesting" ;
  irish_A = compoundA (mkA "Irish") ;
  italian_A = mkA "Italian" ;
  known_A = compoundA (mkA "known") ;
  large_A = mkA "large" ;
  leading_A = mkA "leading" ;
  legal_A = mkA "legal" ;
  likely_A = mkA "likely" "likelier" ;
  major_A = mkA "major" ;
  male_A = compoundA (mkA "male") ;
  many_A = mkA "many" "more" "most" "mostly" ;
  missing_A = mkA "missing" ;
  modest_A = mkA "modest" ;
  national_A = mkA "national" ;
  new_A = mkA "new" ;
  north_american_A = mkA "North American" ;
  noted_A = mkA "noted" ;
  own_A = compoundA (mkA "own") ;
  poor8bad_A = mkA "poor" ;
  poor8penniless_A = mkA "poor" ;
  portuguese_A = mkA "Portuguese" ;
  present8attending_A = mkA "present" ;
  present8current_A = mkA "present" ;
  previous_A = mkA "previous" ;
  red_A = mkA "red" ;
  resident_A = mkA "resident" ;
  scandinavian_A = mkA "Scandinavian" ;
  serious_A = compoundA (mkA "serious") ;
  slow_A = mkA "slow" ;
  small_A = mkA "small" ;
  successful_A = mkA "successful" ;
  swedish_A = mkA "Swedish" ;
  true_A = mkA "true" ;
  unemployed_A = mkA "unemployed" ;
  western_A = mkA "western" ;
  
-- VERBS
  accept_V2 = mkV2 "accept" ;
  allow_V2V = mkV2V (mkV "allow") noPrep (mkPrep "to") ;
  answer_V2 = mkV2 (mkV "answer" "answered") ;
  appoint_V2 = mkV2 "appoint" ;
  arrive_in_V2 = mkV2 (mkV "arrive") (mkPrep "in") ;
  attend_V2 = mkV2 "attend" ;
  award_V3 = mkV3 "award" ;
  beat_V = I.beat_V ;
  become_V2 = mkV2 I.become_V ;
  believe_VS = mkVS (mkV "believe") ;
  blame1_V2 = mkV2 "blame" ;
  blame2_V2 = mkV2 "blame" ;
  bring_V2V = mkV2V I.bring_V noPrep (mkPrep "to") ;
  build_V2 = mkV2 I.build_V ;
  buy_V2 = mkV2 I.buy_V ;
  catch_V2 = mkV2 I.catch_V ;
  chair_V2 = mkV2 "chair" ;
  claim_VS = mkVS (mkV "claim") ;
  come_cheap_VP = G.UseV (partV I.come_V "cheap") ;
  come_in_V = partV I.come_V "in" ;
  continue_V = mkV "continue" ;
  contribute_to_V3 = mkV3 (mkV "contribute") (mkPrep "to") ;
  cost_V2 = mkV2 "cost" ;
  crash_V = mkV "crash" ;
  cross_out_V2 = mkV2 (partV (mkV "cross") "out") ;
  deliver_V2 = mkV2 (mkV "deliver" "delivered") ;
  deliver_V3 = mkV3 (mkV "deliver" "delivered") ;
  destroy_V2 = mkV2 "destroy" ;
  develop_V2 = mkV2 (mkV "develop" "developed") ;
  discover_V2 = mkV2 (mkV "discover" "discovered") ;
  discover_VS = mkVS (mkV "discover" "discovered") ;
  dupe_V2 = mkV2 "dupe" ;
  do_VV = E.do_VV ;
  exist_V = mkV "exist" ;
  expand_V = mkV "expand" ;
  find_V2 = mkV2 I.find_V ;
  finish_V2 = mkV2 "finish" ;
  finish_VV = ingVV (mkV "finish") ;
  found_V2 = mkV2 "found" ;
  gamble_V = mkV "gamble" ;
  get_V2 = mkV2 I.get_V ;
  going_to_VV = mkVV I.go_V ;
  go8travel_V = I.go_V ;
  go8walk_V = I.go_V ;
  graduate_V = mkV "graduate" ;
  hate_V2 = mkV2 "hate" ;
  hurt_V2 = mkV2 I.hurt_V ;
  increase_V = mkV "increase" ;
  know_VQ = mkVQ (mkV "know" "knew" "known") ;	-- misrepresented in IrregEng.gf
  know_VS = mkVS (mkV "know" "knew" "known") ;	-- misrepresented in IrregEng.gf
  last_V2 = mkV2 (mkV "last") ;
  leave_V = I.leave_V ;
  leave_V2 = mkV2 I.leave_V ;
  like_V2 = mkV2 "like" ;
  live_V = mkV "live" ;
  lose_V2 = mkV2 I.lose_V ;
  maintain_V2 = mkV2 "maintain" ;
  make8become_V2 = mkV2 I.make_V ;
  make8do_V2 = mkV2 I.make_V ;
  manage_VV = mkVV (mkV "manage") ;
  meet_V = I.meet_V ;
  need_V2 = mkV2 "need" ;
  need_VV = mkVV (mkV "need") ;
  obtain_from_V3 = mkV3 (mkV "obtain") (mkPrep "from") ;
  open_V2 = mkV2 (mkV "open" "opened") ;
  own_V2 = mkV2 "own" ;
  pay_V2 = mkV2 I.pay_V ;
  publish_V2 = mkV2 "publish" ;
  put_in_V3 = mkV3 I.put_V (mkPrep "in") ;
  read_V2 = mkV2 I.read_V ;
  read_out_V2 = mkV2 (partV I.read_V "out") ;
  remove_V2 = mkV2 "remove" ;
  rent_from_V3 = mkV3 (mkV "rent") (mkPrep "from") ;
  represent_V2 = mkV2 "represent" ;
  revise_V2 = mkV2 "revise" ;
  run_V2 = mkV2 I.run_V ;
  say_VS = mkVS I.say_V ;
  see_V2V = mkV2V I.see_V noPrep noPrep ;
  sell_V2 = mkV2 I.sell_V ;
  send_V2 = mkV2 I.send_V ;
  shall_VV = {
    s = table {
      VVF VInf => ["shall"] ;  -- what to do with these forms?
      VVF VPres => "shall" ;
      VVF VPPart => ["should"] ;
      VVF VPresPart => ["should"] ;  -- what to do with these forms?
      VVF VPast => ["should"] ;
      VVPastNeg => ["shouldn't"] ;
      VVPresNeg => "shan't"
      } ;
    typ = VVAux
    } ;  
  sign_V2 = mkV2 "sign" ;
  sing_V2 = mkV2 I.sing_V ;
  speak_to_V2 = mkV2 I.speak_V (mkPrep "to");
  spend_V2 = mkV2 I.spend_V ;
  start_V = mkV "start" ;
  start_VV = ingVV (mkV "start") ;
  stop_V = mkV "stop" ;
  suggest_to_V2S = mkV2S (mkV "suggest") (mkPrep "to") ;
  swim_V = I.swim_V ;
  take_V2V = mkV2V I.take_V noPrep (mkPrep "to") ;
  take_V2 = mkV2 I.take_V ;
  take_part_in_V2 = mkV2 (partV I.take_V "part") (mkPrep "in") ;
  tell_about_V3 = mkV3 I.tell_V (mkPrep "about") ;
  travel_V = mkV "travel" "travelled" ;
  try_VV = mkVV (mkV "try") ;
  update_V2 = mkV2 "update" ;
  use_V2 = mkV2 "use" ;
  use_VV = mkVV (mkV "used" "used" "used" "used" "used") ;  -- e.g. "X used to Y", "X did used to Y"
  vote_for_V2 = mkV2 (mkV "vote") (mkPrep "for") ;
  win_V2 = mkV2 I.win_V ;
  work_V = mkV "work" ;
  work_in_V2 = mkV2 work_V (mkPrep "in") ;
  write_V2 = mkV2 I.write_V ;
  write_to_V2 = mkV2 I.write_V (mkPrep "to") ;

  award_and_be_awarded_V2 = mkV2 (mkV "award and be awarded" 
				    "awards and is awarded" 
				    "awarded and was awarded"
				    "awarded and been awarded"
				    "awarding and been awarding") ;

-- DETERMINERS
  a_few_Det = mkDeterminer plural "a few" ;
  a_lot_of_Det = mkDeterminer singular "a lot of" ;
  another_Det = mkDeterminer singular "another" ;
  anyPl_Det = mkDeterminer plural "any" ;
  anySg_Det = mkDeterminer singular "any" ;
  both_Det = mkDeterminer plural "both" ;
  each_Det = E.each_Det ;
  either_Det = mkDeterminer singular "either" ;
  neither_Det = mkDeterminer singular "neither" ;
  one_or_more_Det = mkDeterminer plural "one or more" ;
  several_Det = mkDeterminer plural "several" ;
  twice_as_many_Det = mkDeterminer plural "twice as many" ;

  half_a_Card = {s = \\c => "half a"; n = Sg} ;

  the_other_Q = mkQuant "the other" "the other" ;

-- NUMERALS

oper
  selectSub20 : {s : DForm => CardOrd => ResEng.Case => Str} -> DForm -> Numeral ;
  selectSub20 num dform = lin Numeral {s = num.s ! dform; n = plural} ;

  prefixNumeral : Str -> {s : CardOrd => ResEng.Case => Str; n : ResEng.Number} -> Numeral ;
  prefixNumeral prefix num = lin Numeral {s = \\o,c => prefix + num.s ! o ! c; n = num.n} ;

lin
  N_one = {s = G.pot01.s ! unit; n = singular} ;
  N_two = selectSub20 G.n2 unit ;
  N_three = selectSub20 G.n3 unit ;
  N_four = selectSub20 G.n4 unit ;
  N_five = selectSub20 G.n5 unit ;
  N_six = selectSub20 G.n6 unit ;
  N_eight = selectSub20 G.n8 unit ;
  N_ten = selectSub20 G.pot01 ten ;
  N_eleven = selectSub20 G.pot01 teen ;
  N_sixteen = selectSub20 G.n6 teen ;
  N_twenty = selectSub20 G.n2 ten ;
  N_fortyfive = {s = \\o,c => "forty" ++ N_five.s ! o ! c; n = plural} ;

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
  anywhere_Adv = mkAdv "anywhere" ;
  ever_since_Adv = mkAdv "ever since" ;
  late_Adv = mkAdv "late" ;
  long_Adv = mkAdv "long" ;
  over_Adv = mkAdv "over" ; 
  part_time_Adv = mkAdv "part time" ;
  together_Adv = mkAdv "together" ;
  too_Adv = mkAdv "too" ;
  twice_Adv = mkAdv "twice" ;
  yesterday_Adv = mkAdv "yesterday" ;

  at_home_Adv = mkAdv "at home" ;

  all_AdV = mkAdV "all" ;
  already_AdV = mkAdV "already" ;
  also_AdV = mkAdV "also" ;
  currently_AdV = mkAdV "currently" ;
  ever_AdV = mkAdV "ever" ;
  never_AdV = mkAdV "never" ;
  now_AdV = mkAdV "now" ;
  still_AdV = mkAdV "still" ;

  really_AdA = mkAdA "really" ;

  more_than_AdN = mkAdN "more than" ;
  less_than_AdN = mkAdN "less than" ;

-- TIME & DATE EXPRESSIONS
  at_8_am_Adv = mkAdv "at 8 am" ;
  at_a_quarter_past_five_Adv = mkAdv "at a quarter past five" ;
  at_five_oclock_Adv = mkAdv "at five o'clock" ;
  at_four_oclock_Adv = mkAdv "at four o'clock" ;
  at_least_four_times = mkAdv "at least four times" ;
  at_some_time_Adv = mkAdv "at some time" ;
  at_the_same_time_Adv = mkAdv "at the same time" ;
  by_11_am_Adv = mkAdv "by 11 am" ;
  every_month_Adv = mkAdv "every month" ;
  every_week_Adv = mkAdv "every week" ;
  for_8_years_Adv = mkAdv "for 8 years" ;
  for_a_total_of_15_years_or_more_Adv = mkAdv "for a total of 15 years or more" ;
  for_a_year_Adv = mkAdv "for a year" ;
  for_an_hour_Adv = mkAdv "for an hour" ;
  for_exactly_a_year_Adv = mkAdv "for exactly a year" ;
  for_more_than_10_years_Adv = mkAdv "for more than 10 years" ;
  for_more_than_two_years_Adv = mkAdv "for more than two years" ;
  for_three_days_Adv = mkAdv "for three days" ;
  for_two_hours_Adv = mkAdv "for two hours" ;
  for_two_years_Adv = mkAdv "for two years" ;
  friday_13th_Adv = mkAdv "Friday , 13th" ;
  from_1988_to_1992_Adv = mkAdv "from 1988 to 1992" ;
  in_1990_Adv = mkAdv "in 1990" ;
  in_1991_Adv = mkAdv "in 1991" ;
  in_1992_Adv = mkAdv "in 1992" ;
  in_1993_Adv = mkAdv "in 1993" ;
  in_1994_Adv = mkAdv "in 1994" ;
  in_a_few_weeks_Adv = mkAdv "in a few weeks" ;
  in_a_months_time_Adv = mkAdv "in a month's time" ;
  in_july_1994_Adv = mkAdv "in July 1994" ;
  in_march_1993_Adv = mkAdv "in March 1993" ;
  in_march_Adv = mkAdv "in March" ;
  in_one_hour_Adv = mkAdv "in one hour" ;
  in_the_coming_year_Adv = mkAdv "in the coming year" ;
  in_the_past_Adv = mkAdv "in the past" ;
  in_two_hours_Adv = mkAdv "in two hours" ;
  last_week_Adv = mkAdv "last week" ;
  on_friday_Adv = mkAdv "on Friday" ;
  on_july_4th_1994_Adv = mkAdv "on July 4th , 1994" ;
  on_july_8th_1994_Adv = mkAdv "on July 8th , 1994" ;
  on_monday_Adv = mkAdv "on Monday" ;
  on_the_5th_of_may_1995_Adv = mkAdv "on the 5th of May , 1995" ;
  on_the_7th_of_may_1995_Adv = mkAdv "on the 7th of May , 1995" ;
  on_thursday_Adv = mkAdv "on Thursday" ;
  on_tuesday_Adv = mkAdv "on Tuesday" ;
  on_wednesday_Adv = mkAdv "on Wednesday" ;
  saturday_july_14th_Adv = mkAdv "Saturday , July 14th" ;
  since_1992_Adv = mkAdv "since 1992" ;
  the_15th_of_may_1995_Adv = mkAdv "the 15th of May , 1995" ;
  two_years_from_now_Adv = mkAdv "two years from now" ;
  year_1996_Adv = mkAdv "1996" ;
  on_time_Adv = mkAdv "on time" ;

-- PREPOSITIONS
  at_Prep = mkPrep "at" ;
  out_of_Prep = mkPrep "out of" ;
  outside_Prep = mkPrep "outside" ;
  than_Prep = mkPrep "than" ;
  within_Prep = mkPrep "within" ;

-- PREDETERMINERS
  at_least_Predet = ss "at least" ;
  at_most_Predet = ss "at most" ;
  exactly_Predet = ss "exactly" ;
  just_Predet = ss "just" ;
  most_of_Predet = ss "most of" ;

-- CONJUNCTIONS
  andSg_Conj = mkConj "and" singular ;
  comma_and_Conj = mkConj ", and" ;
  if_comma_then_Conj = mkConj "if" ", then" singular ;
  semicolon_and_Conj = mkConj "; and" ;

  after_Subj = mkSubj "after" ;
  before_Subj = mkSubj "before" ;
  since_Subj = mkSubj "since" ; 
  than_Subj = mkSubj "than" ; 
  until_Subj = mkSubj "until" ;
  while_Subj = mkSubj "while" ;

  that_is_PConj = ss "that is ,";
  and_PConj = ss "and" ;
  then_PConj = ss "then" ;

}
