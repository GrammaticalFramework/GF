include 
  examples.Abs.gf;
--  test.Ita.gf;
  ../test.Ita.gf;

lincat 
  Text = SS;

lin
  onePhraseText t = t ;
  combine txt1 txt2 = { s = txt1.s ++ "<p>" ++ txt2.s } ;   
--  combine txt1 txt2 = { s = txt1.s ++ txt2.s } ;   

  ex1 = {s = ["Esempio 1."]};
  ex2 = {s = ["Esempio 2."]};
  ex3 = {s = ["Esempio 3."]};
  ex4 = {s = ["Esempio 4."]};
  ex5 = {s = ["Esempio 5."]};
  ex6 = {s = ["Esempio 6."]};
  ex7 = {s = ["Esempio 7."]};
  ex8 = {s = ["Esempio 8."]};
  ex9 = {s = ["Esempio 9."]};
  ex10 = {s = ["Esempio 10."]};
  ex11 = {s = ["Esempio 11."]};
  ex12 = {s = ["Esempio 12."]};
  ex13 = {s = ["Esempio 13."]};
  ex14 = {s = ["Esempio 14."]};
  ex15 = {s = ["Esempio 15."]};
  ex16 = {s = ["Esempio 16."]};
  ex17 = {s = ["Esempio 17."]};
  ex18 = {s = ["Esempio 18. A combination of ex1-ex16"]};
  ex19 = {s = ["Esempio 19. A combination of ex1-ex17"]};

