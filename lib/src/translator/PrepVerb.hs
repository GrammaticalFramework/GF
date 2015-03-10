import qualified Data.Set
import qualified Data.Map as M

main = do
  let parts w = words (map (\c -> if c =='_' then ' ' else c) w)
  lfuns <- readFile "Dictionary.gf" >>= return . lines
  let funs = [f | "fun":f:_ <- map words lfuns]
  let verbset = Data.Set.fromList [head (parts v) | v <- allVs ++ allV2s] 
  let pverbs = [v | v <- funs, let vs = parts v, length vs > 2, head (last vs) == 'V' , Data.Set.member (head vs) verbset]
  let funset = Data.Set.fromList funs
  let hasCatt f c = case Data.Set.member (f ++ "_" ++ c) funset of
        True -> (True,"_")
        _ -> case Data.Set.member (f ++ "_1_" ++ c) funset of
          True -> (True,"_") ---- (True,"_1_")
          _ -> (False,"_")   ---- why _ needed
  let hasCat f c = fst (hasCatt f c)
  let mkFun f c = f ++ snd (hasCatt f c) ++ c
  let linPVerb v = case parts v of 
        [w,p,"V"]  | hasCat p "Adv"  && hasCat w "V"   -> advV (op w ++ "_V "  ++ mkFun (op p) "Adv") 
        [w,p,"V"]  | hasCat p "Adv"  && hasCat w "V2"  -> advV (v2V (op w) ++ mkFun (op p) "Adv") 
        [w,p,"V2"] | hasCat p "Prep" && hasCat w "V"   -> "prepV2 " ++ op w ++ "_V "  ++ mkFun (op p) "Prep" 
        [w,p,"V2"] | hasCat p "Adv"  && hasCat w "V"   -> "mkV2 (" ++ advV (op w ++ "_V "  ++ mkFun (op p) "Adv") ++ " )"  
        [w,p,"V2"] | hasCat p "Prep" && hasCat w "V2"  -> "prepV2 " ++ v2V (op w)       ++ mkFun (op p) "Prep"  
        [w,p,"V2"] | hasCat p "Adv"  && hasCat w "V2"  -> "mkV2 (" ++ advV (v2V (op w)  ++ mkFun (op p) "Adv") ++ " )"  
        [w,p,q,"V2"] | hasCat p "Adv"  && hasCat q "Prep"  && hasCat w "V"  -> "prepV2 (" ++ advV (op w ++ "_V " ++ mkFun (op p) "Adv") ++" ) " ++ mkFun (op q) "Prep"  
        [w,p,q,"V2"] | hasCat p "Adv"  && hasCat q "Prep"  && hasCat w "V2" -> "prepV2 (" ++ advV (v2V (op w) ++ mkFun (op p) "Adv") ++ " ) " ++ mkFun (op q) "Prep"  
        _ -> "variants {}"

  writeFile "TopPrepVerbs.gf" $ unlines ["lin " ++ p ++ " = " ++ linPVerb p ++ " ; -- guess-p-verb" | p <- pverbs]

advV s = "advV " ++ s
v2V v = "(lin V " ++ v ++ "_V2) "

op v = "OP_" ++ v

firstVariant s = case span (/='|') s of
  (_,[]) -> s
  (v,_) -> v ++ ";"

mkPrepVerbDict lang = do
  rs <- readFile ("Dictionary" ++ lang ++ ".gf") >>= return . lines
  let dict = M.fromList [(f,unwords r) | "lin":f:"=":r <- map words rs]
  let look x = maybe ("","variants {} ;") (\r -> ("",r)) (M.lookup x dict) ---- ("--DD ",r)) (M.lookup x dict)
  let preps = [(p, "Prep", look p) | p <- allPreps]  
  let advs  = [(p, "Adv",  look p) | p <- allAdvs]
  let verbs = [(p, "V",    look p) | p <- allVs]
  let verb2 = [(p, "V2",   look p) | p <- allV2s]

