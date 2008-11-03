package se.chalmers.cs.gf.gwt.client;

import java.util.LinkedList;
import java.util.List;

import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Widget;

public class SettingsPanel extends Composite {

	private PGF pgf;
	private PGF.Grammar grammar;

	private GrammarBox grammarBox;
	private InputLanguageBox fromLangBox;
	private OutputLanguageBox toLangBox;

	private List<SettingsListener> listeners = new LinkedList<SettingsListener>();

	public SettingsPanel (PGF pgf) {
		this.pgf = pgf;

		grammarBox = new GrammarBox();
		grammarBox.addChangeListener(new ChangeListener() {
			public void onChange(Widget sender) {
				updateSelectedGrammar();
			}
		});

		ChangeListener languageChangeListener = new ChangeListener() {
			public void onChange(Widget sender) {
				updateSelectedLanguages();
			}
		};

		fromLangBox = new InputLanguageBox();
		fromLangBox.addChangeListener(languageChangeListener);

		toLangBox = new OutputLanguageBox();
		toLangBox.addChangeListener(languageChangeListener);

		HorizontalPanel settingsPanel = new HorizontalPanel();
		settingsPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		settingsPanel.add(new Label("Grammar:"));
		settingsPanel.add(grammarBox);
		settingsPanel.add(new Label("From:"));
		settingsPanel.add(fromLangBox);
		settingsPanel.add(new Label("To:"));
		settingsPanel.add(toLangBox);

		initWidget(settingsPanel);
		setStylePrimaryName("my-SettingsPanel");
	}

	public interface SettingsListener {
		public void grammarChanged(String pgfName);
		public void languagesChanged(List<String> inputLangs, List<String> outputLangs);
		public void settingsError(String msg, Throwable e);
	}

	public void addSettingsListener(SettingsListener listener) {
		listeners.add(listener);
	}

	void fireGrammarChanged() {
		for (SettingsListener listener : listeners) {
			listener.grammarChanged(getGrammarName());
		}
	}

	void fireLanguagesChanged() {
		for (SettingsListener listener : listeners) {
			listener.languagesChanged(getInputLanguages(), getOutputLanguages());
		}
	}

	void fireSettingsError(String msg, Throwable e) {
		for (SettingsListener listener : listeners) {
			listener.settingsError(msg, e);
		}
	}

	//
	// Grammars
	//

	public void updateAvailableGrammars() {
		pgf.listGrammars(new PGF.GrammarNamesCallback() {
			public void onResult(PGF.GrammarNames grammarNames) {
				grammarBox.setGrammarNames(grammarNames);
				// setGrammarNames() picks the first grammar automatically
				updateSelectedGrammar();
			}

			public void onError (Throwable e) {
				fireSettingsError("Error getting grammar list", e);
			}
		});
	}

	private void updateSelectedGrammar() {
		fireGrammarChanged();
		updateAvailableLanguages();
	}

	public PGF.Grammar getGrammar() {
		return grammar;
	}

	public String getGrammarName() {
		return grammarBox.getSelectedGrammar();
	}


	//
	// Languages
	//

	public List<String> getInputLanguages() {
		return fromLangBox.getSelectedValues();
	}

	public List<String> getOutputLanguages() {
		return toLangBox.getSelectedValues();
	}

	private void updateAvailableLanguages() {
		pgf.grammar(getGrammarName(), new PGF.GrammarCallback() {
			public void onResult(PGF.Grammar grammar) {
				SettingsPanel.this.grammar = grammar;
				fromLangBox.setGrammar(grammar);
				toLangBox.setGrammar(grammar);
				updateSelectedLanguages();
			}

			public void onError (Throwable e) {
				fireSettingsError("Error getting language information", e);
			}
		});	
	}

	private void updateSelectedLanguages() {
		fireLanguagesChanged();
	}

}
