package org.grammaticalframework.ui.android;

import java.util.Arrays;

import android.os.*;
import android.app.*;
import android.content.*;
import android.text.*;
import android.view.*;
import android.view.inputmethod.*;
import android.widget.*;
import android.graphics.*;
import se.fnord.android.layout.*;

public class FridgeMagnets extends Activity {
    /** Called when the activity is first created. */
	String[] words = {"hello","buy","I","you","have","please","where",
			          "how","go","Gothenburg","London","rakia","wine",
			          "whisky","man","woman","boy","girl","to"};

	private Controller controller = new Controller();
	private EditText searchBox = null;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Arrays.sort(words);

        refreshBagOfWords(null);

        View main = findViewById(R.id.main_view);
        main.setFocusableInTouchMode(true);
        main.setOnKeyListener(controller);
    }

	private void applyMagnetStyles(TextView view) {
        view.setTextColor(Color.BLACK);
        view.setBackgroundColor(Color.WHITE);
        view.setSingleLine(true);
        view.setPadding(2, 2, 2, 2);
        view.setClickable(true);
	}
	
	private void refreshBagOfWords(String prefix) {
        PredicateLayout l = (PredicateLayout) findViewById(R.id.magnets_bag);
        
        l.removeAllViews();
        
        for (int i = 0; i < words.length; i++) {
        	if (prefix != null && !words[i].startsWith(prefix))
        		continue;

        	TextView t = new TextView(this);
            t.setText(words[i]);
            t.setOnTouchListener(controller);
        	applyMagnetStyles(t);
            l.addView(t, new PredicateLayout.LayoutParams(3, 3));
        }		
	}

	private void addWord(String word) {
		PredicateLayout l = (PredicateLayout) findViewById(R.id.magnets_sentence);
		
		TextView t = new TextView(this);
		t.setText(word);
		applyMagnetStyles(t);
		l.addView(t, new PredicateLayout.LayoutParams(3, 3));
	}

    private void showSearchBox() {
    	if (searchBox != null)
    		return;
    	
		PredicateLayout l = (PredicateLayout) findViewById(R.id.magnets_sentence);

		EditText edit = new EditText(this);
		edit.setInputType(InputType.TYPE_CLASS_TEXT |
		                  InputType.TYPE_TEXT_FLAG_AUTO_COMPLETE);
		edit.addTextChangedListener(controller);
		edit.setOnKeyListener(controller);
		applyMagnetStyles(edit);

		l.addView(edit, new PredicateLayout.LayoutParams(
								ViewGroup.LayoutParams.WRAP_CONTENT,
								ViewGroup.LayoutParams.WRAP_CONTENT,
								3, 3));
		edit.requestFocus();
		InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.showSoftInput(edit, 0);
		
		searchBox = edit;
	}

	private void hideSearchBox() {
    	if (searchBox == null)
    		return;

		InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.hideSoftInputFromWindow(searchBox.getWindowToken(), 0);

		PredicateLayout l = (PredicateLayout) findViewById(R.id.magnets_sentence);		
		l.removeView(searchBox);

		refreshBagOfWords(null);

		searchBox = null;
	}

	private class Controller implements View.OnKeyListener, View.OnTouchListener, TextWatcher {
    	
    	@Override
    	public boolean onKey(View view, int keyCode, KeyEvent event) {
    		if (event.getAction() == KeyEvent.ACTION_DOWN) {    			
    			if (searchBox == null && keyCode == KeyEvent.KEYCODE_SEARCH) {
    				showSearchBox();
    				return true;
    			} else if (searchBox != null && keyCode == KeyEvent.KEYCODE_SEARCH) {
    				hideSearchBox();
    				return true;
    			}
    		}
        	return false;
        }
    		
    	@Override
    	public boolean onTouch(View view, MotionEvent event) {
			if (event.getAction() == MotionEvent.ACTION_UP) {
				hideSearchBox();
				addWord(((TextView) view).getText().toString());
	            return true;
			}
            
    		return false;
    	}

		@Override
		public void afterTextChanged(Editable arg0) {
		}

		@Override
		public void beforeTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
		}

		@Override
		public void onTextChanged(CharSequence text, int arg1, int arg2, int arg3) {
			refreshBagOfWords(text.toString());
		}
    }
}