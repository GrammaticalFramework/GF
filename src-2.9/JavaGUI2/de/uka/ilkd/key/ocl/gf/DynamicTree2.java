//Copyright (c) Janna Khegai 2004, Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You can either finde the file LICENSE or LICENSE.TXT in the source 
//distribution or in the .jar file of this application

package de.uka.ilkd.key.ocl.gf;
/*
 * This code is based on an example provided by Richard Stanford, 
 * a tutorial reader.
 */

import java.awt.*;
import javax.swing.*;
import javax.swing.tree.*;
import javax.swing.event.*;

import java.util.logging.*;

//import de.uka.ilkd.key.util.KeYResourceManager;

import java.awt.event.*;

/**
 * A GUI class, does store the tree, but does not create it.
 * The tree is created in GFEditor2.
 * This class displays the tree and let the user interact with it via mouse clicks.
 */
public class DynamicTree2 extends JPanel implements KeyListener {
        protected static Logger logger = Logger.getLogger(DynamicTree2.class.getName());

        public DefaultMutableTreeNode rootNode;
        private DefaultTreeModel treeModel;
        public JTree tree;
        private Toolkit toolkit = Toolkit.getDefaultToolkit();
        private GFEditor2 gfeditor;
        protected TreePath oldSelection = null;
        
        /**
         * Initializes the display state of the tree panel, sets up the 
         * event handlers.
         * Does not initialize the tree.
         * @param gfe The editor object this object belongs to.
         */
        public DynamicTree2(GFEditor2 gfe) {
                
                this.gfeditor = gfe;
                rootNode = new DefaultMutableTreeNode("Root Node");
                treeModel = new DefaultTreeModel(rootNode);
                treeModel.addTreeModelListener(new MyTreeModelListener());
                
                tree = new JTree(treeModel);
                tree.setRootVisible(false);
                tree.setEditable(false);
                tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
                tree.addKeyListener(this);
                
                //Add listener to components that can bring up popup menus.
                MouseListener popupListener = new PopupListener();
                tree.addMouseListener(popupListener);
                
                tree.addTreeSelectionListener(new TreeSelectionListener() {
                        /**
                         * Moves to the position of the selected node in GF.
                         * the following is assumed:
                         * gfeditor.nodeTable contains the positions for all selectionPathes.
                         */
                        public void valueChanged(TreeSelectionEvent e) {
                                if ((tree.getSelectionPath() != null) && tree.getSelectionPath().equals(oldSelection)) {
                                        //nothing to be done here, probably
                                        //triggered by showTree
                                        return;
                                }
                                if (tree.getSelectionRows() != null) {
                                        if (tree.getSelectionPath() == null) {
                                                if (logger.isLoggable(Level.FINER)) {
                                                        logger.finer("null root path");
                                                }
                                        } else {
                                                if (logger.isLoggable(Level.FINER)) {
                                                        logger.finer("selected path" + tree.getSelectionPath());
                                                }
                                        }
                                        String pos = gfeditor.getNodePosition(tree.getSelectionPath());
                                        if (pos == null || "".equals(pos)) {
                                                //default to sth. sensible
                                                pos = "[]";
                                        }
                                        gfeditor.send("[t] mp " + pos);
                                }
                                oldSelection = tree.getSelectionPath();
                        }
                });
                
                tree.setCellRenderer(new MyRenderer());
                tree.setShowsRootHandles(true);
                ToolTipManager.sharedInstance().registerComponent(tree);
                ToolTipManager.sharedInstance().setDismissDelay(60000);
                setPreferredSize(new Dimension(200, 100));
                JScrollPane scrollPane = new JScrollPane(tree);
                setLayout(new GridLayout(1,0));
                add(scrollPane);
        }
        
        /**
         * Remove all nodes in the tree and
         * form a dummy tree in treePanel
         */
        protected void resetTree() {
                ((DefaultTreeModel)(tree.getModel())).setRoot(new DefaultMutableTreeNode("Root"));
                ((DefaultTreeModel)(tree.getModel())).reload();
        }
        
