package se.chalmers.cs.gf.gwt.client;

import java.util.List;

import com.allen_sauer.gwt.dnd.client.PickupDragController;
import com.allen_sauer.gwt.dnd.client.drop.DropController;
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp implements EntryPoint {

	protected static final String pgfBaseURL = "/pgf";

	protected PGFWrapper pgf;
	
	protected JSONRequest translateRequest = null;

	private FridgeBagPanel bagPanel;
	private FridgeTextPanel textPanel;
	protected VerticalPanel outputPanel;
	protected StatusPopup statusPopup;

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

	protected void translate() {
		outputPanel.clear();
		outputPanel.addStyleDependentName("working");
		if (translateRequest != null) {
			translateRequest.cancel();
		}
		translateRequest = pgf.translate(getText(), 
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

	protected ClickListener translationClickListener = new ClickListener () {
		public void onClick(Widget widget) {
			Magnet magnet = (Magnet)widget;
			setInputLanguage(magnet.getLanguage()); // FIXME: this causes an unnecessary update()
			setText(magnet.getText(), magnet.getLanguage());
		}
	};

	protected Widget createTranslation(String language, String text) {
		Magnet magnet = magnetFactory.createUsedMagnet(text, language);
		magnet.addClickListener(translationClickListener);
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			magnet.getElement().setLang(lang);
		}
		return magnet;
	}

	//
	// Current text
	//

	public String getText () {
		return textPanel.getText();
	}

	public void setText(String text, String language) {
		textPanel.setText(text, language);
	}

	private void clear() {
		textPanel.clear();
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

	// GUI

	protected Widget createUI() {
		PickupDragController dragController = new PickupDragController(RootPanel.get(), false);
		dragController.setBehaviorDragStartSensitivity(1);
		dragController.setBehaviorDragProxy(true);
		dragController.setBehaviorConstrainedToBoundaryPanel(true);
		/*
		dragController.addDragHandler(new DragHandlerAdapter() {
			public void onDragStart(DragStartEvent event) {
				Widget w = event.getContext().draggable;
				if (w instanceof Magnet) {
					bagPanel.cloneMagnet((Magnet)w);
				}
			}
		});
		*/

		ClickListener magnetClickListener = new ClickListener () {
			public void onClick(Widget widget) {
				Magnet magnet = (Magnet)widget;
				textPanel.addMagnet(magnet);
			}
		};
		magnetFactory = new MagnetFactory(dragController, magnetClickListener);

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

		return textPanel;
	}

	protected Widget createButtonPanel () {
		Panel buttons = new HorizontalPanel();
		buttons.add(new Button("Delete last", new ClickListener () {
			public void onClick(Widget sender) {
				textPanel.deleteLast();
			}
		}));
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

	protected Widget createSettingsPanel () {
		return new SettingsPanel(pgf, true, false);
	}

	protected Widget createTranslationsPanel () {
		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");
		return outputPanel;
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
				pgf.setInputLanguage(pgf.getUserLanguage());
			}
		}
		public void onInputLanguageChanged() {
			clear();
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

		pgf = new PGFWrapper(new PGF(pgfBaseURL), new MySettingsListener());

		RootPanel.get().add(createUI());

		History.addHistoryListener(new MyHistoryListener());

		updateSettingsFromHistoryToken();
	}

}
