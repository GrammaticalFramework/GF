concrete ConjunctionSlv of Conjunction = 
  CatSlv ** open ResSlv in {

  lin
    ConjAP conj xs = {
      s = \\sp,g,c,n => xs.s1 ! sp ! g ! c ! n ++ conj.s ++ xs.s2 ! sp ! g ! c ! n
    } ;

-- These fun's are generated from the list cat's.

    BaseAP x y  = { s1 = x.s; s2=y.s } ;
    ConsAP x xs = {
      s1 = \\sp,g,c,n => x.s ! sp ! g ! c ! n ++ xs.s1 ! sp ! g ! c ! n ;
      s2 = xs.s2
    } ;

  lincat
    [AP] = {s1,s2 : Species => Gender => Case => Number => Str} ;

}
