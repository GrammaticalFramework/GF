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
	
	private VerticalPanel grammarsPanel;
	private FormPanel form = null;

	public GrammarsPanel(PGFWrapper pgf, ContentService contentService, StatusPopup statusPopup) {
		this.pgf = pgf;
		this.contentService = contentService;
		this.statusPopup = statusPopup;

		VerticalPanel vpanel = new VerticalPanel();
		
		Button btnNew = new Button("New Grammar");
		btnNew.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				if (form == null) {
					grammarsPanel.insert(new GrammarInfoPanel(null),0);
				}
			}
		});
		vpanel.add(btnNew);
		
		grammarsPanel = new VerticalPanel();
		grammarsPanel.setWidth("100%");
		vpanel.add(grammarsPanel);

		initWidget(vpanel);
		setStylePrimaryName("my-GrammarsPanel");
		
		contentService.addSettingsListener(new MySettingsListener());
	}

	private class GrammarInfoPanel extends Composite {
		public GrammarInfoPanel(final ContentService.GrammarInfo grammar) {
			final VerticalPanel vpanel = new VerticalPanel();
			
			if (grammar != null) {
				FlexTable header = new FlexTable();
				header.setStylePrimaryName("my-TableHeader");
				header.setText(0,0,grammar.getName());
				vpanel.add(header);

				final Image updateButton = new Image("org.grammaticalframework.ui.gwt.EditorApp/grammar-buttons.png",0,0,20,20);
				updateButton.setTitle("Edit the grammar definition.");
				updateButton.setStylePrimaryName("toolbar-button");
				header.setWidget(0,1,updateButton);
				header.getColumnFormatter().setWidth(1,"20px");
				
				final Image deleteButton = new Image("org.grammaticalframework.ui.gwt.EditorApp/grammar-buttons.png",20,0,20,20);
				deleteButton.setTitle("Delete this grammar.");
				deleteButton.setStylePrimaryName("toolbar-button");
				header.setWidget(0,2,deleteButton);
				header.getColumnFormatter().setWidth(2,"20px");

				final Label descr = new Label(grammar.getDescription());
				descr.setStylePrimaryName("descr-label");
				vpanel.add(descr);
				
				updateButton.addClickListener(new ClickListener () {
					public void onClick(Widget sender) {
						if (form == null) {
							vpanel.remove(descr);
							vpanel.add(form = createUploadForm(grammar));
						}
					}
				});
				
				deleteButton.addClickListener(new ClickListener () {
					public void onClick(Widget sender) {
						contentService.deleteGrammar(grammar.getURL(), new ContentService.DeleteCallback() {
							public void onResult(ContentService.DeleteResult result) {
								contentService.updateAvailableGrammars();
							}

							public void onError(Throwable e) {
								statusPopup.showError("Delete failed", e);
							}
						});
					}
				});
			} else {
				FlexTable header = new FlexTable();
				header.setStylePrimaryName("my-TableHeader");
				header.setText(0,0,"Add New Grammar");
				vpanel.add(header);
				vpanel.add(form = createUploadForm(grammar));
			}
			
			initWidget(vpanel);
			setStylePrimaryName("my-GrammarInfoPanel");
		}

		public FormPanel createUploadForm(final ContentService.GrammarInfo grammar) {
			UploadFormHandler uploadFormHandler = new UploadFormHandler();
			
			final FormPanel form = new FormPanel();
			form.setWidth("100%");
			form.setEncoding(FormPanel.ENCODING_MULTIPART);
			form.setMethod(FormPanel.METHOD_POST);
			form.setAction(contentService.getBaseURL());
			form.addSubmitHandler(uploadFormHandler);
			form.addSubmitCompleteHandler(uploadFormHandler);

			VerticalPanel vPanel = new VerticalPanel();
			vPanel.setWidth("100%");
			form.add(vPanel);

			vPanel.add(new HTML("<input type=\"hidden\" name=\"command\" value=\"update_grammar\"/>"));
		
			HorizontalPanel hPanel = new HorizontalPanel();
			hPanel.setSpacing(8);
			hPanel.setVerticalAlignment(HorizontalPanel.ALIGN_MIDDLE);
			vPanel.add(hPanel);

			final FileUpload fileUpload = new FileUpload();
			fileUpload.setName("file");
			hPanel.add(fileUpload);
			
			hPanel.add(new HTML("&nbsp;"));

			hPanel.add(new Label("Name:"));
			final TextBox grammarName = new TextBox();
			grammarName.setName("name");
			grammarName.setWidth("300px");
			hPanel.add(grammarName);
			
			hPanel.add(new HTML("&nbsp;"));

			hPanel.add(new Button("Upload", new ClickListener() {
				public void onClick(Widget sender) {
					if (grammar == null &&
					    fileUpload.getFilename().equals(""))
						statusPopup.showError("You must select a file to upload", null);
					else
						form.submit();
				}
			}));
			hPanel.add(new Button("Cancel", new ClickListener() {
				public void onClick(Widget sender) {
					contentService.updateAvailableGrammars();
				}
			}));

			vPanel.add(new Label("Description:"));
			TextArea grammarDescr = new TextArea();
			grammarDescr.setName("description");
			grammarDescr.setWidth("100%");
			grammarDescr.setHeight("50px");
			vPanel.add(grammarDescr);

			if (grammar != null) {
				grammarName.setText(grammar.getName());
				grammarDescr.setText(grammar.getDescription());
				
				vPanel.add(new HTML("<input type=\"hidden\" name=\"url\" value=\""+grammar.getURL()+"\"/>"));
			}

			return form;
		}

		private class UploadFormHandler implements FormPanel.SubmitHandler, FormPanel.SubmitCompleteHandler {
			public void onSubmit(FormPanel.SubmitEvent event) {
			}
		
			public void onSubmitComplete(FormPanel.SubmitCompleteEvent event) {
				contentService.updateAvailableGrammars();
			}
		}
	}
	
	private class MySettingsListener implements SettingsListener {
		public void onAvailableGrammarsChanged() {
			form = null;
			grammarsPanel.clear();
			for (ContentService.GrammarInfo grammar : contentService.getGrammars()) {
				grammarsPanel.add(new GrammarInfoPanel(grammar));
			}
		}
		public void onSelectedGrammarChanged() { }
		public void onInputLanguageChanged() { }
		public void onOutputLanguageChanged() {	}
		public void onStartCategoryChanged() { }
		public void onSettingsError(String msg, Throwable e) { }
	}
}
