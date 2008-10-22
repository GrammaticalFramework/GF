package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ListBox;

import java.util.ArrayList;
import java.util.List;

public class MultiListBox extends ListBox {

    public MultiListBox() {
    }

    public List<String> getSelectedValues() {
	int c = getItemCount();
	List<String> l = new ArrayList<String>();
	for (int i = 0; i < c; i++) {
	    if (isItemSelected(i)) {
		l.add(getValue(i));
	    }
	}
	return l;
    }

}