-- all variants
--  let rules = [s ++ "oper " ++ op p ++ " : " ++ c ++ " = " ++ r | (p,c,(s,r)) <- preps ++ advs ++ verbs ++ verb2]
-- just the first variant
  let rules = [s ++ "oper " ++ op p ++ " : " ++ c ++ " = " ++ firstVariant r | (p,c,(s,r)) <- preps ++ advs ++ verbs ++ verb2]
  
  let preamble = [
        "concrete TopPrepVerbs" ++ lang ++ " of Dictionary = Cat" ++ lang ++ " ** ",
        "  open Paradigms" ++ lang ++ ", (S = Syntax" ++ lang ++ "), Dictionary" ++ lang ++ " in {",
        "",
        "oper prepV2 : V -> Prep -> V2 = \\v,p -> mkV2 v p ;",
        "oper advV : V -> Adv -> V = \\v,a -> mkV v a.s ;",
        ""
        ]

  let outFile = "TopPrepVerbs" ++ lang ++ ".gf" 
  writeFile outFile $ unlines preamble
  appendFile outFile $ unlines rules
  appendFile outFile $ "\n"
  lins <- readFile "TopPrepVerbs.gf"
  appendFile outFile lins
  appendFile outFile $ "\n}"




allPreps = ["by_Prep","for_Prep","on_Prep","out_Prep","upon_Prep","up_Prep","to_Prep","with_Prep","at_Prep","of_Prep","down_Prep","about_Prep","after_Prep","around_Prep","in_Prep","over_Prep","round_Prep","off_Prep","into_Prep","under_Prep","through_Prep","along_Prep","across_Prep","before_Prep","from_Prep","against_Prep","among_Prep","towards_Prep","as_Prep","onto_Prep","above_Prep","behind_Prep","past_Prep","without_Prep","toward_Prep"]

allAdvs = ["up_Adv","in_1_Adv","on_Adv","back_Adv","around_Adv","away_1_Adv","down_Adv","off_Adv","out_Adv","about_Adv","over_Adv","apart_Adv","along_Adv","forth_Adv","forward_Adv","aside_Adv","under_Adv","round_Adv","together_Adv","across_Adv","by_Adv","through_Adv","to_Adv","even_Adv","clean_Adv","behind_Adv","ahead_Adv","way_Adv","before_Adv","below_Adv","for_Adv","open_Adv","after_Adv","clear_Adv"]

allVs = ["account_V","act_V","add_V","agree_V","aim_V","answer_V","apply_V","argue_V","ask_V","back_V","bear_V","beat_V","bend_V","blow_V","break_V","build_V","burn_V","burst_V","buy_V","call_V","care_V","carry_V","cast_V","change_V","charge_V","check_V","clean_V","clear_V","climb_V","close_V","come_V","continue_V","cost_V","count_V","crash_V","cross_V","cry_V","cut_V","decide_V","die_V","dig_V","divide_V","double_V","drag_V","draw_V","dream_V","dress_V","drink_V","drive_V","drop_V","dry_V","ease_V","eat_V","end_V","enter_V","face_V","fall_V","feed_V","feel_V","fight_V","figure_V","file_V","fill_V","find_V","finish_V","fire_V","fit_V","fix_V","fly_V","focus_V","follow_V","force_V","gain_V","give_V","go_V","grow_V","hang_V","have_V","head_V","hear_V","help_V","hide_V","hit_V","hold_V","issue_V","join_V","jump_V","keep_V","kick_V","kill_V","knock_V","land_V","laugh_V","lay_V","lead_V","lean_V","leave_V","lie_V","lift_V","light_V","link_V","listen_V","live_V","lock_V","look_V","lose_V","make_V","marry_V","measure_V","meet_V","miss_V","mix_V","mount_V","move_1_V","nod_V","note_V","occur_V","open_V","operate_V","pack_V","pass_V","pay_V","pick_V","play_1_V","point_V","pour_V","press_V","print_V","pull_V","push_V","race_V","reach_V","read_V","rely_V","report_V","ride_V","ring_V","roll_V","rule_V","run_V","rush_V","sail_V","save_V","see_V","seize_V","sell_V","send_V","settle_V","shake_V","shape_V","share_V","shoot_V","shout_V","show_V","sign_V","sing_V","sink_V","sit_V","sleep_V","slip_V","smoke_V","snap_V","sort_V","sound_V","speak_V","split_V","spread_V","stand_V","start_V","stay_V","steal_V","step_V","stick_V","stir_V","stop_V","stretch_V","strike_V","struggle_V","suit_V","sweep_V","swing_V","switch_V","talk_V","tap_V","tear_V","tell_V","think_V","throw_V","tie_V","touch_V","trade_V","train_V","try_V","turn_V","use_V","vote_V","wait_V","wake_V","walk_V","wander_V","want_V","wash_V","waste_V","watch_V","wave_V","wear_V","win_V","wind_V","wipe_V","work_1_V","write_V"]

