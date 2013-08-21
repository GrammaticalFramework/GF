interface LexFacebook = open Syntax in 
{
oper
nounFromS : S -> NP ;
checkIn : NP -> VP ;
beFriends : NP -> VP ;
like : NP -> NP -> S ;
}