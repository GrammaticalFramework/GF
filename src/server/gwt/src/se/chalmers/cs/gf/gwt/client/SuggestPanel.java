package se.chalmers.cs.gf.gwt.client;

import java.util.LinkedList;
import java.util.List;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.DockPanel;
import com.google.gwt.user.client.ui.HasVerticalAlignment;
import com.google.gwt.user.client.ui.KeyboardListenerAdapter;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.Widget;

public class SuggestPanel extends Composite {

	private CompletionOracle oracle;
	private SuggestBox suggest;
	private Button submitButton;

	private List<SubmitListener> listeners = new LinkedList<SubmitListener>();

	public SuggestPanel (PGF pgf) {

		oracle = new CompletionOracle(pgf, new CompletionOracle.ErrorHandler() {
			public void onError(Throwable e) {
				GWT.log("Completion failed", e);
			}
		});

		suggest = new SuggestBox(oracle);
		suggest.setLimit(10);
		suggest.addKeyboardListener(new KeyboardListenerAdapter() {
			public void onKeyUp (Widget sender, char keyCode, int modifiers) {
				if (keyCode == KEY_ENTER) {
					submit();
				}
			}
		});

		submitButton = new Button("Submit");
		submitButton.setEnabled(false);
		submitButton.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				submit();
			}
		});

		DockPanel mainPanel = new DockPanel();
		mainPanel.setVerticalAlignment(HasVerticalAlignment.ALIGN_MIDDLE);
		mainPanel.add(suggest, DockPanel.CENTER);
		mainPanel.add(submitButton, DockPanel.EAST);

		initWidget(mainPanel);
		setStylePrimaryName("my-SuggestPanel");

	}

	public int getLimit() {
		return suggest.getLimit();
	}

	public String getText() {
		return suggest.getText();
	}

	public String getTitle() {
		return suggest.getTitle();
	}

	public void onLoad() {
		suggest.setFocus(true);
	}

	public void setButtonText (String text) {
		submitButton.setText(text);
	}

	public void setEnabled(boolean enabled) {
		submitButton.setEnabled(enabled);
	}

	public void setGrammarName(String pgfName) {
		oracle.setGrammarName(pgfName);
	}

	public void setInputLanguage(String inputLang) {
		oracle.setInputLanguage(inputLang);
	}

	public void setLimit(int limit) {
		suggest.setLimit(limit);
	}

	public void setText (String text) {
		suggest.setText(text);
	}

	public void setTitle(String title) {
		suggest.setTitle(title);
	}

	public void addSubmitListener(SubmitListener listener) {
		listeners.add(listener);
	}

	public void submit() {
		String text = getText();
		for (SubmitListener listener : listeners) {
			listener.onSubmit(text);
		}
	}

	public interface SubmitListener {
		public void onSubmit(String text);
	}

}
