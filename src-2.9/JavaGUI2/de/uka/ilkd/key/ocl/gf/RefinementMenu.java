//Copyright (c) Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.
//
//You can either finde the file LICENSE or LICENSE.TXT in the source 
//distribution or in the .jar file of this applicationpackage de.uka.ilkd.key.ocl.gf;

package de.uka.ilkd.key.ocl.gf;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Collections;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.ListSelectionModel;

/**
 * Takes care of managing the commands, that GF sent,
 * including subcategories and their menus.
 * Manages the graphical lists. To display them, they are reachable
 * via getRefinementListsContainer().
 * @author hdaniels
  */
class RefinementMenu {
        /** 
         * logs things like selections and key events 
         */
        private static Logger logger = Logger.getLogger(RefinementMenu.class.getName());
       
        /**
         * the editor of which this menu is part of
         */
        final private GFEditor2 editor;
        /** 
         * the content of the refinementMenu 
         */
        public DefaultListModel listModel= new DefaultListModel();
        /** 
         * The list of current refinement options 
         */       
        private JList refinementList = new JList(this.listModel);
        /**
         * to store the Vectors which contain the display names for the
         * ListModel for refinementSubcatList for the different 
         * subcategory menus.
         * The key is the shortname String, the value the Vector with the
         * display Strings
         */
        private Hashtable subcatListModelHashtable = new Hashtable(); 
        /** 
         * this ListModel gets refilled every time a %WHATEVER command, 
         * which stands for a shortname for a subcategory of commands
         * in the ListModel of refinementList, is selected there
         */
        private DefaultListModel refinementSubcatListModel = new DefaultListModel();
        /** 
         * The list of current refinement options in the subcategory menu
         */       
        private JList refinementSubcatList = new JList(this.refinementSubcatListModel);
        /** 
         * the scrollpane containing the refinement subcategory
         */
        private JScrollPane refinementSubcatPanel = new JScrollPane(this.refinementSubcatList);
        /** 
         * store what the shorthand name for the current subcat is 
         */
        private String whichSubcat;
        /** 
         * stores the two refinement JLists 
         */
        private JSplitPane refinementListsContainer;
        /**
         * the scrollpane containing the refinements 
         */
        private JScrollPane refinementPanel = new JScrollPane(this.refinementList);
        /** 
         * here the GFCommand objects are stored
         */
        private Vector gfcommands = new Vector();
        /**
         * The cached popup menu containing the same stuff as the refinement list
         */
        public JPopupMenu popup2 = new JPopupMenu();

        /**
         * Creates the panels for the refinement (subcat) menu
         * @param editor the editor, that the refinement menu is part of
         */
        protected RefinementMenu(GFEditor2 editor) {
                this.editor = editor;
                refinementListsContainer = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,refinementPanel, refinementSubcatPanel);
                refinementList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
                
