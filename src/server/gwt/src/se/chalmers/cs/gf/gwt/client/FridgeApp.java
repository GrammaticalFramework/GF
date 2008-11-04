package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Hyperlink;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp implements EntryPoint {

	private static final String pgfBaseURL = "/pgf";

	private PGF pgf;

	private FlowPanel textPanel;	
	private FlowPanel bagPanel;
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
				getText(), 
				settingsPanel.getInputLanguage(), null, 
				settingsPanel.getOutputLanguage(), 
				new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				for (final PGF.Translation t : translations.iterable()) {
					Hyperlink l = new Hyperlink(t.getText(), t.getTo() + "/" + t.getText());
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
	// Available words
	//

	private void updateBag () {
		updateBag("");
	}

	private void updateBag (String prefix) {
		bagPanel.clear();
		int limit = 100;
		pgf.complete(settingsPanel.getGrammarName(), 
				getText() + " " + prefix, 
				settingsPanel.getInputLanguage(), null, 
				limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				for (PGF.Completion completion : completions.iterable()) {
					String text = completion.getText();
					if (!completion.getText().equals(getText() + " ")) {
						String[] words = text.split("\\s+");
						String word = (words.length > 0) ? words[words.length - 1] : "";
						String token = /* settingsPanel.getGrammarName() + "/" + */ completion.getFrom() + "/" + text;
						Hyperlink magnet = new Hyperlink(word, token);
						magnet.addStyleName("my-Magnet");
						bagPanel.add(magnet);
					}
				}
				if (bagPanel.getWidgetCount() == 0) {
					bagPanel.add(new Label("<empty>"));
				}
			}
			public void onError(Throwable e) {
				showError("Error getting completions.", e);
			}
		});
	}

	//
	// Current text
	//

	private String getText () {
		StringBuilder sb = new StringBuilder();
		for (Widget w : textPanel) {
			String word = ((UsedMagnet)w).getText();	
			if (sb.length() > 0) {
				sb.append(' ');
			}
			sb.append(word);			
		}
		return sb.toString();
	}

	private void clear() {
		String token = settingsPanel.getInputLanguage() + "/" + "";
		if (History.getToken().equals(token)) {
			History.fireCurrentHistoryState();
		} else {
			History.newItem(token);
		}
	}

	private HistoryListener historyListener = new HistoryListener() {
		public void onHistoryChanged(String historyToken) {
			GWT.log("History changed:" + historyToken, null);
			String[] parts = historyToken.split("/");
			GWT.log(parts.length + " parts", null);
			if (parts.length == 0) {
				setState("", "");				
			} else if (parts.length == 1) {
				setState(parts[0], "");
			} else if (parts.length == 2) {
				setState(parts[0], parts[1]);
			}
		}
	};
	
	/*
	
	private static class State {
		public String grammarName = "";
		public String inputLanguage = "";
		public String text = "";
				
		public State (String token) {
			String[] parts = token.split("/");
			if (parts.length >= 1) {
				this.grammarName = parts[0];
				if (parts.length >= 2) {
					this.inputLanguage = parts[1];	
					if (parts.length >= 3) {
						this.text = parts[2];
					}
				}
			} 
		}
	}
	
	private void setState(State state) {
		settingsPanel.setInputLanguage(state.inputLanguage);
		textPanel.clear();
		for (String word : state.text.split("\\s+")) {
			textPanel.add(new UsedMagnet(state.inputLanguage, word));
		}
		updateBag();
		translate();
	}
	
	*/

	private void setState(String inputLang, String text) {
		GWT.log("New text: \"" + text + "\"", null);
		settingsPanel.setInputLanguage(inputLang);
		textPanel.clear();
		for (String word : text.split("\\s+")) {
			textPanel.add(new UsedMagnet(inputLang, word));
		}
		updateBag();
		translate();
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
	// GUI
	//

	private void createTranslationUI() {

		statusPopup = new StatusPopup();
		setStatus("Loading...");

		settingsPanel = new SettingsPanel(pgf);
		settingsPanel.addSettingsListener(new SettingsPanel.SettingsListener() {
			public void grammarChanged(String pgfName) {
			}
			public void languagesChanged(String inputLang, String outputLang) {
				clear();
			}
			public void settingsError(String msg, Throwable e) {
				showError(msg,e);
			}
		});

		Panel buttons = new HorizontalPanel();
		buttons.add(new Button("Clear", new ClickListener () {
			public void onClick(Widget sender) {
				clear();
			}
		}));

		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");

		textPanel = new FlowPanel();
		textPanel.setStylePrimaryName("my-TextPanel");

		bagPanel = new FlowPanel();
		bagPanel.setStylePrimaryName("my-BagPanel");

		VerticalPanel mainPanel = new VerticalPanel();
		mainPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		mainPanel.setWidth("100%");
		mainPanel.add(textPanel);
		mainPanel.add(buttons);
		mainPanel.add(bagPanel);
		mainPanel.add(outputPanel);
		mainPanel.add(settingsPanel);

		RootPanel.get().add(mainPanel);

	}

	//
	// Initialization
	//

	public void onModuleLoad() {
		pgf = new PGF(pgfBaseURL);
		createTranslationUI();
		History.addHistoryListener(historyListener);
		settingsPanel.updateAvailableGrammars();
	}

}
