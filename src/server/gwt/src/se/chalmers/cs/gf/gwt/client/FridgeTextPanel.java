package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.ChangeListenerCollection;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.Widget;

public class FridgeTextPanel extends Composite {

	private MagnetFactory magnetFactory;

	private FlowPanel mainPanel;

	private ChangeListenerCollection listeners = null;

	public FridgeTextPanel (MagnetFactory magnetFactory) { 
		this.magnetFactory = magnetFactory;
		mainPanel = new FlowPanel();
		FlowPanel wrapper = new FlowPanel();
		wrapper.add(createMinHeightProp());
		wrapper.add(mainPanel);
		wrapper.add(createFloatClearer());
		initWidget(wrapper);
		setStylePrimaryName("my-FridgeTextPanel");
	}
	
	private Widget createMinHeightProp() {
		Widget prop = new FlowPanel();
		prop.setStylePrimaryName("prop");
		return prop;
	}
	
	private Widget createFloatClearer() {
		Widget clear = new FlowPanel();
		clear.setStylePrimaryName("clear");
		return clear;
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
			if (w instanceof Magnet) {
				String word = ((Magnet)w).getText();	
				if (sb.length() > 0) {
					sb.append(' ');
				}
				sb.append(word);
			}
		}
		return sb.toString();
	}

	public void setText (String text, String language) {
		if (!text.equals(getText())) {
			mainPanel.clear();
			for (String word : text.split("\\s+")) {
				if (word.length() > 0) {
					mainPanel.add(magnetFactory.createUsedMagnet(word, language));
				}
			}
			fireChange();
		}
	}
	
	public void clear () {
		mainPanel.clear();
		fireChange();
	}

	public void addMagnet (Magnet magnet) {
		mainPanel.add(magnetFactory.createUsedMagnet(magnet));
		fireChange();
	}

	public void deleteLast() {
		int c = mainPanel.getWidgetCount();
		if (c > 0) {
			mainPanel.remove(c-1);
			fireChange();
		}
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
