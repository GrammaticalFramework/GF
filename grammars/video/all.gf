-- wrapper module containing both User's and System's grammars. AR 16/9/2004

abstract all = specUser,specSystem **  {

-- Suggestion: use different categories for system's and user's moves
-- and bring them together only here; now both use DMove

-- cat Move ;
-- fun userMove   : UMove -> Move ;
-- fun systemMove : SMove -> Move ;

} ;

