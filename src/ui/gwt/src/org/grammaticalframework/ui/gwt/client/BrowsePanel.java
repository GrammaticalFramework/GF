package org.grammaticalframework.ui.gwt.client;

import java.util.*;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.HistoryListener;
import com.google.gwt.user.client.Command;
import com.google.gwt.user.client.DeferredCommand;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.http.client.*;
import com.google.gwt.xml.client.*;
import com.google.gwt.event.logical.shared.*;

public class BrowsePanel extends Composite {

	private PGFWrapper pgf;
	private StatusPopup statusPopup;
	private HTML sourceView;
	private SuggestBox searchBox;
	private CompletionOracle oracle;
	private List<String> identifiers = null;

	public BrowsePanel(PGFWrapper pgf, StatusPopup statusPopup) {
		this.pgf = pgf;
		this.statusPopup = statusPopup;

		oracle = new CompletionOracle();

		HorizontalPanel browsePanel = new HorizontalPanel();
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(createSearchPanel(oracle));
		vPanel.add(createTreeView());
		browsePanel.add(vPanel);
		browsePanel.add(createSourcePanel());
		browsePanel.setCellWidth(sourceView,"100%");

		initWidget(browsePanel);
		setStylePrimaryName("my-BrowsePanel");

		pgf.addSettingsListener(new MySettingsListener(pgf));
	}

	public native void onActivate() /*-{
		$doc.browsePanel = this;
		$doc.callBrowse = @org.grammaticalframework.ui.gwt.client.BrowsePanel::callBrowse(Lorg/grammaticalframework/ui/gwt/client/BrowsePanel;Ljava/lang/String;);
	 }-*/;

	protected Widget createSearchPanel(CompletionOracle oracle) {
		searchBox = new SuggestBox(oracle);
		searchBox.setLimit(10);
		searchBox.addKeyboardListener(new KeyboardListenerAdapter() {
			public void onKeyUp (Widget sender, char keyCode, int modifiers) {
				if (keyCode == KEY_ENTER) {
					callBrowse(BrowsePanel.this,searchBox.getText());
				}
			}
		});

		DecoratorPanel decorator = new DecoratorPanel();
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(new Label("Search"));
		vPanel.add(searchBox);
		decorator.add(vPanel);
		return decorator;
	}

	private static void callBrowse(BrowsePanel panel, String id) {
		panel.browse(id);
		History.newItem("browse:"+id);
	}

	public void browse(final String id) {
		if (id == null || id.equals("")) {
			sourceView.setHTML("");
			return;
		}
		
		pgf.browse(id, "javascript:document.callBrowse(document.browsePanel,'$ID')",
                               "my-identifierLink",
                               new RequestCallback() {
			public void onResponseReceived(Request request, Response response) {
				sourceView.setHTML(response.getText());
			}

			public void onError(Request request, java.lang.Throwable e) {
				statusPopup.showError("Cannot load the page", e);
			}
		});
	}
	
	protected Widget createTreeView() {
		hierarchyTree = new Tree();
		hierarchyTree.addSelectionHandler(new SelectionHandler<TreeItem>() {
			public void onSelection(SelectionEvent<TreeItem> event) {
				TreeItem item = event.getSelectedItem();
				callBrowse(BrowsePanel.this,item.getText());
			}
		});
		return hierarchyTree;
	}

	protected Widget createSourcePanel() {
		sourceView = new HTML();
		sourceView.setStylePrimaryName("source");
		return sourceView;
	}

	protected class CompletionOracle extends SuggestOracle {

		public CompletionOracle() {
		}

		public void requestSuggestions(SuggestOracle.Request request, SuggestOracle.Callback callback) {
			List<CompletionSuggestion> list = new ArrayList();
			
			int index = Collections.binarySearch(identifiers, request.getQuery());
			index = (index >= 0) ? index : -(index+1);

			for (; index < identifiers.size(); index++) {
				String id = identifiers.get(index);

				if (id.startsWith(request.getQuery())) {
					list.add(new CompletionSuggestion(id));
				}
				else
				  break;

				if (list.size() > request.getLimit())
					break;
			}

			callback.onSuggestionsReady(request, new SuggestOracle.Response(list));
		}
	}

	protected static class CompletionSuggestion implements SuggestOracle.Suggestion {
		private String string;

		public CompletionSuggestion(String string) {
			this.string = string;
		}

		public String getDisplayString() {
			return string;
		}

		public String getReplacementString() {
			return string;
		}
	}

	Tree hierarchyTree = null;
	
	protected void reloadHierarchyTree() {
		hierarchyTree.clear();
		
		final String url = pgf.getGrammarURL()+".xml";
		RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, URL.encode(url));
		try
		{
			builder.sendRequest(null, new RequestCallback() {
				public void onResponseReceived(Request request, Response response)
				{
					if (200 == response.getStatusCode())
					{
						try
						{
							Document browseDoc = XMLParser.parse(response.getText());

							TreeLoader loader = new TreeLoader();

							Element element = browseDoc.getDocumentElement();
							NodeList children = element.getChildNodes();
							for (int i = 0; i < children.getLength(); i++) {
								Node node = children.item(i);
								if (node instanceof Element) {
									Element childElement = (Element) node;
									TreeItem childItem = hierarchyTree.addItem(childElement.getAttribute("name"));
									loader.push(childElement, childItem);
								}
							}
							
							loader.execute();
						}
						catch (DOMException e)
						{
						}
					}
					else
					{
					}
				}

				public void onError(Request request, Throwable e)
				{
				}
			});
		}
		catch (RequestException e)
		{
		}
	}

	private class TreeLoader implements Command {
		private int count = 0;
		private ArrayList<Element> elements = new ArrayList<Element>();
		private ArrayList<TreeItem> items = new ArrayList<TreeItem>();
										
		public void execute() {
			for (int n = 0; n < 100; n++) {
				if (count <= 0)
					return;

				int index = --count;
				Element element = (Element) elements.remove(index);
				TreeItem item = (TreeItem) items.remove(index);

				NodeList children = element.getChildNodes();
				for (int i = 0; i < children.getLength(); i++) {
					Node node = children.item(i);
					if (node instanceof Element) {
						Element childElement = (Element) node;
						TreeItem childItem = item.addItem(childElement.getAttribute("name"));
						push(childElement, childItem);
					}
				}
			}
			DeferredCommand.addCommand(this);
		}
					
		public final void push(Element element, TreeItem item) {
			elements.add(element);
			items.add(item);
			count++;
		}
	}

	protected class MySettingsListener implements PGFWrapper.SettingsListener {

		private PGFWrapper pgf;

		public MySettingsListener(PGFWrapper pgf) {
			this.pgf = pgf;
		}

		public void onAvailableGrammarsChanged() { }
		public void onSelectedGrammarChanged()
		{
			List<String> ids = new ArrayList();

			for (int i = 0; i < pgf.getCategories().length(); i++) {
				ids.add(pgf.getCategories().get(i));
			}
			for (int i = 0; i < pgf.getFunctions().length(); i++) {
				ids.add(pgf.getFunctions().get(i));
			}

			Collections.sort(ids);

			identifiers = ids;
			sourceView.setText("");
			searchBox.setText("");
			reloadHierarchyTree();
		}
		public void onInputLanguageChanged() { }
		public void onOutputLanguageChanged() {	}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}
}
