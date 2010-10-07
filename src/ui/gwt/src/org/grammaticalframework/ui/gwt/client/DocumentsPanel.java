package org.grammaticalframework.ui.gwt.client;

import java.util.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.http.client.*;
import com.google.gwt.xml.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.dom.client.*;

public class DocumentsPanel extends Composite {

	private PGFWrapper pgf;
	private FlexTable table;

	public DocumentsPanel(PGFWrapper pgf) {
		this.pgf = pgf;

		VerticalPanel documentsPanel = new VerticalPanel();
		documentsPanel.setStylePrimaryName("my-DocumentsFrame");

		HorizontalPanel searchPanel = new HorizontalPanel();
		searchPanel.setStylePrimaryName("my-DocumentsSearchFrame");
		TextBox searchBox = new TextBox();
		searchBox.setWidth("20em");
		Button  searchBtn = new Button("Search");
		searchPanel.add(searchBox);
		searchPanel.add(searchBtn);
		documentsPanel.add(searchPanel);
		
		Label header = new Label("Documents");
		header.setStylePrimaryName("my-DocumentsHeader");
		documentsPanel.add(header);
		
		table = new FlexTable();
		table.setStylePrimaryName("my-DocumentsTable");
		documentsPanel.add(table);

		addRow(0, "Test0");
		addRow(1, "Test1");
		addRow(2, "Test2");
		addRow(3, "Test3");
		
		table.addClickHandler(new ClickHandler() {
			public void onClick(ClickEvent event) {
				HTMLTable.Cell cell = table.getCellForEvent(event);
				if (cell != null) {
					int row = cell.getRowIndex();
					selectRow(row);
				}
			}
		});

		initWidget(documentsPanel);
		setStylePrimaryName("my-DocumentsPanel");
	}
	
	private void addRow(int row, String text) {
		table.setText(row, 0, text);
		table.getRowFormatter().addStyleName(row, "row");
	}
	
	private void selectRow(int row) {
	}	
}
