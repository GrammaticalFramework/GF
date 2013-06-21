--# -path=.:../abstract:../common:../prelude

concrete QuestionLav of Question = CatLav ** open
  VerbLav,
  ParadigmsLav,
  ResLav,
  Prelude
in {

flags

  optimize = all_subs ;
  coding = utf8 ;

lin
  QuestCl cl = { s = \\m,p => "vai" ++ cl.s ! m ! p } ;

  QuestVP ip vp = { s = \\m,p => ip.s ! Nom ++ buildVerb vp.v m p (AgrP3 ip.num Masc) Pos vp.rightPol } ;

  QuestSlash ip slash = { s = \\m,p => slash.prep.s ++ ip.s ! (slash.prep.c ! ip.num) ++ slash.s ! m ! p } ;

  QuestIAdv iadv cl = { s = \\m,p => iadv.s ++ cl.s ! m ! p } ;

  QuestIComp icomp np = { s = \\m,p => icomp.s ++ buildVerb (mkV "būt") m p np.agr np.pol Pos ++ np.s ! Nom } ;

  IdetQuant idet num = {
    s = \\g => idet.s ! g ! num.num ++ num.s ! g ! Nom ;
    num = num.num
  } ;

  -- FIXME: quick&dirty - lai kompilētos pret RGL API
  -- Saskaņā ar Cat.gf, Common.gf un Structural.gf nav iespējams neko saskaņot...
  -- Identisks copy-paste ir Rus gadījumā, bet priekš Bul Krasimirs ir kaut ko paplašinājis.
  AdvIAdv i a = ss (i.s ++ a.s) ;

  AdvIP ip adv = {
    s = \\c => ip.s ! c ++ adv.s ;
    num = ip.num
  } ;

  PrepIP p ip = { s = p.s ++ ip.s ! (p.c ! ip.num) } ;

  IdetCN idet cn = {
    s = \\c => idet.s ! cn.gend ++ cn.s ! Def ! idet.num ! c ;
    num = idet.num
  } ;

  IdetIP idet = {
    s = \\c => (idet.s ! Masc) | (idet.s ! Fem) ;
    num = idet.num
  } ;

  CompIAdv a = a ;
  CompIP p = ss (p.s ! Nom) ;

}
