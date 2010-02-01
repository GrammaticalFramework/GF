abstract LetInDefAbs = {

fun f : Int -> Int ;
def f n = let z = f 0
          in f z ;

}