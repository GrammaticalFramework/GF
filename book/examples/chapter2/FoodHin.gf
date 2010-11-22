
 concrete FoodHin of Food = {
   flags coding = utf8 ;
   lincat Comment, Item, Kind, Quality = Str ;
   lin
     Pred item quality = item ++ quality ++ "है" ;
     This kind = "यह" ++ kind ;
     That kind = "वह" ++ kind ;
     Mod quality kind = quality ++ kind ;
     Wine = "मदिरा" ;
     Cheese = "पनीर" ;
     Fish = "मछली" ;
     Very quality = "अति" ++ quality ;
     Fresh = "ताज़ा" ;
     Warm = "गरम" ;
     Italian = "इटली" ; 
     Expensive = "बहुमूल्य" ;
     Delicious = "स्वादिष्ट" ;
     Boring = "अरुचिकर" ;
 }




