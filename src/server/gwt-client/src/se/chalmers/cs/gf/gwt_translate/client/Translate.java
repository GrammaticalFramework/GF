package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.DialogBox;
import com.google.gwt.user.client.ui.Grid;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.ListBox;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;

import com.google.gwt.user.client.Window;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class Translate implements EntryPoint {

    private static final String gfBaseURL = "http://localhost/~bringert/gf-server/gf.fcgi";

    private GF gf;

    private CompletionOracle oracle;
    private SuggestBox suggest;
    private List<String> fromLangs;
    private List<String> toLangs;
    private Grid outputTable;

    private void translate() {
	gf.translate(suggest.getText(), fromLangs, null, toLangs, new GF.TranslateCallback() {
		public void onTranslateDone (GF.Translations translations) {
		    outputTable.resizeRows(translations.length());
		    for (int i = 0; i < translations.length(); i++) {
			GF.Translation t = translations.get(i);
			outputTable.setText(i, 0, t.getFrom());
			outputTable.setText(i, 1, t.getTo());
			outputTable.setText(i, 2, t.getText());
		    }
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

    public void onModuleLoad() {
    
	gf = new GF(gfBaseURL);

	oracle = new CompletionOracle(gf);

	suggest = new SuggestBox(oracle);
	suggest.setWidth("50em");
	suggest.setText("this cheese is warm");
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

	HorizontalPanel hPanel = new HorizontalPanel();
	hPanel.add(new Label("From:"));
	hPanel.add(fromLangBox);
	hPanel.add(new Label("To:"));
	hPanel.add(toLangBox);
	hPanel.add(translateButton);

	outputTable = new Grid(0, 3);

	VerticalPanel vPanel = new VerticalPanel();
	vPanel.setWidth("100%");
	vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
	vPanel.add(suggest);
	vPanel.add(hPanel);
	vPanel.add(outputTable);

	RootPanel.get().add(vPanel);

	gf.languages(new GF.LanguagesCallback() {
		public void onLanguagesDone(GF.Languages languages) {
		    for (int i = 0; i < languages.length(); i++) {
			GF.Language l = languages.get(i);
			if (l.canParse()) {
			    fromLangBox.addItem(l.getName());
			}
			toLangBox.addItem(l.getName());
		    }
		}
	    });
	
    }
}
