-- A file with Pointers...
-- With pointers I mean the phrases that point out a specific semantics of a segment.
-- Example "I want to listen to the artist Sting" where "the artist" makes clear 
-- that "Sting" is an artist and not a song for instance. 

resource SpecResSwe = {

param ListInfo =  Numeric | Ordered ;
param ItemChoice = Artist | Song | Post;

oper listForm : ListInfo => Str 
   = table {
		Numeric => ["nummer"];
		Ordered => ["den"]
		
	};
	

oper itemForm : ItemChoice => Str
	= table {
		Artist => "artisten";
		Song => "låten";
		Post => ""
	};

}

