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

  oper
    Agr = {gn : GenNum ; p : Person} ;

    agrP3 : GenNum -> Agr = \gn -> 
      {gn = gn; p = P3} ;

}