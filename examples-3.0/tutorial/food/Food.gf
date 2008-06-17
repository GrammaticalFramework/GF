abstract Food = {

  cat
    Phrase ; Item ; Kind ; Quality ;

  flags startcat = Phrase ;

  fun
    Is : Item -> Quality -> Phrase ;
    This, That : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}