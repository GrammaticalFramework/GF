package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.http.client.*;
import com.google.gwt.user.client.ui.*;

public class QueryPanel extends Composite {

	private PGFWrapper pgf;

	public QueryPanel(PGFWrapper pgf) {
		this.pgf = pgf;

		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(createQueryPanel());

		initWidget(vPanel);
		setStylePrimaryName("my-QueryPanel");

		pgf.addSettingsListener(new MySettingsListener(pgf));
	}

	protected Widget createQueryPanel() {
		final TextArea queryBox = new TextArea();
		queryBox.setStylePrimaryName("my-QueryBox");
		
		final Grid resultGrid = new Grid(0, 1);
		resultGrid.setStylePrimaryName("my-ResultGrid");
		resultGrid.setBorderWidth(3);
		
		Button execButton = new Button("Execute");
		execButton.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				pgf.query(queryBox.getText(), new PGF.QueryCallback() {
					public void onResult(PGF.QueryResult result) {
						while (resultGrid.getRowCount() > 0) {
							resultGrid.removeRow(resultGrid.getRowCount() - 1);
						}

						ClickListener labelClickListener = new ClickListener() {
							public void onClick(Widget sender) {
								final Label label = (Label) sender;
								pgf.linearize(label.getText(), new PGF.LinearizeCallback() {
					public void onResult(PGF.Linearizations result) {
						final PopupPanel popup = new PopupPanel(true);
						popup.setWidget(new LinearizationsPanel(pgf, label.getText(), result));
						popup.setPopupPosition(label.getAbsoluteLeft(),
							               label.getAbsoluteTop()+label.getOffsetHeight());
						popup.show();
					}

					public void onError(Throwable e) {

					}
				});
							}
						};
						
						int row = 0;
						for (String tree : result.getRows()) {
							Label label = new Label(tree);
							label.addClickListener(labelClickListener);
							resultGrid.insertRow(row);
							resultGrid.setWidget(row, 0, label);
							row++;
						}
					}

					public void onError(Throwable e) {

					}
				});
			}
		});

		DecoratorPanel queryDecorator = new DecoratorPanel();
		VerticalPanel vPanel = new VerticalPanel();
		vPanel.add(new Label("Query"));
		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.add(queryBox);
		hPanel.add(execButton);
		vPanel.add(hPanel);
		queryDecorator.add(vPanel);

		VerticalPanel queryPanel = new VerticalPanel();
		queryPanel.setHorizontalAlignment(VerticalPanel.ALIGN_CENTER);
		queryPanel.add(queryDecorator);
		queryPanel.add(resultGrid);
		
		return queryPanel;
	}

	protected class MySettingsListener implements PGFWrapper.SettingsListener {

		private PGFWrapper pgf;

		public MySettingsListener(PGFWrapper pgf) {
			this.pgf = pgf;
		}

		public void onAvailableGrammarsChanged() { }
		public void onSelectedGrammarChanged() { }
		public void onInputLanguageChanged() { }
		public void onOutputLanguageChanged() {	}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}
}
