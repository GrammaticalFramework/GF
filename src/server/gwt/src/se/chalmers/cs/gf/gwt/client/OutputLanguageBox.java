package se.chalmers.cs.gf.gwt.client;

public class OutputLanguageBox extends MultiListBox {

	public OutputLanguageBox() {
		setEnabled(false);
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