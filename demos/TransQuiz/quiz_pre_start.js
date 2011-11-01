// Copyright © Elnaz Abolahrar, 2011

// pre_start: runs on load time before evrything else to prepare the quiz

function pre_start()
{
  hide_element('history_part');
  hide_element('toggle_show'); 

  default_values();

  var quiz_mode=empty_id("select","quiz_mode");

  //adds the  "Quiz Mode" and "Restart Quiz" and "End Quiz" and "Start Quiz"  
  appendChildren(minibar.quizbar,
		    [text(" Quiz Mode: "), quiz_mode, 
			button("Restart Quiz","restart_quiz()","R"),
			button("End Quiz","end_quiz(true)","E"),
			button("Start Quiz","start_quiz()","S")]);
			
				
  //adds the  "Next Question" and "Previous Question" and "Hint" and "Check Answer" buttons
  var buttons_bar=element("buttons_bar");
  appendChildren(buttons_bar,
		   [button("< Previous Question","previous_question_quiz()","B", "previous_question"),
			button("Next Question >","generate_question()","N", "next_question"),
			button("Hint","show_hint()","H", "hint"),
			submit_button("Check Answer", "check_answer")]);
	
    disable_all();	
	
	//hide the minibar word magnets
      hide_element('minibar_contin');
		   
	//hide the delete and clear buttons
	  hide_element('minibar_buttons');

	mode_options(quiz_mode);
}


function mode_options(quiz_mode)
     {
	  var opt=empty("option");
	  opt.setAttribute("value","Easy Study Mode");
	  opt.innerHTML="Easy Study Mode";
	  quiz_mode.appendChild(opt);
	  
	  var opt=empty("option");
	  opt.setAttribute("value","Medium Study Mode");
	  opt.innerHTML="Medium Study Mode";
	  quiz_mode.appendChild(opt);
	  
	  var opt=empty("option");
	  opt.setAttribute("value","Hard Study Mode");
	  opt.innerHTML="Hard Study Mode";
	  quiz_mode.appendChild(opt);
	  
	  var opt=empty("option");
	  opt.setAttribute("value","Exam Mode");
	  opt.innerHTML="Exam Mode";
	  quiz_mode.appendChild(opt);  
     }
	 
