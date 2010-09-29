package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.shared.*;

public class TextInputPanel extends Composite implements Focusable, HasValueChangeHandlers<String>, HasSelectionHandlers<String> {

	protected FlowPanel textPanel = null;
	protected FlowPanel mainPanel = null;
	protected FocusPanel focusPanel = null;
	protected Panel focusedPanel = null;
	protected List<Panel> selectedPanels = null;
	protected List<Panel> errorPanels = null;
	protected Panel tempPanel = null;
	protected Label status = null;
	protected NavigationController navigationController;
	protected MagnetSearchBox searchBox = null;

	private List<Label> words = new ArrayList<Label>();

	private Map<Panel,   Phrase> mapPanel2Phrase = new HashMap<Panel, Phrase>();
	private Map<Integer, Phrase> mapFId2Phrase   = new HashMap<Integer, Phrase>();

	private ChangeListenerCollection changeListeners = null;

	public TextInputPanel() {
		mainPanel = new FlowPanel();
		mainPanel.setStylePrimaryName("wordspanel");

		textPanel = new FlowPanel();
		textPanel.add(mainPanel);
		textPanel.setStylePrimaryName("wordspanel");

		Label space = new Label(" ");
		space.setStylePrimaryName("wordspace");
		textPanel.add(space);

		Panel contentPanel = new FlowPanel();
		contentPanel.add(textPanel);
		contentPanel.setStylePrimaryName("text");

		focusPanel = new FocusPanel();
		focusPanel.setWidget(contentPanel);
		focusPanel.setStylePrimaryName("frame");

		Widget buttons = createToolbarPanel();

                VerticalPanel wrapper = new VerticalPanel();
		wrapper.add(buttons);
		wrapper.add(focusPanel);
		initWidget(wrapper);
		setStylePrimaryName("my-TextInputPanel");

		navigationController = new NavigationController();
		focusPanel.addKeyDownHandler(navigationController);
	}

	protected Widget createToolbarPanel() {
		HorizontalPanel toolbar = new HorizontalPanel();
		toolbar.setStylePrimaryName("toolbar");

		Panel buttons = new HorizontalPanel();
		toolbar.add(buttons);
		toolbar.setCellHorizontalAlignment(buttons,HorizontalPanel.ALIGN_LEFT);
		toolbar.setCellVerticalAlignment(buttons,HorizontalPanel.ALIGN_MIDDLE);

		Image clearButton = new Image("org.grammaticalframework.ui.gwt.EditorApp/textinput-buttons.png",0,0,20,20);
		clearButton.setTitle("Clears the whole text.");
		clearButton.setStylePrimaryName("button");
		clearButton.addClickListener(new ClickListener () {
			public void onClick(Widget sender) {
				clear();
			}
		});
		buttons.add(clearButton);

 		Image deleteLastButton = new Image("org.grammaticalframework.ui.gwt.EditorApp/textinput-buttons.png",20,0,20,20);
		deleteLastButton.setTitle("Removes the last word.");
		deleteLastButton.setStylePrimaryName("button");
		deleteLastButton.addClickListener(new ClickListener () {
			public void onClick(Widget sender) {
				deleteLast();
			}
		});
		buttons.add(deleteLastButton);

 		status = new Label();
		status.setTitle("The currently selected category.");
		status.setStylePrimaryName("status");
		toolbar.add(status);
		toolbar.setCellHorizontalAlignment(status,HorizontalPanel.ALIGN_RIGHT);
		toolbar.setCellVerticalAlignment(status,HorizontalPanel.ALIGN_MIDDLE);

		return toolbar;
	}

	public void renderBracketedString(final PGF.BracketedString bs) {
		words.clear();
		mapPanel2Phrase.clear();
		mapFId2Phrase.clear();
		mainPanel.clear();
		selectedPanels = null;
		focusedPanel = null;
		errorPanels = null;
		tempPanel = null;

		Widget widget = createWordPanels(bs);
		mainPanel.add(widget);
	}

	private Widget createWordPanels(final PGF.BracketedString bs) {
		if (bs.getToken() != null) {
			Label wordLabel = new Label(bs.getToken());
			wordLabel.setStylePrimaryName("wordlabel");
			wordLabel.addClickListener(navigationController);
			words.add(wordLabel);
			return wordLabel;
		} else {
			FlowPanel panel = new FlowPanel();
			panel.setStylePrimaryName("wordspanel");

			Integer fid = new Integer(bs.getFId());
			Phrase phrase = mapFId2Phrase.get(fid);
			if (phrase == null) {
				phrase = new Phrase();
				phrase.cat = bs.getCat();
				phrase.panels = new ArrayList<Panel>();
				mapFId2Phrase.put(fid,phrase);
			}
			phrase.panels.add(panel);
			mapPanel2Phrase.put(panel, phrase);

			for (PGF.BracketedString child : bs.getChildren()) {
				if (panel.getWidgetCount() > 0) {
					Label space = new Label(" ");
					space.setStylePrimaryName("wordspace");
					panel.add(space);
				}
				panel.add(createWordPanels(child));
			}
			return panel;
		}
	}

