package se.chalmers.cs.gf.gwt.client;

import com.allen_sauer.gwt.dnd.client.PickupDragController;
import com.google.gwt.user.client.ui.ClickListener;

public class MagnetFactory {

	private PickupDragController dragController;
	
	private ClickListener clickListener;
	
	public MagnetFactory (PickupDragController dragController, ClickListener clickListener) {
		this.dragController = dragController;
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
		dragController.makeDraggable(magnet);
		return magnet;
	}
	
}
