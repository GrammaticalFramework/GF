concrete QuestionEng of Question = CatEng, SentenceEng ** open ResEng in {

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! OQuest ;
              QIndir => "if" ++ cls ! ODir
              } ---- "whether" in exts
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,q => 
        let 
          agr   = {n = qp.n ; p = P3} ;
          verb  = vp.s ! t ! a ! b ! ODir ! agr ;
          subj  = qp.s ! Nom ;
          compl = vp.s2 ! agr
        in
        subj ++ verb.fin ++ verb.inf ++ compl
    } ;

{-
    QuestSlash : IP -> Slash -> QCl ;
    QuestIAdv  : IAdv -> Cl -> QCl ;

    PrepIP : Prep -> IP -> IAdv ;
    FunIP  : N2 -> IP -> IP ;
    AdvIP  : IP -> Adv -> IP ;
 
    IDetCN : IDet -> Num -> IP ;
-}

}
   
