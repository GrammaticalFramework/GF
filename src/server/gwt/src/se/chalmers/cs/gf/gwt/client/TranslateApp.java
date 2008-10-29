package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.PopupPanel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;

import com.google.gwt.core.client.GWT;


public class TranslateApp implements EntryPoint {

    private static final String pgfBaseURL = "/pgf";
    private static final String pgfName = "grammar.pgf";

    private PGF pgf;

    private CompletionOracle oracle;
    private SuggestBox suggest;
    private PGF.Grammar grammar;
    private InputLanguageBox fromLangBox;
    private OutputLanguageBox toLangBox;
    private Button translateButton;
    private VerticalPanel outputPanel;
    private PopupPanel statusPopup;
    private Label statusLabel;

    private void addTranslation(String text, String toLang) {
	Label l = new Label(text);
	l.addStyleName("my-translation");
	PGF.Language lang = grammar.getLanguage(toLang);
	if (lang != null) {
	    l.getElement().setLang(lang.getLanguageCode());
	}
	outputPanel.add(l);
    }

    private void translate() {
	outputPanel.clear();
	setStatus("Translating...");
	pgf.translate(suggest.getText(), fromLangBox.getSelectedValues(), null, 
		     toLangBox.getSelectedValues(), new PGF.TranslateCallback() {
		public void onResult (PGF.Translations translations) {
		    for (PGF.Translation t : translations.iterable()) {
			addTranslation(t.getText(), t.getTo());
		    }
		    clearStatus();
		}
		public void onError (Throwable e) {
		    showError("Translation failed", e);
		}
	    });
    }

    private void updateLangs() {
	oracle.setInputLangs(fromLangBox.getSelectedValues());
    }

    private void setStatus(String msg) {
	statusLabel.setText(msg);
	statusPopup.center();
    }

    private void showError(String msg, Throwable e) {
	GWT.log(msg, e);
	setStatus(msg);
    }

    private void clearStatus() {
	statusPopup.hide();
    }

    private void setGrammar(PGF.Grammar grammar) {
	this.grammar = grammar;

	fromLangBox.setGrammar(grammar);
	toLangBox.setGrammar(grammar);

	updateLangs();
	clearStatus();
	translateButton.setEnabled(true);
    }

    private void createTranslationUI() {

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

	fromLangBox = new InputLanguageBox();
	fromLangBox.addItem("Any language", "");
	fromLangBox.addChangeListener(new ChangeListener() {
		public void onChange(Widget sender) {
		    updateLangs();
		    translate();
		}
	    });

	toLangBox = new OutputLanguageBox();
	toLangBox.addItem("All languages", "");
	toLangBox.addChangeListener(new ChangeListener() {
		public void onChange(Widget sender) {
		    updateLangs();
		    translate();
		}
	    });

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

    public void onModuleLoad() {    
	statusLabel = new Label("Loading...");
	statusPopup = new PopupPanel(true, true);
	statusPopup.add(statusLabel);
	statusPopup.center();

	pgf = new PGF(pgfBaseURL, pgfName);

	createTranslationUI();

	pgf.grammar(new PGF.GrammarCallback() {
		public void onResult(PGF.Grammar grammar) {
		    setGrammar(grammar);
		}

		public void onError (Throwable e) {
		    showError("Error getting language information", e);
		}
	    });	
    }

}
