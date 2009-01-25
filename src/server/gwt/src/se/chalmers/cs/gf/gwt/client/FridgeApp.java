package se.chalmers.cs.gf.gwt.client;

import java.util.List;

import com.allen_sauer.gwt.dnd.client.PickupDragController;
import com.allen_sauer.gwt.dnd.client.drop.DropController;
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.WindowResizeListener;
import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.DockPanel;
import com.google.gwt.user.client.ui.HasHorizontalAlignment;
import com.google.gwt.user.client.ui.HasVerticalAlignment;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp implements EntryPoint {

	protected static final String pgfBaseURL = "/grammars";

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

		textPanel = new FridgeTextPanel(magnetFactory);
		textPanel.addChangeListener(new ChangeListener() {
			public void onChange(Widget widget) {
				update();
			}
		});
		bagPanel = new FridgeBagPanel(pgf, magnetFactory);
		outputPanel = new TranslationsPanel();
		SettingsPanel settingsPanel = new SettingsPanel(pgf, true, false);
		
		final DockPanel mainPanel = new DockPanel();
		mainPanel.setStyleName("my-FridgeApp");
		mainPanel.add(textPanel, DockPanel.NORTH);
		mainPanel.add(settingsPanel, DockPanel.SOUTH);
		mainPanel.add(bagPanel, DockPanel.CENTER);
		mainPanel.add(outputPanel, DockPanel.EAST);
		
		mainPanel.setCellHeight(bagPanel, "100%");
		mainPanel.setCellWidth(bagPanel, "80%");
		mainPanel.setCellHeight(outputPanel, "100%");
		mainPanel.setCellWidth(outputPanel, "20%");
		mainPanel.setCellVerticalAlignment(bagPanel, HasVerticalAlignment.ALIGN_TOP);
		mainPanel.setCellHorizontalAlignment(outputPanel, HasHorizontalAlignment.ALIGN_RIGHT);
		mainPanel.setCellWidth(settingsPanel, "100%");
		
		DropController dropController = new FridgeTextPanelDropController(textPanel);
		dragController.registerDropController(dropController);

		Window.addWindowResizeListener(new WindowResizeListener() {
			public void onWindowResized(int w, int h) {
				mainPanel.setPixelSize(w, h);
			}
		});
		int w = Window.getClientWidth();
		int h = Window.getClientHeight();
		mainPanel.setPixelSize(w, h);
		
		return mainPanel;
	}
	
	private static class TranslationsPanel extends VerticalPanel {
		public TranslationsPanel () {
			setStylePrimaryName("my-TranslationsPanel");
			addStyleDependentName("empty");
		}
		
		public void clear () {
			super.clear();
			addStyleDependentName("empty");
		}

		public void add(Widget w) {
			removeStyleDependentName("empty");
			super.add(w);
		}
		
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

		pgf = new PGFWrapper(pgfBaseURL);
		RootPanel.get().add(createUI());
		pgf.addSettingsListener(new MySettingsListener());
		History.addHistoryListener(new MyHistoryListener());
		updateSettingsFromHistoryToken();
		pgf.updateAvailableGrammars();
	}

}
