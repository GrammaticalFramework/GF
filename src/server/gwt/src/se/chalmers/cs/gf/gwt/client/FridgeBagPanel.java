package se.chalmers.cs.gf.gwt.client;

import java.util.LinkedHashSet;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;

public class FridgeBagPanel extends Composite {

	private PGFWrapper pgf;

	private MagnetFactory magnetFactory;

	private JSONRequest completeRequest = null;

	private FlowPanel prefixPanel;

	private FlowPanel mainPanel; 

	private int maxMagnets = 100;

	private LinkedHashSet<String> prefixes = new LinkedHashSet<String>();


	public FridgeBagPanel (PGFWrapper pgf, MagnetFactory magnetFactory) {
		this.pgf = pgf;
		this.magnetFactory = magnetFactory;
		prefixPanel = new FlowPanel();
		mainPanel = new FlowPanel();
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(prefixPanel);
		vPanel.add(mainPanel);
		initWidget(vPanel);
		setStylePrimaryName("my-FridgeBagPanel");
	}

	public void updateBag (String text) {
		updateBag(text, "");
	}

	public void updateBag (final String text, String prefix) {
		if (completeRequest != null) {
			completeRequest.cancel();
		}
		final boolean updatePrefixes = prefix.equals("");
		mainPanel.clear();
		if (updatePrefixes) { clearPrefixes(); }
	    int limit = updatePrefixes ? 0 : maxMagnets; 
		completeRequest = pgf.complete(text + " " + prefix, 
				limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				for (PGF.Completion completion : completions.iterable()) {
					String newText = completion.getText();
					if (!newText.equals(text + " ")) {
						String[] words = newText.split("\\s+");
						if (words.length > 0) {
							String word = words[words.length - 1];
							if (word.length() > 0) {
								if (updatePrefixes) {
									addPrefix(text, word.substring(0,1));
								}
								if (mainPanel.getWidgetCount() < maxMagnets) {
									Magnet magnet = magnetFactory.createMagnet(word, completion.getFrom());
									mainPanel.add(magnet);
								} else {
									prefixPanel.setVisible(true);
								}
							}
						}
					}
				}
			}
			public void onError(Throwable e) {
				// FIXME: show message to user?
				GWT.log("Error getting completions.", e); 
			}
		});
	}

	protected void clearPrefixes () {
		prefixes.clear();
		prefixPanel.clear();
		prefixPanel.setVisible(false);
	}

	protected void addPrefix(final String text, final String prefix) {
		if (prefixes.add(prefix)) {
			Button prefixButton = new Button(prefix, new ClickListener() {		
				public void onClick(Widget sender) {
					updateBag(text, prefix);
				}
			});
			prefixPanel.add(prefixButton);
		}
	}


	/*
	public void cloneMagnet (Magnet magnet) {
		int i = getWidgetIndex(magnet);
		GWT.log("cloneMagnet: " + magnet.getParent(), null);
		if (i != -1) {
			GWT.log("cloning", null);
			insert(magnetFactory.createMagnet(magnet), i);
		}
	}
	 */

}
