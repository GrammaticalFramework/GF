incomplete concrete FacebookI of Facebook = 
       open 
         Syntax, 
         Prelude, 
         LexFacebook 
     in 
{
lincat 
   SPerson = NP ;
   Person = NP ;
   Place = NP ;
   Page = NP ;
   Action = S ;
   Item = NP ;


lin 
SPersonToPerson sperson = sperson ;
MorePersons sperson person = mkNP and_Conj sperson person ;

PlaceToItem place = place ;
PageToItem page = page ;
ActionToItem action = nounFromS action ; 

CheckIn sperson place = mkS pastTense (mkCl sperson (checkIn place)) ;
BeFriends sperson person = mkS pastTense (mkCl sperson (beFriends person)) ;
Like sperson item = like sperson item ;

}   