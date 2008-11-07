package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;


public class PGFWrapper {

	private PGF pgf;

	private String pgfName = null;

	private String inputLanguage = null;

	private String outputLanguage = null;

	private String cat = null;

	// Cached info about the available grammars 

	private List<String> grammars;

	// Cached info about the currently selected grammar
	
	private String userLanguage;
	
	private LinkedHashMap<String,PGF.Language> languages;

	private List<String> parseableLanguages;
	
	// Event listeners
	
	private List<SettingsListener> listeners = new LinkedList<SettingsListener>();
	

	public PGFWrapper(PGF pgf) {
		this.pgf = pgf;
	}

	public void updateAvailableGrammars() {
		pgf.listGrammars(new PGF.GrammarNamesCallback() {
			public void onResult(PGF.GrammarNames grammarNames) {
				grammars = new ArrayList<String>();
				for (PGF.GrammarName grammarName : grammarNames.iterable()) {
					grammars.add(grammarName.getName());
				}
				fireAvailableGrammarsChanged();
			}
			public void onError (Throwable e) {
				fireSettingsError("Error getting grammar list", e);
			}
		});
	}
	
	protected void updateSelectedGrammar () {
		clearCachedInfo();
		pgf.grammar(pgfName, new PGF.GrammarCallback() {
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
				fireAvailableLanguagesChanged();
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
		return pgf.translate(pgfName, input, inputLanguage, cat, outputLanguage, callback);
	}

	public JSONRequest complete (String input, int limit, final PGF.CompleteCallback callback) {
		return pgf.complete(pgfName, input, inputLanguage, cat, limit, callback);
	}

	public JSONRequest parse (String input, final PGF.ParseCallback callback) {
		return pgf.parse(pgfName, input, inputLanguage, cat, callback);
	}

	//
	// Settings
	//
	
	public String getPGFName() {
		return pgfName;
	}

	public void setPGFName(String pgfName) {
		this.pgfName = pgfName;
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

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
		fireCatChanged();
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
		public void onAvailableLanguagesChanged();
		public void onInputLanguageChanged();
		public void onOutputLanguageChanged();
		public void onCatChanged();
		public void onSettingsError(String msg, Throwable e);
	}
	
	public static class SettingsAdapter implements SettingsListener {
		public void onAvailableGrammarsChanged() {}
		public void onAvailableLanguagesChanged() {}
		public void onInputLanguageChanged() {}
		public void onOutputLanguageChanged() {}
		public void onCatChanged() {}
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

	protected void fireAvailableLanguagesChanged() {
		for (SettingsListener listener : listeners) {
			listener.onAvailableLanguagesChanged();
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
	
	protected void fireCatChanged() {
		for (SettingsListener listener : listeners) {
			listener.onCatChanged();
		}
	}
	
	protected void fireSettingsError(String msg, Throwable e) {
		for (SettingsListener listener : listeners) {
			listener.onSettingsError(msg, e);
		}
	}
	
}