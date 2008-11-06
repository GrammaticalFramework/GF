package se.chalmers.cs.gf.gwt.client;

import com.allen_sauer.gwt.dnd.client.PickupDragController;
import com.allen_sauer.gwt.dnd.client.drop.DropController;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Hyperlink;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp extends TranslateApp {

	private FridgeBagPanel bagPanel;
	private FridgeTextPanel textPanel;

	private MagnetFactory magnetFactory;

	//
	// Text
	//

	protected void update () {
		bagPanel.updateBag(getText());
		translate();
	}

	//
	// Translation
	//

	protected Widget createTranslation(String language, String text) {
		Hyperlink l = new Hyperlink(text, makeToken(language, text));
		l.addStyleName("my-translation");
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			l.getElement().setLang(lang);
		}
		return l;
	}

	//
	// Available words
	//

	private String makeToken (String language, String text) {
		return pgf.getPGFName() + "/" + language + "/" + text;
	}

	//
	// Current text
	//

	private void clear() {
		textPanel.clear();
	}


	// History stuff

	protected void updateSettingsFromHistoryToken(String[] tokenParts) {
		super.updateSettingsFromHistoryToken(tokenParts);
		if (tokenParts.length >= 3 && tokenParts[2].length() > 0) {
			setText(tokenParts[2]);
			update();
		}
	}


	// GUI

	protected Widget createUI() {
		PickupDragController dragController = new PickupDragController(RootPanel.get(), false);
		magnetFactory = new MagnetFactory(dragController);

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(createTextPanel());
		vPanel.add(createButtonPanel());
		vPanel.add(createBagPanel());
		vPanel.add(createSettingsPanel());
		vPanel.add(createTranslationsPanel());

		DropController dropController = new FridgeTextPanelDropController(textPanel);
		dragController.registerDropController(dropController);

		return vPanel;
	}

	protected Widget createTextPanel () {
		textPanel = new FridgeTextPanel(magnetFactory);		
		textPanel.addChangeListener(new ChangeListener() {
			public void onChange(Widget widget) {
				update();
			}
		});

		textSource = textPanel;

		return textPanel;
	}

	protected Widget createButtonPanel () {
		Panel buttons = new HorizontalPanel();
		buttons.add(new Button("Clear", new ClickListener () {
			public void onClick(Widget sender) {
				clear();
			}
		}));
		return buttons;
	}

	protected Widget createBagPanel () {
		bagPanel = new FridgeBagPanel(pgf, magnetFactory);
		return bagPanel;
	}


	// Initialization

	public void onModuleLoad() {
		statusPopup = new StatusPopup();

		pgf = new PGFWrapper(new PGF(pgfBaseURL), new MySettingsListener());

		RootPanel.get().add(createUI());

		History.addHistoryListener(new MyHistoryListener());

		updateSettingsFromHistoryToken();
	}

}
