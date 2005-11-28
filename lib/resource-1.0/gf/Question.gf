abstract Question = Cat, Sentence ** {

  fun

    QuestCl    : Cl -> QCl ;
    QuestVP    : IP -> VP -> QCl ;
    QuestSlash : IP -> Slash -> QCl ;
    QuestIAdv  : IAdv -> Cl -> QCl ;

    PrepIP : Prep -> IP -> IAdv ;
    FunIP  : N2 -> IP -> IP ;
    AdvIP  : IP -> Adv -> IP ;
 
    IDetCN : IDet -> Num -> CN -> IP ;

}
   
