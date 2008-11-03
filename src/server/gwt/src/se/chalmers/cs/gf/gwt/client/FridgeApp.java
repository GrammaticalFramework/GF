package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.PushButton;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp implements EntryPoint {

	private static final String pgfBaseURL = "/pgf";

	private PGF pgf;

	private FlowPanel textPanel;	
	private Panel bagPanel;
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
					  settingsPanel.getInputLanguages(), null, 
				      settingsPanel.getOutputLanguages(), 
				      new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				for (final PGF.Translation t : translations.iterable()) {
					PushButton l = new PushButton(t.getText());					
					l.addStyleName("my-translation");
					l.addClickListener(new ClickListener() {
						public void onClick(Widget sender) {
							setText(t.getTo(), t.getText());
						}
					});
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
	// Magnets
	//
	
	private List<String> getWords() {
		List<String> l = new ArrayList<String>();
		for (Widget w : textPanel) {
			l.add(((Magnet)w).getText());			
		}
		return l;
	}
	
	private String getText () {
		StringBuilder sb = new StringBuilder();
		for (String word : getWords()) {
			if (sb.length() > 0) {
				sb.append(' ');
			}
			sb.append(word);			
		}
		return sb.toString();
	}
	
	private void setText (String language, String text) {
		settingsPanel.setInputLanguages(Collections.singletonList(language));
		textPanel.clear();
		for (String word : text.split("\\s+")) {
			textPanel.add(new Magnet(language, word));
		}
		updateBag();
	}

	private ClickListener magnetClickListener = new ClickListener () {
		public void onClick(Widget sender) {
			Magnet magnet = (Magnet)sender;
			textPanel.add(new Magnet(magnet));
			update();
		}
	};
	
	private void updateBag () {
		bagPanel.clear();
		int limit = 100;
		pgf.complete(settingsPanel.getGrammarName(), 
				     getText() + " ", 
				     settingsPanel.getInputLanguages(), null, 
			         limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				boolean empty = true;
				List<String> oldWords = getWords();				
				for (PGF.Completion completion : completions.iterable()) {
					String[] newWords = completion.getText().split("\\s+");
					if (newWords.length == oldWords.size()+1) {
						String word = newWords[newWords.length-1];
						bagPanel.add(new Magnet(completion.getFrom(), word, magnetClickListener));
						empty = false;
					}
				}
				if (empty) {
					bagPanel.add(new Label("<empty>"));
				}
			}
			public void onError(Throwable e) {
				showError("Error getting completions.", e);
			}
		});
	}
	
	public void update() {
		updateBag();
		translate();
	}

	public void clear() {
		textPanel.clear();
		update();
	}
	
	public void deleteLastMagnet() {
		int c = textPanel.getWidgetCount();
		if (c > 0) {
			textPanel.remove(c-1);
			update();
		}
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
			public void languagesChanged(List<String> inputLangs, List<String> outputLangs) {
				update();
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
		buttons.add(new Button("Delete last", new ClickListener () {
			public void onClick(Widget sender) {
				deleteLastMagnet();
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
		settingsPanel.updateAvailableGrammars();
	}

}
