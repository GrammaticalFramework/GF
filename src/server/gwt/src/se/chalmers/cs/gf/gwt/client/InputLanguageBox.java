package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ListBox;

public class InputLanguageBox extends ListBox {

	public InputLanguageBox() {
		setEnabled(false);
	}

	public String getLanguage() {
		return getValue(getSelectedIndex());
	}
	
	public void setLanguage(String lang) {
		int c = getItemCount();
		for (int i = 0; i < c; i++) {
			if (getValue(i).equals(lang)) {
				setSelectedIndex(i);
			}
		}
	}
	
	public void setGrammar(PGF.Grammar grammar) {
		clear();
		addItem("Any language", "");
		for (PGF.Language l : grammar.getLanguages().iterable()) {
			String name = l.getName();
			if (l.canParse()) {
				addItem(name);
				if (name.equals(grammar.getUserLanguage())) {
					setSelectedIndex(getItemCount()-1);
				}
			}
		}
		setEnabled(true);
	}

}