
/*
 * This code is based on an example provided by Richard Stanford, 
 * a tutorial reader.
 */

import java.awt.*;
import javax.swing.*;
import javax.swing.tree.*;
import javax.swing.event.*;
import java.util.Vector;
import java.awt.event.*;

public class DynamicTree2 extends JPanel implements KeyListener,
                                           ActionListener{
    public static DefaultMutableTreeNode rootNode;
    protected DefaultTreeModel treeModel;
    public JTree tree;
    public int oldSelection = 0;
    private Toolkit toolkit = Toolkit.getDefaultToolkit();
    public JPopupMenu popup = new JPopupMenu();
    JMenuItem menuItem;
    Timer timer = new Timer(500, this);
    MouseEvent m;
    
    public DynamicTree2() {
        timer.setRepeats(false);
        rootNode = new DefaultMutableTreeNode("Root Node");
        treeModel = new DefaultTreeModel(rootNode);
        treeModel.addTreeModelListener(new MyTreeModelListener());

        tree = new JTree(treeModel);
        tree.setRootVisible(false);
        tree.setEditable(false);
        tree.getSelectionModel().setSelectionMode
                (TreeSelectionModel.SINGLE_TREE_SELECTION);
        tree.addKeyListener(this);
        menuItem = new JMenuItem("Paste");
        menuItem.addActionListener(this);
        popup.add(menuItem);                         
            
        //Add listener to components that can bring up popup menus.
        MouseListener popupListener = new PopupListener();
        tree.addMouseListener(popupListener);
              
        tree.addTreeSelectionListener(new TreeSelectionListener() {
           public void valueChanged(TreeSelectionEvent e) {
             if  (tree.getSelectionRows()!=null) {
               if (GFEditor2.nodeTable == null)
                  {if (GFEditor2.debug) System.out.println("null node table");}
               else
                 {if (GFEditor2.debug) System.out.println("node table: "+
                   GFEditor2.nodeTable.contains(new Integer(0)) +" "+ 
                  GFEditor2.nodeTable.keys().nextElement()); }
               if (tree.getSelectionPath() == null)
                 {if (GFEditor2.debug) System.out.println("null root path"); }
               else
                 {if (GFEditor2.debug) System.out.println("selected path"+
                        tree.getSelectionPath());} 
               int i = ((Integer)GFEditor2.nodeTable.get(
                       tree.getSelectionPath())).intValue();
               int j = oldSelection;    
               GFEditor2.treeChanged = true; 
               if (i>j) GFEditor2.send("> "+String.valueOf(i-j)); 
               else GFEditor2.send("< "+String.valueOf(j-i));               
            }          
          }
        });

        tree.setCellRenderer(new MyRenderer());
        tree.setShowsRootHandles(true);
        setPreferredSize(new Dimension(200, 100));
        JScrollPane scrollPane = new JScrollPane(tree);
        setLayout(new GridLayout(1,0));
        add(scrollPane);
    }

    /** Remove all nodes except the root node. */
    public void clear() {
        rootNode.removeAllChildren();
        treeModel.reload();
    }

    /** Remove the currently selected node. */
    public void removeCurrentNode() {
        TreePath currentSelection = tree.getSelectionPath();
        if (currentSelection != null) {
            DefaultMutableTreeNode currentNode = (DefaultMutableTreeNode)
                         (currentSelection.getLastPathComponent());
            MutableTreeNode parent = (MutableTreeNode)(currentNode.getParent());
            if (parent != null) {
                treeModel.removeNodeFromParent(currentNode);
                return;
            }
        } 

        // Either there was no selection, or the root was selected.
        toolkit.beep();
    }

    /** Add child to the currently selected node. */
    public DefaultMutableTreeNode addObject(Object child) {
        DefaultMutableTreeNode parentNode = null;
        TreePath parentPath = tree.getSelectionPath();

        if (parentPath == null) {
            parentNode = rootNode;
        } else {
            parentNode = (DefaultMutableTreeNode)
                         (parentPath.getLastPathComponent());
        }

        return addObject(parentNode, child, true);
    }

    public DefaultMutableTreeNode addObject(DefaultMutableTreeNode parent,
                                            Object child) {
        return addObject(parent, child, false);
    }

    public DefaultMutableTreeNode addObject(DefaultMutableTreeNode parent,
                                            Object child, 
                                            boolean shouldBeVisible) {
        DefaultMutableTreeNode childNode = 
                new DefaultMutableTreeNode(child);

        if (parent == null) {
            parent = rootNode;
        }

        treeModel.insertNodeInto(childNode, parent, 
                                 parent.getChildCount());

        // Make sure the user can see the lovely new node.
        if (shouldBeVisible) {
            tree.scrollPathToVisible(new TreePath(childNode.getPath()));
        }
        return childNode;
    }

    class MyTreeModelListener implements TreeModelListener {
        public void treeNodesChanged(TreeModelEvent e) {
            DefaultMutableTreeNode node;
            node = (DefaultMutableTreeNode)
                     (e.getTreePath().getLastPathComponent());

            /*
             * If the event lists children, then the changed
             * node is the child of the node we've already
             * gotten.  Otherwise, the changed node and the
             * specified node are the same.
             */
            try {
                int index = e.getChildIndices()[0];
                node = (DefaultMutableTreeNode)
                       (node.getChildAt(index));
            } catch (NullPointerException exc) {}

            if (GFEditor2.debug) System.out.println
                            ("The user has finished editing the node.");
            if (GFEditor2.debug) System.out.println(
                            "New value: " + node.getUserObject());
        }
        public void treeNodesInserted(TreeModelEvent e) {
        }
        public void treeNodesRemoved(TreeModelEvent e) {
        }
        public void treeStructureChanged(TreeModelEvent e) {
        }
    }

    private class MyRenderer extends DefaultTreeCellRenderer {
        ImageIcon tutorialIcon;

        public MyRenderer() {
            tutorialIcon = new ImageIcon("images/middle.gif");
        }

        public Component getTreeCellRendererComponent(
                            JTree tree,
                            Object value,
                            boolean sel,
                            boolean expanded,
                            boolean leaf,
                            int row,
                            boolean hasFocus) {

            super.getTreeCellRendererComponent(
                            tree, value, sel,
                            expanded, leaf, row,
                            hasFocus);
            if (leaf && isTutorialBook(value)) 
                setIcon(tutorialIcon);
                
           return this;
        }
        protected boolean isTutorialBook(Object value) {
            DefaultMutableTreeNode node =
                    (DefaultMutableTreeNode)value;
            String nodeInfo = 
                    (String)(node.getUserObject());
           
            if (nodeInfo.indexOf("?") >= 0) {
                return true;
            } 

            return false;
        }

    }//class

    class PopupListener extends MouseAdapter {
        public void mousePressed(MouseEvent e) {
            int selRow = tree.getRowForLocation(e.getX(), e.getY());
            tree.setSelectionRow(selRow);
            if (GFEditor2.debug) System.out.println("selection changed!");
            maybeShowPopup(e);
        }

        public void mouseReleased(MouseEvent e) {
            if (GFEditor2.debug) System.out.println("mouse released!");
            maybeShowPopup(e);
        }
    }
    void maybeShowPopup(MouseEvent e) {
         if (GFEditor2.debug) System.out.println("may be!");        
         if (e.isPopupTrigger()) {
            m = e;
            timer.start();
         } 
    }
    void addMenuItem(String name){
                menuItem = new JMenuItem(name);
                menuItem.addActionListener(this);
                popup.add(menuItem);

    }

    public void actionPerformed(ActionEvent ae)
    { 
      if (ae.getSource()==timer){
            if (GFEditor2.debug) System.out.println("changing menu!");
            popup.removeAll();
            for (int i = 0; i<GFEditor2.listModel.size() ; i++) 
                addMenuItem(GFEditor2.listModel.elementAt(i).toString());
            popup.show(m.getComponent(), m.getX(), m.getY());
       }
       else{
         GFEditor2.treeChanged = true; 
         GFEditor2.send((String)GFEditor2.commands.elementAt
               (popup.getComponentIndex((JMenuItem)(ae.getSource()))));
       }                   
    }

    /** Handle the key pressed event. */
    public void keyPressed(KeyEvent e) {
        int keyCode = e.getKeyCode();   
        switch (keyCode){ 
        case 32:  GFEditor2.send("'"); break;
        case 127: GFEditor2.send("d"); break;
        }
    }
    /** Handle the key typed event. */
    public void keyTyped(KeyEvent e) {
    }
    /** Handle the key released event. */
    public void keyReleased(KeyEvent e) {
    }

}


