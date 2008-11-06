package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.FlowPanel;

public class FridgeBagPanel extends Composite {

	private PGFWrapper pgf;

	private MagnetFactory magnetFactory;
	
	private FlowPanel mainPanel;

	public FridgeBagPanel (PGFWrapper pgf, MagnetFactory magnetFactory) {
		this.pgf = pgf;
		this.magnetFactory = magnetFactory;
		mainPanel = new FlowPanel();
		initWidget(mainPanel);
		setStylePrimaryName("my-FridgeBagPanel");
	}

	public void updateBag (String text) {
		updateBag(text, "");
	}

	public void updateBag (String text, String prefix) {
		mainPanel.clear();
		int limit = 100;
		pgf.complete(text + " " + prefix, 
				limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				mainPanel.clear();
				for (PGF.Completion completion : completions.iterable()) {
					String text = completion.getText();
					if (!completion.getText().equals(text + " ")) {
						String[] words = text.split("\\s+");
						if (words.length > 0) {
							String word = words[words.length - 1];
							Magnet magnet = magnetFactory.createMagnet(word);
							mainPanel.add(magnet);
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

}
