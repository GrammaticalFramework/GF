resource OrthoAra = open Prelude, Predef in {

flags coding=utf8 ;

  oper
    
    rectifyHmz: Str -> Str = \word ->
      case word of {
        l@(""|"ال") + "؟" + v@("َ"|"ُ") + tail => l + "أ" + v + tail;
        l@(""|"ال") + "؟" + v@("ِ") + tail => l + "إ" + v + tail;
        head + v1@("ِ"|"ُ"|"َ"|"ْ"|"ا"|"ي"|"و") + "؟" + v2@(""|"ُ"|"َ"|"ْ"|"ِ") => head + v1 + (tHmz v1) + v2;
        head + "؟" + tail => head + (bHmz (dp 2 head) (take 2 tail)) + tail; --last head , take 1 tail
        _           => word
      };
    
    --hamza at beginning of word (head)
    hHmz : Str -> Str = \d ->
      case d of {
        "ِ" => "إ";
	    _	 => "أ"
      };
    
    --hamza in middle of word (body)
    bHmz : Str -> Str -> Str = \d1,d2 ->
      case <d1,d2> of {
        <"ِ",_> | <_,"ِ"> => "ئ";
	    <"ُ",_> | <_,"ُ"> => "ؤ";
	    <"َ",_> | <_,"َ"> => "أ";
	    _				   => "ء"
      };
    
    --hamza carrier sequence
    tHmz : Str -> Str = \d ->
      case d of {
        "ِ" => "ئ";
	    "ُ" => "ؤ";
	    "َ" => "أ";
	    "ْ"|"ا"|"و"|"ي" => "ء"
      };
    
}