	public void clear() {
		setSearchTerm("");
		words.clear();
		mapPanel2Phrase.clear();
		mapFId2Phrase.clear();
		mainPanel.clear();
		selectedPanels = null;
		focusedPanel = null;
		errorPanels = null;
		tempPanel = null;
		fireValueChange();
	}

	public void addMagnet(Magnet magnet) {
		Label wordLabel = new Label(magnet.getText());
		wordLabel.setStylePrimaryName("wordlabel");
		getTempPanel().add(wordLabel);
		words.add(wordLabel);

		fireValueChange();
	}

	public String deleteLast() {
		int wordsCount = words.size();
		if (wordsCount <= 0)
			return null;
		Label lastWord = words.remove(wordsCount-1);

		setSearchTerm("");
		mapPanel2Phrase.clear();
		mapFId2Phrase.clear();
		mainPanel.clear();
		selectedPanels = null;
		focusedPanel = null;
		errorPanels = null;
		tempPanel = null;
		for (Label word : words) {
			if (((FlowPanel) getTempPanel()).getWidgetCount() > 0) {
				Label space = new Label(" ");
				space.setStylePrimaryName("wordspace");
				getTempPanel().add(space);
			}
			getTempPanel().add(word);
		}
		fireValueChange();
		
		return lastWord.getText();
	}

	public void showSearchBox() {
		if (searchBox == null) {
			searchBox = new MagnetSearchBox();
			SearchBoxKeyboardHandler handler = new SearchBoxKeyboardHandler();
			searchBox.addKeyUpHandler(handler);
			searchBox.addKeyDownHandler(handler);

			textPanel.add(searchBox);
			searchBox.setFocus(true);
		}
	}

	public void hideSearchBox() {
		if (searchBox != null) {
			searchBox.removeFromParent();
			searchBox = null;
		}
	}

	public void setSearchTerm(String term) {
		if (searchBox != null) {
			searchBox.setText(term);
			if ("".equals(term))
				searchBox.setCursorPos(0);
		}
	}

	public String getSearchTerm() {
		if (searchBox != null)
			return searchBox.getText();
		else
			return null;
	}

	public void showSearchError() {
		if (searchBox != null) {
			searchBox.addStyleDependentName("error");
		}
	}

	public void clearSearchError() {
		if (searchBox != null) {
			searchBox.removeStyleDependentName("error");
		}
	}

	public void showError(int fid) {
		if (errorPanels != null) {
			for (Panel panel : errorPanels) {
				panel.removeStyleDependentName("error");
			}
			errorPanels = null;
		}

		Phrase phrase = mapFId2Phrase.get(fid);
		if (phrase != null) {
			errorPanels = phrase.panels;
			if (errorPanels != null) {
				for (Panel selPanel : errorPanels) {
					selPanel.addStyleDependentName("error");
				}
			}
		}
	}

	private Panel getTempPanel() {
		if (tempPanel == null) {
			if (mainPanel.getWidgetCount() > 0) {
				Label space = new Label(" ");
				space.setStylePrimaryName("wordspace");
				mainPanel.add(space);
			}

			tempPanel = new FlowPanel();
			tempPanel.setStylePrimaryName("wordspanel");
			mainPanel.add(tempPanel);
		}
		return tempPanel;
	}

	protected void fireValueChange() {
		DeferredCommand.addCommand(new Command() {
			public void execute() {
				ValueChangeEvent.fire(TextInputPanel.this, getText());
			}
		});
	}

	protected void fireSelection() {
		SelectionEvent.fire(this, (searchBox == null) ? "" : searchBox.getText());
	}

