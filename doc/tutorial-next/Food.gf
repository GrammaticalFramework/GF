abstract Food = {

  cat
    S ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> S ;
    This, That : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}