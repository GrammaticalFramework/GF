package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.Label;

public class UsedMagnet extends Composite {

	private String word;
	
	public UsedMagnet(String language, String word) {
		this.word = word;
		initWidget(new Label(word));
		setStylePrimaryName("my-UsedMagnet");
	}
	
	public String getText() {
		return word;
	}
	
}
