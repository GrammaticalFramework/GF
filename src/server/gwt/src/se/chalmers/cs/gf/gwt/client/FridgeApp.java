package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.HasText;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Hyperlink;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;


public class FridgeApp extends TranslateApp {

	private FlowPanel bagPanel;

	//
	// Text
	//

	protected void update () {
		updateBag();
		translate();
	}

	//
	// Translation
	//

	protected Widget createTranslation(String language, String text) {
		Hyperlink l = new Hyperlink(text, makeToken(language, text));
		l.addStyleName("my-translation");
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			l.getElement().setLang(lang);
		}
		return l;
	}

	//
	// Available words
	//

	private String makeToken (String language, String text) {
		return pgf.getPGFName() + "/" + language + "/" + text;
	}

	private void updateBag () {
		updateBag("");
	}

	private void updateBag (String prefix) {
		int limit = 100;
		pgf.complete(getText() + " " + prefix, 
				limit, new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				bagPanel.clear();
				for (PGF.Completion completion : completions.iterable()) {
					String text = completion.getText();
					if (!completion.getText().equals(getText() + " ")) {
						String[] words = text.split("\\s+");
						String word = (words.length > 0) ? words[words.length - 1] : "";
						String token = makeToken(completion.getFrom(), text);
						Hyperlink magnet = new Hyperlink(word, token);
						magnet.addStyleName("my-Magnet");
						bagPanel.add(magnet);
					}
				}
				if (bagPanel.getWidgetCount() == 0) {
					bagPanel.add(new Label("<empty>"));
				}
			}
			public void onError(Throwable e) {
				showError("Error getting completions.", e);
			}
		});
	}

	//
	// Current text
	//

	private class TextPanel extends FlowPanel implements HasText {

		public TextPanel () { }

		public String getText () {
			StringBuilder sb = new StringBuilder();
			for (Widget w : this) {
				String word = ((UsedMagnet)w).getText();	
				if (sb.length() > 0) {
					sb.append(' ');
				}
				sb.append(word);			
			}
			return sb.toString();
		}

		public void setText (String text) {
			String inputLanguage = pgf.getInputLanguage();
			clear();
			for (String word : text.split("\\s+")) {
				if (word.length() > 0) {
					add(new UsedMagnet(inputLanguage, word));
				}
			}
		}

	}

	private void clear() {
		setText("");
	}

	//
	// History stuff
	//

	protected void updateSettingsFromHistoryToken(String[] tokenParts) {
		super.updateSettingsFromHistoryToken(tokenParts);
		if (tokenParts.length >= 3 && tokenParts[2].length() > 0) {
			textSource.setText(tokenParts[2]);
			update();
		}
	}

	//
	// GUI
	//

	protected Widget createTranslationUI() {
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.setWidth("100%");
		vPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		vPanel.add(createTextPanel());
		vPanel.add(createButtonPanel());
		vPanel.add(createBagPanel());
		vPanel.add(createSettingsPanel());
		vPanel.add(createTranslationsPanel());
		return vPanel;
	}

	protected Widget createTextPanel () {
		TextPanel textPanel = new TextPanel();		
		textPanel.setStylePrimaryName("my-TextPanel");

		textSource = textPanel;

		return textPanel;
	}

	protected Widget createButtonPanel () {
		Panel buttons = new HorizontalPanel();
		buttons.add(new Button("Clear", new ClickListener () {
			public void onClick(Widget sender) {
				clear();
			}
		}));
		return buttons;
	}

	protected Widget createBagPanel () {
		bagPanel = new FlowPanel();
		bagPanel.setStylePrimaryName("my-BagPanel");
		return bagPanel;
	}

	//
	// Initialization
	//

	public void onModuleLoad() {
		super.onModuleLoad();
	}

}
