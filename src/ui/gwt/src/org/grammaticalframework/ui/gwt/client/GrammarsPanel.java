package org.grammaticalframework.ui.gwt.client;

import java.util.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.http.client.*;
import com.google.gwt.xml.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.shared.*;

public class GrammarsPanel extends Composite {

	private PGFWrapper pgf;
	private ContentService contentService;
	private StatusPopup statusPopup;
	private FlexTable table;
	private ArrayList documentIds = new ArrayList();

	public GrammarsPanel(PGFWrapper pgf, ContentService contentService, StatusPopup statusPopup) {
		this.pgf = pgf;
		this.contentService = contentService;
		this.statusPopup = statusPopup;

		HorizontalPanel grammarsPanel = new HorizontalPanel();

		UploadFormHandler uploadFormHandler = new UploadFormHandler();
		
		final FormPanel form = new FormPanel();
		form.setEncoding(FormPanel.ENCODING_MULTIPART);
		form.setMethod(FormPanel.METHOD_POST);
		form.setAction(contentService.getBaseURL());
		form.addSubmitHandler(uploadFormHandler);
		form.addSubmitCompleteHandler(uploadFormHandler);
		grammarsPanel.add(form);

		HorizontalPanel hPanel = new HorizontalPanel();
		hPanel.setSpacing(8);
		form.add(hPanel);

		VerticalPanel vPanel = new VerticalPanel();
		hPanel.add(vPanel);

		vPanel.add(new HTML("<input type=\"hidden\" name=\"command\" value=\"update_grammar\"/>"));
		
		FileUpload fileUpload = new FileUpload();
		fileUpload.setName("file");
		vPanel.add(fileUpload);

		vPanel.add(new HTML("<BR/>"));
		
		vPanel.add(new Label("Name:"));
		TextBox grammarName = new TextBox();
		grammarName.setName("name");
		grammarName.setWidth("100%");
		vPanel.add(grammarName);
		
		vPanel.add(new HTML("<BR/>"));
		
		vPanel.add(new Label("Description:"));
		TextArea grammarDescr = new TextArea();
		grammarDescr.setName("description");
		grammarDescr.setWidth("100%");
		grammarDescr.setHeight("150px");
		vPanel.add(grammarDescr);
		
		VerticalPanel btnPanel = new VerticalPanel();
		btnPanel.setSpacing(3);
		hPanel.add(btnPanel);
		
		btnPanel.add(new Button("Upload", new ClickListener() {
			public void onClick(Widget sender) {
				form.submit();
			}
		}));
		btnPanel.add(new Button("Cancel", new ClickListener() {
			public void onClick(Widget sender) {
			}
		}));
		
		initWidget(grammarsPanel);
		setStylePrimaryName("my-GrammarsPanel");
	}

	private class UploadFormHandler implements FormPanel.SubmitHandler, FormPanel.SubmitCompleteHandler {
		public void onSubmit(FormPanel.SubmitEvent event) {
		}
		
		public void onSubmitComplete(FormPanel.SubmitCompleteEvent event) {
		}
	};
}
