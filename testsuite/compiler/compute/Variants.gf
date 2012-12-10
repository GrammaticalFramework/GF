resource Variants = {
  oper
    hello = r.f "hello";
    r = { f:Str->Str = (id|dup) };
    id : Str->Str = \ s -> s;
    dup : Str->Str = \ s -> s++s;
}
