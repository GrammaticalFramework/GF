abstract Food = {

  cat
    S ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> S ;
    This, That, All : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish, Beer, Pizza : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}