        /** Remove all nodes except the root node. */
        public void clear() {
                ((DefaultTreeModel)(tree.getModel())).setRoot(null);
                oldSelection = null;
                //((DefaultTreeModel)(tree.getModel())).reload();
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
        
        /**
         * Add child to the root node.
         * It will come last in this node.
         * @param child the payload of the new node
         * @return the tree node having child as the node data
         */
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
        
        /** 
         * Add a new node containing child to the node parent.
         * It will come last in this node.
         * This method gets actually called 
         * @param parent the parent node of the to be created node
         * @param child the wannabe node data
         * @return the tree node having child as the node data and parent as the parent
         */
        public DefaultMutableTreeNode addObject(DefaultMutableTreeNode parent,
                        Object child) {
                return addObject(parent, child, false);
        }
        
        /**
         * Add child to the currently selected node (parent?).
         * It will come last in this node.
         * @param parent the parent node of the to be created node
         * @param child the wannabe node data
         * @param shouldBeVisible true iff the viewport should show the 
         * new node afterwards
         * @return the tree node having child as the node data and parent 
         * as the parent
         */
        public DefaultMutableTreeNode addObject(DefaultMutableTreeNode parent, Object child, boolean shouldBeVisible) {
                if (logger.isLoggable(Level.FINER)) {
                        logger.finer("node added: '" + child + "', parent: '" + parent + "'");
                }
                DefaultMutableTreeNode childNode = new DefaultMutableTreeNode(child);
                
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
                                node = (DefaultMutableTreeNode)(node.getChildAt(index));
                        } catch (NullPointerException exc) {
                                System.err.println(exc.getMessage());
                                exc.printStackTrace();
                        }
                        
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("The user has finished editing the node.");
                                logger.finer("New value: " + node.getUserObject());
                        }
                }
                public void treeNodesInserted(TreeModelEvent e) {
                        //nothing to be done here
                }
                public void treeNodesRemoved(TreeModelEvent e) {
                        //nothing to be done here
                }
                public void treeStructureChanged(TreeModelEvent e) {
                        //nothing to be done here
                }
        }
        
        /**
         * This tree cell renderer got overwritten to make it possible to show
         * tooltips according to the user object
         */
        private class MyRenderer extends DefaultTreeCellRenderer {
                //int counter = 0;
                //final ImageIcon iconFilled;
                //final ImageIcon iconOpen;
                
//                public MyRenderer() {
//                        final URL urlOpen = KeYResourceManager.getManager().getResourceFile(DynamicTree2.class, "metal_leaf_open.png");
//                        final URL urlFilled = KeYResourceManager.getManager().getResourceFile(DynamicTree2.class, "metal_leaf_filled.png");
//                        iconOpen = new ImageIcon(urlOpen);
//                        iconFilled = new ImageIcon(urlFilled);
//                }

                /**
                 * The heart of this class, sets display and tooltip text
                 * depending on the user data
                 */
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
                        if (value instanceof DefaultMutableTreeNode) {
                                DefaultMutableTreeNode node = (DefaultMutableTreeNode)value;
                                if (node.getUserObject() instanceof AstNodeData) {
				                        AstNodeData and = (AstNodeData)node.getUserObject();
				                        String ptt = and.getParamTooltip();
				                        if (!and.subtypingStatus ) {
				                                this.setForeground(Color.RED);
				                                ptt = Printname.htmlAppend(ptt, "<p>Subtyping proof is missing. <br>If no refinements are offered here, then there is a subtyping error.");
				                        }
				                        this.setToolTipText(ptt);
				                        this.setText(and.toString());
//				                        if (and.isMeta()) {
//				                                this.setLeafIcon(this.iconOpen);
//				                        } else {
//				                                this.setLeafIcon(this.iconFilled);
//				                        }
                                } else {
				                        this.setToolTipText(null);
				                        this.setText(value.toString());
                                }
                        } else {
		                        this.setToolTipText(null);
		                        this.setText(value.toString());
                        }
                        return this;
                }
                
                /** 
                 * Checks if the current node represents an open metavariable
                 * or question mark
                 * @param value The payload of the node
                 * @return true iff value begins with a '?'
                 */
                protected boolean isMetavariable(Object value) {
                        try {
                                DefaultMutableTreeNode node =
                                        (DefaultMutableTreeNode)value;
                                String nodeInfo = 
                                        (String)(node.getUserObject());
                                if (nodeInfo.indexOf("?") == 0) {
                                        return true;                                        
                                } 
                        } catch (Exception e) {
                                e.printStackTrace();
                                return false;
                        }
                        
                        return false;
                }
                
        }//class
        
        class PopupListener extends MouseAdapter {
                public void mousePressed(MouseEvent e) {
                        gfeditor.maybeShowPopup(e);
                }
                
                public void mouseReleased(MouseEvent e) {
                        //nothing to be done here
                }
        }

        /** 
         * Handle the key pressed event. 
         */
        public void keyPressed(KeyEvent e) {
                int keyCode = e.getKeyCode();   
                switch (keyCode){ 
                        case KeyEvent.VK_SPACE	:  gfeditor.send("'"); break;
                        case KeyEvent.VK_DELETE	: gfeditor.send("d"); break;
                }
        }
        /** 
         * Handle the key typed event. 
         */
        public void keyTyped(KeyEvent e) {
                //nothing to be done here
        }
        /** 
         * Handle the key released event. 
         */
        public void keyReleased(KeyEvent e) {
                //nothing to be done here
        }
        
}


