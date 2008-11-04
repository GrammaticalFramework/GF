package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;


public class TranslateApp implements EntryPoint {

	private static final String pgfBaseURL = "/pgf";

	private PGF pgf;

	private SuggestPanel suggestPanel;
	private SettingsPanel settingsPanel;
	private VerticalPanel outputPanel;
	private StatusPopup statusPopup;

	//
	// Translation
	//

	private void translate() {
		outputPanel.clear();
		setStatus("Translating...");
		pgf.translate(settingsPanel.getGrammarName(), 
					  suggestPanel.getText(), 
					  settingsPanel.getInputLanguage(), null, 
				      settingsPanel.getOutputLanguage(), 
				      new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				for (PGF.Translation t : translations.iterable()) {
					Label l = new Label(t.getText());
					l.addStyleName("my-translation");
					PGF.Language lang = settingsPanel.getGrammar().getLanguage(t.getTo());
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
	// Grammars and languages
	//

	private void updateSelectedGrammar() {
		suggestPanel.setGrammarName(settingsPanel.getGrammarName());
	}

	private void updateSelectedLanguages() {
		suggestPanel.setInputLanguage(settingsPanel.getInputLanguage());
		suggestPanel.setEnabled(true);
		clearStatus();
		translate();
	}

	//
	// GUI
	//

	private void createTranslationUI() {

		statusPopup = new StatusPopup();
		setStatus("Loading...");

		suggestPanel = new SuggestPanel(pgf);
		suggestPanel.setButtonText("Translate");
		suggestPanel.addSubmitListener(new SuggestPanel.SubmitListener() {
			public void onSubmit(String text) {
				translate();
			}
		});

		settingsPanel = new SettingsPanel(pgf);
		settingsPanel.addSettingsListener(new SettingsPanel.SettingsListener() {
			public void grammarChanged(String pgfName) {
				updateSelectedGrammar();
			}
			public void languagesChanged(String inputLang, String outputLang) {
				updateSelectedLanguages();
			}
			public void settingsError(String msg, Throwable e) {
				showError(msg,e);
			}
		});

		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(suggestPanel);
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
		settingsPanel.updateAvailableGrammars();
	}

}
