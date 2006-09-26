include 
  examples.Abs.gf;
--  test.Eng.gf;
  ../test.Eng.gf;

lincat 
  Text = SS;

lin
  onePhraseText t = t ;
  combine txt1 txt2 = { s = txt1.s ++ "<p>" ++ txt2.s } ;   
  russian = simpleAdj "Russian"; 
  parkedNear = (simpleAdj "parked") ** { s2 = "near" };

  ex1 = {s = ["Example 1."]};
  ex2 = {s = ["Example 2."]};
  ex3 = {s = ["Example 3."]};
  ex4 = {s = ["Example 4."]};
  ex5 = {s = ["Example 5."]};
  ex6 = {s = ["Example 6."]};
  ex7 = {s = ["Example 7."]};
  ex8 = {s = ["Example 8."]};
  ex9 = {s = ["Example 9."]};
  ex10 = {s = ["Example 10."]};
  ex11 = {s = ["Example 11."]};
  ex12 = {s = ["Example 12."]};
  ex13 = {s = ["Example 13."]};
  ex14 = {s = ["Example 14."]};
  ex15 = {s = ["Example 15."]};
  ex16 = {s = ["Example 16."]};
  ex17 = {s = ["Example 17."]};
  ex18 = {s = ["Example 18. A combination of ex1-ex16"]};
  ex19 = {s = ["Example 19. A combination of ex1-ex17"]};