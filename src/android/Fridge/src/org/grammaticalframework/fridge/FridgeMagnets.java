package org.grammaticalframework.fridge;

import java.util.Arrays;

import android.os.*;
import android.app.*;
import android.content.Context;
import android.view.*;
import android.widget.*;
import android.graphics.*;
import se.fnord.android.layout.*;

public class FridgeMagnets extends Activity {
    /** Called when the activity is first created. */
	String[] words = {"hello","buy","I","you","have","please","where",
			          "how","go","Gothenburg","London","rakia","wine",
			          "whisky","man","woman","boy","girl"};
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Arrays.sort(words);
        
        PredicateLayout l = (PredicateLayout) findViewById(R.id.magnets_bag);
        for (int i = 0; i < words.length; i++) {
        	Magnet t = new Magnet(this);
            t.setText(words[i]);
            l.addView(t, new PredicateLayout.LayoutParams(3, 3));
        }
    }
    
    private static class Magnet extends TextView {
    	public Magnet(Context context) {
			super(context);
            setTextColor(Color.BLACK);
            setBackgroundColor(Color.WHITE);
            setSingleLine(true);
            setPadding(2, 2, 2, 2);
            setClickable(true);
		}

		@Override
    	public boolean onTouchEvent(MotionEvent event) {
			if (event.getAction() == MotionEvent.ACTION_UP) {
				Activity activity = (Activity) getContext();
				PredicateLayout l = (PredicateLayout) activity.findViewById(R.id.magnets_sentence);
				
				Magnet t = new Magnet(activity);
	            t.setText(getText());
	            l.addView(t, new PredicateLayout.LayoutParams(3, 3));				
			}
            
    		return super.onTouchEvent(event);
    	}
    }
}