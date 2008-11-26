instance DiffBul of DiffSlavic = open CommonSlavic, Prelude in {

  param
    Case  = Acc | Dat ;

    Species = Indef | Def ;

    NForm = 
        NF Number Species
      | NFSgDefNom
      | NFPlCount
      | NFVocative
      ;

}