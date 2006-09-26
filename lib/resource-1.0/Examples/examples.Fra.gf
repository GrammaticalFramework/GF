include 
  examples.Abs.gf;
--  test.Fra.gf;
  ../test.Fra.gf;

lincat 
  Text = SS;

lin
  onePhraseText t = t ;
  combine txt1 txt2 = { s = txt1.s ++ "<p>" ++ txt2.s } ;   
--  combine txt1 txt2 = { s = txt1.s ++ txt2.s } ;   
  russian = mkAdjective (adjJeune "russe") adjPost ; 
  parkedNear = mkAdjective (adjGrand "garé") adjPost ** 
       {s2 = "prés"; c = genitive};

  ex1 = {s = ["Example 1."]};
  ex2 = {s = ["Exemple 2."]};
  ex3 = {s = ["Exemple 3."]};
  ex4 = {s = ["Exemple 4."]};
  ex5 = {s = ["Exemple 5."]};
  ex6 = {s = ["Exemple 6."]};
  ex7 = {s = ["Exemple 7."]};
  ex8 = {s = ["Exemple 8."]};
  ex9 = {s = ["Exemple 9."]};
  ex10 = {s = ["Exemple 10."]};
  ex11 = {s = ["Exemple 11."]};
  ex12 = {s = ["Exemple 12."]};
  ex13 = {s = ["Exemple 13."]};
  ex14 = {s = ["Exemple 14."]};
  ex15 = {s = ["Exemple 15."]};
  ex16 = {s = ["Exemple 16."]};
  ex17 = {s = ["Exemple 17."]};
  ex18 = {s = ["Exemple 18. Une combination de ex1-ex16"]};
  ex19 = {s = ["Exemple 19. Une combination de ex1-ex17"]};