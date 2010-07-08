package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;


public class EditorApp implements EntryPoint {

	private MenuBar createCommandsMenu(final AbstractSyntaxController absController)
	{
		// Create the commands menu
		MenuBar menu = new MenuBar(true);
		menu.addStyleName("my-CommandsMenu");
		menu.setAutoOpen(true);
		menu.setAnimationEnabled(true);

		menu.addItem(new MenuItem("Undo", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Redo", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Cut", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Copy", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Paste", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Delete", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Refine", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Replace", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Wrap", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Parse", new Command() {
			public void execute() {
				absController.edit();
			}
		}));
		menu.addItem(new MenuItem("Refine the node at random", new Command() {
			public void execute() {
			}
		}));
		menu.addItem(new MenuItem("Refine the tree at random", new Command() {
			public void execute() {
			}
		}));

		return menu;
	}

	private void populate(AbstractSyntaxController absController)
	{
		TreeItem sentenceItem = absController.addItem("Is : Phrase");
		TreeItem item1 = absController.addItem(sentenceItem,"Det : ItemDet");
		TreeItem item2 = absController.addItem(item1,"This : Item");
		absController.addWord(item2,"this");
		TreeItem item3 = absController.addItem(item1,"Cheese : Kind");
		absController.addWord(item3,"cheese");
		absController.addWord(item2,"and");
		absController.addWord(item2,"only");
		absController.addWord(item2,"this");
		absController.addWord(sentenceItem,"is");
		TreeItem item4 = absController.addItem(sentenceItem,"Expensive : Quality");
		absController.addWord(item4,"expensive");
	}

	public void onModuleLoad() {
		Tree abstractTree = new Tree();
		abstractTree.addStyleName("my-AbstractTree");

		FlowPanel textPanel = new FlowPanel();

		ListBox choiceListBox = new ListBox();
		choiceListBox.setVisibleItemCount(10);
		choiceListBox.addStyleName("my-ChoiceListBox");

		AbstractSyntaxController absController = new AbstractSyntaxController(abstractTree, textPanel);

		VerticalSplitPanel vSplit = new VerticalSplitPanel();
		vSplit.setSize("800px", "500px");
		vSplit.setSplitPosition("52%");

		HorizontalSplitPanel hSplit1 = new HorizontalSplitPanel();
		hSplit1.setSplitPosition("22%");
		hSplit1.setLeftWidget(new ScrollPanel(abstractTree));
		hSplit1.setRightWidget(textPanel);
		vSplit.setTopWidget(hSplit1);

		HorizontalSplitPanel hSplit2 = new HorizontalSplitPanel();
		hSplit2.setSplitPosition("22%");
		hSplit2.setLeftWidget(createCommandsMenu(absController));
		hSplit2.setRightWidget(choiceListBox);
		vSplit.setBottomWidget(hSplit2);

		populate(absController);

		// Wrap the split panel in a decorator panel
		DecoratorPanel decPanel = new DecoratorPanel();
		decPanel.addStyleName("my-EditorPanel");
		decPanel.setWidget(vSplit);

		RootPanel.get().add(decPanel);
	}

}
