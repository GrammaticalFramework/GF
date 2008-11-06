package se.chalmers.cs.gf.gwt.client;

import com.allen_sauer.gwt.dnd.client.DragContext;
import com.allen_sauer.gwt.dnd.client.drop.SimpleDropController;
import com.google.gwt.user.client.ui.Widget;

public class FridgeTextPanelDropController extends SimpleDropController {

	private FridgeTextPanel textPanel;

	public FridgeTextPanelDropController (FridgeTextPanel textPanel) {
		super(textPanel);
		this.textPanel = textPanel;
	}

	public void onEnter(DragContext context) {
		super.onEnter(context);
		textPanel.setEngaged(true);
	}

	public void onLeave(DragContext context) {
		textPanel.setEngaged(false);
		super.onLeave(context);
	}

	public void onDrop(DragContext context) {
		for (Widget widget : context.selectedWidgets) {
			Magnet magnet = (Magnet)widget;
			textPanel.addMagnet(magnet);
		}
		super.onDrop(context);
	}

}
