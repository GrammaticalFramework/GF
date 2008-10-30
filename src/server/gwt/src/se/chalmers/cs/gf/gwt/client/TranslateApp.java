package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class TranslateApp implements EntryPoint {

	private static final String pgfBaseURL = "/pgf";

	private PGF pgf;

	private CompletionOracle oracle;
	private SuggestBox suggest;
	private PGF.Grammar grammar;
	private GrammarBox grammarBox;
	private InputLanguageBox fromLangBox;
	private OutputLanguageBox toLangBox;
	private Button translateButton;
	private VerticalPanel outputPanel;
	private StatusPopup statusPopup;

	//
	// Translation
	//

	private void translate() {
		outputPanel.clear();
		setStatus("Translating...");
		pgf.translate(getGrammarName(), suggest.getText(), fromLangBox.getSelectedValues(), null, 
				toLangBox.getSelectedValues(), new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				for (PGF.Translation t : translations.iterable()) {
					Label l = new Label(t.getText());
					l.addStyleName("my-translation");
					PGF.Language lang = grammar.getLanguage(t.getTo());
					if (lang != null) {
						l.getElement().setLang(lang.getLanguageCode());
					}
					outputPanel.add(l);
				}
				clearStatus();
			}
			public void onError (Throwable e) {
				showError("Translation failed", e);
			}
		});
	}

	//
	// Status stuff
	//

	private void setStatus(String msg) {
		statusPopup.setStatus(msg);
	}

	private void showError(String msg, Throwable e) {
		statusPopup.showError(msg, e);
	}

	private void clearStatus() {
		statusPopup.clearStatus();
	}

	//
	// Grammars
	//

	private String getGrammarName() {
		return grammarBox.getSelectedGrammar();
	}

	private void updateAvailableGrammars() {
		pgf.listGrammars(new PGF.GrammarNamesCallback() {
			public void onResult(PGF.GrammarNames grammarNames) {
				grammarBox.setGrammarNames(grammarNames);
				// setGrammarNames() picks the first grammar automatically
				updateSelectedGrammar();
			}

			public void onError (Throwable e) {
				showError("Error getting grammar list", e);
			}
		});
	}

	private void updateSelectedGrammar() {
		oracle.setGrammarName(getGrammarName());
		updateAvailableLanguages();
	}

	//
	// Languages
	//

	private void updateAvailableLanguages() {
		pgf.grammar(getGrammarName(), new PGF.GrammarCallback() {
			public void onResult(PGF.Grammar grammar) {
				TranslateApp.this.grammar = grammar;

				fromLangBox.setGrammar(grammar);
				toLangBox.setGrammar(grammar);

				updateSelectedLanguages();
				clearStatus();
				translateButton.setEnabled(true);
			}

			public void onError (Throwable e) {
				showError("Error getting language information", e);
			}
		});	
	}

	private void updateSelectedLanguages() {
		oracle.setInputLangs(fromLangBox.getSelectedValues());
		translate();
	}

	//
	// GUI
	//

	private void createTranslationUI() {

		statusPopup = new StatusPopup();
		setStatus("Loading...");

		oracle = new CompletionOracle(pgf, new CompletionOracle.ErrorHandler() {
			public void onError(Throwable e) {
				showError("Completion failed", e);
			}
		});

		suggest = new SuggestBox(oracle);
		suggest.addKeyboardListener(new KeyboardListenerAdapter() {
			public void onKeyUp (Widget sender, char keyCode, int modifiers) {
				if (keyCode == KEY_ENTER) {
					translate();
				}
			}
		});

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

		translateButton = new Button("Translate");
		translateButton.setEnabled(false);
		translateButton.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				translate();
			}
		});

		HorizontalPanel settingsPanel = new HorizontalPanel();
		settingsPanel.addStyleName("my-settingsPanel");
		settingsPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		settingsPanel.add(new Label("Grammar:"));
		settingsPanel.add(grammarBox);
		settingsPanel.add(new Label("From:"));
		settingsPanel.add(fromLangBox);
		settingsPanel.add(new Label("To:"));
		settingsPanel.add(toLangBox);
		settingsPanel.add(translateButton);

		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(suggest);
		vPanel.add(settingsPanel);
		vPanel.add(outputPanel);

		RootPanel.get().add(vPanel);

	}

	//
	// Initialization
	//

	public void onModuleLoad() {
		pgf = new PGF(pgfBaseURL);
		createTranslationUI();
		updateAvailableGrammars();
	}

}
