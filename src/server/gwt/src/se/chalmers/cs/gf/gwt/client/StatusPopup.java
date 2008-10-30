package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.PopupPanel;

public class StatusPopup extends PopupPanel {

	private Label label = new Label();

	public StatusPopup () {
		super(true, true);
		label = new Label();
		add(label);
	}

	public void setStatus(String msg) {
		removeStyleDependentName("error");
		label.setText(msg);
		center();
	}

	public void showError(String msg, Throwable e) {
		GWT.log(msg, e);
		addStyleDependentName("error");
		label.setText(msg);
		center();
	}

	public void clearStatus() {
		removeStyleDependentName("error");
		label.setText("");
		hide();
	}

}
