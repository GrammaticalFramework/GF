
--concrete SymbolUrd of Symbol = CatUrd ** open Prelude, ResUrd, StringsHindustani in {
incomplete concrete SymbolHindustani of Symbol = 
  CatHindustani ** open Prelude, ResHindustani, CommonHindustani in {

 lin
-- SymbPN i = {s = \\_ => i.s ; g = Masc} ;
  SymbPN i = {s = addGenitiveS i.s ; g = Masc} ;
  IntPN i  = {s = addGenitiveS i.s ; g = Masc} ;
  FloatPN i = {s = addGenitiveS i.s ; g = Masc} ;
  NumPN i = {s = \\_ =>i.s ; g = Masc} ;
  CNIntNP cn i = {
    s = \\c => cn.s ! Sg ! Dir ++ i.s ;
    a = agrP3 cn.g Sg
    } ;
  CNSymbNP det cn xs = {
    s = \\c => det.s ! det.n ! Masc ! Dir ++ cn.s ! det.n ! Dir ++  xs.s ;  -- may be need to refine it i.e instead of using \\c should use table and then corresponding forms from det 
    a = agrP3 cn.g det.n
    } ;
  CNNumNP cn i = {
    s = \\c => cn.s ! Sg ! Dir ++ i.s ;
    a = agrP3 cn.g Sg
    } ;

  SymbS sy = sy ; 
  SymbNum sy = { s = sy.s ; n = Pl } ;
  SymbOrd sy = { s = sy.s ++ waN ; n = Pl} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS awr ;
  ConsSymb = infixSS [] ;
  
oper
    -- Note: this results in a space before 's, but there's
    -- not mauch we can do about that.
    addGenitiveS : Str -> Case => Str = \s -> 
--     table {_ => s ++ "ka" } ;
     table {_ => s  } ;  -- testing for webalt but i think should bring back to its origional form as 'ka' is needed for making genitive, in webalt it gives unnecessary 'ka'

}