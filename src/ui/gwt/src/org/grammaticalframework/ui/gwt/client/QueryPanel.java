package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.http.client.*;
import com.google.gwt.user.client.ui.*;

public class QueryPanel extends Composite {

	private PGFWrapper pgf;
	private StatusPopup statusPopup;
	private TextArea queryBox;
	private VerticalPanel outputPanel;
	private JSONRequest executeRequest = null;

	public QueryPanel(PGFWrapper pgf, StatusPopup statusPopup) {
		this.pgf = pgf;
		this.statusPopup = statusPopup;

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(createQueryPanel());

		initWidget(vPanel);
		setStylePrimaryName("my-QueryPanel");

		pgf.addSettingsListener(new MySettingsListener());
	}

	protected Widget createQueryPanel() {
		queryBox = new TextArea();
		queryBox.setStylePrimaryName("my-QueryBox");
		queryBox.setTitle("Goal category");

		HorizontalPanel boxPanel = new HorizontalPanel();
		boxPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
		boxPanel.setSpacing(5);
		
		final TextBox limitBox = new TextBox();
		limitBox.setTitle("Upper limit of the number of examples generated");
		limitBox.setWidth("5em");
		limitBox.setText("10");
		boxPanel.add(new Label("limit:"));
		boxPanel.add(limitBox);

		boxPanel.add(new HTML(""));

		final TextBox depthBox = new TextBox();
		depthBox.setTitle("Maximal depth for every example");
		depthBox.setWidth("5em");
		depthBox.setText("4");
		boxPanel.add(new Label("depth:"));
		boxPanel.add(depthBox);
		
		boxPanel.add(new HTML(""));

		final CheckBox randomBox = new CheckBox();
		randomBox.setTitle("random/exhaustive generation");
		randomBox.setText("random");
		boxPanel.add(randomBox);

		outputPanel = new VerticalPanel();
		outputPanel.addStyleName("my-translations");
		outputPanel.addStyleDependentName("working");

		Button execButton = new Button("Execute");

		DecoratorPanel queryDecorator = new DecoratorPanel();
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(new Label("Query"));
		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.add(queryBox);
		hPanel.add(execButton);
		vPanel.add(hPanel);
		vPanel.add(boxPanel);
		queryDecorator.add(vPanel);

		VerticalPanel queryPanel = new VerticalPanel();
		queryPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		queryPanel.add(queryDecorator);
		queryPanel.add(outputPanel);
		
		execButton.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				if (executeRequest != null) {
					executeRequest.cancel();
				}
		
				PGF.GenerationCallback callback = new PGF.GenerationCallback() {
					public void onResult(IterableJsArray<PGF.Linearizations> result) {
						executeRequest = null;
						
						outputPanel.clear();
						outputPanel.removeStyleDependentName("working");

						for (PGF.Linearizations lins : result.iterable()) {
							LinearizationsPanel lin = new LinearizationsPanel(pgf, lins);
							lin.setWidth("100%");
							outputPanel.add(lin);
						}
					}

					public void onError(Throwable e) {
						executeRequest = null;
						statusPopup.showError("The execution failed", e);
					}
				};
			
				int depth, limit;
				try {
					depth = Integer.parseInt(depthBox.getText());
					limit = Integer.parseInt(limitBox.getText());
				} catch (NumberFormatException e) {
					statusPopup.showError("Invalid depth/limit parameter", e);
					return;
				}

				if (randomBox.getValue())
					executeRequest = pgf.generateRandom(queryBox.getText(), depth, limit, callback);
				else
					executeRequest = pgf.generateAll(queryBox.getText(), depth, limit, callback);
			}
		});
		
		return queryPanel;
	}

	protected class MySettingsListener implements PGFWrapper.SettingsListener {

		public MySettingsListener() {
		}

		public void onAvailableGrammarsChanged() { }

		public void onSelectedGrammarChanged() {
			queryBox.setText("");
			outputPanel.clear();
		}

		public void onInputLanguageChanged() { }
		public void onOutputLanguageChanged() {	}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}
}
