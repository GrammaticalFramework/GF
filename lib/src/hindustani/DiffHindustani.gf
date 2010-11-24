interface DiffHindustani = open CommonHindustani, Prelude in {
 oper
  
  mkClause : NP -> VPH -> Clause ;
  mkSClause : Str -> Agr -> VPH -> Clause ;
  
  np2pronCase :  (Case => Str) -> NPCase -> Agr -> Str ;
}