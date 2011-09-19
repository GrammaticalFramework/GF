resource Records = {

param P = A;

oper
  hello = id "hello";
  -- Id should be an identity function for Str
--id : Str -> Str = \ s -> s ;
  id : Str -> Str = \ s -> ({a=s}**f r).a;
  f : { b:Str } -> { b:Str } = \ x -> x;
  r : { a:P; b:Str} = {a=A;b="b"};
}
