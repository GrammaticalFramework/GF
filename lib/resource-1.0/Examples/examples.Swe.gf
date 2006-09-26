include 
  examples.Abs.gf;
--  test.Swe.gf;
  ../test.Swe.gf;

lincat 
  Text = SS;

lin
  onePhraseText t = t ;
  combine txt1 txt2 = { s = txt1.s ++ "<p>" ++ txt2.s } ;   
--  combine txt1 txt2 = { s = txt1.s ++ txt2.s } ;   
  russian = extAdjective (aFin "rysk");
  parkedNear = extAdjective (aFin "parkerad") ** { s2 = "vid" };

  ex1 = {s = ["Exempel 1."]};
  ex2 = {s = ["Exempel 2."]};
  ex3 = {s = ["Exempel 3."]};
  ex4 = {s = ["Exempel 4."]};
  ex5 = {s = ["Exempel 5."]};
  ex6 = {s = ["Exempel 6."]};
  ex7 = {s = ["Exempel 7."]};
  ex8 = {s = ["Exempel 8."]};
  ex9 = {s = ["Exempel 9."]};
  ex10 = {s = ["Exempel 10."]};
  ex11 = {s = ["Exempel 11."]};
  ex12 = {s = ["Exempel 12."]};
  ex13 = {s = ["Exempel 13."]};
  ex14 = {s = ["Exempel 14."]};
  ex15 = {s = ["Exempel 15."]};
  ex16 = {s = ["Exempel 16."]};
  ex17 = {s = ["Exempel 17."]};
  ex18 = {s = ["Exempel 18. En combination av ex1-ex16"]};
  ex19 = {s = ["Exempel 19. En combination av ex1-ex17"]};