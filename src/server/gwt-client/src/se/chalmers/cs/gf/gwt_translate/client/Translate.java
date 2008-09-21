package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.DockPanel;
import com.google.gwt.user.client.ui.DialogBox;
import com.google.gwt.user.client.ui.Grid;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.ListBox;
import com.google.gwt.user.client.ui.PopupPanel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;

import com.google.gwt.core.client.GWT;

import com.google.gwt.user.client.Window;

import com.google.gwt.i18n.client.LocaleInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class Translate implements EntryPoint {

    private static final String gfBaseURL = "/~bringert/gf-server/gf.fcgi";

    private GF gf;

    private CompletionOracle oracle;
    private SuggestBox suggest;
    private GF.Grammar grammar;
    private ListBox fromLangBox;
    private ListBox toLangBox;
    private Button translateButton;
    private VerticalPanel outputPanel;
    private PopupPanel statusPopup;
    private Label statusLabel;

    private void addTranslation(String text, String toLang) {
	Label l = new Label(text);
	l.addStyleName("my-translation");
	GF.Language lang = grammar.getLanguage(toLang);
	if (lang != null) {
	    l.getElement().setLang(lang.getLanguageCode());
	}
	outputPanel.add(l);
    }

    private void translate() {
	outputPanel.clear();
	setStatus("Translating...");
	gf.translate(suggest.getText(), listBoxSelection(fromLangBox), null, 
		     listBoxSelection(toLangBox), new GF.TranslateCallback() {
		public void onResult (GF.Translations translations) {
		    for (GF.Translation t : GF.iterable(translations)) {
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
	oracle.setInputLangs(listBoxSelection(fromLangBox));
    }

    private List<String> listBoxSelection(ListBox box) {
	int c = box.getItemCount();
	List<String> l = new ArrayList<String>();
	for (int i = 0; i < c; i++) {
	    if (box.isItemSelected(i)) {
		l.add(box.getValue(i));
	    }
	}
	return l;
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

    private void setGrammar(GF.Grammar grammar) {
	this.grammar = grammar;

	for (GF.Language l :GF.iterable(grammar.getLanguages())) {
	    String name = l.getName();
	    if (l.canParse()) {
		fromLangBox.addItem(name);
		if (name.equals(grammar.getUserLanguage())) {
		    fromLangBox.setSelectedIndex(fromLangBox.getItemCount()-1);
		}
	    }
	    toLangBox.addItem(name);
	}

	updateLangs();
	clearStatus();
	fromLangBox.setEnabled(true);
	toLangBox.setEnabled(true);
	translateButton.setEnabled(true);
    }

    private void createTranslationUI() {

	oracle = new CompletionOracle(gf, new CompletionOracle.ErrorHandler() {
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

	fromLangBox = new ListBox();
	fromLangBox.setEnabled(false);
	fromLangBox.addItem("Any language", "");
	fromLangBox.addChangeListener(new ChangeListener() {
		public void onChange(Widget sender) {
		    updateLangs();
		    translate();
		}
	    });

	toLangBox = new ListBox();
	toLangBox.setEnabled(false);
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

	gf = new GF(gfBaseURL);

	createTranslationUI();

	gf.grammar(new GF.GrammarCallback() {
		public void onResult(GF.Grammar grammar) {
		    setGrammar(grammar);
		}

		public void onError (Throwable e) {
		    showError("Error getting language information", e);
		}
	    });	
    }

}
