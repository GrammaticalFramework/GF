package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.shared.*;

public class EditorApp implements EntryPoint {

	protected ContentService contentService;
	protected PGFWrapper pgf;

	protected SettingsPanel settingsPanel;
	protected VerticalPanel outputPanel;
	protected Widget editorPanel;
	protected BrowsePanel browsePanel;
	protected QueryPanel queryPanel;
	protected DocumentsPanel documentsPanel;
	protected GrammarsPanel grammarsPanel;
	protected StatusPopup statusPopup;
	protected TextInputPanel textPanel;
	protected FridgeBagPanel bagPanel;
	protected MagnetFactory magnetFactory;
	protected TabBar tabBar;

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
			public void onResult (IterableJsArray<PGF.TranslationResult> translations) {
				translateRequest = null;

				outputPanel.clear();
				outputPanel.removeStyleDependentName("working");
				for (PGF.TranslationResult tr : translations.iterable()) {
					textPanel.renderBracketedString(tr.getBracketedString());

					if (tr.getTranslations() != null)
						for (PGF.Linearizations lins : tr.getTranslations().iterable()) {
							LinearizationsPanel lin = new LinearizationsPanel(pgf, lins);
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

				statusPopup.showError("Translation failed", e);
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
			public void onResult(IterableJsArray<PGF.Completion> completions) {
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

				statusPopup.showError("Getting completions failed", e);
			}
		});
	}

	//
	// GUI
	//

	protected Widget createUI() {
		editorPanel = createEditorPanel();
		browsePanel = createBrowsePanel();
		queryPanel = createQueryPanel();
		documentsPanel = createDocumentsPanel();
		grammarsPanel = createGrammarsPanel();

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);

		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		hPanel.setStylePrimaryName("my-HeaderPanel");

		TabBar linksPanel = createLinksPanel(vPanel);
		hPanel.add(linksPanel);
		hPanel.setCellHorizontalAlignment(linksPanel,HorizontalPanel.ALIGN_LEFT);
		linksPanel.selectTab(1);

		settingsPanel = createSettingsPanel();
		hPanel.add(settingsPanel);
		hPanel.setCellHorizontalAlignment(settingsPanel,HorizontalPanel.ALIGN_RIGHT);

		vPanel.add(hPanel);
		vPanel.add(editorPanel);

		return vPanel;
	}

	protected SettingsPanel createSettingsPanel () {
		return new SettingsPanel(pgf, contentService, statusPopup);
	}

	protected Widget createEditorPanel() {
		textPanel = new TextInputPanel(contentService, statusPopup);
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

		final DockPanel editorPanel = new DockPanel();
		editorPanel.setStyleName("my-EditorPanel");
		editorPanel.add(textPanel, DockPanel.NORTH);
		editorPanel.add(bagPanel, DockPanel.CENTER);
		editorPanel.add(outputPanel, DockPanel.EAST);

		editorPanel.setCellHeight(bagPanel, "100%");
		editorPanel.setCellWidth(bagPanel, "70%");
		editorPanel.setCellHeight(outputPanel, "100%");
		editorPanel.setCellWidth(outputPanel, "30%");
		editorPanel.setCellVerticalAlignment(bagPanel, HasVerticalAlignment.ALIGN_TOP);
		editorPanel.setCellHorizontalAlignment(outputPanel, HasHorizontalAlignment.ALIGN_RIGHT);

		Window.addWindowResizeListener(new WindowResizeListener() {
			public void onWindowResized(int w, int h) {
				editorPanel.setPixelSize(w-20, h-50);
			}
		});
		int w = Window.getClientWidth();
		int h = Window.getClientHeight();
		editorPanel.setPixelSize(w-20, h-50);

		return editorPanel;
	}

	protected BrowsePanel createBrowsePanel() {
		return new BrowsePanel(pgf, statusPopup);
	}

	protected QueryPanel createQueryPanel() {
		return new QueryPanel(pgf, statusPopup);
	}

	protected DocumentsPanel createDocumentsPanel() {
		DocumentsPanel panel = new DocumentsPanel(pgf, contentService, statusPopup);
		panel.addSelectionHandler(new SelectionHandler<Object>() {
			public void onSelection(SelectionEvent<Object> event) {
				tabBar.selectTab(1);
				textPanel.load(event.getSelectedItem());
			}
		});
		return panel;
	}

	protected GrammarsPanel createGrammarsPanel() {
		return new GrammarsPanel(pgf, contentService, statusPopup);
	}

	protected TabBar createLinksPanel(final Panel parent) {
		tabBar = new TabBar();
		tabBar.setStylePrimaryName("my-LinksPanel");
		tabBar.addTab("Documents");
		tabBar.addTab("Editor");
		tabBar.addTab("Query");
		tabBar.addTab("Browse");
		tabBar.addTab("Grammars");
		
		NavigationHandler handler = new NavigationHandler(tabBar, parent);
		tabBar.addSelectionHandler(handler);
		History.addHistoryListener(handler);

		return tabBar;
	}

	//
	// History stuff
	//

	protected class NavigationHandler implements HistoryListener, SelectionHandler<Integer> {
		private final TabBar linksPanel;
		private final Panel parent;
		private int level = 0;

		public NavigationHandler(TabBar linksPanel, Panel parent) {
			this.linksPanel = linksPanel;
			this.parent = parent;
		}

		public void onSelection(SelectionEvent<Integer> event) {
			parent.remove(documentsPanel);
			parent.remove(editorPanel);
			parent.remove(queryPanel);
			parent.remove(browsePanel);
			parent.remove(grammarsPanel);

			switch (event.getSelectedItem().intValue()) {
				case 0: parent.add(documentsPanel); 
				        if (level == 0) History.newItem("documents", false);
				        break;
				case 1: parent.add(editorPanel);
					if (level == 0) History.newItem("editor", false);
					break;
				case 2: parent.add(queryPanel);
					if (level == 0) History.newItem("query", false);
					break;
				case 3: parent.add(browsePanel);
					if (level == 0) History.newItem("browse", false);
					browsePanel.onActivate();
					break;
				case 4: parent.add(grammarsPanel);
					if (level == 0) History.newItem("grammars", false);
					break;
			}
		}

		public void onHistoryChanged(String token) {
			level++;
			
			if (token.equals("documents")) {
				linksPanel.selectTab(0);
			} else if (token.equals("editor")) {
				linksPanel.selectTab(1);
			} else if (token.equals("query")) {
				linksPanel.selectTab(2);
			} else if (token.equals("browse")) {
				linksPanel.selectTab(3);
				browsePanel.onActivate();
				browsePanel.browse(null);
			} else if (token.startsWith("browse:")) {
				linksPanel.selectTab(3);
				browsePanel.browse(token.substring(7));
			} else if (token.equals("grammars")) {
				linksPanel.selectTab(4);
			}
			
			level--;
		}
	};

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
	// Initialization
	//

	protected class MySettingsListener implements SettingsListener {
		// Will only happen on load
		public void onAvailableGrammarsChanged() {
			if (pgf.getGrammarURL() == null) {
				List<String> grammars = pgf.getGrammars();
				if (!grammars.isEmpty()) {
					pgf.setGrammarURL(grammars.get(0));
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
			statusPopup.showError(msg,e);
		}
	}
	
	public void onModuleLoad() {
		statusPopup = new StatusPopup();

		pgf = new PGFWrapper();
		contentService = new ContentService();
		RootPanel.get().add(createUI());
		pgf.addSettingsListener(new MySettingsListener());
		contentService.updateAvailableGrammars();

		textPanel.setFocus(true);
	}
}
