abstract Shaw = Trigram ** {

-- This module contains Trigram model of this quote from George Bernard Shaw:
--
-- The reasonable man adapts himself to the world; the unreasonable one persists in trying
-- to adapt the world to himself. Therefore all progress depends on the unreasonable man.

data
   the_W,reasonable_W,man_W,adapts_W,himself_W,to_W,world_W,unreasonable_W,
   one_W,persists_W,in_W,trying_W,adapt_W,therefore_W,all_W,progress_W,depends_W,on_W : Word ;
   
   the_U          : Unigram the_W ;           --# prob 0.179
   reasonable_U   : Unigram reasonable_W ;    --# prob 0.036
   man_U          : Unigram man_W ;           --# prob 0.071
   adapts_U       : Unigram adapts_W ;        --# prob 0.036
   himself_U      : Unigram himself_W ;       --# prob 0.071
   to_U           : Unigram to_W ;            --# prob 0.107
   world_U        : Unigram world_W ;         --# prob 0.071
   unreasonable_U : Unigram unreasonable_W ;  --# prob 0.071
   one_U          : Unigram one_W ;           --# prob 0.036
   persists_U     : Unigram persists_W ;      --# prob 0.036
   in_U           : Unigram in_W ;            --# prob 0.036
   trying_U       : Unigram trying_W ;        --# prob 0.036
   adapt_U        : Unigram adapt_W ;         --# prob 0.036
   therefore_U    : Unigram therefore_W ;     --# prob 0.036
   all_U          : Unigram all_W ;           --# prob 0.036
   progress_U     : Unigram progress_W ;      --# prob 0.036
   depends_U      : Unigram depends_W ;       --# prob 0.036
   on_U           : Unigram on_W ;            --# prob 0.036

   the_reasonable_B    : Bigram the_W reasonable_W ;      --# prob 0.037
   reasonable_man_B    : Bigram reasonable_W man_W ;      --# prob 0.037
   man_adapts_B        : Bigram man_W adapts_W ;          --# prob 0.037
   adapts_himself_B    : Bigram adapts_W himself_W ;      --# prob 0.037
   himself_to_B        : Bigram himself_W to_W ;          --# prob 0.037
   to_the_B            : Bigram to_W the_W ;              --# prob 0.037
   the_world_B         : Bigram the_W world_W ;           --# prob 0.037
   world_the_B         : Bigram world_W the_W ;           --# prob 0.037
   the_unreasonable_B  : Bigram unreasonable_W one_W ;    --# prob 0.074
   unreasonable_one_B  : Bigram unreasonable_W one_W ;    --# prob 0.037
   one_persists_B      : Bigram one_W persists_W ;        --# prob 0.037
   persists_in_B       : Bigram persists_W in_W ;         --# prob 0.037
   in_trying_B         : Bigram in_W trying_W ;           --# prob 0.037
   trying_to_B         : Bigram trying_W to_W ;           --# prob 0.037
   to_adapt_B          : Bigram to_W adapt_W ;            --# prob 0.037
   adapt_the_B         : Bigram adapt_W the_W ;           --# prob 0.037
   the_world_B         : Bigram the_W world_W ;           --# prob 0.037
   world_to_B          : Bigram world_W to_W ;            --# prob 0.037
   to_himself_B        : Bigram to_W himself_W ;          --# prob 0.037
   himself_therefore_B : Bigram himself_W therefore_W ;   --# prob 0.037
   therefore_all_B     : Bigram therefore_W all_W ;       --# prob 0.037
   all_progress_B      : Bigram all_W progress_W ;        --# prob 0.037
   progress_depends_B  : Bigram progress_W depends_W ;    --# prob 0.037
   depends_on_B        : Bigram depends_W on_W ;          --# prob 0.037
   on_the_B            : Bigram on_W the_W ;              --# prob 0.037
   unreasonable_man_B  : Bigram unreasonable_W man_W ;    --# prob 0.037
   
   the_reasonable_man_T         : Trigram the_W reasonable_W man_W ;         --# prob 0.038
   reasonable_man_adapts_T      : Trigram reasonable_W man_W adapts_W ;      --# prob 0.038
   man_adapts_himself_T         : Trigram man_W adapts_W himself_W ;         --# prob 0.038
   adapts_himself_to_T          : Trigram adapts_W himself_W to_W ;          --# prob 0.038
   himself_to_the_T             : Trigram himself_W to_W the_W ;             --# prob 0.038
   to_the_world_T               : Trigram to_W the_W world_W ;               --# prob 0.038
   the_world_the_T              : Trigram the_W world_W the_W ;              --# prob 0.038
   world_the_unreasonable_T     : Trigram world_W the_W unreasonable_W ;     --# prob 0.038
   the_unreasonable_one_T       : Trigram the_W unreasonable_W one_W ;       --# prob 0.038
   unreasonable_one_persists_T  : Trigram unreasonable_W one_W persists_W ;  --# prob 0.038
   one_persists_in_T            : Trigram one_W persists_W in_W ;            --# prob 0.038
   persists_in_trying_T         : Trigram persists_W in_W trying_W ;         --# prob 0.038
   in_trying_to_T               : Trigram in_W trying_W to_W ;               --# prob 0.038
   trying_to_adapt_T            : Trigram trying_W to_W adapt_W ;            --# prob 0.038
   to_adapt_the_T               : Trigram to_W adapt_W the_W ;               --# prob 0.038
   adapt_the_world_T            : Trigram adapt_W the_W world_W ;            --# prob 0.038
   the_world_to_T               : Trigram the_W world_W to_W ;               --# prob 0.038
   world_to_himself_T           : Trigram world_W to_W himself_W ;           --# prob 0.038
   to_himself_therefore_T       : Trigram to_W himself_W therefore_W ;       --# prob 0.038
   himself_therefore_all_T      : Trigram himself_W therefore_W all_W ;      --# prob 0.038
   therefore_all_progress_T     : Trigram therefore_W all_W progress_W ;     --# prob 0.038
   all_progress_depends_T       : Trigram all_W progress_W depends_W ;       --# prob 0.038
   progress_depends_on_T        : Trigram progress_W depends_W on_W ;        --# prob 0.038
   depends_on_the_T             : Trigram depends_W on_W the_W ;             --# prob 0.038
   on_the_unreasonable_T        : Trigram on_W the_W unreasonable_W ;        --# prob 0.038
   the_unreasonable_man_T       : Trigram the_W unreasonable_W man_W ;       --# prob 0.038
}