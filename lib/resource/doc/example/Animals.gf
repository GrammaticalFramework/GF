-- The Question grammar specialized to animals.

abstract Animals = Questions ** {

  fun
    -- a lexicon of animals and actions among them
    Dog, Cat, Mouse, Lion, Zebra : Entity ;
    Chase, Eat, Like : Action ;
}

