resource NumeralsResEng = {

param DForm = unit  | teen  | ten  ;

oper mkNum : Str -> Str -> Str -> {s : DForm => Str} = 
  \two -> \twelve -> \twenty -> 
  {s = table {unit => two ; teen => twelve ; ten => twenty}} ;
oper regNum : Str -> {s : DForm => Str} = 
  \six -> mkNum six (six + "teen") (six + "ty") ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;

}