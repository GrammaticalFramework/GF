abstract MoreTest = Structural ** {

-- a random sample of lexicon to test resource grammar with

fun
Big, Happy, Small, Old, Young : AdjDeg ;
Interested, Fresh : AdjDeg ;
Slow, New, Own, Free : AdjDeg ;
American, Finnish : Adj1 ;
Married : Adj2 ; 

Finale : N ;
Man, Woman, Car, House, Light, Bar, Bottle, Wine : N ;
DrinkS, Air, Glass, Letter, Fiance, Chair, Fever : N ;
Seriousness, Book, Success, HomeBake, Golf : N ;
Competition : N ;
CinemaVisit : N ;
Orientation : N ; --? vad det nu kan heta på engelska
Idea : N ;

-- Nomen med en-ställig funktion
Mother, Uncle : Fun ;

-- Nomen med två-ställig funktion
Connection : Fun2 ;


--Intransitiva verb
Walk, Run : V ;
Sleep : V ;	
Rain : V ;
Dance : V ;
ArriveX : V ;
Sail : V ;
--Monotransitiva verb --som tar NP som objekt
Send, Wait, Love, Drink, SwitchOn, SwitchOff : TV ;
Hug, Rent, Surprise : TV ;
MakeDo : TV ;
Have : TV ;
Like : TV ;
Take : TV ;
Buy : TV ;
Build : TV ;
--med prep
Talk : TV ; -- prata med
Trust  : TV ; -- lita på
Start : TV ;
Play : TV ;
Win : TV ;
Accustomize : V3 ;
Remind : V3 ;
Devote : V3 ;
Steal : TV ;
DeserveVV : VV ;

--Ditransitiva verb
Give, Prefer : V3 ;
--(Pelle ger Fido till Lisa)
--(Pelle ger Lisa Fido)

Put : V3 ; --sätter Lisa i stolen
--Direkt, indirekt objekt
Give2 : V3 ;
Envy : V3 ;
-- två ppp som dir o indir obj
Talk2 : V3 ; -- tala med ngn om ngt

-- Verb med satskomplement 
Say, Prove : VS ;


Hope : VS ;

Believe : VS ;
Know : VS ; 
--Seem : VS ;
UseToVV : VV ;
ShallVV : VV ;
-- Partikelverb -- se TV


--Adverb
Well, Difficult, Always, ToNight, Now : AdV ;

HaveVV : VV ;
TryVV : VV;
RefuseVV : VV;
SeemVV : VV ;
ContinueVV : VV;

--Pronomen
John, Mary, Liza, Charlie, Phido, Pelle, Anders: PN ;
} ;