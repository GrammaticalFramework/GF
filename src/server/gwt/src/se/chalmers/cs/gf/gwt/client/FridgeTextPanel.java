package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.*;

public class FridgeTextPanel extends Composite {

	private MagnetFactory magnetFactory;

	private FlowPanel mainPanel;

	private ChangeListenerCollection listeners = null;

	public FridgeTextPanel (MagnetFactory magnetFactory) { 
		this.magnetFactory = magnetFactory;
		mainPanel = new FlowPanel();
		mainPanel.setStylePrimaryName("magnets");
		DockPanel wrapper = new DockPanel();		
		wrapper.add(mainPanel, DockPanel.CENTER);
		Widget buttons = createButtonPanel();
		wrapper.add(buttons, DockPanel.EAST);
		wrapper.setCellWidth(mainPanel, "100%");
		wrapper.setCellWidth(buttons, "6em");
		wrapper.setHorizontalAlignment(DockPanel.ALIGN_RIGHT);
		initWidget(wrapper);
		setStylePrimaryName("my-FridgeTextPanel");
	}
	

	protected Widget createButtonPanel () {
		Panel buttons = new VerticalPanel();
		buttons.setStylePrimaryName("buttons");
		PushButton deleteLastButton = new PushButton(new Image("se.chalmers.cs.gf.gwt.FridgeApp/delete-last.png"));
		deleteLastButton.setTitle("Removes the last magnet.");
		deleteLastButton.addClickListener(new ClickListener () {
			public void onClick(Widget sender) {
				deleteLast();
			}
		});
		buttons.add(deleteLastButton);
		PushButton clearButton = new PushButton("Clear");
		clearButton.addClickListener(new ClickListener () {
			public void onClick(Widget sender) {
				clear();
			}
		});
		clearButton.setTitle("Removes all magnets.");
		buttons.add(clearButton);
		return buttons;
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
