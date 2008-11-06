package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.FlowPanel;

public class FridgeBagPanel extends FlowPanel {

	private PGFWrapper pgf;

	private MagnetFactory magnetFactory;
	
	protected JSONRequest completeRequest = null;

	public FridgeBagPanel (PGFWrapper pgf, MagnetFactory magnetFactory) {
		this.pgf = pgf;
		this.magnetFactory = magnetFactory;
		setStylePrimaryName("my-FridgeBagPanel");
	}

	public void updateBag (String text) {
		updateBag(text, "");
	}

	public void updateBag (final String text, String prefix) {
		clear();
		int limit = 100;
		if (completeRequest != null) {
			completeRequest.cancel();
		}
		completeRequest = pgf.complete(text + " " + prefix, 
				limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				clear();
				for (PGF.Completion completion : completions.iterable()) {					
					String newText = completion.getText();
					if (!newText.equals(text + " ")) {
						String[] words = newText.split("\\s+");
						if (words.length > 0) {
							String word = words[words.length - 1];
							Magnet magnet = magnetFactory.createMagnet(word, completion.getFrom());
							add(magnet);
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
