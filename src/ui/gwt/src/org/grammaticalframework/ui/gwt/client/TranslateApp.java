package org.grammaticalframework.ui.gwt.client;

import java.util.List;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;


public class TranslateApp implements EntryPoint {

	protected static final String pgfBaseURL = "/grammars";

	protected PGFWrapper pgf;

	protected SuggestPanel suggestPanel;
	protected VerticalPanel outputPanel;
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
			public void onResult (IterableJsArray<PGF.TranslationResult> translations) {
				outputPanel.clear();
				outputPanel.removeStyleDependentName("working");
				for (PGF.TranslationResult tr : translations.iterable()) {
					if (tr.getTranslations() != null) {
						for (PGF.Linearizations t : tr.getTranslations().iterable()) {
							outputPanel.add(new LinearizationsPanel(pgf, t));
						}
					}

					if (tr.getTypeErrors() != null && tr.getTypeErrors().length > 0) {
						for (PGF.TcError error : tr.getTypeErrors()) {
							VerticalPanel panel = new VerticalPanel();
							panel.addStyleName("my-typeError");
							Label errLabel = new Label("Type Error");
							errLabel.addStyleName("my-error-title");
							HTML  msgHTML  = new HTML("<pre>"+error.getMsg()+"</pre>");
							panel.add(errLabel);
							panel.add(msgHTML);
							outputPanel.add(panel);
						}
					}
				}
			}
			public void onError (Throwable e) {
				showError("Translation failed", e);
			}
		});
	}

	protected Widget createAbsTreeButton(final String abstractTree) {
		Image treeBtn = new Image("org.grammaticalframework.ui.gwt.TranslateApp/tree-btn.png");
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
		Image alignBtn = new Image("org.grammaticalframework.ui.gwt.TranslateApp/align-btn.png");
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
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(createSuggestPanel());
        vPanel.add(createSettingsPanel());
		vPanel.add(createTranslationsPanel());

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
