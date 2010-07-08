package org.grammaticalframework.ui.gwt.client;

import java.util.Collection;

import com.google.gwt.user.client.ui.ListBox;

public class MyListBox extends ListBox {

	public MyListBox () { }
	
	public void clearSelection () {
		setSelectedIndex(-1);
	}
	
	public String getSelectedValue() {
		int i = getSelectedIndex();
		return i == -1 ? null : getValue(i);
	}
	
	public void setSelectedValue(String value) {
		if (value == null) {
			clearSelection();
		} else {
			int c = getItemCount();
			for (int i = 0; i < c; i++) {
				if (getValue(i).equals(value)) {
					setSelectedIndex(i);
					return;
				}
			}
		}
	}
	
	public void addItems(Collection<String> items) {
		for (String item : items) {
			addItem(item);
		}
	}
	
}
