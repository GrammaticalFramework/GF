abstract Food = {
  flags startcat = Comment ;
  cat
    Comment ; Item ; Kind ; Quality ; 
  fun
    Pred : Item -> Quality -> Comment ;
    This, That : Kind -> Item ;
    Mod : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, 
      Expensive, Delicious, Boring : Quality ;
}
