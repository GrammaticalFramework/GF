package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ListBox;

public class GrammarBox extends ListBox {
    
	public GrammarBox() {
		setEnabled(false);
	}
	
	public void setGrammarNames(PGF.GrammarNames grammarNames) {
		for (PGF.GrammarName grammarName : grammarNames.iterable()) {
			addItem(grammarName.getName());
		}
		if (!grammarNames.isEmpty()) {
			setSelectedIndex(0);
			setEnabled(true);
		}
	}

	public String getSelectedGrammar() {
		int i = getSelectedIndex();
		return i == -1 ? null : getValue(i);
	}

}
