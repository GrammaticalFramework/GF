concrete strMatchCnc of strMatch = open Prelude in {
  lincat S = {s : Str; b : Bool} ;
  lin f x = case x.s of {
              "" => {s="empty"; b=False} ;
              _  => x
            } ;
  lin z = {s=""; b=False} ;
}