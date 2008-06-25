abstract Foods = {

  flags startcat=Phrase ;

  cat
    Phrase ; Item ; Kind ; Quality ;

  fun
    Is : Item -> Quality -> Phrase ;
    This, That, These, Those : Kind -> Item ;
    QKind : Quality -> Kind -> Kind ;
    Wine, Cheese, Fish, Pizza : Kind ;
    Very : Quality -> Quality ;
    Fresh, Warm, Italian, Expensive, Delicious, Boring : Quality ;

}
