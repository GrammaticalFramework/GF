abstract Question = Cat ** {

  fun

    QuestCl    : Cl -> QCl ;
    QuestVP    : IP -> VP -> QCl ;
    QuestSlash : IP -> Slash -> QCl ;
    QuestIAdv  : IAdv -> Cl -> QCl ;

    PrepIP : Prep -> IP -> IAdv ;
    AdvIP  : IP -> Adv -> IP ;
 
    IDetCN : IDet -> Num -> Ord -> CN -> IP ;

}
   
