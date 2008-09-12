package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.DialogBox;
import com.google.gwt.user.client.ui.Grid;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;

import com.google.gwt.user.client.Window;

public class Translate implements EntryPoint {

    private SuggestBox suggest;
    private Grid outputTable;

    private void translate() {
	outputTable.resizeRows(3);
	outputTable.setText(0, 1, suggest.getText());
	outputTable.setText(1, 1, suggest.getText());
	outputTable.setText(2, 1, suggest.getText());
    }

    public void onModuleLoad() {
    
	suggest = new SuggestBox(new CompletionOracle("http://localhost/~bringert/gf-server/gf.fcgi"));
	suggest.setWidth("50em");
	suggest.addKeyboardListener(new KeyboardListenerAdapter() {
		public void onKeyUp (Widget sender, char keyCode, int modifiers) {
		    if (keyCode == KEY_ENTER) {
			translate();
		    }
		}
	    });

	Button translateButton = new Button("Translate");
        translateButton.addClickListener(new ClickListener() {
		public void onClick(Widget sender) {
		    translate();
		}
	    });

	outputTable = new Grid(0, 2);

	VerticalPanel vPanel = new VerticalPanel();
	vPanel.setWidth("100%");
	vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
	vPanel.add(suggest);
	vPanel.add(translateButton);
	vPanel.add(outputTable);

	RootPanel.get().add(vPanel);

    }
}
