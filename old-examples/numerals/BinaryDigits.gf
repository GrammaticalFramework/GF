concrete BinaryDigits of Binary = {

flags startcat=Bin ;

lincat Bin = { s : Str } ;

lin End = { s = "" } ;
lin Zero b = { s = "0" ++ b.s } ;
lin One b = { s = "1" ++ b.s } ;

}