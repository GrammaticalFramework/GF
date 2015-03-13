concrete FoodsMon of Foods = open ResFoodsMon in {
  flags coding=utf8;

  lincat
   Phrase = {s : Str} ;
Quality = Adjective ;
Kind = Noun ;
   Item = NounPhrase ;

  lin
   Pred item quality = {s = item.s ++ "бол"++ quality.s} ;
   This  = det Sg "энэ" ;
   These = det Pl "эдгээр" ;
   Mod quality kind = {s = \\n => quality.s ++ kind.s ! n} ;
   Wine = regNoun "дарс" ;
   Cheese = regNoun "бяслаг" ;
   Very adj = {s = "маш" ++ adj.s} ;
   Fresh = mkAdj "шинэ" ;
   Expensive = mkAdj "үнэтэй" ;
}
