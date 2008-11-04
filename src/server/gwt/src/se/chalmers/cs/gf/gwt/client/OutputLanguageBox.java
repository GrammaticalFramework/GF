package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ListBox;

public class OutputLanguageBox extends ListBox {

	public OutputLanguageBox() {
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
		addItem("All languages", "");
		for (PGF.Language l : grammar.getLanguages().iterable()) {
			addItem(l.getName());
		}
		setEnabled(true);
	}

}