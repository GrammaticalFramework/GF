resource ResDecimal = {

param Zeros = noz  | zz  ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;
oper mkz : Str -> {s : Zeros => Str} = \s -> {s = table {_ => s}} ;
}