	public HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> handler) {
		return addHandler(handler, ValueChangeEvent.getType());
	}

	public HandlerRegistration addSelectionHandler(SelectionHandler<String> handler) {
		return addHandler(handler, SelectionEvent.getType());
	}

	public String getText () {
		StringBuilder sb = new StringBuilder();
		for (Label word : words) {
			if (sb.length() > 0) {
				sb.append(' ');
			}
			sb.append(word.getText());
		}
		return sb.toString();
	}

	public int getTabIndex() {
		return focusPanel.getTabIndex();
	}

	public void setTabIndex(int index) {
		focusPanel.setTabIndex(index);
	}

	public void setAccessKey(char key) {
		focusPanel.setAccessKey(key);
	}

	public void setFocus(boolean focused) {
		focusPanel.setFocus(focused);
	}

	private class Phrase {
		public String cat;
		public ArrayList<Panel> panels;
	}

	private final class NavigationController implements KeyDownHandler, ClickListener {

		public void onKeyDown(KeyDownEvent event) {
			switch (event.getNativeKeyCode()) {
				case KeyCodes.KEY_UP:
					if (focusedPanel != null) {
						Panel firstUp = null;
						FlowPanel parent = (FlowPanel) focusedPanel.getParent();
						while (parent != mainPanel) {
							if (parent.getWidgetCount() > 1) {
								firstUp = parent;
								break;
							}

							parent = (FlowPanel) parent.getParent();
						}

						if (firstUp != null)
							setFocusedPanel(firstUp);
						event.stopPropagation();
					}
					break;
				case KeyCodes.KEY_DOWN:
					if (focusedPanel != null) {
						Panel firstDown = null;
						for (Widget child : focusedPanel) {
							if (child instanceof Panel) {
								firstDown = (Panel) child;
								break;
							}
						}
						if (firstDown != null)
							setFocusedPanel(firstDown);
						event.stopPropagation();
					}
					break;
				case KeyCodes.KEY_LEFT:
					if (focusedPanel != null) {
						Panel firstLeft = null;
						Panel parent = (Panel) focusedPanel.getParent();
						for (Widget child : parent) {
							if (child instanceof Panel) {
								if (child == focusedPanel)
									break;
								firstLeft = (Panel) child;
							}
						}

						if (firstLeft == null) {
							if (parent != mainPanel)
								firstLeft = parent;
						} else {
							for (;;) {
								Panel lastChild = null;
								for (Widget child : firstLeft) {
									if (child instanceof Panel) {
										lastChild = (Panel) child;
									}
								}
								if (lastChild == null)
									break;
								firstLeft = lastChild;
							}
						}
						if (firstLeft != null)
							setFocusedPanel(firstLeft);
						event.stopPropagation();
					}
					break;
				case KeyCodes.KEY_RIGHT:
					if (focusedPanel != null) {
						Panel firstRight = null;
						Panel parent = (Panel) focusedPanel.getParent();
						Widget prev = null;
						for (Widget child : parent) {
							if (child instanceof Panel) {
								if (prev == focusedPanel) {
									firstRight = (Panel) child;
									break;
								}
								prev = child;
							}
						}

						if (firstRight == null) {
							if (parent != mainPanel)
								firstRight = parent;
						} else {
							for (;;) {
								Panel firstChild = null;
								for (Widget child : firstRight) {
									if (child instanceof Panel) {
										firstChild = (Panel) child;
										break;
									}
								}
								if (firstChild == null)
									break;
								firstRight = firstChild;
							}
						}
						if (firstRight != null)
							setFocusedPanel(firstRight);
						event.stopPropagation();
					}
					break;
				case KeyCodes.KEY_ENTER:
				case KeyCodes.KEY_ESCAPE:
					break;
				default:
					if (searchBox == null) {
						showSearchBox();
						searchBox.fireEvent(event);
					}
			}
		}

		public void onClick(Widget sender) {
			FlowPanel panel = (FlowPanel) sender.getParent();
			FlowPanel tmpPanel = panel;
			while (tmpPanel != mainPanel) {
				FlowPanel parent = (FlowPanel) tmpPanel.getParent();

				if (tmpPanel == focusedPanel && parent != mainPanel) {
					panel = parent;
					break;
				}

				tmpPanel = parent;
			}

			tmpPanel = (FlowPanel) panel.getParent();
			while (tmpPanel != mainPanel) {
				if (tmpPanel.getWidgetCount() > 1)
					break;

				panel = tmpPanel;
				tmpPanel = (FlowPanel) panel.getParent();
			}

			setFocusedPanel(panel);
		}

		private void setFocusedPanel(Panel panel) {
			if (selectedPanels != null) {
				for (Panel tmpPanel : selectedPanels) {
					tmpPanel.removeStyleDependentName("selected");
				}
				selectedPanels = null;
			}

			if (focusedPanel != null) {
				focusedPanel.removeStyleDependentName("focused");
				focusedPanel = null;
			}

			Phrase phrase = mapPanel2Phrase.get(panel);
			if (phrase != null) {
				status.setText(phrase.cat);
				selectedPanels = phrase.panels;
				if (selectedPanels != null) {
					for (Panel selPanel : selectedPanels) {
						selPanel.addStyleDependentName("selected");
					}
				}

				focusedPanel = panel;
				focusedPanel.addStyleDependentName("focused");
			}
		}
	}

	private final class SearchBoxKeyboardHandler implements KeyUpHandler, KeyDownHandler {

		public void onKeyDown(KeyDownEvent event) {
			switch (event.getNativeKeyCode()) {
				case KeyCodes.KEY_ESCAPE:
					hideSearchBox();
					fireSelection();
					setFocus(true);
					event.stopPropagation();
					break;
				case KeyCodes.KEY_ENTER:
					searchBox.setText(searchBox.getText()+" ");
					fireSelection();
					hideSearchBox();
					setFocus(true);
					event.stopPropagation();
					break;
				case KeyCodes.KEY_BACKSPACE:
					if ("".equals(searchBox.getText())) {
						String word = deleteLast();
						searchBox.setText(word);
						searchBox.setCursorPos(word.length());
						event.stopPropagation();
						event.preventDefault();
					}
					break;
			}
		}

		public void onKeyUp(KeyUpEvent event) {
			switch (event.getNativeKeyCode()) {
				case KeyCodes.KEY_ESCAPE:
				case KeyCodes.KEY_ENTER:
				case KeyCodes.KEY_UP:
				case KeyCodes.KEY_DOWN:
				case KeyCodes.KEY_LEFT:
				case KeyCodes.KEY_RIGHT:
					break;
				default:
					fireSelection();
			}
		}
	}
}
