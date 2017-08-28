concrete ConjunctionEus of Conjunction = 
  CatEus ** open ResEus, Coordination, Prelude in {

  flags optimize=all_subs ;

    {- Conjunction for category X needs four things:
       lincat [X] 
       lin BaseX
       lin ConsX
       lin ConjX

    For example, if X is defined as

      lincat X   = {s     : Number => Str ;   g : Gender} ;

    then [X] will split its s field into two, and retain its other fields as is:

      lincat [X] = {s1,s2 : Number => Str ;   g : Gender} ;

    Let us look at a simple case: Adv is of type {s : Str}
    Then [Adv] is {s1,s2 : Str}.
    BaseAdv, ConsAdv and ConjAdv can all use functions defined in prelude/Coordination:

      BaseAdv = twoSS ;
      ConsAdv = consrSS comma ;
      ConjAdv = conjunctSS ;

    --}


-- Adverb and other simple {s : Str} types.
lincat
  [Adv],[AdV],[IAdv] = {s1,s2 : Str} ;

lin
  BaseAdv, BaseAdV, BaseIAdv = twoSS ;
  ConsAdv, ConsAdV, ConsIAdv = consrSS comma ;
  ConjAdv, ConjAdV, ConjIAdv = conjunctDistrSS ;


-- RS depends on agreement, otherwise exactly like previous.
lincat
  [RS] = {s1,s2 : Agr => Str } ;

lin 
  BaseRS x y = twoTable Agr x y ;
  ConsRS xs x = consrTable Agr comma xs x ;
  ConjRS co xs = conjunctDistrTable Agr co xs ;

-- S has three building blocks; we keep only the last one's aux open,
-- and choose the independent form to all the rest.
-- Produces ungrammatical results for adverbial usage of conj sentences, e.g.
-- "when [the dog runs and you sleep], I drink beer"
lincat
  [S] = { s : Sentence } ** { firstSent : Str } ;

lin 
  BaseS x y = 
    y ** { firstSent = linS x.s } ;

  ConsS x xs = 
    xs ** { firstSent = linS x.s ++ "," ++ xs.firstSent } ;

  -- Combine the finished sentences all into the beforeAux part of the S
  ConjS co xs = 
    { s = xs.s ** {beforeAux = co.s1 ++ xs.firstSent ++ co.s2 ++ xs.s.beforeAux} } ;




-- APs and CNs. FIXME: crude first attempt, doesn't work properly.
-- ConjCN gives `*nesk edo neskek'
lincat
  [AP] = {s1,s2 : Str ; ph : Phono ; typ : APType } ;

lin
  BaseAP x y = twoSS x y ** y ; --choose all the other fields from second argument
  ConsAP as a = consrSS comma as a ** as ;
  ConjAP co as = conjunctDistrSS co as ** as ; 

lincat
  [CN] = { s1,s2 : Agr => Str } ** CNLight ;

lin 
  BaseCN = baseCN ; -- phono=FinalA words work correctly now!
  ConsCN = consCN ;
  ConjCN co cs = conjunctDistrTable Agr co cs ** cs ; 

oper
  CNLight : Type = { heavyMod : Agr => Str ; comp : Str ; ph : Phono ; anim : Bizi } ;

  -- Use linCNIndef so that words with FinalA get the -a at the end
  baseCN : CN -> CN -> [CN] = \x,y ->  
    y ** --choose all the other fields from second argument
    { s1 = \\agr => linCNIndef x ;
      s2 = y.s } ;

  consCN : CN -> [CN] -> [CN] = \x,xs ->
    xs ** --choose all the other fields from the list
    { s1 = \\agr => linCNIndef x ++ SOFT_BIND 
                 ++ comma ++ xs.s1 ! agr } ;


lincat
  [DAP] = Determiner ** { pref2 : Str } ; 

lin
  BaseDAP x y = x ** { pref2 = y.pref } ;
  ConsDAP xs x = xs ** { pref2 = x.pref } ;
  ConjDet conj xs = xs ** { pref = conj.s1 ++ xs.pref ++ conj.s2 ++ xs.pref2 } ;
  -- his or some car: haren edo zenbait auto &+ a
  -- TODO: "the or some car" 


-- Noun phrases. Should work better now.
lincat
  [NP] = { s1,s2 : Case => Str } ** NPLight ;

lin
  BaseNP x y = twoTable Case x y ** consNP x y ;
  ConsNP xs x = consrTable Case comma xs x ** consNP xs x ;
  ConjNP conj xs = conjunctNPTable conj xs ** conjNP xs conj ;

oper

  --NP without the s field; just to avoid copypaste and make things easier to change
  NPLight : Type = { stem : Str ; agr  : Agr ; anim : Bizi ; isDef : Bool } ;

  consNP : NPLight -> NPLight -> NPLight = \x,y ->
    x ** { agr = conjAgr x.agr (getNum y.agr) } ;

  conjNP : NPLight -> Conj -> NPLight = \xs,conj ->
    xs ** { agr = conjAgr xs.agr conj.nbr } ;

 -- Like conjunctTable from prelude/Coordination.gf,
 -- but forces the first argument into absolutive.
  conjunctNPTable : Conj -> ListTable Case -> {s : Case => Str} = \co,xs ->
   { s = table { Erg => co.s1 ++ xs.s1 ! Erg ++ co.s2 ++ xs.s2 ! Erg ;
                 cas => co.s1 ++ xs.s1 ! Abs ++ co.s2 ++ xs.s2 ! cas } } ;

  conjAgr : Agr -> Number -> Agr = \a,n ->
    case n of { Pl => plAgr a ; _  => a } ;

  conjNbr : Number -> Number -> Number = \n,m ->
    case n of { Pl => Pl ; _ => m } ;

}