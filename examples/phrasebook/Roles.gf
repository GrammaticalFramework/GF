resource Roles = {

param
  Gender = Male | Female ;
  Politeness = Polite | Familiar ;

oper
  RolePhrase : Type = {s : Politeness => Gender => Gender => Str} ;

  politeDistinct : (_,_ : Str) -> RolePhrase = \pol,fam -> {
    s = table {
      Polite   => \\_,_ => pol ;
      Familiar => \\_,_ => fam
      }
    } ;

  speakerDistinct : (_,_ : Str) -> RolePhrase = \mal,fem -> {
    s = \\p,s,h => case s of {
      Male   => mal ;
      Female => fem
      }
    } ;

  hearerDistinct : (_,_ : Str) -> RolePhrase = \mal,fem -> {
    s = \\p,s,h => case h of {
      Male   => mal ;
      Female => fem
      }
    } ;

  roleNeutral : Str -> RolePhrase = \s -> {
    s = \\_,_,_ => s
    } ;
}
