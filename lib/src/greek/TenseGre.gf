--concrete TenseEll of Tense = 
-- CatEll ** open ResEll, CommonEll , Prelude in {

concrete TenseGre of Tense = ResGre [TTense,Mood,Voice] ,CommonGre ** open (R = ParamX) in {


flags coding = utf8 ;

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a ; m = t.m } ;
   

     TPres = {s = [] ; t = ResGre.TPres ; m = Ind} ;
     TPast = {s = [] ; t = ResGre.TPast; m = Ind} ;
     TFut = {s = [] ; t = ResGre.TFut; m = Ind} ;
     TCond = {s = [] ; t = ResGre.TCond; m = Ind} ;
     

    ASimul = {s = []} ** {a = R.Simul} ;
    AAnter = {s = []} ** {a = R.Anter} ; --# notpresent
   
    PPos  = {s = []} ** {p = R.Pos} ;
    PNeg  = {s = []} ** {p = R.Neg} ;

    }
    