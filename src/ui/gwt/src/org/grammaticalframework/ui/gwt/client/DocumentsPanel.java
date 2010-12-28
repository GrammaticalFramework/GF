package org.grammaticalframework.ui.gwt.client;

import java.util.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.http.client.*;
import com.google.gwt.xml.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.shared.*;

public class DocumentsPanel extends Composite implements HasSelectionHandlers<Object> {

	private PGFWrapper pgf;
	private ContentService contentService;
	private StatusPopup statusPopup;
	private FlexTable table;
	private ArrayList documentIds = new ArrayList();

	public DocumentsPanel(PGFWrapper pgf, ContentService contentService, StatusPopup statusPopup) {
		this.pgf = pgf;
		this.contentService = contentService;
		this.statusPopup = statusPopup;

		VerticalPanel documentsPanel = new VerticalPanel();
		documentsPanel.setStylePrimaryName("my-DocumentsFrame");

		HorizontalPanel searchPanel = new HorizontalPanel();
		searchPanel.setStylePrimaryName("my-DocumentsSearchFrame");
		final TextBox searchBox = new TextBox();
		searchBox.setWidth("20em");
		final Button  searchBtn = new Button("Search");
		searchPanel.add(searchBox);
		searchPanel.add(searchBtn);
		documentsPanel.add(searchPanel);

		Image deleteButton = new Image("org.grammaticalframework.ui.gwt.EditorApp/trash-button.png");
		deleteButton.setTitle("Deletes the selected documents.");
		deleteButton.setStylePrimaryName("toolbar-button");
		deleteButton.addClickListener(new ClickListener () {
			public void onClick(Widget sender) {
				deleteSelected();
			}
		});

		FlexTable header = new FlexTable();
		header.setStylePrimaryName("my-TableHeader");
		header.setText(0,0,"Documents");
		header.setWidget(0,1,deleteButton);
		header.getColumnFormatter().setWidth(1,"20px");
		documentsPanel.add(header);
		
		table = new FlexTable();
		table.setCellPadding(2);
		table.setStylePrimaryName("my-DocumentsTable");
		table.getColumnFormatter().setWidth(1,"80em");
		table.getColumnFormatter().setWidth(2,"80em");
		documentsPanel.add(table);
		
		searchBtn.addClickHandler(new ClickHandler() {
			public void onClick(ClickEvent event) {
				searchDocuments(searchBox.getText());
			}
		});
		table.addClickHandler(new ClickHandler() {
			public void onClick(ClickEvent event) {
				HTMLTable.Cell cell = table.getCellForEvent(event);
				if (cell != null) {
					int row = cell.getRowIndex();
					selectDocument(row);
				}
			}
		});

		initWidget(documentsPanel);
		setStylePrimaryName("my-DocumentsPanel");
	}

	public HandlerRegistration addSelectionHandler(SelectionHandler<Object> handler) {
		return addHandler(handler, SelectionEvent.getType());
	}
		
	protected void selectDocument(int row) {
		SelectionEvent.fire(this, documentIds.get(row));
	}
	
	protected void searchDocuments(String fullTextQuery) {
		statusPopup.setStatus("Searching...");
		
		documentIds.clear();
		while (table.getRowCount() > 0)
			table.removeRow(0);
		
		contentService.search(fullTextQuery, new ContentService.SearchCallback() {
			public void onResult(IterableJsArray<ContentService.DocumentSignature> documents) {
				for (ContentService.DocumentSignature sign : documents.iterable()) {
					int row = table.getRowCount();
					table.setWidget(row, 0, new CheckBox(sign.getTitle()));
					table.setText(row, 1, sign.getCreated());
					table.setText(row, 2, sign.getModified());
					table.getRowFormatter().addStyleName(row, "row");
					documentIds.add(sign.getId());
				}
				
				statusPopup.clearStatus();
			}

			public void onError(Throwable e) {
				statusPopup.showError("Search failed", e);
			}
		});
	}
	
	protected void deleteSelected() {
		statusPopup.setStatus("Deleting...");
		
		final ArrayList ids  = new ArrayList();
		final ArrayList<Integer> rows = new ArrayList<Integer>();
		for (int row = 0; row < table.getRowCount(); row++) {
			CheckBox checkBox = (CheckBox) table.getWidget(row,0);
			if (checkBox.isChecked()) {
				ids.add(documentIds.get(row));
				rows.add(new Integer(row));
			}
		}
		
		contentService.delete(ids, new ContentService.DeleteCallback() {
			public void onResult(ContentService.DeleteResult result) {
				for (Integer row : rows) {
					table.removeRow(row.intValue());
				}
				
				statusPopup.clearStatus();
			}

			public void onError(Throwable e) {
				statusPopup.showError("Delete failed", e);
			}
		});
		
	}
}
