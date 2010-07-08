package org.grammaticalframework.ui.gwt.client;

import com.google.gwt.user.client.ui.*;

public class MagnetFactory {

	private ClickListener clickListener;
	
	public MagnetFactory (ClickListener clickListener) {
		this.clickListener = clickListener;
	}
	
	public Magnet createUsedMagnet(Magnet magnet) {
		return createUsedMagnet(magnet.getText(), magnet.getLanguage());
	}
	
	public Magnet createUsedMagnet(String text, String language) {
		return new Magnet(text, language);
	}
	
	public Magnet createMagnet(Magnet magnet) {
		return createMagnet(magnet.getText(), magnet.getLanguage());
	}
	
	public Magnet createMagnet(String text, String language) {
		Magnet magnet = new Magnet(text, language);
		magnet.addClickListener(clickListener);			
		return magnet;
	}
	
}
