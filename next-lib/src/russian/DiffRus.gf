instance DiffRus of DiffSlavic = open CommonSlavic, Prelude in {

  param
    PrepKind   = PrepOther | PrepVNa;
    Case  = Nom | Gen | Dat | Acc | Inst | Prepos PrepKind ;

    NForm = NF Number Case ;

}