                final MouseListener mlRefinementList = new MouseAdapter() {
                        public void mouseClicked(MouseEvent e) {
                                refinementList.setSelectionBackground(refinementSubcatList.getSelectionBackground());
                                boolean doubleClick = (e.getClickCount() == 2); 
                                listAction(refinementList, refinementList.locationToIndex(e.getPoint()), doubleClick);
                        }
                };
                refinementList.addMouseListener(mlRefinementList);
                refinementList.addKeyListener(new KeyListener() {
                        /** Handle the key pressed event for the refinement list. */
                        public void keyPressed(KeyEvent e) {
                                int keyCode = e.getKeyCode();   
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("Key pressed: " + e.toString());
                                }

                                int index = refinementList.getSelectedIndex();                        
                                if (index == -1) {
                                        //nothing selected, so nothing to be seen here, please move along
                                } else if (keyCode == KeyEvent.VK_ENTER) { 
                                        listAction(refinementList, refinementList.getSelectedIndex(), true);
                                } else if (keyCode == KeyEvent.VK_DOWN && index < listModel.getSize() - 1) {
                                        listAction(refinementList, index + 1, false);
                                } else if (keyCode == KeyEvent.VK_UP && index > 0) {
                                        listAction(refinementList, index - 1, false);
                                } else if (keyCode == KeyEvent.VK_RIGHT) {
                                        if (refinementSubcatList.getModel().getSize() > 0) {
                                                refinementSubcatList.requestFocusInWindow();
                                                refinementSubcatList.setSelectedIndex(0);
                                                refinementList.setSelectionBackground(Color.GRAY);
                                        }
                                }
                        }

                        /** 
                         * Handle the key typed event.
                         * We are not really interested in typed characters, thus empty
                         */
                        public void keyTyped(KeyEvent e) {
                                //needed for KeyListener, but not used                
                        }

                        /** Handle the key released event. */
                        public void keyReleased(KeyEvent e) {
                                //needed for KeyListener, but not used
                        }
                });

                refinementSubcatList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
                
                final MouseListener mlRefinementSubcatList = new MouseAdapter() {
                        public void mouseClicked(MouseEvent e) {
                                boolean doubleClick = (e.getClickCount() == 2);
                                listAction(refinementSubcatList, refinementSubcatList.locationToIndex(e.getPoint()), doubleClick);
                                refinementList.setSelectionBackground(Color.GRAY);
                        }
                };
                refinementSubcatList.addMouseListener(mlRefinementSubcatList);
                refinementSubcatList.addKeyListener(new KeyListener() {
                        /** Handle the key pressed event. */
                        public void keyPressed(KeyEvent e) {
                                int keyCode = e.getKeyCode();   
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("Key pressed: " + e.toString());
                                }
                                if (keyCode == KeyEvent.VK_ENTER) {
                                        listAction(refinementSubcatList, refinementSubcatList.getSelectedIndex(), true);
                                } else if (keyCode == KeyEvent.VK_LEFT) {
                                        refinementList.requestFocusInWindow();
                                        refinementSubcatList.clearSelection();
                                        refinementList.setSelectionBackground(refinementSubcatList.getSelectionBackground());
                                }
                        }

                        /** 
                         * Handle the key typed event.
                         * We are not really interested in typed characters, thus empty
                         */
                        public void keyTyped(KeyEvent e) {
                                //needed for KeyListener, but not used                
                        }

                        /** Handle the key released event. */
                        public void keyReleased(KeyEvent e) {
                                //needed for KeyListener, but not used
                        }
                });
                refinementList.setToolTipText("The list of current refinement options");
                refinementList.setCellRenderer(new ToolTipCellRenderer());
                refinementSubcatList.setToolTipText("The list of current refinement options");
                refinementSubcatList.setCellRenderer(new ToolTipCellRenderer());

        }
        
        /**
         * @return Returns the refinementListsContainer,
         * which will contain both JLists.
         */
        protected JSplitPane getRefinementListsContainer() {
                return refinementListsContainer;
        }

        /**
         * handling the event of choosing the action at index from the list.
         * That is either giving commands to GF or displaying the subcat menus
         * @param list The list that generated this action
         * @param index the index of the selected element in list
         * @param doubleClick true iff a command should be sent to GF, 
         * false if only a new subcat menu should be opened. 
         */
        private void listAction(JList list, int index, boolean doubleClick) {
                if (index == -1) {
                        if (logger.isLoggable(Level.FINER)) logger.finer("no selection");
                } else {
                        Object o;
                        if (list == refinementList) {
                                o = listModel.elementAt(index); 
                        } else {
                                if (whichSubcat == null) {
                                        //this is probably the case when no fitting properties of self
                                        //are available and only a string is displayed in the submenu.
                                        //clicking that string should do exactly nothing.
                                        return;
                                }
                                Vector cmdvector = (Vector)this.subcatListModelHashtable.get(this.whichSubcat);
                                o = (cmdvector.get(index));
                        }
                        GFCommand command = null;
                        if (o instanceof GFCommand) {
                                command = (GFCommand)o;
                        } else {
                                return;
                        }
                        if (command instanceof SelfPropertiesCommand) {
                               SelfPropertiesCommand  spc = (SelfPropertiesCommand)command;
                               Vector selfs = spc.produceSubmenu();
                               if (selfs.size() == 0) {
                                       listModel.remove(index);
                                       refinementSubcatListModel.clear();
                                       refinementSubcatListModel.addElement("No properties fit here");
                                       return;
                               } else {
                                       this.subcatListModelHashtable.put(command.getSubcat(), selfs);
                                       listModel.remove(index);
                                       LinkCommand newLink = new LinkCommand(PrintnameManager.SELF_SUBCAT, editor.getPrintnameManager());
                                       listModel.add(index, newLink);
                                       command = newLink;
                               }
                        } 
                        if (command instanceof LinkCommand) { //includes SelfPropertiesCommand, which is intended
                                this.whichSubcat = command.getSubcat();
                                refinementSubcatListModel.clear();
                                Vector currentCommands = (Vector)this.subcatListModelHashtable.get(this.whichSubcat);
                                for (Iterator it = currentCommands.iterator(); it.hasNext();) {
                                        this.refinementSubcatListModel.addElement(it.next());
                                }
                        } else if (doubleClick && command instanceof InputCommand) {
                                InputCommand ic = (InputCommand)command;
                                editor.executeInputCommand(ic);
                                
                        } else if (doubleClick){
                                refinementSubcatListModel.clear();
                                if (command instanceof RealCommand) {
                                        editor.send("[t] " + command.getCommand(), true, ((RealCommand)command).undoSteps);
                                } else {
                                        //that shouldn't be the case ...
                                        editor.send("[t] " + command.getCommand());
                                }
                        } else if (list == refinementList){
                                refinementSubcatListModel.clear();
                        }
                }
        }
        /**
         * Produces the popup menu that represents the current refinements.
         * An alternative to the refinement list.
         * @return s.a.
         */
        protected JPopupMenu producePopup() {
                if (popup2.getComponentCount() > 0) {
                        return popup2;
                }
                for (int i = 0; i < this.listModel.size(); i++) {
                        GFCommand gfcmd = (GFCommand)this.listModel.get(i);
                        if (gfcmd instanceof LinkCommand) {
                                LinkCommand lc = (LinkCommand)gfcmd;
                                Vector subcatMenu = (Vector)this.subcatListModelHashtable.get(lc.getSubcat());
                                JMenu tempMenu = new JMenu(lc.getDisplayText());
                                tempMenu.setToolTipText(lc.getTooltipText());
                                tempMenu.setFont(popup2.getFont());
                                JMenuItem tempMenuItem;
                                for (Iterator it = subcatMenu.iterator(); it.hasNext();) {
                                        GFCommand subgfcmd = (GFCommand)it.next();
                                        tempMenuItem = menuForCommand(subgfcmd);
                                        if (tempMenuItem != null) {
                                                tempMenu.add(tempMenuItem);
                                        }
                                }
                                popup2.add(tempMenu);
                        } else { 
                                JMenuItem tempMenu = menuForCommand(gfcmd);
                                if (tempMenu != null) {
                                        popup2.add(tempMenu);
                                }
                        }
                }
                return popup2;
        }
        
        /**
         * takes a GFCommand and "transforms" it in a JMenuItem.
         * These JMenuItems have their own listeners that take care of
         * doing what is right ...
         * @param gfcmd a RealCommand or an InputCommand
         * (LinkCommand is ignored and produces null as the result)
         * @return either the correspondend JMenuItem or null.
         */
        private JMenuItem menuForCommand(GFCommand gfcmd) {
                JMenuItem tempMenu = null;
                if (gfcmd instanceof RealCommand){
                        tempMenu = new JMenuItem(gfcmd.getDisplayText());
                        tempMenu.setFont(popup2.getFont());
                        tempMenu.setActionCommand(gfcmd.getCommand());
                        tempMenu.setToolTipText(gfcmd.getTooltipText());
                        tempMenu.addActionListener(new ActionListener() {
                                public void actionPerformed(ActionEvent ae) {
                                        JMenuItem mi = (JMenuItem)ae.getSource();
                                        refinementSubcatListModel.clear();
                                        String command = "[t] " + mi.getActionCommand();
                                        editor.send(command);
                                }
                        });
                } else if (gfcmd instanceof InputCommand) {
                        tempMenu = new JMenuItem(gfcmd.getDisplayText());
                        tempMenu.setFont(popup2.getFont());
                        tempMenu.setActionCommand(gfcmd.getCommand());
                        tempMenu.setToolTipText(gfcmd.getTooltipText());
                        tempMenu.addActionListener(new ActionListener() {
                                public void actionPerformed(ActionEvent ae) {
                                        JMenuItem mi = (JMenuItem)ae.getSource();
                                        String command = mi.getActionCommand();
                                        InputCommand ic = InputCommand.forTypeName(command);
                                        if (ic != null) {
                                                editor.executeInputCommand(ic);
                                        }
                                }
                        });
                        
                }
                return tempMenu;
        }
        /**
         * Takes the StringTuples in gfCommandVector, creates the RealCommand
         * objects for them.
         * Goes through this list and groups the RealCommands
         * according to their subcategory tag (which starts with %)
         * If there is a "(" afterwards, everything until the before last
         * character in the printname will be used as the display name
         * for this subcategory. If this displayname is defined a second time,
         * it will get overwritten.
         * Sorting is also done here.
         * Adding additional special commands like InputCommand happens here too.
         * @param gfCommandVector contains all RealCommands, that are available
         * at the moment
         * @param toAppend will be appended to every command, that is sent to GF.
         * Normally, toAppend will be the empty String "". 
         * But it can be a chain command's second part. 
         * @param isAbstract If the selected menu language is abstract or not
         * @param easyAttributes if true, attributes of self will be added.
         * @param focusPosition The current position of the focus in the AST. 
         * Needed for easy access to properties of self. 
         * @param gfCapsule The read/write encapsulation of the GF process.
         * Needed for easy access to properties of self.
         */
        protected void formRefinementMenu(final Vector gfCommandVector, final String toAppend, GfAstNode currentNode, final boolean isAbstract, boolean easyAttributes, LinPosition focusPosition, GfCapsule gfCapsule) {
                this.listModel.clear();
                this.refinementSubcatListModel.clear();
                this.gfcommands.clear();
                this.subcatListModelHashtable.clear();
                this.whichSubcat = null;
                this.popup2.removeAll();
                Vector prelListModel = new Vector();
                /** to keep track of subcats and their names */
                HashSet processedSubcats = new HashSet();
                //at the moment, we don't know yet, which subcats are
                //nearly empty
                for (Iterator it = gfCommandVector.iterator(); it.hasNext();) {
                        final StringTuple st = (StringTuple)it.next();
                        GFCommand gfcommand;
                        if (st instanceof ChainCommandTuple) {
                                ChainCommandTuple cct = (ChainCommandTuple)st;
                                gfcommand = new RealCommand(st.first, processedSubcats, editor.getPrintnameManager(), st.second, isAbstract, toAppend, cct.undoSteps, cct.fun, cct.subcat);
                        } else {
                                gfcommand = new RealCommand(st.first, processedSubcats, editor.getPrintnameManager(), st.second, isAbstract, toAppend);
                        }   
                        if ((!editor.isGroupSubcat()) || (gfcommand.getSubcat() == null)) {
                                prelListModel.addElement(gfcommand);
                        } else {
                                //put stuff in the correct Vector for the refinementSubcatListModel
                                Vector lm;
                                if (subcatListModelHashtable.containsKey(gfcommand.getSubcat())) {
                                        lm = (Vector)this.subcatListModelHashtable.get(gfcommand.getSubcat());
                                } else {
                                        lm = new Vector();
                                        this.subcatListModelHashtable.put(gfcommand.getSubcat(), lm);
                                }
                                lm.addElement(gfcommand);
                                if (gfcommand.isNewSubcat()) {
                                        GFCommand linkCmd = new LinkCommand(gfcommand.getSubcat(), editor.getPrintnameManager());
                                        prelListModel.addElement(linkCmd);
                                }
                        }
                }
                
                //so we remove empty subcats now and replace them by their RealCommand
                for (int i = 0; i < prelListModel.size(); i++) {
                        if (prelListModel.get(i) instanceof LinkCommand) {
                                LinkCommand lc = (LinkCommand) prelListModel.get(i);
                                Vector subcatMenu = (Vector)this.subcatListModelHashtable.get(lc.getSubcat());
                                if (subcatMenu.size() == 1) {
                                        RealCommand rc = (RealCommand)subcatMenu.get(0);
                                        prelListModel.set(i, rc);
                                }
                        }
                }
                
                
                // Some types invite special treatment, like Int and String 
                // which can be read from the user.
                if (currentNode.isMeta()) {
                        InputCommand usedInputCommand = null;
                        if (currentNode.getType().equals("Int")) {
                                usedInputCommand = InputCommand.intInputCommand;
                                prelListModel.addElement(usedInputCommand);
                        } if (currentNode.getType().equals("String")) {
                                usedInputCommand = InputCommand.stringInputCommand;
                                prelListModel.addElement(usedInputCommand);
                        }
                        if (usedInputCommand != null) {
                                for (Iterator it = usedInputCommand.enteredValues.iterator(); it.hasNext();) {
                                        Object o = it.next();
                                        //for GF it seems to make no difference, 
                                        //if we use 'g' or 'r' as the command to send 
                                        //Int and String. 'r' is already supported
                                        //by RealCommand, so I chose that.
                                        RealCommand rc = new RealCommand("r " + o, processedSubcats, editor.getPrintnameManager(), "r " + o, isAbstract, toAppend);
                                        prelListModel.addElement(rc);
                                }
                        }
                }
                
                //add the special entry for the properties of self
                if (easyAttributes) {
                        final SelfPropertiesCommand spc = new SelfPropertiesCommand(editor.getPrintnameManager(), gfCapsule, focusPosition, isAbstract, toAppend, processedSubcats);
                        prelListModel.add(spc);
                }
                
                //now sort the preliminary listmodels
                if (editor.isSortRefinements()) {
                        Collections.sort(prelListModel);
                        for (Iterator it = subcatListModelHashtable.values().iterator(); it.hasNext();) {
                                Vector slm = (Vector)it.next();
                                Collections.sort(slm);
                        }
                }
                //now fill this.listModel
                for (Iterator it = prelListModel.iterator(); it.hasNext();) {
                        Object next = it.next();
                        this.listModel.addElement(next);
                }
                //select the first command in the refinement menu, if available
                if (this.listModel.size() > 0) {
                        this.refinementList.setSelectedIndex(0);
                } else {
                        this.refinementList.setSelectedIndex(-1);
                }
                this.refinementList.setSelectionBackground(refinementSubcatList.getSelectionBackground());
        }

        /**
         * Requests the focus for the refinement list
         */
        protected void requestFocus() {
                refinementList.requestFocusInWindow();
        }
        
        /**
         * clears the list model
         */
        protected void reset() {
                listModel.clear();
        }
        
        /**
         * Applies newFont to the visible elements
         * @param newFont The new font, what else?
         */
        protected void setFont(Font newFont) {
                refinementList.setFont(newFont);
                refinementSubcatList.setFont(newFont);
                popup2.setFont(newFont);  
        }
}
