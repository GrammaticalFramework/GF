package se.chalmers.cs.gf.gwt.client;

public class InputLanguageBox extends MultiListBox {

	public InputLanguageBox() {
		setEnabled(false);
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