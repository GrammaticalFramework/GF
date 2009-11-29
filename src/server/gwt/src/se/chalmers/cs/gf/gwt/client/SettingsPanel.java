package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.ChangeListener;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Widget;

public class SettingsPanel extends Composite {

	private PGFWrapper pgf;

	private MyListBox grammarBox;
	private MyListBox fromLangBox;
	private MyListBox toLangBox;

	public SettingsPanel (PGFWrapper pgf) {
		this(pgf, true, true);
	}

	public SettingsPanel (PGFWrapper pgf, boolean showPGFName, boolean showOutputLanguage) {
		this.pgf = pgf;
		
		HorizontalPanel settingsPanel = new HorizontalPanel();
		settingsPanel.setHorizontalAlignment(HorizontalPanel.ALIGN_CENTER);
		settingsPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);

		if (showPGFName) {
			grammarBox = new MyListBox();
			grammarBox.addChangeListener(new ChangeListener() {
				public void onChange(Widget sender) {
					SettingsPanel.this.pgf.setPGFName(grammarBox.getSelectedValue());
				}
			});			
			settingsPanel.add(new FormWidget("Grammar:", grammarBox));
		}

		fromLangBox = new MyListBox();
		fromLangBox.addChangeListener(new ChangeListener() {
			public void onChange(Widget sender) {
				SettingsPanel.this.pgf.setInputLanguage(fromLangBox.getSelectedValue());
			}
		});
		settingsPanel.add(new FormWidget("From:", fromLangBox));

		if (showOutputLanguage) {
			toLangBox = new MyListBox();
			toLangBox.addChangeListener(new ChangeListener() {
				public void onChange(Widget sender) {
					SettingsPanel.this.pgf.setOutputLanguage(toLangBox.getSelectedValue());
				}
			});
			settingsPanel.add(new FormWidget("To:", toLangBox));
		}

		initWidget(settingsPanel);
		setStylePrimaryName("my-SettingsPanel");

		pgf.addSettingsListener(new MySettingsListener());
	}

	private static class FormWidget extends HorizontalPanel {
		public FormWidget(String label, Widget w) {
			setStylePrimaryName(".my-FormWidget");
			setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
			add(new Label(label));
			add(w);
		}
	}
	
	private class MySettingsListener implements PGFWrapper.SettingsListener {
		public void onAvailableGrammarsChanged() {
			if (grammarBox != null) {
				grammarBox.clear();
				grammarBox.addItems(pgf.getGrammars());
			}
		}
		public void onSelectedGrammarChanged() {
			if (grammarBox != null) {
				grammarBox.setSelectedValue(pgf.getPGFName());
			}
			if (fromLangBox != null) {
				fromLangBox.clear();
				fromLangBox.addItem("Any language", "");
				fromLangBox.addItems(pgf.getParseableLanguages());
				String inputLanguage = pgf.getInputLanguage();
				if (inputLanguage != null) {
					fromLangBox.setSelectedValue(inputLanguage);
				}
			}
			if (toLangBox != null) {
				toLangBox.clear();
				toLangBox.addItem("All languages", "");		
				toLangBox.addItems(pgf.getAllLanguages());
				String outputLanguage = pgf.getOutputLanguage();
				if (outputLanguage != null) {
					fromLangBox.setSelectedValue(outputLanguage);
				}
			}
		}
		public void onInputLanguageChanged() {
			if (fromLangBox != null) {
				fromLangBox.setSelectedValue(pgf.getInputLanguage());
			}
		}
		public void onOutputLanguageChanged() {
			if (toLangBox != null) {
				toLangBox.setSelectedValue(pgf.getOutputLanguage());
			}
		}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}

}
