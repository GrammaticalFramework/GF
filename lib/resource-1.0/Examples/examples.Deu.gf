include 
  examples.Abs.gf;
--  test.Deu.gf;
  ../test.Deu.gf;

lincat 
  Text = SS;

lin
  onePhraseText t = t ;
  combine txt1 txt2 = { s = txt1.s ++ "<p>" ++ txt2.s } ;   
--  combine txt1 txt2 = { s = txt1.s ++ txt2.s } ;   

  ex1 = {s = ["Beispiel 1."]};
  ex2 = {s = ["Beispiel 2."]};
  ex3 = {s = ["Beispiel 3."]};
  ex4 = {s = ["Beispiel 4."]};
  ex5 = {s = ["Beispiel 5."]};
  ex6 = {s = ["Beispiel 6."]};
  ex7 = {s = ["Beispiel 7."]};
  ex8 = {s = ["Beispiel 8."]};
  ex9 = {s = ["Beispiel 9."]};
  ex10 = {s = ["Beispiel 10."]};
  ex11 = {s = ["Beispiel 11."]};
  ex12 = {s = ["Beispiel 12."]};
  ex13 = {s = ["Beispiel 13."]};
  ex14 = {s = ["Beispiel 14."]};
  ex15 = {s = ["Beispiel 15."]};
  ex16 = {s = ["Beispiel 16."]};
  ex17 = {s = ["Beispiel 17."]};
  ex18 = {s = ["Beispiel 18. A combination of ex1-ex16"]};
  ex19 = {s = ["Beispiel 19. A combination of ex1-ex17"]};

