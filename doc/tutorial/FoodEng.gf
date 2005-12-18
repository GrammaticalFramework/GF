concrete FoodEng of Food = {

  lincat
    S, Item, Kind, Quality = {s : Str} ;

  lin
    Is item quality = {s = item.s ++ "is" ++ quality.s} ;
    This kind = {s = "this" ++ kind.s} ;
    That kind = {s = "that" ++ kind.s} ;
    QKind quality kind = {s = quality.s ++ kind.s} ;
    Wine = {s = "wine"} ;
    Cheese = {s = "cheese"} ;
    Fish = {s = "fish"} ;
    Very quality = {s = "very" ++ quality.s} ;
    Fresh = {s = "fresh"} ;
    Warm = {s = "warm"} ;
    Italian = {s = "Italian"} ;
    Expensive = {s = "expensive"} ;
    Delicious = {s = "delicious"} ;
    Boring = {s = "boring"} ;

}
    