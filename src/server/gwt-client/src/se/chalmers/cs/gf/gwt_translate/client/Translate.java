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
    private GF.Languages availableLangs;
    private List<String> fromLangs;
    private List<String> toLangs;
    private VerticalPanel outputPanel;
    private Label statusLabel;

    private void addTranslation(String text, String toLang) {
	Label l = new Label(text);
	l.addStyleName("my-translation");
	GF.Language lang = availableLangs.getLanguage(toLang);
	if (lang != null) {
	    l.getElement().setLang(lang.getLanguageCode());
	}
	outputPanel.add(l);
    }

    private void translate() {
	gf.translate(suggest.getText(), fromLangs, null, toLangs, new GF.TranslateCallback() {
		public void onResult (GF.Translations translations) {
		    outputPanel.clear();
		    for (int i = 0; i < translations.length(); i++) {
			GF.Translation t = translations.get(i);
			addTranslation(t.getText(), t.getTo());
		    }
		}
		public void onError (Throwable e) {
		    showError("Translation failed", e);
		}
	    });
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
    }

    private void showError(String msg, Throwable e) {
	GWT.log(msg, e);
	setStatus(msg);
    }

    public void onModuleLoad() {
    
	statusLabel = new Label("Loading...");

	gf = new GF(gfBaseURL);

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

	final ListBox fromLangBox = new ListBox();
	fromLangBox.addItem("Any language", "");
	fromLangBox.addChangeListener(new ChangeListener() {
		public void onChange(Widget sender) {
		    fromLangs = listBoxSelection(fromLangBox);
		    oracle.setInputLangs(fromLangs);
		    translate();
		}
	    });

	final ListBox toLangBox = new ListBox();
	toLangBox.addItem("All languages", "");
	toLangBox.addChangeListener(new ChangeListener() {
		public void onChange(Widget sender) {
		    toLangs = listBoxSelection(toLangBox);
		    translate();
		}
	    });

	Button translateButton = new Button("Translate");
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

	// CSS debug
	//	addTranslation("hello");
	//	addTranslation("world");

	VerticalPanel vPanel = new VerticalPanel();
	vPanel.setWidth("100%");
	vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
	vPanel.add(suggest);
	vPanel.add(settingsPanel);
	vPanel.add(outputPanel);

	RootPanel.get().add(vPanel);
	RootPanel.get().add(statusLabel, (Window.getClientWidth() - statusLabel.getOffsetWidth())/2, (Window.getClientHeight() - statusLabel.getOffsetHeight()));

	gf.languages(new GF.LanguagesCallback() {
		public void onResult(GF.Languages languages) {
		    availableLangs = languages;
		    for (int i = 0; i < languages.length(); i++) {
			GF.Language l = languages.get(i);
			if (l.canParse()) {
			    fromLangBox.addItem(l.getName());
			}
			toLangBox.addItem(l.getName());
		    }
		    gf.mylanguage(new GF.MyLanguageCallback() {

			}

		    setStatus("Loaded languages.");		    
		}

		public void onError (Throwable e) {
		    showError("Error getting language information", e);
		}
	    });

	GWT.log("Current locale: " + LocaleInfo.getCurrentLocale().getLocaleName(), null);
	
    }
}
