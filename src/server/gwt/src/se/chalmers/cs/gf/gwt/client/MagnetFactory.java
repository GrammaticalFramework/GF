package se.chalmers.cs.gf.gwt.client;

import com.allen_sauer.gwt.dnd.client.PickupDragController;

public class MagnetFactory {

	private PickupDragController dragController;
	
	public MagnetFactory (PickupDragController dragController) {
		this.dragController = dragController;
	}
	
	public Magnet createMagnet(String text) {
		Magnet magnet = new Magnet(text);
		dragController.makeDraggable(magnet);
		return magnet;
	}
	
}
