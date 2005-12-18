concrete MorefoodEng of Morefood = FoodEng ** {
    lincat
      Question = {s : Str} ;
    lin
      QIs item quality = {s = "is" ++ item.s ++ quality.s} ;
      Pizza = {s = "pizza"} ;
}