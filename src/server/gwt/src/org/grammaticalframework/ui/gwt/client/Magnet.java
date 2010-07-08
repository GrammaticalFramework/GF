package org.grammaticalframework.ui.gwt.client;

import com.google.gwt.user.client.ui.HTML;

public class Magnet extends HTML {
	
	private String language;
	
	public Magnet (String text, String language) {
		this.language = language;
		setHTML(text);
		setStylePrimaryName("my-Magnet");
	}
	
	public String getLanguage() {
		return language;
	}

}
