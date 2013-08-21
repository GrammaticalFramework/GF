abstract Facebook = {

flags startcat = Action ;

cat 
  SPerson;
  Person;
  Place;
  Page;
  Action; 
  Item ;

fun 
 CheckIn : SPerson -> Place -> Action ;
 BeFriends : SPerson -> Person -> Action ;
 Like : SPerson -> Item -> Action ; 

 SPersonToPerson : SPerson -> Person ;
 MorePersons : SPerson -> Person -> Person ;
 
 PlaceToItem : Place -> Item ;
 PageToItem : Page -> Item ;
 ActionToItem : Action -> Item ;

 
---------
 
You : SPerson ;
John : SPerson; 
Mary : SPerson; 

Frauinsel : Place;
GF : Page; 

}