allV2s = ["allow_V2","block_V2","bring_V2","catch_V2","choose_V2","cover_V2","explain_V2","free_V2","frighten_V2","get_V2","hand_V2","hate_V2","invite_V2","kiss_V2","mark_V2","match_V2","offer_V2","own_V2","plant_V2","put_V2","seek_V2","set_V2","shrug_V2","shut_V2","take_V2","urge_V2"]

-- full list
allV2sAll = ["allow_V2","auction_V2","bash_V2","bed_V2","belt_V2","black_V2","block_V2","blot_V2","blurt_V2","board_V2","bone_V2","book_V2","boot_V2","boss_V2","botch_V2","bottle_V2","brick_V2","bring_V2","buff_V2","bug_V2","butter_V2","cap_V2","cart_V2","catch_V2","chalk_V2","choose_V2","chuck_V2","claw_V2","cobble_V2","cock_V2","coop_V2","cop_V2","cover_V2","crack_V2","crank_V2","cream_V2","deck_V2","dish_V2","dole_V2","dust_V2","egg_V2","eke_V2","even_V2","explain_V2","eye_V2","fathom_V2","fell_V2","fence_V2","fiddle_V2","flick_V2","flog_V2","fluff_V2","fob_V2","fool_V2","free_V2","frighten_V2","fritter_V2","get_V2","gin_V2","ginger_V2","gloss_V2","glue_V2","gun_V2","hand_V2","hash_V2","hate_V2","hone_V2","hose_V2","hound_V2","invite_V2","jack_V2","jazz_V2","jot_V2","key_V2","kiss_V2","loan_V2","log_V2","lug_V2","lure_V2","man_V2","map_V2","mark_V2","mash_V2","match_V2","mete_V2","mug_V2","mull_V2","nail_V2","net_V2","offer_V2","own_V2","palm_V2","paper_V2","parcel_V2","pare_V2","patch_V2","pencil_V2","pep_V2","phase_V2","pin_V2","pit_V2","plant_V2","plate_V2","pop_V2","power_V2","prop_V2","put_V2","queer_V2","rack_V2","ramp_V2","rein_V2","rope_V2","rough_V2","salt_V2","seek_V2","set_V2","sex_V2","shore_V2","shrug_V2","shut_V2","single_V2","size_V2","smuggle_V2","snaffle_V2","spirit_V2","stack_V2","staff_V2","stash_V2","stock_V2","stow_V2","stub_V2","stuck_V2","stuff_V2","summon_V2","suss_V2","take_V2","tide_V2","time_V2","tool_V2","top_V2","tow_V2","twist_V2","urge_V2","usher_V2","vacuum_V2","wall_V2","ward_V2","wean_V2","whack_V2","while_V2","winkle_V2","word_V2","wound_V2","yank_V2","yield_V2","zip_V2","zone_V2"]

