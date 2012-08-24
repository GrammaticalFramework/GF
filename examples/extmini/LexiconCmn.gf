concrete LexiconCmn of Lexicon = GrammarCmn ** open Prelude, ResCmn, ParadigmsCmn in {
flags coding=utf8;
lin
  man_N = mkN "男人" "个";        -- "nanren" "ge" first being noun, second is classifier(counter)
  woman_N = mkN "女人" "个";      -- "nvren"  "ge" classifier behaves like the "cup" in "cup of tea"
  house_N = mkN "房子" "间";      -- "fangzi" "jian"
  tree_N = mkN "树" "棵";         -- "shu"  "ke"
  big_A = mkA "大" True;          -- "da"
  small_A = mkA "小" True;        -- "xiao"
  green_A = mkA "绿" True;        -- "lv"
  walk_V = mkV "走" ;             -- "zou"
  sleep_V = mkV "睡" ;            -- "shui"
  arrive_V = mkV "到" "了" [] [] "过";           -- "dao"
  love_V2 = mkV "爱" ;            -- "ai"
  look_V2 = mkV "看" ;            -- "kan"
  please_V2 = mkV "麻烦" ;        -- "mafan"
  believe_VS = mkV "相信" ;       -- "xiangxin"
  know_VS = mkV "知道" [] [] [] [];          -- "zhidao"
  wonder_VQ = mkV "好奇" [] [] [] [];        -- "haoqi" 
  john_PN = mkPN "约翰" Sg ;         -- "yuehan"
  mary_PN = mkPN "玛丽" Sg ;         -- "mali"

}
