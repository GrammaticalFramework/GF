package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.shared.*;

public class LinearizationsPanel extends Composite {

	protected PGFWrapper pgf;
	
	public LinearizationsPanel(PGFWrapper pgf, PGF.Linearizations lins) {
		this.pgf = pgf;
		
		HorizontalPanel hPanel = new HorizontalPanel();
		VerticalPanel linsPanel = new VerticalPanel();
		linsPanel.addStyleName("my-translation-bar");
		hPanel.add(linsPanel);
		HorizontalPanel btnPanel = new HorizontalPanel();
		btnPanel.addStyleName("my-translation-btns");
		btnPanel.setSpacing(4);
		btnPanel.add(createAbsTreeButton(lins.getTree()));
		btnPanel.add(createAlignButton(lins.getTree()));
		hPanel.add(btnPanel);
		hPanel.setCellHorizontalAlignment(btnPanel,HasHorizontalAlignment.ALIGN_RIGHT);

		for (PGF.Linearization l : lins.getLinearizations().iterable()) {
			linsPanel.add(createTranslation(l.getTo(), lins.getTree(), l.getText()));
		}
		
		initWidget(hPanel);
		setStylePrimaryName("my-translation-frame");
	}

	protected Widget createAbsTreeButton(final String abstractTree) {
		Image treeBtn = new Image("org.grammaticalframework.ui.gwt.EditorApp/tree-btn.png");
		treeBtn.setTitle("Displays the abstract syntax tree.");
		treeBtn.addClickListener(
			new ClickListener() {
				public void onClick(Widget sender) {
					// Create a dialog box and set the caption text
					final DialogBox dialogBox = new DialogBox();
					dialogBox.setText("Abstract Syntax Tree");

					// Create a table to layout the content
					HorizontalPanel dialogContents = new HorizontalPanel();
					dialogContents.setSpacing(4);
					dialogBox.setWidget(dialogContents);

					// Add an image to the dialog

					Frame image = new Frame(pgf.graphvizAbstractTree(abstractTree));
					image.addStyleName("my-treeimage");
					dialogContents.add(image);

					// Add a close button at the bottom of the dialog
					Button closeButton = new Button("Close",
						new ClickListener() {
							public void onClick(Widget sender) {
								dialogBox.hide();
						}
					});
					dialogContents.add(closeButton);

					dialogBox.center();
					dialogBox.show();
				}
			});
		return treeBtn;
	}

	protected Widget createAlignButton(final String abstractTree) {
		Image alignBtn = new Image("org.grammaticalframework.ui.gwt.EditorApp/align-btn.png");
		alignBtn.setTitle("Displays word-alignment diagram.");
		alignBtn.addClickListener(
			new ClickListener() {
				public void onClick(Widget sender) {
					// Create a dialog box and set the caption text
					final DialogBox dialogBox = new DialogBox();
					dialogBox.setText("Word Alignment");

					// Create a table to layout the content
					HorizontalPanel dialogContents = new HorizontalPanel();
					dialogContents.setSpacing(4);
					dialogBox.setWidget(dialogContents);

					// Add an image to the dialog
					Frame image = new Frame(pgf.graphvizAlignment(abstractTree));
					image.addStyleName("my-alignmentimage");
					dialogContents.add(image);

					// Add a close button at the bottom of the dialog
					Button closeButton = new Button("Close",
						new ClickListener() {
							public void onClick(Widget sender) {
								dialogBox.hide();
						}
					});
					dialogContents.add(closeButton);

					dialogBox.center();
					dialogBox.show();
				}
			});
		return alignBtn;
	}

	protected Widget createTranslation(final String language, final String abstractTree, String text) {
		Label l = new Label(text);
		l.addStyleName("my-translation");
		String lang = pgf.getLanguageCode(language);
		if (lang != null) {
			l.getElement().setLang(lang);
		}
		l.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
				// Create a dialog box and set the caption text
				final DialogBox dialogBox = new DialogBox();
				dialogBox.setText("Parse Tree");

				// Create a table to layout the content
				HorizontalPanel dialogContents = new HorizontalPanel();
				dialogContents.setSpacing(4);
				dialogBox.setWidget(dialogContents);

				// Add an image to the dialog
				Frame image = new Frame(pgf.graphvizParseTree(abstractTree, language));
				image.addStyleName("my-treeimage");
				dialogContents.add(image);

				// Add a close button at the bottom of the dialog
				Button closeButton = new Button("Close",
					new ClickListener() {
						public void onClick(Widget sender) {
							dialogBox.hide();
					}
				});
				dialogContents.add(closeButton);

				dialogBox.center();
				dialogBox.show();
			}
		});
		return l;
	}
}