allVsAll = ["abide_V","account_V","ache_V","act_V","add_V","agree_V","aim_V","angle_V","answer_V","apply_V","argue_V","ask_V","back_V","bag_V","bail_V","ball_V","bang_V","bank_V","bargain_V","barge_V","bat_V","bawl_V","bear_V","beat_V","beaver_V","beef_V","bend_V","bid_V","bitch_V","blare_V","blast_V","blaze_V","bleed_V","blow_V","bog_V","boil_V","bolster_V","border_V","bottom_V","bounce_V","bowl_V","box_V","brace_V","branch_V","break_V","breeze_V","brighten_V","brush_V","bubble_V","buck_V","bucket_V","buckle_V","budge_V","build_V","bulk_V","bump_V","bundle_V","bunk_V","buoy_V","burn_V","burst_V","bust_V","butt_V","buy_V","buzz_V","call_V","calm_V","camp_V","cancel_V","care_V","carry_V","carve_V","cash_V","cast_V","cater_V","cave_V","chance_V","change_V","charge_V","chase_V","chat_V","cheat_V","check_V","cheer_V","chew_V","chill_V","chime_V","chip_V","choke_V","chop_V","churn_V","clam_V","clamp_V","clank_V","clean_V","clear_V","click_V","climb_V","cling_V","clog_V","close_V","cloud_V","clown_V","clutch_V","coast_V","colour_V","come_V","conjure_V","conk_V","continue_V","contract_V","cool_V","cost_V","cotton_V","cough_V","count_V","cram_V","crash_V","creep_V","crop_V","cross_V","cruise_V","cry_V","curl_V","cut_V","damp_V","dash_V","dawn_V","decide_V","die_V","dig_V","dine_V","dip_V","disagree_V","dive_V","divide_V","doss_V","double_V","doze_V","drag_V","draw_V","dream_V","dredge_V","dress_V","drift_V","drill_V","drink_V","drive_V","drone_V","drop_V","drown_V","drum_V","dry_V","duck_V","dump_V","dwell_V","ease_V","eat_V","ebb_V","edge_V","embark_V","empty_V","end_V","enter_V","face_V","fall_V","farm_V","fart_V","fasten_V","fatten_V","fawn_V","feed_V","feel_V","fend_V","ferret_V","fight_V","figure_V","file_V","fill_V","filter_V","find_V","finish_V","fire_V","firm_V","fish_V","fit_V","fix_V","fizzle_V","flag_V","flake_V","flame_V","flare_V","flip_V","flounce_V","flush_V","fly_V","focus_V","fold_V","follow_V","force_V","forge_V","fork_V","freak_V","freeze_V","freshen_V","front_V","frown_V","fuel_V","gad_V","gag_V","gain_V","gang_V","gear_V","ghost_V","give_V","gnaw_V","go_V","goof_V","grasp_V","grass_V","grey_V","grind_V","grow_V","hack_V","ham_V","hammer_V","hang_V","hanker_V","harp_V","haul_V","have_V","head_V","hear_V","heat_V","heave_V","help_V","hide_V","hinge_V","hit_V","hive_V","hold_V","hole_V","hook_V","hover_V","hunt_V","hush_V","inch_V","iron_V","issue_V","jabber_V","jam_V","jaw_V","jerk_V","jet_V","join_V","joke_V","jump_V","keel_V","keep_V","kick_V","kill_V","kip_V","knock_V","knuckle_V","land_V","lap_V","lark_V","lash_V","latch_V","laugh_V","lay_V","lead_V","leak_V","lean_V","leap_V","leave_V","level_V","lie_V","lift_V","light_V","lighten_V","limber_V","line_V","link_V","listen_V","live_V","load_V","lock_V","look_V","loosen_V","lose_V","lust_V","make_V","marry_V","measure_V","meet_V","melt_V","mess_V","mill_V","miss_V","mix_V","mock_V","monkey_V","mooch_V","mop_V","mope_V","mount_V","mouth_V","move_1_V","muddle_V","muscle_V","nag_V","narrow_V","nip_V","nod_V","nose_V","note_V","nut_V","occur_V","open_V","operate_V","opt_V","pack_V","pad_V","pair_V","pal_V","pan_V","part_V","pass_V","pat_V","pay_V","peck_V","peel_V","peg_V","perk_V","peter_V","pick_V","pig_V","pile_V","pine_V","pipe_V","pitch_V","play_1_V","plead_V","plot_V","plough_V","plow_V","pluck_V","plug_V","plump_V","plunge_V","point_V","poke_V","polish_V","pore_V","potter_V","pour_V","prattle_V","press_V","prey_V","price_V","print_V","pucker_V","pull_V","pump_V","push_V","quarrel_V","quiet_V","quieten_V","quit_V","race_V","rain_V","rake_V","ramble_V","rap_V","rat_V","rattle_V","reach_V","read_V","reason_V","reel_V","rely_V","rent_V","report_V","ride_V","ring_V","rip_V","roll_V","romp_V","room_V","root_V","round_V","row_V","rub_V","rule_V","run_V","rush_V","rustle_V","saddle_V","sag_V","sail_V","sally_V","save_V","saw_V","scale_V","scare_V","scoop_V","scout_V","scrape_V","scratch_V","screen_V","screw_V","see_V","seize_V","sell_V","send_V","settle_V","shack_V","shade_V","sidle_V","shake_V","shape_V","share_V","shave_V","shell_V","ship_V","shoot_V","shop_V","short_V","shout_V","shove_V","show_V","shy_V","side_V","sift_V","sign_V","silt_V","simmer_V","sing_V","sink_V","sit_V","skin_V","skip_V","slack_V","slacken_V","slant_V","sleep_V","slice_V","slip_V","slope_V","slough_V","slow_V","smack_V","smash_V","smoke_V","smooth_V","snap_V","snarl_V","sneak_V","sniff_V","snitch_V","snuff_V","soak_V","sober_V","soften_V","soldier_V","sort_V","sound_V","spark_V","speak_V","speed_V","spell_V","spew_V","spill_V","spin_V","spit_V","splash_V","split_V","spoil_V","sponge_V","spread_V","spring_V","sprout_V","spruce_V","spur_V","square_V","squeeze_V","stamp_V","stand_V","stare_V","start_V","stave_V","stay_V","steal_V","steer_V","stem_V","step_V","stick_V","stiffen_V","stir_V","stitch_V","stomp_V","stop_V","storm_V","straighten_V","stretch_V","strike_V","string_V","struggle_V","stumble_V","stump_V","suck_V","suit_V","sum_V","surge_V","swallow_V","swan_V","swear_V","sweat_V","sweep_V","swing_V","switch_V","syphon_V","tack_V","tag_V","tail_V","talk_V","tap_V","taper_V","team_V","tear_V","tee_V","tell_V","think_V","throw_V","thrust_V","tick_V","tidy_V","tie_V","tighten_V","tip_V","tire_V","toddle_V","tone_V","tootle_V","toss_V","tot_V","touch_V","toy_V","track_V","trade_V","train_V","trek_V","trickle_V","trip_V","trot_V","trough_V","trump_V","try_V","tuck_V","tune_V","turn_V","type_V","use_V","vamp_V","veer_V","venture_V","vote_V","wade_V","wait_V","wake_V","walk_V","waltz_V","wander_V","want_V","warm_V","wash_V","waste_V","watch_V","water_V","wave_V","wear_V","weed_V","weigh_V","well_V","wheel_V","whip_V","whisk_V","wiggle_V","win_V","wind_V","wipe_V","wire_V","work_1_V","wrap_V","wriggle_V","write_V","yammer_V","yell_V","zero_V","zoom_V"]

