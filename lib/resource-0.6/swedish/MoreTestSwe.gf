--# -path=.:../abstract:../../prelude

concrete MoreTestSwe of MoreTest = StructuralSwe ** open Prelude, SyntaxSwe in {

flags startcat=Phr ; lexer=text ; unlexer=text ;

-- a random sample from the lexicon

lin
--aFin, aFager, aGrund, aVid, aVaken, aKorkad,  aAbstrakt

Big = stor_25 ;
Small = liten_1146 ;
Old = gammal_16 ;
Young = ung_29 ;

American = extAdjective (aFin "amerikansk") ;
Finnish = extAdjective (aFin "finsk") ;
Married = extAdjective (aAbstrakt "gift") ** {s2 = "med"} ;

Happy = aFin "lycklig" ;
Free = aFin "ledig" ;
Slow = aFin "långsam" ;
New = aVid "ny" ;
Own = aVaken "eg" ;
Fresh = aFin "frisk" ; 
Interested = aGrund "intressera" ;


--sApa, sBil sPojke, sNyckel sKam sSak , sVarelse , 
--sNivå, sParti,sMuseum sRike sLik sRum sHus sPapper 
--sNummer sKikare, sProgram
Finale = extCommNoun NoMasc (sSak "final") ; 
Idea = extCommNoun NoMasc (sBil "idé") ; 
Orientation = extCommNoun NoMasc (sBil "orientering") ; 
Air = extCommNoun NoMasc (sBil "luft") ;
Golf = extCommNoun NoMasc (sBil "golf") ;
Man = extCommNoun Masc man_1144 ;
Bar = extCommNoun NoMasc (sSak "bar") ;
DrinkS = extCommNoun NoMasc (sSak "drink") ;
Book = extCommNoun NoMasc (sSak "bok") ; -- omljud?
Bottle = extCommNoun NoMasc (sApa "flask") ;
Letter = extCommNoun NoMasc (sHus "brev") ;
Fiance = extCommNoun NoMasc (sNivå "fästmö") ;
Woman = extCommNoun NoMasc (sApa "kvinn") ;
Car = extCommNoun NoMasc (sBil "bil") ;
House = extCommNoun NoMasc (sHus "hus") ;
Glass = extCommNoun NoMasc (sHus "glas") ;
Light = extCommNoun NoMasc (sHus "ljus") ;
Wine = extCommNoun NoMasc (sParti "vin") ;
Success = extCommNoun NoMasc (sBil "framgång") ;
Seriousness = extCommNoun NoMasc (sHus "allvar") ;
Chair = extCommNoun NoMasc (sBil "stol") ;
Fever = extCommNoun NoMasc (sBil "feber") ;
HomeBake = extCommNoun NoMasc (sBil "hembakt") ; --måste ändra sen
Competition = extCommNoun NoMasc (sBil "tävling") ;
CinemaVisit = extCommNoun NoMasc (sHus "biobesök") ;

-- Nomen med en-ställig funktion
Mother = mkFun (extCommNoun NoMasc mor_1) "till" ;
Uncle = mkFun (extCommNoun Masc farbror_8) "till" ;

-- Nomen med två-ställig funktion
Connection = mkFun (extCommNoun NoMasc (sVarelse "förbindelse")) "från" ** 
         {s3 = "till"} ;


--vTala, vLeka vTyda vVända
--vByta vGömma vHyra vTåla
--vFinna

-- Intransitiva verb
Walk = extVerb Act gå_1174 ;
Run = extVerb Act (vFinna "spring" "sprang" "sprung") ;
Dance = extVerb Act (vTala "dans") ;
Rain = extVerb Act (vTala "regn") ;
Sleep = extVerb Act (vFinna "sov" "sov" "sov") ;
Sail = extVerb Act (vTala "segl") ;

--Monotransitiva verb
Surprise = extTransVerb (vTala "överrask") [] ;
Drink = extTransVerb (vFinna "drick" "drack" "druck") [] ;
Love = extTransVerb (vTala "älsk") [] ;
Send = extTransVerb (vTala "skick") [] ;
Wait = extTransVerb (vTala "vänt") "på" ;
Build = extTransVerb (vLeka "bygg") [] ;
Buy = extTransVerb (vLeka "köp") [] ;
Rent = extTransVerb (vHyra "hyr") [] ;
MakeDo = extTransVerb (vHyra "gör") [] ; --Hack!
Hug = extTransVerb (vTala "kram") [] ;
Have = extTransVerb hava_1198 [] ;
Like = extTransVerb (vTala "gill") [] ;
Take = extTransVerb (vFinna "ta" "tog" "tag") [] ; --
Start = extTransVerb (vTala "start") [] ;
Play = extTransVerb (vTala "spel") [] ;
Win = extTransVerb (vFinna "vinn" "vann" "vunn") [] ;

--Bitransitiva verb
Give2 = extTransVerb (vFinna "giv" "gav" "giv") [] ** {s3 = ""} ; -- ge
Envy = extTransVerb (vTala "missunn") [] ** {s3 = ""} ; 

--(Bi)transverb med obligatorisk pp
Give = extTransVerb (vFinna "giv" "gav" "giv") [] ** {s3 = "till"} ; -- ge
Accustomize = extTransVerb (vFinna "vänj" "vande" "van")  [] ** {s3 = "vid"} ; -- 
Steal = extTransVerb (vHyra "stjäl") [] ; -- oh o hur ska detta böjas?

Devote = extTransVerb (vTala "ägn")  [] ** {s3 = "åt"} ; -- 
Remind = extTransVerb (vTåla "påminn")  [] ** {s3 = "om"} ; -- 

Prefer = extTransVerb (vFinna "föredrag" "föredrog" "föredrag") [] ** {s3 = "framför"} ; --- föredra
Put = extTransVerb (vFinna "sätt" "satte" "satt") [] ** {s3 = "i"} ; 
Talk2 = extTransVerb (vTala "tal") ["med"] ** {s3 = "om"} ;


-- Verb med satskomplement
-- kan bara ta fullständiga satser, inledda med att?
Say = extVerb Act (vLeka "säg") ;
Prove = extVerb Act (vTala "bevis") ;


Hope  = extVerb Pass(vTala "hopp") ;-- har ej deponens?
Believe = extTransVerb (vTala "lit") "på" ;
Know = extVerb Act (vTala "vet") ;

-- Verb som tar infinitivt verb, "ha" tar emellertid supinum
UseToVV = extVerb Act (vTala "bruk") ** {isAux = True} ;
RefuseVV    = extVerb Act (vTala "vägr") ** {isAux = variants{False;True}} ;
HaveVV    = extVerb Act (vHyra "har") ** {isAux = True} ; -- finns ju redan, måste kolla
SeemVV = extVerb Act (vTala "verk")  ** {isAux = True};
ShallVV = extVerb Act (vTala "skull")  ** {isAux = True};
ContinueVV = extVerb Act (vFinna "fortsätt" "fortsatte" "fortsatt")  ** {isAux = variants{False;True}} ;
DeserveVV = extVerb Act (vTala "förtjän")  ** {isAux = variants{False;True}} ;
TryVV    = extVerb Act (vLeka "försök") ** {isAux = variants{False;True}} ;

--Partikelverb
SwitchOn = mkDirectVerb (extVerbPart Act (vFinna "sätt" "satte" "satt") "på") ;
SwitchOff = mkDirectVerb (extVerbPart Act (vLeka "stäng") "av") ;
ArriveX = extVerbPart Act (vFinna "komm" "kom" "kommit") "fram" ;

-- Transitiva verb med obligatorisk pp
Talk = extTransVerb (vTala "prat") "med" ;
Trust = extTransVerb (vTala "lit") "på" ;

--Adverb
Always = advPre "alltid" ;
Well = advPost "bra" ;
Now = advPost "nu" ;
Difficult = advPost "svårt" ;
ToNight = advPost "ikväll" ;

-- Pronomen
John = mkProperName "Johan" Utr Masc ;
Mary = mkProperName "Maria" Utr NoMasc ;
Pelle = mkProperName "Pelle" Utr Masc ;
Liza = mkProperName "Lisa" Utr NoMasc ;
Phido = mkProperName "Fido" Utr NoMasc ;
Charlie = mkProperName "Kalle" Utr Masc ;
Anders = mkProperName "Anders" Utr Masc ;

-- verbVara = extVerb Act vara_1200 ;
-- verbHava = extVerb Act hava_1198 ;
-- verbFinnas = mkVerb "finnas" "finns" "finns" ;

} ;