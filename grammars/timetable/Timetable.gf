abstract Timetable = {
  cat
    Table ;
    TrainList CityList ;
    City ;
    CityList ;
    Train CityList ;
    Stop ;
    Time ;
    Number ;

  fun
    MkTable : (cs : CityList) -> TrainList cs -> Table ;
    NilTrain : (cs : CityList) -> TrainList cs ;
    ConsTrain : 
      (cs : CityList) -> Number -> Train cs -> TrainList cs -> TrainList cs ;
    OneCity : City -> CityList ;
    ConsCity : City -> CityList -> CityList ;

    StopTime : Time -> Stop ;
    NoStop : Stop ;
    
    LocTrain : (c : City) -> Stop -> Train (OneCity c) ;
    CityTrain : 
      (c : City) -> Stop -> (cs : CityList) -> 
        Train cs -> Train (ConsCity c cs) ;

    T : Int -> Time ;
    N : Int -> Number ;
    C : String -> City ;
}
