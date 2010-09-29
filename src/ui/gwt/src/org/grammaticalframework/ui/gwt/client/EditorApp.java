package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.shared.*;

public class EditorApp implements EntryPoint {

	protected static final String pgfBaseURL = "/grammars";

	protected PGFWrapper pgf;

	protected VerticalPanel outputPanel;
	protected Widget translatePanel;
	protected BrowsePanel browsePanel;
	protected QueryPanel queryPanel;
	protected StatusPopup statusPopup;
	protected TextInputPanel textPanel;
	protected FridgeBagPanel bagPanel;
	protected MagnetFactory magnetFactory;

	private JSONRequest completeRequest = null;
	private JSONRequest translateRequest = null;

	private int maxMagnets = 100;
	private static final int LIMIT_SCALE_FACTOR = 4;
	
	private String cachedPrefix = null;
	private List<Magnet> cachedMagnets = Collections.emptyList();

	//
	// Update
	//
	protected void update() {
		clearMagnetCache();
		updateBag("");
		updateTranslation();
	}
	
	protected void clearMagnetCache() {
		cachedPrefix = null;
		cachedMagnets = Collections.emptyList();
	}

	protected void updateTranslation() {
		if (translateRequest != null) {
			translateRequest.cancel();
		}

		outputPanel.clear();
		outputPanel.addStyleDependentName("working");
		translateRequest = pgf.translate(textPanel.getText(),
				new PGF.TranslateCallback() {
			public void onResult (PGF.Translations translations) {
				translateRequest = null;

				outputPanel.clear();
				outputPanel.removeStyleDependentName("working");
				for (PGF.TranslationResult tr : translations.iterable()) {
					textPanel.renderBracketedString(tr.getBracketedString());

					if (tr.getTranslations() != null)
						for (PGF.Translation t : tr.getTranslations().iterable()) {
							LinearizationsPanel lin = new LinearizationsPanel(pgf, t.getTree(), t.getLinearizations());
							lin.setWidth("100%");
							outputPanel.add(lin);
						}

					if (tr.getTypeErrors() != null && tr.getTypeErrors().length > 0) {
						for (PGF.TcError error : tr.getTypeErrors()) {
							VerticalPanel panel = new VerticalPanel();
							panel.addStyleName("my-typeError");
							Label errLabel = new Label("Type Error");
							errLabel.addStyleName("title");
							panel.add(errLabel);
							panel.add(createErrorMsg(error));
							outputPanel.add(panel);
						}
						textPanel.showError(tr.getTypeErrors()[0].getFId());
					}
				}
			}
			public void onError (Throwable e) {
				translateRequest = null;

				showError("Translation failed", e);
			}
		});
	}
	
	private class Callback {
		private String prefix;
		
		public Callback(String prefix) {
			this.prefix = prefix;
		}
		
		public void onResult(List<Magnet> magnets) {
			bagPanel.fill(magnets);

			if (magnets.size() == 0) {
				if (prefix.isEmpty()) {
					textPanel.hideSearchBox();
					textPanel.setFocus(true);
				}
				else
					textPanel.showSearchError();
			} else {
				textPanel.clearSearchError();
			}
		}
	}

	public void updateBag(String prefix) {
		Callback callback = new Callback(prefix);
		List<Magnet> magnets = filterCachedMagnets(prefix);
		if (magnets != null)
			callback.onResult(magnets);
		else
			retrieveMagnets(prefix, callback);
	}

	public List<Magnet> filterCachedMagnets(final String prefix) {
		if (prefix.length() > 0 && cachedPrefix != null && prefix.startsWith(cachedPrefix)) {
			// If the prefix had no completions, there is no way that the current input will.
			if (cachedMagnets.isEmpty()) {
				return Collections.emptyList();
			}

			List<Magnet> magnets = new ArrayList<Magnet>();
			for (Magnet magnet : cachedMagnets) {
				if (magnet.getWord().startsWith(prefix)) {
					magnets.add(magnet);
					if (magnets.size() >= maxMagnets)
						return magnets;
				}
			}
		}
		return null;
	}

