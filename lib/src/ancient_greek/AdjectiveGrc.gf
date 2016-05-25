concrete AdjectiveGrc of Adjective = CatGrc ** open ResGrc, Prelude, (M=MorphoGrc) in {

  lin
    PositA  a = { s = \\af => a.s ! Posit ! af } ;

    ComparA a np = let agr = Ag Masc Sg P3  -- Default, TODO : s : Agr => ...
      in {
       s = \\af => a.s ! Compar ! af ++ np.s ! Gen ; 
       } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    -- TODO: where is the argument of an A going - before or after the adjective?
    ComplA2 a np = let agr = Ag Masc Sg P3  -- DEFAULT, need ap.s : Agr => ... TODO
     in {
      s = \\af => a.s ! Posit ! af ++ a.c2.s ++ np.s ! a.c2.c ; 
      } ;

    ReflA2 a = {
      s = \\af => a.s ! Posit ! af ++ a.c2.s ++             -- P3 ??
                  M.reflPron ! (Ag (genderAf af) (numberAf af) P3) ! a.c2.c ;  
      } ;         

    SentAP ap sc = {
      s = \\af => ap.s ! af ++ sc.s ; 
      } ;

    AdAP ada ap = {
      s = \\af => ada.s ++ ap.s ! af ;
      } ;

    UseA2 a = { s = a.s ! Posit } ;

    UseComparA a = {
      s = a.s ! Compar 
      } ;

    -- TODO: 
    -- CAdvAP : CAdv -> AP -> NP -> AP  -- as cool as John
    AdjOrd ord = ord ; -- Ord -> AP = { s : AForm => Str } -- warmest

}
