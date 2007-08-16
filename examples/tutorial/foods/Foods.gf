abstract Foods = {

  cat
    S ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> S ;
    This, That, These, Those : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish, Pizza : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}