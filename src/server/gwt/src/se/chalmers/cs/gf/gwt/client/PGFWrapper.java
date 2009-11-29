package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import com.google.gwt.http.client.*;
import com.google.gwt.xml.client.*;
import com.google.gwt.core.client.*;

public class PGFWrapper {

	private String baseURL;

	private String grammarURL;

	private String pgfName = null;

	private PGF pgf;

	private String inputLanguage = null;

	private String outputLanguage = null;

	private String cat = null;

	// Cached info about the available grammars 

	private List<String> grammars;

	// Cached info about the currently selected grammar
	
	private String userLanguage;
	
	private LinkedHashMap<String,PGF.Language> languages;

	private List<String> parseableLanguages;

	private JsArrayString categories;
	private JsArrayString functions;

	// Event listeners
	
	private List<SettingsListener> listeners = new LinkedList<SettingsListener>();
	

	public PGFWrapper() {
		this.baseURL = null;
		this.pgf = new PGF();
	}

	public PGFWrapper(String baseURL) {
		this.baseURL = baseURL;
		this.pgf = new PGF();
	}

	public void updateAvailableGrammars() {
		String url = baseURL+"/grammars.xml";
		RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, URL.encode(url));
		try
		{
			Request request = builder.sendRequest(null, new RequestCallback() {
				public void onResponseReceived(Request request, Response response)
				{
					if (200 == response.getStatusCode())
					{
						grammars = new ArrayList<String>();
						try
						{
							Document grammarsDoc = XMLParser.parse(response.getText());

							NodeList grammarsList = grammarsDoc.getElementsByTagName("grammar");
							for (int i = 0; i < grammarsList.getLength(); i++)
							{
								Node grammarNode = grammarsList.item(i);
								grammars.add(((Element)grammarNode).getAttribute("name"));
							}
						}
						catch (DOMException e)
						{
							fireSettingsError("Could not parse XML document.", e);
						}
						fireAvailableGrammarsChanged();
					}
					else
					{
						fireSettingsError("Error getting grammar list", null);
					}
				}

				public void onError(Request request, Throwable e)
				{
					fireSettingsError("Error getting grammar list", e);
				}
			});
		}
		catch (RequestException e)
		{
			fireSettingsError("Couldn't connect to server", e);
		}
	}
	
	protected void updateSelectedGrammar () {
		clearCachedInfo();
		pgf.grammar(grammarURL, new PGF.GrammarCallback() {
			public void onResult(PGF.Grammar grammar) {
				userLanguage = grammar.getUserLanguage();
				languages = new LinkedHashMap<String,PGF.Language>();
				parseableLanguages = new ArrayList<String>();
				for (PGF.Language l : grammar.getLanguages().iterable()) {
					String name = l.getName();
					languages.put(name, l);
					if (l.canParse()) {
						parseableLanguages.add(name);
					}
				}
				
				categories = grammar.getCategories();
				functions = grammar.getFunctions();

				fireSelectedGrammarChanged();
			}

			public void onError (Throwable e) {
				fireSettingsError("Error getting language information", e);
			}
		});
	}

	//
	// PGF functionality
	//
	
	public JSONRequest translate (String input, final PGF.TranslateCallback callback) {
		return pgf.translate(grammarURL, input, inputLanguage, cat, outputLanguage, callback);
	}

	public JSONRequest complete (String input, int limit, final PGF.CompleteCallback callback) {
		return pgf.complete(grammarURL, input, inputLanguage, cat, limit, callback);
	}

	public JSONRequest parse (String input, final PGF.ParseCallback callback) {
		return pgf.parse(grammarURL, input, inputLanguage, cat, callback);
	}

	public String graphvizAbstractTree(String abstractTree) {
		return pgf.graphvizAbstractTree(grammarURL,abstractTree);
	}

	public String graphvizParseTree(String abstractTree, String lang) {
		return pgf.graphvizParseTree(grammarURL,abstractTree,lang);
	}

	public String graphvizAlignment(String abstractTree) {
		return pgf.graphvizAlignment(grammarURL,abstractTree);
	}

	public Request browse(String id, String href, String cssClass, RequestCallback callback) {
		return pgf.browse(grammarURL, id, href, cssClass, callback);
	}

	//
	// Settings
	//
	
	public String getPGFName() {
		return pgfName;
	}

	public void setPGFName(String pgfName) {
		this.pgfName = pgfName;
		this.grammarURL = baseURL + "/" + pgfName;
		this.inputLanguage = null;
		this.outputLanguage = null;
		this.cat = null;
		updateSelectedGrammar();
	}

	public String getGrammarURL() {
		return grammarURL;
	}

	public void setGrammarURL(String grammarURL) {
		this.pgfName = null;
		this.grammarURL = grammarURL;
		this.inputLanguage = null;
		this.outputLanguage = null;
		this.cat = null;
		updateSelectedGrammar();
	}

	public String getInputLanguage() {
		return inputLanguage;
	}

	public void setInputLanguage(String inputLanguage) {
		this.inputLanguage = inputLanguage;
		fireInputLanguageChanged();
	}

	public String getOutputLanguage() {
		return outputLanguage;
	}

	public void setOutputLanguage(String outputLanguage) {
		this.outputLanguage = outputLanguage;
		fireOutputLanguageChanged();
	}

	public String getStartCategory() {
		return cat;
	}

	public void setStartCategory(String cat) {
		this.cat = cat;
		fireStartCategoryChanged();
	}

	public JsArrayString getCategories() {
		return categories;
	}

	public JsArrayString getFunctions() {
		return functions;
	}
	
	
	//
	// Information about the available grammars
	//
	public List<String> getGrammars() {
		return grammars;
	}

	//
	// Information about the selected grammar
	//
	private void clearCachedInfo () {
		languages = null;
		parseableLanguages = null;
	}

	public String getUserLanguage () {
		return userLanguage;
	}

	public String getLanguageCode (String language) {
		PGF.Language l = languages.get(language);
		return l == null ? null : l.getLanguageCode();
	}

	public Collection<String> getParseableLanguages() {
		return parseableLanguages;
	}
	
	public Collection<String> getAllLanguages() {
		return languages.keySet();
	}
	
	//
	// Listeners
	//
	
	public interface SettingsListener {
		public void onAvailableGrammarsChanged();
		public void onSelectedGrammarChanged();
		public void onInputLanguageChanged();
		public void onOutputLanguageChanged();
		public void onStartCategoryChanged();
		public void onSettingsError(String msg, Throwable e);
	}
	
	public static class SettingsAdapter implements SettingsListener {
		public void onAvailableGrammarsChanged() {}
		public void onSelectedGrammarChanged() {}
		public void onInputLanguageChanged() {}
		public void onOutputLanguageChanged() {}
		public void onStartCategoryChanged() {}
		public void onSettingsError(String msg, Throwable e) {}
	}

	public void addSettingsListener(SettingsListener listener) {
		listeners.add(listener);
	}

	protected void fireAvailableGrammarsChanged() {
		for (SettingsListener listener : listeners) {
			listener.onAvailableGrammarsChanged();
		}
	}

	protected void fireSelectedGrammarChanged() {
		for (SettingsListener listener : listeners) {
			listener.onSelectedGrammarChanged();
		}
	}

	protected void fireInputLanguageChanged() {
		for (SettingsListener listener : listeners) {
			listener.onInputLanguageChanged();
		}
	}

	protected void fireOutputLanguageChanged() {
		for (SettingsListener listener : listeners) {
			listener.onOutputLanguageChanged();
		}
	}
	
	protected void fireStartCategoryChanged() {
		for (SettingsListener listener : listeners) {
			listener.onStartCategoryChanged();
		}
	}
	
	protected void fireSettingsError(String msg, Throwable e) {
		for (SettingsListener listener : listeners) {
			listener.onSettingsError(msg, e);
		}
	}
	
}