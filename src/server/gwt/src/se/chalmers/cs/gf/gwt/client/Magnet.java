package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.ClickListenerCollection;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.PushButton;
import com.google.gwt.user.client.ui.SourcesClickEvents;
import com.google.gwt.user.client.ui.Widget;

public class Magnet extends Composite implements SourcesClickEvents {

	private String language;
	
	private String text;
	
	private ClickListenerCollection clickListeners = null;
	
	public Magnet(Magnet magnet) {
		this(magnet.language, magnet.text);
	}
	
	public Magnet(String language, String text) {
		this(language, text, null);
	}
	
	public Magnet(String language, String text, ClickListener listener) {
		this.language = language;
		this.text = text;
		final PushButton button = new PushButton(text);
		button.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				button.setFocus(false);
				fireClick();
			}
		});
		initWidget(button);
		addStyleName("my-Magnet");
		if (listener != null) {
			addClickListener(listener);
		}
	}

	public String getText() {
		return text;
	}
	
	public void addClickListener(ClickListener listener) {
		if (clickListeners == null) {
			clickListeners = new ClickListenerCollection();
		}
		clickListeners.add(listener);
	}

	public void removeClickListener(ClickListener listener) {
		if (clickListeners != null) {
			clickListeners.remove(listener);
		}
	}
	
	public void fireClick () {		
		if (clickListeners != null) {
			clickListeners.fireClick(this);
		}
	}

}
