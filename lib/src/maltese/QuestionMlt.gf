-- QuestionMlt.gf: questions and interrogatives
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete QuestionMlt of Question = CatMlt ** open ResMlt, ParamX, Prelude in {

  flags optimize=all_subs ;

  lin

    -- Cl -> QCl
    -- does John walk
    QuestCl cl = {
      s = \\t,a,p =>
        let cls = cl.s ! t ! a ! p
        in table {
          QDir   => cls ! OQuest ;
          QIndir => "kieku" ++ cls ! ODir
        }
      } ;

    -- IP -> VP -> QCl
    -- who walks
    QuestVP qp vp =
      let
        -- cl = mkClause (qp.s ! npNom) (agrP3 qp.n) vp
        cl = mkClause qp.s (agrP3 qp.n Masc) vp
      in {
        s = \\t,a,p,_ => cl.s ! t ! a ! p ! ODir
      } ;

    -- IP -> ClSlash -> QCl
    -- whom does John love
    QuestSlash ip slash =
      mkQuestion (ss (slash.c2.s ! Definite ++ ip.s)) slash ;

    -- IAdv -> Cl -> QCl
    -- why does John walk
    QuestIAdv iadv cl = mkQuestion iadv cl ;

    -- IComp -> NP -> QCl
    -- where is John
    QuestIComp icomp np =
      mkQuestion icomp (mkClause (np.s ! npNom) np.a CopulaVP) ;

    -- Prep -> IP -> IAdv
    -- with whom
    PrepIP prep ip = {s = prep.s ! Definite ++ ip.s} ;

    -- IP -> Adv -> IP
    -- who in Paris
    AdvIP ip adv = {
      s = ip.s ++ adv.s ;
      n = ip.n
      } ;

    -- IDet -> CN -> IP
    -- which five songs
    IdetCN idet cn = {
      s = idet.s ++ cn.s ! num2nounnum idet.n ;
      n = idet.n
      } ;

    -- IDet -> IP
    -- which five
    IdetIP idet = {
      s = idet.s ;
      n = idet.n
      } ;

    -- IQuant -> Num -> IDet
    -- which (five)
    IdetQuant iquant num = {
      s = iquant.s ++ num.s ! NumNom ;
      n = numform2num num.n
      } ;

    -- IAdv -> Adv -> IAdv
    -- where in Paris
    AdvIAdv iadv adv = ss (iadv.s ++ adv.s) ;

    -- IAdv -> IComp
    -- where (is it)
    CompIAdv iadv = iadv ;

    -- IP -> IComp
    -- who (is it)
    CompIP ip = ss (ip.s) ;

  lincat
    QVP = ResMlt.VerbPhrase ;

  lin
    -- VPSlash -> IP -> QVP
    -- buys what
    ComplSlashIP vp np = insertObjPre (\\_ => vp.c2.s ! Definite ++ np.s) vp ;

    -- VP -> IAdv -> QVP
    -- lives where
    AdvQVP vp adv = insertObj (\\_ => adv.s) vp ;

    -- QVP -> IAdv -> QVP
    -- buys what where
    AddAdvQVP qvp iadv = insertObj (\\_ => iadv.s) qvp ;

    -- IP -> QVP -> QCl
    -- who buys what where
    QuestQVP ip vp =
      let cl = mkClause (ip.s) (agrP3 ip.n Masc) vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;

}