	public void retrieveMagnets(final String prefix, final Callback callback) {
		final String query = textPanel.getText() + " " + prefix;
		
		if (completeRequest != null) {
			completeRequest.cancel();
		}

		bagPanel.clear();
		completeRequest = pgf.complete(query, LIMIT_SCALE_FACTOR * maxMagnets,
					 new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				completeRequest = null;

				cachedPrefix = query;
				cachedMagnets = new ArrayList<Magnet>();

				for (PGF.Completion completion : completions.iterable()) {
					textPanel.renderBracketedString(completion.getBracketedString());
					if (completion.getCompletions() != null) {
						if (completion.getText() != prefix)
							textPanel.setSearchTerm(completion.getText());

						for (String word : completion.getCompletions()) {
							Magnet magnet = magnetFactory.createMagnet(word, completion.getFrom());
							cachedMagnets.add(magnet);
						}
					} else {
						textPanel.setSearchTerm(completion.getText());
					}
				}

				List<Magnet> magnets = new ArrayList<Magnet>();
				for (Magnet magnet : cachedMagnets) {
					magnets.add(magnet);
					if (magnets.size() >= maxMagnets)
						break;
				}				
				callback.onResult(magnets);
			}

			public void onError(Throwable e) {
				completeRequest = null;

				showError("Getting completions failed", e);
			}
		});
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
		queryPanel = createQueryPanel();

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);

		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		hPanel.setStylePrimaryName("my-HeaderPanel");

		Widget linksPanel = createLinksPanel(vPanel);
		hPanel.add(linksPanel);
		hPanel.setCellHorizontalAlignment(linksPanel,HorizontalPanel.ALIGN_LEFT);

		Widget settingsPanel = createSettingsPanel();
		hPanel.add(settingsPanel);
		hPanel.setCellHorizontalAlignment(settingsPanel,HorizontalPanel.ALIGN_RIGHT);

		vPanel.add(hPanel);
		vPanel.add(translatePanel);

		History.newItem("translate");
		History.addHistoryListener(new MyHistoryListener(vPanel));

		return vPanel;
	}

	protected Widget createSettingsPanel () {
		return new SettingsPanel(pgf);
	}

	protected Widget createTranslatePanel() {
		textPanel = new TextInputPanel();
		textPanel.addValueChangeHandler(new ValueChangeHandler<String>() {
			public void onValueChange(ValueChangeEvent<String> event) {
				update();
			}
		});
		textPanel.addSelectionHandler(new SelectionHandler<String>() {
			public void onSelection(SelectionEvent<String> event) {
				String prefix = event.getSelectedItem();
				char lastChar = prefix.charAt(prefix.length()-1);

				Iterator<Magnet> iter = bagPanel.iterator();
				if ((Character.isSpace(lastChar) || lastChar == 160) && iter.hasNext()) {
					Magnet magnet = iter.next();
					textPanel.setSearchTerm("");
					textPanel.addMagnet(magnet);
				}
				else
					updateBag(prefix);
			}
		});

		final ClickListener magnetClickListener = new ClickListener () {
			public void onClick(Widget widget) {
				Magnet magnet = (Magnet)widget;
				textPanel.hideSearchBox();
				textPanel.addMagnet(magnet);
				textPanel.setFocus(true);
			}
		};
		magnetFactory = new MagnetFactory(magnetClickListener);

		bagPanel = new FridgeBagPanel();

		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");

		final DockPanel translatePanel = new DockPanel();
		translatePanel.setStyleName("my-TranslatePanel");
		translatePanel.add(textPanel, DockPanel.NORTH);
		translatePanel.add(bagPanel, DockPanel.CENTER);
		translatePanel.add(outputPanel, DockPanel.EAST);

		translatePanel.setCellHeight(bagPanel, "100%");
		translatePanel.setCellWidth(bagPanel, "70%");
		translatePanel.setCellHeight(outputPanel, "100%");
		translatePanel.setCellWidth(outputPanel, "30%");
		translatePanel.setCellVerticalAlignment(bagPanel, HasVerticalAlignment.ALIGN_TOP);
		translatePanel.setCellHorizontalAlignment(outputPanel, HasHorizontalAlignment.ALIGN_RIGHT);

		Window.addWindowResizeListener(new WindowResizeListener() {
			public void onWindowResized(int w, int h) {
				translatePanel.setPixelSize(w-20, h-50);
			}
		});
		int w = Window.getClientWidth();
		int h = Window.getClientHeight();
		translatePanel.setPixelSize(w-20, h-50);

		return translatePanel;
	}

	protected BrowsePanel createBrowsePanel() {
		return new BrowsePanel(pgf);
	}

	protected QueryPanel createQueryPanel() {
		return new QueryPanel(pgf);
	}

	protected Widget createLinksPanel(final Panel parent) {
		HorizontalPanel linksPanel = new HorizontalPanel();
		linksPanel.setStylePrimaryName("my-LinksPanel");

		Hyperlink translateLink = new Hyperlink("Translate", "translate");
		translateLink.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				parent.remove(browsePanel);
				parent.remove(queryPanel);
				parent.add(translatePanel);
			}
		});
		linksPanel.add(translateLink);

		Hyperlink queryLink = new Hyperlink("Query", "query");
		queryLink.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				parent.remove(translatePanel);
				parent.remove(browsePanel);
				parent.add(queryPanel);
			}
		});
		linksPanel.add(queryLink);

		Hyperlink browseLink = new Hyperlink("Browse", "browse");
		browseLink.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				parent.remove(translatePanel);
				parent.remove(queryPanel);
				parent.add(browsePanel);
				browsePanel.onActivate();
			}
		});
		linksPanel.add(browseLink);

		return linksPanel;
	}

	protected Widget createErrorMsg(final PGF.TcError error) {
		HTML msgHTML = new HTML("<pre>"+error.getMsg()+"</pre>");
		msgHTML.addStyleName("content");
		msgHTML.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				textPanel.showError(error.getFId());
			}
		});
		return msgHTML;
	}

	//
	// History stuff
	//

	protected class MyHistoryListener implements HistoryListener {
		private final Panel parent;

		public MyHistoryListener(Panel parent) {
			this.parent = parent;
		}

		public void onHistoryChanged(String token) {
			if (token.equals("translate")) {
				parent.remove(queryPanel);
				parent.remove(browsePanel);
				parent.add(translatePanel);
			} else if (token.equals("query")) {
				parent.remove(translatePanel);
				parent.remove(browsePanel);
				parent.add(queryPanel);
			} else if (token.equals("browse")) {
				parent.remove(translatePanel);
				parent.remove(queryPanel);
				parent.add(browsePanel);
				browsePanel.onActivate();
				browsePanel.browse(null);
			} else if (token.startsWith("browse:")) {
				browsePanel.browse(token.substring(7));
			}
		}
	};

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
			textPanel.clear();
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
		pgf.updateAvailableGrammars();

		textPanel.setFocus(true);
	}
}
