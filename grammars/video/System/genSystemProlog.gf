-- File name system.Prolog.gf

concrete genSystemProlog of genSystem = generalProlog **
  open prologResource in {


pattern
greet = "greet" ;
quit = "quit" ;

lin
ask q = {s = app "ask" q.s} ;

lin
---Language
change_language = {s = "change_language"} ;
language_alt = {s = "[" ++ "language" ++ "(" ++ "X" ++ ")" ++ "]" } ;  -- hack!

---Actions
pattern
actionQ = "action" ;

lin
whQuestion f = {s = "X" ++ "^" ++ app f.s "X"} ;
altQuestion a1 a2 = {s = a1.s ++ a2.s};

--- Issue
issue i = {s = app "issue" i.s} ;

pattern
nil = "[]" ;
}
