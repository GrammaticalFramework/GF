package se.chalmers.cs.gf.gwt.client;

import java.util.List;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.ui.*;


public class TranslateApp implements EntryPoint {

	protected static final String pgfBaseURL = "/grammars";

	protected PGFWrapper pgf;

	protected SuggestPanel suggestPanel;
	protected VerticalPanel outputPanel;
	protected Widget translatePanel;
	protected BrowsePanel browsePanel;
	protected StatusPopup statusPopup;

	//
	// Text
	//
	
	public String getText () {
		return suggestPanel.getText();
	}
	
	protected void update () {
		translate();
	}
	
	//
	// Translation
	//
	
	protected void translate() {
		outputPanel.clear();
		outputPanel.addStyleDependentName("working");
		pgf.translate(getText(), 
				new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				outputPanel.clear();
				outputPanel.removeStyleDependentName("working");
				for (PGF.Translation t : translations.iterable()) {
					HorizontalPanel hPanel = new HorizontalPanel();
					hPanel.addStyleName("my-translation-frame");
					VerticalPanel linsPanel = new VerticalPanel();
					linsPanel.addStyleName("my-translation-bar");
					hPanel.add(linsPanel);
					HorizontalPanel btnPanel = new HorizontalPanel();
					btnPanel.addStyleName("my-translation-btns");
					btnPanel.setSpacing(4);
					btnPanel.add(createAbsTreeButton(t.getTree()));
					btnPanel.add(createAlignButton(t.getTree()));
					hPanel.add(btnPanel);
					hPanel.setCellHorizontalAlignment(btnPanel,
						HasHorizontalAlignment.ALIGN_RIGHT);
					outputPanel.add(hPanel);

					for (PGF.Linearization l : t.getLinearizations().iterable()) {
						linsPanel.add(createTranslation(l.getTo(), t.getTree(), l.getText()));
					}
				}
			}
			public void onError (Throwable e) {
				showError("Translation failed", e);
			}
		});
	}

	protected Widget createAbsTreeButton(final String abstractTree) {
		Image treeBtn = new Image("se.chalmers.cs.gf.gwt.TranslateApp/tree-btn.png");
		treeBtn.addClickListener(
			new ClickListener() {
				public void onClick(Widget sender) {
					// Create a dialog box and set the caption text
					final DialogBox dialogBox = new DialogBox();
					dialogBox.setText("Abstract Syntax Tree");

					// Create a table to layout the content
					HorizontalPanel dialogContents = new HorizontalPanel();
					dialogContents.setSpacing(4);
					dialogBox.setWidget(dialogContents);

					// Add an image to the dialog
					
					Frame image = new Frame(pgf.graphvizAbstractTree(abstractTree));
					image.addStyleName("my-treeimage");
					dialogContents.add(image);

					// Add a close button at the bottom of the dialog
					Button closeButton = new Button("Close",
						new ClickListener() {
							public void onClick(Widget sender) {
								dialogBox.hide();
						}
					});
					dialogContents.add(closeButton);

					dialogBox.center();
					dialogBox.show();
				}
			});
		return treeBtn;
	}

	protected Widget createAlignButton(final String abstractTree) {
		Image alignBtn = new Image("se.chalmers.cs.gf.gwt.TranslateApp/align-btn.png");
		alignBtn.addClickListener(
			new ClickListener() {
				public void onClick(Widget sender) {
					// Create a dialog box and set the caption text
					final DialogBox dialogBox = new DialogBox();
					dialogBox.setText("Word Alignment");

					// Create a table to layout the content
					HorizontalPanel dialogContents = new HorizontalPanel();
					dialogContents.setSpacing(4);
					dialogBox.setWidget(dialogContents);

					// Add an image to the dialog
					Frame image = new Frame(pgf.graphvizAlignment(abstractTree));
					image.addStyleName("my-alignmentimage");
					dialogContents.add(image);

					// Add a close button at the bottom of the dialog
					Button closeButton = new Button("Close",
						new ClickListener() {
							public void onClick(Widget sender) {
								dialogBox.hide();
						}
					});
					dialogContents.add(closeButton);

					dialogBox.center();
					dialogBox.show();
				}
			});
		return alignBtn;
	}

	protected Widget createTranslation(final String language, final String abstractTree, String text) {
		Label l = new Label(text);
		l.addStyleName("my-translation");
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			l.getElement().setLang(lang);
		}
		l.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				// Create a dialog box and set the caption text
				final DialogBox dialogBox = new DialogBox();
				dialogBox.setText("Parse Tree");

				// Create a table to layout the content
				HorizontalPanel dialogContents = new HorizontalPanel();
				dialogContents.setSpacing(4);
				dialogBox.setWidget(dialogContents);

				// Add an image to the dialog
				Frame image = new Frame(pgf.graphvizParseTree(abstractTree, language));
				image.addStyleName("my-treeimage");
				dialogContents.add(image);

				// Add a close button at the bottom of the dialog
				Button closeButton = new Button("Close",
					new ClickListener() {
						public void onClick(Widget sender) {
							dialogBox.hide();
					}
				});
				dialogContents.add(closeButton);

				dialogBox.center();
				dialogBox.show();
			}
		});
		return l;
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

	//
	// GUI
	//
	
	protected Widget createUI() {
		translatePanel = createTranslatePanel();
		browsePanel = createBrowsePanel();

		VerticalPanel vPanel = new VerticalPanel();

		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		hPanel.setStylePrimaryName("my-HeaderPanel");

		Widget linksPanel = createLinksPanel(vPanel);
		hPanel.add(linksPanel);
		hPanel.setCellHorizontalAlignment(linksPanel,HorizontalPanel.ALIGN_LEFT);

		Widget settingsPanel = createSettingsPanel();
		hPanel.add(settingsPanel);
		hPanel.setCellHorizontalAlignment(settingsPanel,HorizontalPanel.ALIGN_RIGHT);

		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(hPanel);
		vPanel.add(translatePanel);

		return vPanel;
	}

	protected Widget createSuggestPanel () {
		suggestPanel = new SuggestPanel(pgf);
		suggestPanel.setButtonText("Translate");
		suggestPanel.addSubmitListener(new SuggestPanel.SubmitListener() {
			public void onSubmit(String text) {
				translate();
			}
		});		
		return suggestPanel;
	}

	protected Widget createSettingsPanel () {
		return new SettingsPanel(pgf);
	}

	protected Widget createTranslationsPanel () {
		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");
		return outputPanel;
	}

	protected Widget createTranslatePanel() {
		VerticalPanel translatePanel = new VerticalPanel();
		translatePanel.add(createSuggestPanel());
		translatePanel.add(createTranslationsPanel());
		return translatePanel;
	}

	protected BrowsePanel createBrowsePanel() {
		return new BrowsePanel(pgf);
	}

	protected Widget createLinksPanel(final Panel parent) {
		HorizontalPanel linksPanel = new HorizontalPanel();
		linksPanel.setStylePrimaryName("my-LinksPanel");

		Hyperlink translateLink = new Hyperlink("Translate", null);
		translateLink.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				parent.remove(browsePanel);
				parent.add(translatePanel);
			}
		});
		linksPanel.add(translateLink);

		Hyperlink browseLink = new Hyperlink("Browse", null);
		browseLink.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				parent.remove(translatePanel);
				parent.add(browsePanel);
				browsePanel.onActivate();
			}
		});
		linksPanel.add(browseLink);

		return linksPanel;
	}

	protected Widget createLoadingWidget () {
		VerticalPanel loadingPanel = new VerticalPanel();
		loadingPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		loadingPanel.add(new Label("Loading..."));
		return loadingPanel;
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
		public void onSelectedGrammarChanged() {
			if (pgf.getInputLanguage() == null) {
				GWT.log("Setting input language to user language: " + pgf.getUserLanguage(), null);
				pgf.setInputLanguage(pgf.getUserLanguage());
			}
			update();
		}
		public void onInputLanguageChanged() {
			update();
		}
		public void onOutputLanguageChanged() {
			update();
		}
		public void onStartCategoryChanged() {
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
