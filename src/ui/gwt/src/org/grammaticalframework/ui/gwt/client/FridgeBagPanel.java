package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.*;

public class FridgeBagPanel extends Composite implements Iterable<Magnet> {

	private FlowPanel mainPanel;

	public FridgeBagPanel () {
		mainPanel = new FlowPanel();

		initWidget(new ScrollPanel(mainPanel));
		setStylePrimaryName("my-FridgeBagPanel");
		addStyleDependentName("empty");
	}

	public void clear() {
		mainPanel.clear();
	}

	public void fill(List<Magnet> magnets) {
		for (Magnet magnet : magnets) {
			mainPanel.add(magnet);
		}

		if (mainPanel.getWidgetCount() == 0)
			addStyleDependentName("empty");
		else
			removeStyleDependentName("empty");
	}

	public Iterator<Magnet> iterator() {
		return (Iterator<Magnet>) (Iterator) mainPanel.iterator();
	}
}
