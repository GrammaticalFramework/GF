package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ChangeListenerCollection;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.HasText;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.Widget;

public class FridgeTextPanel extends Composite implements HasText {

	private MagnetFactory magnetFactory;
	
	private Panel mainPanel;

	private ChangeListenerCollection listeners = null;

	public FridgeTextPanel (MagnetFactory magnetFactory) { 
		this.magnetFactory = magnetFactory;
		mainPanel = new FlowPanel();
		initWidget(mainPanel);
		setStylePrimaryName("my-FridgeTextPanel");
	}

	public void setEngaged(boolean engaged) {
		if (engaged) {
			addStyleDependentName("engage");
		} else {
			removeStyleDependentName("engage");
		}
	}
	
	public String getText () {
		StringBuilder sb = new StringBuilder();
		for (Widget w : mainPanel) {
			String word = ((Magnet)w).getText();	
			if (sb.length() > 0) {
				sb.append(' ');
			}
			sb.append(word);			
		}
		return sb.toString();
	}

	public void setText (String text) {
		clear();
		for (String word : text.split("\\s+")) {
			if (word.length() > 0) {
				addMagnet(magnetFactory.createMagnet(word));
			}
		}
	}

	public void clear () {
		mainPanel.clear();
		fireChange();
	}

	public void addMagnet (Magnet magnet) {
		mainPanel.add(magnet);
		fireChange();
	}

	protected void fireChange() {
		listeners.fireChange(this);
	}
	
	public void addChangeListener(ChangeListener listener) {
		if (listeners == null) {
			listeners = new ChangeListenerCollection();
		}
		listeners.add(listener);
	}
}
