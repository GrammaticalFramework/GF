package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.user.client.ui.*;


public class AbstractSyntaxController {
	private final Tree abstractTree;
	private final FlowPanel textPanel;

	private Map<Panel,TreeItem> panels;
	private Map<TreeItem,List<Panel>> items;
	
	private ClickListener labelClickListener;

	private Panel focusPanel = null;
	private Panel selectedPanel = null;
	private TreeItem lastPanelItem = null;

	public AbstractSyntaxController(final Tree abstractTree, final FlowPanel textPanel)
	{
		this.abstractTree = abstractTree;
		this.textPanel    = textPanel;

		panels = new HashMap();
		items  = new HashMap();

		abstractTree.addTreeListener(new TreeListener() {
			public void onTreeItemSelected(TreeItem item)
			{
				focusPanel = selectedPanel;

				for (Panel panel : panels.keySet())
				{
					panel.removeStyleDependentName("selected");
					panel.removeStyleDependentName("focused");
				}

				List<Panel> panels = items.get(item);
				if (panels != null)
				{
					for (Panel panel : panels)
					{
						String style = (panel == selectedPanel) ? "focused" : "selected";
						panel.addStyleDependentName(style);
					}
				}
			}

			public void onTreeItemStateChanged(TreeItem item)
			{
			}
		});

		labelClickListener = new ClickListener() {
			public void onClick(Widget sender) {
				Panel panel = (Panel) (sender.getParent());

				TreeItem item = panels.get(panel);
				if (item != null)
				{
					selectedPanel = panel;
					abstractTree.setSelectedItem(item);
					abstractTree.ensureSelectedItemVisible();
					selectedPanel = null;
				}
			}
		};
	}

	public TreeItem addItem(String label)
	{
		TreeItem child = abstractTree.addItem(label);
		addPanel(child, textPanel);
		return child;
	}

	public TreeItem addItem(TreeItem parent, String label)
	{
		TreeItem child = parent.addItem(label);
		addPanel(child, getPanel(parent));
		return child;
	}

	private Panel addPanel(TreeItem item, Panel parentPanel)
	{
		FlowPanel wordsPanel = new FlowPanel();
		wordsPanel.setStylePrimaryName("my-WordsPanel");
		panels.put(wordsPanel,item);

		List<Panel> others = items.get(item);
		if (others == null)
		{
			others = new ArrayList();
			items.put(item,others);
		}
		others.add(wordsPanel);

		parentPanel.add(wordsPanel);

		lastPanelItem = item;
		return wordsPanel;
	}

	private Panel getPanel(TreeItem item)
	{
		TreeItem tmpItem;

		LinkedList<TreeItem> curr = new LinkedList();
		tmpItem = item;
		while (tmpItem != null)
		{
			curr.addFirst(tmpItem);
			tmpItem = tmpItem.getParentItem();
		}

		LinkedList<TreeItem> last = new LinkedList();
		tmpItem = lastPanelItem;
		while (tmpItem != null)
		{
			last.addFirst(tmpItem);
			tmpItem = tmpItem.getParentItem();
		}

		int i = 0;
		TreeItem parent = null;
		while (i < curr.size() && i < last.size())
		{
			if (curr.get(i) != last.get(i))
			  break;

			parent = curr.get(i);
			i++;
		}

		List<Panel> others = items.get(parent);
		if (others == null)
			return null;
		Panel panel = others.get(others.size()-1);

		if (parent != item)
		{
			while (i < curr.size())
				panel = addPanel(curr.get(i++), panel);
		}

		return panel;
	}

	public Label addWord(TreeItem item, String word)
	{
		Panel wordsPanel = getPanel(item);

		Label wordLabel = new Label(word);
		wordLabel.setStylePrimaryName("my-WordLabel");
		wordLabel.addClickListener(labelClickListener);
		
		wordsPanel.add(wordLabel);

		return wordLabel;
	}

	public void edit()
	{
		if (focusPanel != null)
		{
			FlowPanel mainPanel = new FlowPanel();
			mainPanel.add(new Magnet("fish","LangEng"));
			mainPanel.add(new Magnet("beer","LangEng"));
			mainPanel.add(new Magnet("cheese","LangEng"));
			mainPanel.add(new Magnet("expensive","LangEng"));
			mainPanel.add(new Magnet("delicious","LangEng"));

			DecoratedPopupPanel completionPopup = new DecoratedPopupPanel(true);
			completionPopup.addStyleName("my-FridgeBagPopup");
			completionPopup.setWidget(mainPanel);
			completionPopup.setPopupPosition(100, 100);
			completionPopup.show();

			final List<Widget> children = new ArrayList();
			for (Widget widget : focusPanel)
			{
				children.add(widget);
			}

			TextBox textBox = new TextBox();
			textBox.setStylePrimaryName("my-TextEdit");
			textBox.addFocusListener(new FocusListener() {
				public void onFocus(Widget sender)
				{
				}

				public void onLostFocus(Widget sender)
				{
					focusPanel.clear();
					for (Widget widget : children)
					{
						focusPanel.add(widget);
					}
				}
			});

			focusPanel.clear();
			focusPanel.add(textBox);
			textBox.setFocus(true);
		}
	}
}
