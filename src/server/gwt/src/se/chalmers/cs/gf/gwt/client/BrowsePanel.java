package se.chalmers.cs.gf.gwt.client;

import java.util.*;
import java.lang.*;
import com.google.gwt.core.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.http.client.*;
import com.google.gwt.dom.client.*;

public class BrowsePanel extends Composite {

	private PGFWrapper pgf;
	private HTML sourceView;
	private SuggestBox searchBox;
	private CompletionOracle oracle;
	private List<String> identifiers = null;

	public BrowsePanel(PGFWrapper pgf) {
		this.pgf = pgf;

		oracle = new CompletionOracle();

		HorizontalPanel browsePanel = new HorizontalPanel();
		browsePanel.add(createSearchPanel(oracle));
		browsePanel.add(createSourcePanel());
		browsePanel.setCellWidth(sourceView,"100%");

		initWidget(browsePanel);
		setStylePrimaryName("my-BrowsePanel");

		pgf.addSettingsListener(new MySettingsListener(pgf));
	}

	public native void onActivate() /*-{
		$doc.browsePanel = this;
		$doc.callBrowse = @se.chalmers.cs.gf.gwt.client.BrowsePanel::callBrowse(Lse/chalmers/cs/gf/gwt/client/BrowsePanel;Ljava/lang/String;);
	 }-*/;

	protected Widget createSearchPanel(CompletionOracle oracle) {
		searchBox = new SuggestBox(oracle);
		searchBox.setLimit(10);
		searchBox.addKeyboardListener(new KeyboardListenerAdapter() {
			public void onKeyUp (Widget sender, char keyCode, int modifiers) {
				if (keyCode == KEY_ENTER) {
					browse(searchBox.getText());
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
	}

	protected void browse(String id) {
		pgf.browse(id, "javascript:document.callBrowse(document.browsePanel,'$ID')",
                               "my-identifierLink",
                               new RequestCallback() {
			public void onResponseReceived(Request request, Response response) {
				sourceView.setHTML(response.getText());
			}

			public void onError(Request request, java.lang.Throwable exception) {
				// errorHandler.onError(e);
			}
		});
	}

	protected Widget createSourcePanel() {
		sourceView = new HTML();
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
		}
		public void onInputLanguageChanged() { }
		public void onOutputLanguageChanged() {	}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}
}