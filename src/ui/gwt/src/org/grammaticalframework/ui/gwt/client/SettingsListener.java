package org.grammaticalframework.ui.gwt.client;

public interface SettingsListener {
	public void onAvailableGrammarsChanged();
	public void onSelectedGrammarChanged();
	public void onInputLanguageChanged();
	public void onOutputLanguageChanged();
	public void onStartCategoryChanged();
	public void onSettingsError(String msg, Throwable e);
}
