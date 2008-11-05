package se.chalmers.cs.gf.gwt.client;

import java.util.List;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.ui.HasText;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class TranslateApp implements EntryPoint {

	private static final String pgfBaseURL = "/pgf";

	protected PGFWrapper pgf;

	protected Widget translationUI;

	protected HasText textSource;
	protected VerticalPanel outputPanel;
	protected StatusPopup statusPopup;

	//
	// Text
	//
	
	public String getText () {
		return textSource.getText();
	}
	
	public void setText(String text) {
		textSource.setText(text);
		update();
	}
	
	protected void update () {
		translate();
	}
	
	//
	// Translation
	//
	
	protected void translate() {
		outputPanel.clear();
		outputPanel.addStyleDependentName("working");
		pgf.translate(textSource.getText(), 
				new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				outputPanel.removeStyleDependentName("working");
				for (PGF.Translation t : translations.iterable()) {
					outputPanel.add(createTranslation(t.getTo(), t.getText()));
				}
			}
			public void onError (Throwable e) {
				showError("Translation failed", e);
			}
		});
	}

	protected Widget createTranslation(String language, String text) {
		Label l = new Label(text);
		l.addStyleName("my-translation");
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			l.getElement().setLang(lang);
		}
		return l;
	}

	//
	// Status stuff
	//

	protected void setStatus(String msg) {
		statusPopup.setStatus(msg);
	}

	protected void showError(String msg, Throwable e) {
		statusPopup.showError(msg, e);
	}

	protected void clearStatus() {
		statusPopup.clearStatus();
	}

	//
	// GUI
	//

	protected Widget createTranslationUI() {
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(createSuggestPanel());
		vPanel.add(createSettingsPanel());
		vPanel.add(createTranslationsPanel());
		return vPanel;
	}

	protected Widget createSuggestPanel () {
		SuggestPanel suggestPanel = new SuggestPanel(pgf);
		suggestPanel.setButtonText("Translate");
		suggestPanel.addSubmitListener(new SuggestPanel.SubmitListener() {
			public void onSubmit(String text) {
				translate();
			}
		});
		
		textSource = suggestPanel;
		
		return suggestPanel;
	}

	protected Widget createSettingsPanel () {
		return new SettingsPanel(pgf);
	}

	protected Widget createTranslationsPanel () {
		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");
		return outputPanel;
	}

	protected Widget createLoadingWidget () {
		VerticalPanel loadingPanel = new VerticalPanel();
		loadingPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		loadingPanel.add(new Label("Loading..."));
		return loadingPanel;
	}
	
	//
	// History stuff
	//
	
	private HistoryListener historyListener = new HistoryListener() {
		public void onHistoryChanged(String historyToken) {
			updateSettingsFromHistoryToken();
		}
	};

	protected void updateSettingsFromHistoryToken() {
		updateSettingsFromHistoryToken(History.getToken().split("/"));
	}
	
	protected void updateSettingsFromHistoryToken(String[] tokenParts) {
		if (tokenParts.length >= 1 && tokenParts[0].length() > 0) {
			setPGFName(tokenParts[0]);
		}
		if (tokenParts.length >= 2 && tokenParts[1].length() > 0) {
			setInputLanguage(tokenParts[1]);
		}
	}

	protected void setPGFName (String pgfName) {
		if (pgfName != null && !pgfName.equals(pgf.getPGFName())) {
			pgf.setPGFName(pgfName);
		}
	}

	protected void setInputLanguage (String inputLanguage) {
		if (inputLanguage != null && !inputLanguage.equals(pgf.getInputLanguage())) {
			pgf.setInputLanguage(inputLanguage);	
		}
	}

	//
	// Initialization
	//

	protected class MySettingsListener implements PGFWrapper.SettingsListener {
		// Will only happen on load
		public void onAvailableGrammarsChanged() {
			if (pgf.getPGFName() == null) {
				List<String> grammars = pgf.getGrammars();
				if (!grammars.isEmpty()) {
					pgf.setPGFName(grammars.get(0));
				}
			}			
			RootPanel.get().clear();
			RootPanel.get().add(translationUI);
		}
		public void onAvailableLanguagesChanged() {
			if (pgf.getInputLanguage() == null) {
				GWT.log("Setting input language to user language: " + pgf.getUserLanguage(), null);
				pgf.setInputLanguage(pgf.getUserLanguage());
			}
			update();
		}
		public void onInputLanguageChanged() {
			update();
		}
		public void onOutputLanguageChanged() {
			update();
		}
		public void onCatChanged() {
			update();
		}
		public void onSettingsError(String msg, Throwable e) {
			showError(msg,e);
		}
	}

	public void onModuleLoad() {
		statusPopup = new StatusPopup();

		RootPanel.get().add(createLoadingWidget());

		pgf = new PGFWrapper(new PGF(pgfBaseURL), new MySettingsListener());

		translationUI = createTranslationUI();

		History.addHistoryListener(historyListener);

		updateSettingsFromHistoryToken();
	}

}
