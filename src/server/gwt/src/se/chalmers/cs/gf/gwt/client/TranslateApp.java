package se.chalmers.cs.gf.gwt.client;

import java.util.List;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class TranslateApp implements EntryPoint {

	protected static final String pgfBaseURL = "/grammars";

	protected PGFWrapper pgf;

	protected SuggestPanel suggestPanel;
	protected VerticalPanel outputPanel;
	protected StatusPopup statusPopup;

	//
	// Text
	//
	
	public String getText () {
		return suggestPanel.getText();
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
		pgf.translate(getText(), 
				new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				outputPanel.clear();
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
	
	protected Widget createUI() {
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(createSuggestPanel());
		vPanel.add(createSettingsPanel());
		vPanel.add(createTranslationsPanel());
		return vPanel;
	}

	protected Widget createSuggestPanel () {
		suggestPanel = new SuggestPanel(pgf);
		suggestPanel.setButtonText("Translate");
		suggestPanel.addSubmitListener(new SuggestPanel.SubmitListener() {
			public void onSubmit(String text) {
				translate();
			}
		});		
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
	
	protected class MyHistoryListener implements HistoryListener {
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

		pgf = new PGFWrapper(pgfBaseURL);
		RootPanel.get().add(createUI());
		pgf.addSettingsListener(new MySettingsListener());
		History.addHistoryListener(new MyHistoryListener());
		updateSettingsFromHistoryToken();
		pgf.updateAvailableGrammars();
	}

}
