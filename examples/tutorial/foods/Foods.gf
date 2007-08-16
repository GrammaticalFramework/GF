abstract Foods = {

  flags startcat=Phr ;

  cat
    Phr ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> Phr ;
    This, That, These, Those : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish, Pizza : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}
