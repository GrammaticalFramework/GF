package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.google.gwt.user.client.ui.ListBox;

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
	
	public void setSelectedValues(List<String> values) {
		Set<String> vs = new HashSet<String>(values);
		int c = getItemCount();
		for (int i = 0; i < c; i++) {
			setItemSelected(i, vs.contains(getValue(i)));
		}
	}

}