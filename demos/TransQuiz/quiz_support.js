// Copyright © Elnaz Abolahrar and Thomas Hallgren, 2011

function hide_element(elem_id)
{
  document.getElementById(elem_id).style.display="none";
}

function show_element(elem_id)
{
  document.getElementById(elem_id).style.display="";
}

function toggle_info()
{ 
  if ( info_hidden == true )
    {
     show_element("info");
	 hide_element("toggle_show");
	 show_element("toggle_hide");
	 info_hidden = false;
     }
  else
    {
     hide_element("info");
	 show_element("toggle_show");
	 hide_element("toggle_hide");
	 info_hidden = true;
     }
}

function show_word_magnets()
{ 
  if ( words_hidden == true )
    {
     show_element("words");
     words_hidden= false;
	 var buttons_bar=element("buttons_bar");
     buttons_bar.removeChild(buttons_bar.lastChild);
	 } 
}

function hide_word_magnets()
{ 
  if ( words_hidden == false )
    {
      hide_element("words");
      words_hidden= true;
  
     //add "Show magnets" button
	 var buttons_bar=element("buttons_bar");
     appendChildren(buttons_bar,
		   [ button("Show Magnets","show_word_magnets()","M", "show_magnets")]);
	 }
}		   

function popUp(newPage, pageName) 
{
  window.open(newPage, pageName, "dependent = 1, scrollbars=1, location=1, statusbar=1, width=540, height=650, left = 10, top = 20");
}


function disable_all()
{
  //disables the "Hint", "Check Answer", "Next Question" and "Previous Question" buttons + user answer area	
    document.getElementById('check_answer').disabled = true;
    document.getElementById('next_question').disabled = true;
    document.getElementById('previous_question').disabled = true;
    document.getElementById('hint').disabled = true;
    document.getElementById('user_answer').disabled = true;
}

function set_mode()
{	
    //disable the grammar - To - From languages, and mode menubar
      document.getElementById('grammar_menu').disabled = true;	
      document.getElementById('from_menu').disabled = true;
      document.getElementById('to_menu').disabled = true;
      document.getElementById('quiz_mode').disabled = true;
    	
	
    selected_mode = element("quiz_mode").value;
		
    //sets the Quiz mode displayed
      document.getElementById('mode').value = selected_mode;
	  
/*-------------------------------------- Modes Settings --------------------------------------*/	  
    switch (selected_mode)
	 {
	  case "Easy Study Mode":
	        have_minibar = true;
			have_prevQuestion = true;
			have_checkAns = true;
			max_hint_times = 100;
			break;
	         
	  case "Medium Study Mode":
			have_minibar = false;
			have_prevQuestion = true;
			have_checkAns = true;
			max_hint_times = 3;
			break;
			
	  case "Hard Study Mode":
			have_minibar = false;
			have_prevQuestion = false;
			have_checkAns = true;
			max_hint_times = 1;
			break;
			
	  case "Exam Mode":
			have_minibar = false;
			have_prevQuestion = false;
			have_checkAns = false;
			max_hint_times = 0;
			break;
	  }
}

function reset_mode()
{		 	  
    //enable the grammar - To - From languages, and mode menubar
      document.getElementById('grammar_menu').disabled = false;	
      document.getElementById('from_menu').disabled = false;
      document.getElementById('to_menu').disabled = false;
      document.getElementById('quiz_mode').disabled = false;
			 
    //clears the Quiz mode displayed
      document.getElementById('mode').value = "";
}

function remove_minibar()
{
  if (have_minibar && is_ended == false )
	{
	    //hide the minibar word magnets
        hide_element("minibar_contin");
		   
	   //hide the delete and clear buttons
	    hide_element("minibar_buttons");
	 }
}

function remove_unwanted_characters(txt)
{
  //removes digits, special characters and extra spaces from user's answer 
    txt =  txt.replace(/[\u0021-\u0026 \u0028-\u0040 \u005b-\u0060 \u007b-\u007e]+/g,' ').replace(/^\s+|\s+$/g,'').replace(/\s+/g,' ');
  
  //changes the first character to lowercase 
    txt= txt.replace(txt.charAt(0),txt.charAt(0).toLowerCase());
 
  return txt;
}

function split_to_words(str)
{
  if (!(str == "" || str == null))
	str = str.split(" ");
  else 
	str = "";
	
  return str;
}

function string_matching(serv_answer,use_answer)
{
  var result = new Array();
  
  //for empty answers
  if ( use_answer== "" || use_answer== null)
	  result= "";	
  else
    {
	  var min_length = Math.min(serv_answer.length, use_answer.length);
	  
	  var i=0;   
	  for (i= 0; i < min_length; i++)
        {
	      if (serv_answer[i] == use_answer[i])
		     result[i] = 1;
		  else
           	 result[i] = 0;
		 }
	  //for answers with extra words (more than the number of words in the right answer)   
	    while ( i < use_answer.length)
	        {
		    	result[i] = 0;
		 	    i++;
		     } 
	 }
	 
   return result;
}

function sum_all(arr) {
  var s = 0;
  for (var i = 0; i < arr.length; i++) 
  {
    s += arr[i];
  }
  return s;
}

function find_closest(all_ans)
{ 
  var best_match = new Array();
  var comp = new Array();
  var server_answer2  = new Array();
  var max=0;
  var k = 0;
  for (k= 0; k < all_ans.length; k++)
      {
	    server_answer = remove_unwanted_characters(all_ans[k]);
		server_answer2 = split_to_words(server_answer);
		
		comp = string_matching(server_answer2, user_answer_splited);
        var sum = sum_all(comp);
		if (sum >= max)
		  {
		    best_match = server_answer2;
			max= sum;
			}	
		}
	return best_match;
}

function clearing()
{
  //clears the question, answer and the explanation and hint display areas
	document.question.question_text.value= "...";
	document.answer.answer_text.value = "";
	document.explanation.explanation_text.value= "";	
	document.getElementById("hint_txt").innerHTML = ""; 
}

//checks that the answer field is not empty
function check_notEmpty()
{
  if (document.answer.answer_text.value == null || document.answer.answer_text.value =="")
    {
	  alert(" You have to write something first!");	
	  //sets the focus on the answer area
        document.answer.answer_text.focus();
	   
	  return false; 
      }
  else
      return true;
}