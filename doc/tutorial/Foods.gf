abstract Foods = {

  cat
    S ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> S ;
    This, That, All, Most : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}