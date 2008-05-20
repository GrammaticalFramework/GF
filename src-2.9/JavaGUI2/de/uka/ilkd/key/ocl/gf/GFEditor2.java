//Copyright (c) Janna Khegai 2004, Kristofer Johanisson 2004, 
//              Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as publisrhed by
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

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.text.*;
import javax.swing.event.*;
import javax.swing.tree.*;
import java.io.*;
import java.util.*;
import java.net.URL;
import javax.swing.text.html.HTMLDocument;
import java.net.MalformedURLException;
import java.util.logging.*;
import jargs.gnu.CmdLineParser;

public class GFEditor2 extends JFrame {
        /** 
         * the main logger for this class 
         */
        private static Logger logger = Logger.getLogger(GFEditor2.class.getName());
        /** 
         * debug stuff for the tree 
         */
        private static Logger treeLogger = Logger.getLogger(DynamicTree2.class.getName());
        /** 
         * red mark-up && html debug messages 
         */
        private static Logger redLogger = Logger.getLogger(GFEditor2.class.getName() + "_Red");
        /** 
         * pop-up/mouse handling debug messages 
         */
        private static Logger popUpLogger = Logger.getLogger(GFEditor2.class.getName() + "_PopUp");
        /** 
         * linearization marking debug messages 
         */
        private static Logger linMarkingLogger = Logger.getLogger(GFEditor2.class.getName() + "_LinMarking");
        /** 
         * keyPressedEvents & Co. 
         */
        private static Logger keyLogger = Logger.getLogger(GFEditor2.class.getName() + "_key");
        /** 
         * everything that is sent to GF
         */
        private static Logger sendLogger = Logger.getLogger(GFEditor2.class.getName() + ".send");
        /**
         * the first part of the name of the GF grammar file
         */
        public final static String modelModulName = "FromUMLTypes";
        /** 
         * Does the saving of constraints in Together.
         * Or to be more precise, itself knows nothing about Together.
         * Only its subclasses. That way it can be compiled without KeY. 
         */
        final private ConstraintCallback callback;
        /**
         * if the OCL features should be switched on
         */
        final private boolean oclMode;
        
        /**
         * does all direct interaction with GF
         * (except for the probers)
         */
        private GfCapsule gfCapsule = null;
        /** 
         * current Font 
         */
        private Font font;
        /** 
         * contains the offered fonts by name 
         */
        private JMenu fontMenu;
        /** 
         * offers a list of font sizes 
         */
        private JMenu sizeMenu;

        /**
         * what is written here is parsed and the result inserted instead of tbe selection.
         * No idea how this element is displayed
         */
        private JTextField parseField = new JTextField("textField!"); 

        /**
         * The position of the focus, that is, the currently selected node in the AST
         */
        private LinPosition focusPosition ;
        /**
         * When a new category is chosen, it is set to true. 
         * In the reset or a completely new state it is falsed.
         * The structure of the GF output is different then and this must be taken
         * care of.
         */
        private boolean newObject = false;
        /**
         * if the user enters text for the alpha conversion, he perhaps wants to input the same text again.
         * Therefore it is saved.
         */
        private String alphaInput = "";
        /**
         * if a user sends a custom command to GF, he might want to do this 
         * again with the same command.
         * Therefore it is saved.
         */
        private String commandInput = "";
        
        /**
         * default status text, just status
         */
        private final static String status = "status";
        /**
         * the language the possible actions are displayed 
         */
        private String selectedMenuLanguage = "Abstract";
        /**
         * write-only variable, stores the current import paths
         * reset after each reset.
         */
        private String fileString = "";
        /**
         * The mapping between Java tree pathes and GF AST positions 
         * is stored here.
         */
        private Hashtable nodeTable = new Hashtable();
        /**
         * This is necessary to map clicks in the tree, where in the event handler
         * only the selection path is availble, to AST positions which can be
         * sent to GF. 
         * @param key The TreeSelectionPath, that identifies the wanted node
         * @return The AST position string of the given TreePath in the table
         * of stored nodes.
         */
        protected String getNodePosition(Object key) {
                return nodeTable.get(key).toString();
        }
        /**
         * this FileChooser gets enriched with the Term/Text option 
         */
        private JFileChooser saveFc = new  JFileChooser("./");
        /** used for new Topic, Import and Browse (readDialog) */
        private JFileChooser fc = new  JFileChooser("./");
        private final static String [] modifyMenu = {"Modify", "identity","transfer", 
                        "compute", "paraphrase", "generate","typecheck", "solve", "context" };
        private static final String [] newMenu = {"New"};
        
        /** 
         * Linearizations' display area 
         */
        private JTextArea linearizationArea = new JTextArea();
        /**
         * The abstract syntax tree representation of the current editing object
         */
        private DynamicTree2 tree = new DynamicTree2(this);
        
        /** 
         * Current Topic 
         */
        private JLabel grammar = new JLabel("No topic          ");
        /**
         * Writing the current editing object to file in the term or text 
         * format
         */
        private JButton save = new JButton("Save");
        /**
         * Reading both a new environment and an editing object from file.
         * Current editing will be discarded
         */
        private JButton open = new JButton("Open");
        /**
         * Reading a new environment from file. Current editing will be 
         * discarded.
         */
        private JButton newTopic;
        /** Sending a command to GF */
        private JButton gfCommand;   
        
        /** Moving the focus to the previous metavariable */
        private JButton leftMeta = new JButton("?<");
        /** Moving the focus to the previous term */
        private JButton left = new JButton("<");
        /** Moving the focus to the top term */
        private JButton top = new JButton("Top");
        /** Moving the focus to the next term */
        private JButton right = new JButton(">");
        /** Moving the focus to the next metavariable */
        private JButton rightMeta = new JButton(">?");
        private final static String actionOnSubtermString = "Select Action on Subterm";
        private JLabel subtermNameLabel = new JLabel();
        private JLabel subtermDescLabel = new JLabel();
        /** Refining with term or linearization from typed string or file */
        private JButton read = new JButton("Read");   
        /** Performing alpha-conversion of bound variables */
        private JButton alpha;
        /** Generating random refinement */
        private JButton random;
        /** Going back to the previous state */
        private JButton undo;
        /** The main panel on which the others are put */
        private JPanel coverPanel = new JPanel();
        /** the dialog to read in Strings or Terms */
        private ReadDialog readDialog;

        /** The list of available categories to start editing */
        private JComboBox newCategoryMenu = new JComboBox(newMenu);
        /** Choosing a linearization method */
        private JComboBox modify = new JComboBox(modifyMenu);   
        /** the panel with the more general command buttons */
        private JPanel downPanel = new JPanel();
        /** the splitpane containing tree on the left and linearization area on the right*/
        private JSplitPane treePanel;
        /** the upper button bar for New, Save */
        private JPanel upPanel = new JPanel();
        /** the panel that contains the navigation buttons and some explanatory text */
        private JPanel middlePanel = new JPanel();
        /** the panel that contains only the navigation buttons */
        private JPanel middlePanelUp = new JPanel();
        /** the panel that vontains the the explanatory text for the refinement menu */
        private JPanel middlePanelDown = new JPanel(new BorderLayout());
        /** splits between tree and lin above and nav buttons and refinements below */
        private JSplitPane centerPanel;
        /** the window that contains the refinements when in split mode */
        private JFrame gui2 = new JFrame();
        /** the main window with tree, lin and buttons when in split mode */
        private JPanel centerPanel2= new JPanel();
        /** contains refinment list and navigation buttons */
        private JPanel centerPanelDown = new JPanel();
        /** only contains the linearization area */
        private JScrollPane outputPanelText = new JScrollPane(this.linearizationArea);
        /** HTML Linearizations' display area */
        private JTextPane htmlLinPane = new JTextPane();
        /** only contains the HTML linearization area */
        private JScrollPane outputPanelHtml = new JScrollPane(this.htmlLinPane);
        /** contains both pure text and HTML areas */
        private JSplitPane linSplitPane;
        /** contains the linSplitPane and the status field below it */
        private JPanel outputPanelUp = new JPanel(new BorderLayout());
        /** contains statusLabel */
        private JPanel statusPanel = new JPanel();
        /** The type the currently focused term has */
        private JLabel statusLabel = new JLabel(status);
        /** the main menu in the top */
        private JMenuBar menuBar= new JMenuBar();
        /** View settings */
        private JMenu viewMenu= new JMenu("View");
        /**
         * stores a list of all languages + abstract to select the language, 
         * in which the selectMenu will be filled.
         */
        private JMenu mlMenu= new JMenu("language");
        /** Choosing the refinement options' representation */
        private JMenu modeMenu= new JMenu("Menus");
        /** Language settings */
        private JMenu langMenu= new JMenu("Languages");
        /** Main operations */
        private JMenu fileMenu= new JMenu("File");
        /** stores whether the refinement list should be in 'long' format */
        private JRadioButtonMenuItem rbMenuItemLong;
        /** stores whether the refinement list should be in 'short' format */
        private JRadioButtonMenuItem rbMenuItemShort;
        /** stores whether the refinement list should be in 'untyped' format */
        private JRadioButtonMenuItem rbMenuItemUnTyped;
        /** 
         * linked to rbMenuItemUnTyped. 
         * Is true if type information should be appended in the refinement menu
         */
        private boolean typedMenuItems = false;
        /** stores whether the AST is visible or not */
        private JCheckBoxMenuItem treeCbMenuItem;
        /** in the save dialog whether to save as a Term or as linearized Text */
        private ButtonGroup saveTypeGroup = new ButtonGroup();
        /** the entries of the filter menu */
        private final static String [] filterMenuContents = {"identity", 
                        "erase", "take100", "text", "code", "latexfile", 
                        "structured", "unstructured" };
        /** Choosing the linearization representation format */
        private JMenu filterMenu = new JMenu("Filter");
        /** for managing the filter menu entries*/
        private ButtonGroup filterButtonGroup = new ButtonGroup();
        
        /** Some usability things can be switched off here for testing */
        private JMenu usabilityMenu= new JMenu("Usability");
        /** 
         * stores whether self and result should only be made visible 
         * if applicable 
         */
        private JCheckBoxMenuItem selfresultCbMenuItem;
        /** to switch grouping of entries in the refinement menu on and off */
        private JCheckBoxMenuItem subcatCbMenuItem;
        /** to switch sorting of entries in the refinement menu on and off */
        private JCheckBoxMenuItem sortCbMenuItem;
        /** to switch autocoercing */
        private JCheckBoxMenuItem coerceCbMenuItem;
        /** to switch reducing the argument 3 refinement menu of coerce on or off */
        private JCheckBoxMenuItem coerceReduceCbMenuItem;
        /** to switch highlighting subtyping errors on or off */
        private JCheckBoxMenuItem highlightSubtypingErrorsCbMenuItem;
        /** to switch hiding coerce on or off */
        private JCheckBoxMenuItem hideCoerceCbMenuItem;
        /** to switch hiding coerce even if parts are unrefined on or off */
        private JCheckBoxMenuItem hideCoerceAggressiveCbMenuItem;
        /** to switch the attributes of self in the refinement menu on or off */
        private JCheckBoxMenuItem easyAttributesCbMenuItem;
        
        /** 
         * if true, self and result are only shown if applicable, 
         * tied to @see selfresultCbMenuItem
         */  
        private boolean showSelfResult = true;
        /** 
         * if true, refinements are grouped by subcat 
         * tied to @see subcatCbMenuItem.
         */  
        private boolean groupSubcat = true;
        /**
         * @return Returns whether subcategories should be grouped or not
         */
        protected boolean isGroupSubcat() {
                return groupSubcat;
        }        
        /** 
         * if true, refinements are grouped by subcat. 
         * tied to @see subcatCbMenuItem.
         */  
        private boolean sortRefinements = true;
        /**
         * @return Returns if the refinements should get sorted.
         */
        protected boolean isSortRefinements() {
                return sortRefinements;
        }
        /**
         * if true, then Instances will automatically get wrapped with a coerce
         * if encountered as meta in the active node
         */
        private boolean autoCoerce = false;
        /**
         * If this is true, the refinementmenu for argument 3 of coerce
         * will be populated only with suiting refinements.
         */
        private boolean coerceReduceRM = false;
        /**
         * If true, then the AST will be checked for missing subtyping witnesses
         */
        private boolean highlightSubtypingErrors = false;
        /**
         * if true, filled in coercions will be hidden from the user
         */
        private boolean hideCoerce = false;
        /**
         * if true, filled in coercions will be hidden from the user
         * even if they lack filled in type arguments
         */
        private boolean hideCoerceAggressive = false;
        /**
         * offer the attributes of self directly in the refinement menu
         */
        private boolean easyAttributes = false;
        
        
        /** 
         * handles all the Printname naming and so on.
         */
        private PrintnameManager printnameManager;
        /**
         * @return Returns the printnameManager.
         */
        protected PrintnameManager getPrintnameManager() {
                return printnameManager;
        }

        
        /** 
         * stores the current type. Since the parsing often fails, this is
         * most often null, except for Int and String, which can be parsed.
         */
        private GfAstNode currentNode = null;
        /** stores the displayed parts of the linearization */
        private Display display = new Display(3);

        /** takes care of the menus that display the available languages */
        private LangMenuModel langMenuModel = new LangMenuModel();
        
        //Now the stuff for choosing the wanted output type (pure text or HTML)
        /**
         * 1 for text, 2 for HTML, 3 for both 
         */
        private int displayType = 1;
        /**
         * rbText, rbHtml and rbTextHtml are grouped here.
         */
        private ButtonGroup bgDisplayType = new ButtonGroup();
        /**
         * The button that switches the linearization view to text only
         */
        private JRadioButtonMenuItem rbText = new JRadioButtonMenuItem(new AbstractAction("pure text") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 1;
                        display.setDisplayType(displayType);
                        outputPanelUp.removeAll();
                        outputPanelUp.add(outputPanelText, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType == 2) { //not manually called in the beginning and only HTML
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        /**
         * The button that switches the linearization view to HTML only
         */
        private JRadioButtonMenuItem rbHtml = new JRadioButtonMenuItem(new AbstractAction("HTML") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 2;
                        display.setDisplayType(displayType);
                        outputPanelUp.removeAll();
                        outputPanelUp.add(outputPanelHtml, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType == 1) { //not manually called in the beginning and only text
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        /**
         * The button that switches the linearization view to both text and 
         * HTML separated with a JSplitpane
         */
        private JRadioButtonMenuItem rbTextHtml = new JRadioButtonMenuItem(new AbstractAction("text and HTML") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 3;
                        display.setDisplayType(displayType);
                        linSplitPane.setLeftComponent(outputPanelText);
                        linSplitPane.setRightComponent(outputPanelHtml);
                        outputPanelUp.removeAll();
                        outputPanelUp.add(linSplitPane, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType != 3) { //not manually called in the beginning and not both (the latter should always be true)
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        
        /**
         * Since the user will be able to send chain commands to GF,
         * the editor has to keep track of them, since GF does not undo
         * all parts with one undo, instead 'u n' with n as the number of
         * individual commands, has to be sent.
         */
        private final Stack undoStack = new Stack();
        
        /**
         * for starting a SubtypingProber run
         */
        private JButton checkSubtyping;
        
        /**
         * handles the commands and how they are presented to the user
         */
        private RefinementMenu refinementMenu;
        /**
         * handles parsing and preparing for display
         * of the linearization XML from GF.
         * Also takes care of the click-in functionality.
         */
        private Linearization linearization;
        
        /**
         * Initializes GF with the given command, sets up the GUI
         * and reads the first GF output
         * @param gfcmd The command with all parameters, including -java
         * that is to be executed. Will set up the GF side of this session.
         * @param isHtml true iff the editor should start in HTML mode.
         * @param baseURL the URL that is the base for all relative links in HTML
         * @param isOcl if the OCL special features should be available
         */
        public GFEditor2(String gfcmd, boolean isHtml, URL baseURL, boolean isOcl) {
                this.callback = null;
                this.oclMode = isOcl;
                Image icon = null;
                try {
                final URL iconURL = ClassLoader.getSystemResource("gf-icon.gif");
                icon = Toolkit.getDefaultToolkit().getImage(iconURL);
                } catch (NullPointerException npe) {
                        logger.info("gf-icon.gif could not be found.\n" + npe.getLocalizedMessage());
                }
                initializeGUI(baseURL, isHtml, icon);
                initializeGF(gfcmd, null);                
        }
        
        /**
         * a specialized constructor for OCL comstraints
         * Starts with a new Constraint and an initial syntax tree
         * @param gfcmd The command with all parameters, including -java
         * that is to be executed. Will set up the GF side of this session.
         * @param callback The class responsible for saving the OCL constraint
         * as a JavaDoc comment 
         * @param initAbs the initial abstract syntax tree
         * @param pm to monitor the loading progress. May be null
         */
        public GFEditor2(String gfcmd, ConstraintCallback callback, String initAbs, ProgressMonitor pm) {
                this.oclMode = true;
                this.callback = callback;
                
                Utils.tickProgress(pm, 5220, "Loading grammars");
                initializeGF(gfcmd, pm);
                Utils.tickProgress(pm, 9350, "Initializing GUI");
                initializeGUI(null, true, null);
                
                // send correct term (syntax tree)
                //The initial GF constraint has until now always been 
                //automatically solvable. So don't startle the user
                //with painting everything red.
                send(initAbs + " ;; c solve ", false, 2);
                processGfedit();
                Utils.tickProgress(pm, 9700, "Loading finished");
                pm.close();
                logger.finer("GFEditor2 constructor finished");
        }

        /**
         * Starts GF and sets up the reading facilities.
         * Shouldn't be called twice.
         * @param gfcmd The command for GF to be executed.
         * expects the -java parameters and all grammar modules
         * to be specified. Simply executes this command without any
         * modifications.
         * @param pm to monitor the loading progress. May be null
         */
        private void initializeGF(String gfcmd, ProgressMonitor pm){
                        Utils.tickProgress(pm, 5250, "Starting GF");
                        logger.fine("Trying: "+gfcmd);
                        gfCapsule = new GfCapsule(gfcmd);
                        processInit(pm, true);
                        resetPrintnames(false);
        }

        /**
         * (re-)initializes this.printnameManager and loads the printnames from
         * GF.
         * @param replayState If GF should be called to give the same state as before,
         * but without the message. Is needed, when this function is started by the user.
         * If sth. else is sent to GF automatically, this is not needed.
         */
        private void resetPrintnames(boolean replayState) {
                this.printnameManager = new PrintnameManager();
                PrintnameLoader pl = new PrintnameLoader(gfCapsule, this.printnameManager, this.typedMenuItems);
                if (!selectedMenuLanguage.equals("Abstract")) {
                        String sendString = selectedMenuLanguage;
                        pl.readPrintnames(sendString);
                        //empty GF command, clears the message, so that the printnames
                        //are not printed again when for example a 'ml' command comes
                        //next
                        if (replayState) {
                                send("gf ", true, 0);
                        }
                }
        }
        /**
         * reliefs the constructor from setting up the GUI stuff
         * @param baseURL the base URL for relative links in the HTML view
         * @param showHtml if the linearization area for HTML should be active
         * instead of the pure text version
         * @param icon The icon in the title bar of the main window.
         * For KeY-usage, no icon is given and the Swing default is chosen
         * instead. 
         */
        private void initializeGUI(URL baseURL, boolean showHtml, Image icon) {
                refinementMenu = new RefinementMenu(this);
                this.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
                this.addWindowListener(new WindowAdapter() {
                        public void windowClosing(WindowEvent e) {
                                endProgram();
                        }
                });
                setIconImage(icon);
                this.readDialog = new ReadDialog(this);
                
                //Add listener to components that can bring up popup menus.
                MouseListener popupListener2 = new PopupListener();
                linearizationArea.addMouseListener(popupListener2);
                htmlLinPane.addMouseListener(popupListener2);
                
                //now for the menus
                
                setJMenuBar(menuBar);
                setTitle("GF Syntax Editor");
                viewMenu.setToolTipText("View settings");        
                fileMenu.setToolTipText("Main operations");
                langMenu.setToolTipText("Language settings");
                usabilityMenu.setToolTipText("Usability settings");
                menuBar.add(fileMenu);
                menuBar.add(langMenu);                        
                menuBar.add(viewMenu);
                menuBar.add(modeMenu);
                menuBar.add(usabilityMenu);
                modeMenu.setToolTipText("Choosing the refinement options' representation");
                
                /**
                 * listens to the showTree JCheckBoxMenuItem and
                 * switches displaying the AST on or off
                 */
                final ActionListener showTreeListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                if (!((JCheckBoxMenuItem)e.getSource()).isSelected()){
                                        if (logger.isLoggable(Level.FINER)) logger.finer("showTree was selected");
                                        treeCbMenuItem.setSelected(false);
                                        if (((JRadioButtonMenuItem)viewMenu.getItem(2)).isSelected()) {      
                                                centerPanel.remove(treePanel);
                                                centerPanel.setLeftComponent(outputPanelUp); 
                                        }
                                        else {
                                                centerPanel2.remove(treePanel);
                                                centerPanel2.add(outputPanelUp, BorderLayout.CENTER); 
                                        }
                                }
                                else { 
                                        if (logger.isLoggable(Level.FINER)) logger.finer("showTree was not selected");
                                        treeCbMenuItem.setSelected(true);
                                        if (((JRadioButtonMenuItem)viewMenu.getItem(2)).isSelected()) {      
                                                centerPanel.remove(outputPanelUp);
                                                treePanel.setRightComponent(outputPanelUp);
                                                centerPanel.setLeftComponent(treePanel);
                                        }
                                        else {
                                                centerPanel2.remove(outputPanelUp);
                                                treePanel.setRightComponent(outputPanelUp);
                                                centerPanel2.add(treePanel, BorderLayout.CENTER);
                                        }                    
                                }
                                pack();
                                repaint();
                        }
                        
                };
                
                treeCbMenuItem = new JCheckBoxMenuItem("Tree");
                treeCbMenuItem.setActionCommand("showTree");
                treeCbMenuItem.addActionListener(showTreeListener);
                treeCbMenuItem.setSelected(true);
                
                viewMenu.add(treeCbMenuItem);
                viewMenu.addSeparator();

                final Action saveAction = new SaveAction();
                final Action openAction = new OpenAction();
                final Action newTopicAction = new NewTopicAction();
                final Action resetAction = new ResetAction();
                final Action quitAction = new QuitAction();
                final Action undoAction = new UndoAction();
                final Action randomAction = new RandomAction();
                final Action alphaAction = new AlphaAction();
                final Action gfCommandAction = new GfCommandAction();
                final Action readAction = new ReadAction();
                final Action splitAction = new SplitAction();
                final Action combineAction = new CombineAction();
                                
                JMenuItem fileMenuItem = new JMenuItem(openAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(newTopicAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(resetAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(saveAction);
                fileMenu.add(fileMenuItem);
                fileMenu.addSeparator();
                fileMenuItem = new JMenuItem(quitAction);
                fileMenu.add(fileMenuItem);
                
                JRadioButtonMenuItem rbMenuItem = new JRadioButtonMenuItem(combineAction);
                rbMenuItem.setSelected(true);
                /*        rbMenuItem.setMnemonic(KeyEvent.VK_R);
                 rbMenuItem.setAccelerator(KeyStroke.getKeyStroke(
                 KeyEvent.VK_1, ActionEvent.ALT_MASK));
                 rbMenuItem.getAccessibleContext().setAccessibleDescription(
                 "This doesn't really do anything");
                 */
                ButtonGroup menuGroup = new ButtonGroup();
                menuGroup.add(rbMenuItem);
                viewMenu.add(rbMenuItem);
                
                rbMenuItem = new JRadioButtonMenuItem(splitAction);
                menuGroup.add(rbMenuItem);
                viewMenu.add(rbMenuItem);
                
                //Font stuff
                final int DEFAULT_FONT_SIZE = 14;
                GraphicsEnvironment gEnv = GraphicsEnvironment.getLocalGraphicsEnvironment();
                /** The list of font names our environment offers us */
                String[] envfonts = gEnv.getAvailableFontFamilyNames();
 
                /** the list of fonts the environment offers us */
                Font[] fontObjs = new Font[envfonts.length];
                for (int fi = 0; fi < envfonts.length; fi++) {
                        fontObjs[fi] = new Font(envfonts[fi], Font.PLAIN,
                                        DEFAULT_FONT_SIZE);
                }
                font = new Font(null, Font.PLAIN, DEFAULT_FONT_SIZE);
                //font menus
                viewMenu.addSeparator();
                fontMenu = new JMenu("Font");
                fontMenu.setToolTipText("Change font");
                sizeMenu = new JMenu("Font Size");
                sizeMenu.setToolTipText("Change font size");
                viewMenu.add(sizeMenu);
                viewMenu.add(fontMenu);

               {
                        JMenuItem fontItem;
                        ActionListener fontListener = new ActionListener(){
                                public void actionPerformed(ActionEvent ae) {
                                        try {
                                                JMenuItem source = (JMenuItem)ae.getSource();
                                                font = new Font(source.getText(), Font.PLAIN, font.getSize());
                                                fontEveryWhere(font);
                                        } catch (ClassCastException e) {
                                                logger.warning("Font change started on strange object\n" + e.getLocalizedMessage());
                                        }
                                }
                        };                        
                        for (int i = 0; i < envfonts.length; i++) {
                                fontItem = new JMenuItem(envfonts[i]);
                                fontItem.addActionListener(fontListener);
                                fontItem.setFont(new Font(envfonts[i], Font.PLAIN, font.getSize()));
                                fontMenu.add(fontItem);
                        }
                }
                {
                        JMenuItem sizeItem;
                        ActionListener sizeListener = new ActionListener(){
                                public void actionPerformed(ActionEvent ae) {
                                        try {
                                                JMenuItem source = (JMenuItem)ae.getSource();
                                                font = new Font(font.getFontName(), Font.PLAIN, Integer.parseInt(source.getText()));
                                                fontEveryWhere(font);
                                        } catch (ClassCastException e) {
                                                logger.warning("Font change started on strange object\n" + e.getLocalizedMessage());
                                        } catch (NumberFormatException e) {
                                                logger.warning("strange size entry\n" + e.getLocalizedMessage());
                                        }
                                }
                        };
                        /** The list of offered font sizes */
                        int[] sizes = {14,18,22,26,30};
                        for (int i = 0; i < sizes.length; i++) {
                                sizeItem = new JMenuItem("" + sizes[i]);
                                sizeItem.addActionListener(sizeListener);
                                sizeMenu.add(sizeItem);
                        }
                }
                //font stuff over

                filterMenu.setToolTipText("Choosing the linearization representation format");
                {
		                ActionListener filterActionListener = new ActionListener() {
		                        public void actionPerformed(ActionEvent ae) {
		                                JMenuItem jmi = (JMenuItem)ae.getSource();
		                                final String sendString = "f " + jmi.getActionCommand(); 
		                                send(sendString);
		                        }
		                };
		                JRadioButtonMenuItem jrbmi;
		                for (int i = 0; i < filterMenuContents.length; i++) {
		                        jrbmi = new JRadioButtonMenuItem(filterMenuContents[i]);
		                        jrbmi.setActionCommand(filterMenuContents[i]);
		                        jrbmi.addActionListener(filterActionListener);
		                        filterButtonGroup.add(jrbmi);
		                        filterMenu.add(jrbmi);
		                }
                }
                viewMenu.addSeparator();
                viewMenu.add(filterMenu);
                
                mlMenu.setToolTipText("the language of the entries in the refinement menu");
                modeMenu.add(mlMenu);
                /**
                 * switches GF to either display the refinement menu commands
                 * either in long or short format
                 */
                final ActionListener longShortListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                String action = e.getActionCommand();
                                if ((action.equals("long")) || (action.equals("short"))) {
                                        send("ms " + action);
                                        return;
                                } else {
                                        logger.warning("RadioListener on wrong object: " + action + "should either be 'typed' or 'untyped'");
                                }
                        }
                };

                modeMenu.addSeparator();              
                menuGroup = new ButtonGroup();
                rbMenuItemLong = new JRadioButtonMenuItem("long");
                rbMenuItemLong.setToolTipText("long format in the refinement menu, e.g. 'refine' instead of 'r'");
                rbMenuItemLong.setActionCommand("long");
                rbMenuItemLong.addActionListener(longShortListener);
                menuGroup.add(rbMenuItemLong);
                modeMenu.add(rbMenuItemLong);
                rbMenuItemShort = new JRadioButtonMenuItem("short");
                rbMenuItemShort.setToolTipText("short format in the refinement menu, e.g. 'r' instead of 'refine'");
                rbMenuItemShort.setActionCommand("short");
                rbMenuItemShort.setSelected(true);
                rbMenuItemShort.addActionListener(longShortListener);
                menuGroup.add(rbMenuItemShort);
                modeMenu.add(rbMenuItemShort);
                modeMenu.addSeparator();
                
                /**
                 * switches GF to either display the refinement menu with or 
                 * without type annotation ala " : Type"
                 */
                final ActionListener unTypedListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                String action = e.getActionCommand();
                                if ((action.equals("typed")) || (action.equals("untyped"))) {
                                        send("mt " + action);
                                        if ((action.equals("typed"))) {
                                                typedMenuItems = true;
                                        } else {
                                                typedMenuItems = false;
                                        }
                                        resetPrintnames(true);
                                        return;
                                } else {
                                        logger.warning("RadioListener on wrong object: " + action + "should either be 'typed' or 'untyped'");
                                }
                        }
                };
                menuGroup = new ButtonGroup();
                rbMenuItem = new JRadioButtonMenuItem("typed");
                rbMenuItem.setToolTipText("append the respective types to the entries of the refinement menu");
                rbMenuItem.setActionCommand("typed");
                rbMenuItem.addActionListener(unTypedListener);
                rbMenuItem.setSelected(false);
                menuGroup.add(rbMenuItem);
                modeMenu.add(rbMenuItem);
                rbMenuItemUnTyped = new JRadioButtonMenuItem("untyped");
                rbMenuItemUnTyped.setToolTipText("omit the types of the entries of the refinement menu");
                rbMenuItemUnTyped.setSelected(true);
                rbMenuItemUnTyped.setActionCommand("untyped");
                rbMenuItemUnTyped.addActionListener(unTypedListener);
                menuGroup.add(rbMenuItemUnTyped);
                modeMenu.add(rbMenuItemUnTyped);
                
                
                //usability menu
                subcatCbMenuItem = new JCheckBoxMenuItem("group possible refinements");
                subcatCbMenuItem.setActionCommand("subcat");
                subcatCbMenuItem.setToolTipText("group the entries of the refinement menus as defined in the printnames for the selected menu language");
                subcatCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                groupSubcat = subcatCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                subcatCbMenuItem.setSelected(groupSubcat);
                usabilityMenu.add(subcatCbMenuItem);                
                
                sortCbMenuItem = new JCheckBoxMenuItem("sort refinements");
                sortCbMenuItem.setActionCommand("sortRefinements");
                sortCbMenuItem.setToolTipText("sort the entries of the refinement menu");
                sortCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                sortRefinements = sortCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                sortCbMenuItem.setSelected(sortRefinements);
                usabilityMenu.add(sortCbMenuItem);
                
                //OCL specific stuff
                
                if (oclMode) {
                        usabilityMenu.addSeparator();
                }
                selfresultCbMenuItem = new JCheckBoxMenuItem("skip self&result if possible");
                selfresultCbMenuItem.setToolTipText("do not display self and result in the refinement menu, if they don't fit");
                selfresultCbMenuItem.setActionCommand("selfresult");
                selfresultCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                showSelfResult = selfresultCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                selfresultCbMenuItem.setSelected(showSelfResult);
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(selfresultCbMenuItem);
                }

                coerceReduceCbMenuItem = new JCheckBoxMenuItem("only suiting subtype instances for coerce");
                coerceReduceCbMenuItem.setToolTipText("For coerce, where the target type is already known, show only the functions that return a subtype of this type.");
                coerceReduceCbMenuItem.setActionCommand("coercereduce");
                coerceReduceCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                coerceReduceRM = coerceReduceCbMenuItem.isSelected();
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(coerceReduceCbMenuItem);
                        coerceReduceRM = true;
                }
                coerceReduceCbMenuItem.setSelected(coerceReduceRM);
                
                coerceCbMenuItem = new JCheckBoxMenuItem("coerce automatically");
                coerceCbMenuItem.setToolTipText("Fill in coerce automatically where applicable");
                coerceCbMenuItem.setActionCommand("autocoerce");
                coerceCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                autoCoerce = coerceCbMenuItem.isSelected();
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(coerceCbMenuItem);
                        autoCoerce = true;
                }
                coerceCbMenuItem.setSelected(autoCoerce);
                
                highlightSubtypingErrorsCbMenuItem = new JCheckBoxMenuItem("highlight suptyping errors");
                highlightSubtypingErrorsCbMenuItem.setToolTipText("Mark nodes in situations, if where a non-existing subtyping is expected.");
                highlightSubtypingErrorsCbMenuItem.setActionCommand("highlightsubtypingerrors");
                highlightSubtypingErrorsCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                highlightSubtypingErrors = highlightSubtypingErrorsCbMenuItem.isSelected();
                                send("[t] gf");
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(highlightSubtypingErrorsCbMenuItem);
                        highlightSubtypingErrors = true;
                }
                highlightSubtypingErrorsCbMenuItem.setSelected(highlightSubtypingErrors);
                
                hideCoerceCbMenuItem = new JCheckBoxMenuItem("hide coerce if completely refined");
                hideCoerceCbMenuItem.setToolTipText("<html>Hide coerce functions when all arguments are filled in.<br>Note that, when a subtyping error is introduced, they will be shown.</html>");
                hideCoerceCbMenuItem.setActionCommand("hideCoerce");
                hideCoerceCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                hideCoerce = hideCoerceCbMenuItem.isSelected();
                                //hideCoerceAggressiveCbMenuItem can only be used,
                                //if hideCoerce is active. But its state should survive.
                                hideCoerceAggressiveCbMenuItem.setEnabled(hideCoerce);
                                if (hideCoerce) {
                                        hideCoerceAggressive = hideCoerceAggressiveCbMenuItem.isSelected();
                                } else {
                                        hideCoerceAggressive = false;
                                }
                                send("[t] gf ", true, 0);
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(hideCoerceCbMenuItem);
                        hideCoerce = true;
                }
                hideCoerceCbMenuItem.setSelected(hideCoerce);

                
                hideCoerceAggressiveCbMenuItem = new JCheckBoxMenuItem("hide coerce always");
                hideCoerceAggressiveCbMenuItem.setActionCommand("hideCoerceAggressive");
                hideCoerceAggressiveCbMenuItem.setToolTipText("<html>Hide coerce functions even if the type arguments are incomplete.<br>Note that, when a subtyping error is introduced, they will be shown.</html>");
                hideCoerceAggressiveCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                hideCoerceAggressive = hideCoerceAggressiveCbMenuItem.isSelected();
                                send("[t] gf ", true, 0);
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(hideCoerceAggressiveCbMenuItem);
                        hideCoerceAggressive = true;
                }
                hideCoerceAggressiveCbMenuItem.setSelected(hideCoerceAggressive);                
              

                easyAttributesCbMenuItem = new JCheckBoxMenuItem("directly offer attributes of 'self'");
                easyAttributesCbMenuItem.setActionCommand("easyAttributes");
                easyAttributesCbMenuItem.setToolTipText("list suiting attributes of self directly in the refinement menu");
                easyAttributesCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                easyAttributes = easyAttributesCbMenuItem.isSelected();
                                send("[t] gf ", true, 0);
                        }
                });
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(easyAttributesCbMenuItem);
                        easyAttributes = true;
                }
                easyAttributesCbMenuItem.setSelected(easyAttributes);                
                
                //now for the other elements
                
                //HTML components
                this.htmlLinPane.setContentType("text/html");
                this.htmlLinPane.setEditable(false);
                if (this.htmlLinPane.getStyledDocument() instanceof HTMLDocument) {
                        try {
                                URL base;
                                if (baseURL == null) {
                                        base = (new File("./")).toURL();
                                } else {
                                        base = baseURL;
                                }
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("base for HTML: " + base);
                                }
                                ((HTMLDocument)this.htmlLinPane.getDocument()).setBase(base);
                        } catch (MalformedURLException me) {
                                logger.severe(me.getLocalizedMessage());
                        }
	            } else {
	                    logger.warning("No HTMLDocument: " + this.htmlLinPane.getDocument().getClass().getName());
	            }
                this.htmlLinPane.addCaretListener(new CaretListener() {
                        /**
                         * One can either click on a leaf in the lin area, or select a larger subtree.
                         * The corresponding tree node is selected.
                         */
                        public void caretUpdate(CaretEvent e) {
                                int start = htmlLinPane.getSelectionStart(); 
                                int end   = htmlLinPane.getSelectionEnd();
                                if (popUpLogger.isLoggable(Level.FINER)) {
                                        popUpLogger.finer("CARET POSITION: " + htmlLinPane.getCaretPosition()
                                                        + "\n-> SELECTION START POSITION: "+start
                                                        + "\n-> SELECTION END POSITION: "+end);
                                }
                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                        if (end > 0 && (end < htmlLinPane.getDocument().getLength())) {
                                                try {
                                                        linMarkingLogger.finer("CHAR: " + htmlLinPane.getDocument().getText(end, 1));
                                                } catch (BadLocationException ble) {
                                                        linMarkingLogger.warning(ble.getLocalizedMessage());
                                                }
                                        }
                                }
                                // not null selection:
                                if (start < htmlLinPane.getDocument().getLength()) {
                                        String position = linearization.markedAreaForPosHtml(start, end);
                                        if (position != null) {
                                                send("[t] mp " + position);
                                        }
                                }//not null selection
                        }

                });
                this.linSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
                                this.outputPanelText, outputPanelHtml);
                
                //cp = getContentPane();
                JScrollPane cpPanelScroll = new JScrollPane(coverPanel); 
                this.getContentPane().add(cpPanelScroll);
                coverPanel.setLayout(new BorderLayout());
                linearizationArea.setToolTipText("Linearizations' display area");   
                linearizationArea.addCaretListener(new CaretListener() {
                        /**
                         * One can either click on a leaf in the lin area, or select a larger subtree.
                         * The corresponding tree node is selected.
                         */
                        public void caretUpdate(CaretEvent e) {
                                int start = linearizationArea.getSelectionStart();
                                int end = linearizationArea.getSelectionEnd();
                                if (popUpLogger.isLoggable(Level.FINER)) {
                                        popUpLogger.finer("CARET POSITION: "+linearizationArea.getCaretPosition()
                                                        + "\n-> SELECTION START POSITION: "+start
                                                        + "\n-> SELECTION END POSITION: "+end);
                                }
                                final int displayedTextLength = linearizationArea.getText().length();
                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                        if (end>0&&(end<displayedTextLength)) { 
                                                linMarkingLogger.finer("CHAR: "+linearizationArea.getText().charAt(end));
                                        }
                                }
                                // not null selection:
                                if (start < displayedTextLength) { //TODO was -1 before, why?
                                        String position = linearization.markedAreaForPosPureText(start, end);
                                        if (position != null) {
                                                send("[t] mp " + position);
                                        }
                                }//not null selection
                        }
                        
                });
                linearizationArea.setEditable(false);
                linearizationArea.setLineWrap(true);
                linearizationArea.setWrapStyleWord(true);

                parseField.setFocusable(true);
                parseField.addKeyListener(new KeyListener() {
                        /** Handle the key pressed event. */
                        public void keyPressed(KeyEvent e) {
                                int keyCode = e.getKeyCode();   
                                if (keyLogger.isLoggable(Level.FINER)) {
                                        keyLogger.finer("Key pressed: " + e.toString());
                                }

        		                if  (keyCode == KeyEvent.VK_ENTER) { 
        		                        getLayeredPane().remove(parseField); 
        		                        send("[t] p "+parseField.getText());        
        		                        if (logger.isLoggable(Level.FINE)) logger.fine("sending parse string: "+parseField.getText());
        		                        repaint();
        		                } else if  (keyCode == KeyEvent.VK_ESCAPE) { 
        		                        getLayeredPane().remove(parseField);   
        		                        repaint();
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
                parseField.addFocusListener(new FocusListener() {
                        public void focusGained(FocusEvent e) {
                                //do nothing
                        }
                        public void focusLost(FocusEvent e) {
                                getLayeredPane().remove(parseField);
                                repaint();
                        }
                });
                //                System.out.println(output.getFont().getFontName());

                
                //Now for the command buttons in the lower part
                gfCommand = new JButton(gfCommandAction);
                read = new JButton(readAction);
                modify.setToolTipText("Choosing a linearization method");
                alpha = new JButton(alphaAction);
                random = new JButton(randomAction);
                undo = new JButton(undoAction);
                checkSubtyping = new JButton(new SubtypeAction());
                downPanel.add(gfCommand);
                downPanel.add(read);  
                downPanel.add(modify);   
                downPanel.add(alpha);     
                downPanel.add(random);
                downPanel.add(undo);
                if (oclMode) {
                        // only visible, if we really do OCL constraints
                        downPanel.add(checkSubtyping);
                }
                
                //now for the navigation buttons
                leftMeta.setToolTipText("Moving the focus to the previous metavariable");
                rightMeta.setToolTipText("Moving the focus to the next metavariable");
                left.setToolTipText("Moving the focus to the previous term");
                right.setToolTipText("Moving the focus to the next term");
                top.setToolTipText("Moving the focus to the top term");       
                middlePanelUp.add(leftMeta);
                middlePanelUp.add(left);
                middlePanelUp.add(top);
                middlePanelUp.add(right);
                middlePanelUp.add(rightMeta);
                middlePanelDown.add(subtermNameLabel, BorderLayout.WEST);
                middlePanelDown.add(subtermDescLabel, BorderLayout.CENTER);
                middlePanel.setLayout(new BorderLayout());
                middlePanel.add(middlePanelUp, BorderLayout.NORTH);
                middlePanel.add(middlePanelDown, BorderLayout.CENTER);
                
                //now for the upper button bar
                newTopic = new JButton(newTopicAction);
                newCategoryMenu.setToolTipText("The list of available categories to start editing");
                open.setToolTipText("Reading both a new environment and an editing object from file. Current editing will be discarded");
                save.setToolTipText("Writing the current editing object to file in the term or text format");
                grammar.setToolTipText("Current Topic");
                newTopic.setToolTipText("Reading a new environment from file. Current editing will be discarded.");
                upPanel.add(grammar);
                upPanel.add(newCategoryMenu);
                upPanel.add(open);
                upPanel.add(save);
                upPanel.add(newTopic);
                
                statusLabel.setToolTipText("The current focus type");
                
                tree.setToolTipText("The abstract syntax tree representation of the current editing object");
                tree.resetTree(); 

                bgDisplayType.add(rbText);
                bgDisplayType.add(rbHtml);
                bgDisplayType.add(rbTextHtml);
                if (showHtml) {
                        rbHtml.setSelected(true);
                        rbHtml.getAction().actionPerformed(null);
                } else {
                        rbText.setSelected(true);
                        rbText.getAction().actionPerformed(null);
                }
                
                viewMenu.addSeparator();
                viewMenu.add(rbText);
                viewMenu.add(rbHtml);
                viewMenu.add(rbTextHtml);
                display = new Display(displayType);
                linearization = new Linearization(display);
                
                statusPanel.setLayout(new GridLayout(1,1));
                statusPanel.add(statusLabel);
                treePanel = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
                                tree, outputPanelUp);
                treePanel.setDividerSize(5);
                treePanel.setDividerLocation(100);
                centerPanel2.setLayout(new BorderLayout());
                gui2.setSize(350,100);
                gui2.setTitle("Select Action on Subterm");
                gui2.setLocationRelativeTo(treePanel);
                centerPanelDown.setLayout(new BorderLayout());
                centerPanel = new JSplitPane(JSplitPane.VERTICAL_SPLIT,
                                treePanel, centerPanelDown);
                centerPanel.setDividerSize(5);
                centerPanel.setDividerLocation(250);
                centerPanel.addKeyListener(tree);      
                centerPanel.setOneTouchExpandable(true);
                
                
                
                centerPanelDown.add(middlePanel, BorderLayout.NORTH);
                centerPanelDown.add(refinementMenu.getRefinementListsContainer(), BorderLayout.CENTER);
                coverPanel.add(centerPanel, BorderLayout.CENTER);
                coverPanel.add(upPanel, BorderLayout.NORTH);
                coverPanel.add(downPanel, BorderLayout.SOUTH);
                
                
                
                newCategoryMenu.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent ae) {
                                if (!newCategoryMenu.getSelectedItem().equals("New")) { 
                                        send("[nt] n " + newCategoryMenu.getSelectedItem());
                                        newCategoryMenu.setSelectedIndex(0);
                                }
                        }
                        
                });
                save.setAction(saveAction);
                open.setAction(openAction);     
                
                newCategoryMenu.setFocusable(false);
                save.setFocusable(false); 
                open.setFocusable(false); 
                newTopic.setFocusable(false);
                gfCommand.setFocusable(false);
                
                leftMeta.setFocusable(false);
                left.setFocusable(false);  
                
                /** handles the clicking of the navigation buttons */
                ActionListener naviActionListener = new ActionListener() {
                        /**
                         * convenience method instead of 5 single ones
                         */
                        public void actionPerformed(ActionEvent ae) {  
                                Object obj = ae.getSource();
                                if ( obj == leftMeta ) {
                                        send("[t] <<");
                                }
                                if ( obj == left ) {
                                        send("[t] <");
                                }
                                if ( obj == top ) {
                                        send("[t] '");
                                }
                                if ( obj == right ) {
                                        send("[t] >");
                                }
                                if ( obj == rightMeta ) {
                                        send("[t] >>");
                                }
                        }
                };
                
                top.addActionListener(naviActionListener);
                right.addActionListener(naviActionListener);
                rightMeta.addActionListener(naviActionListener);     
                leftMeta.addActionListener(naviActionListener);     
                left.addActionListener(naviActionListener);
                modify.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent ae) {
                                if (!modify.getSelectedItem().equals("Modify")) { 
                                        send("[t] c " + modify.getSelectedItem());
                                        modify.setSelectedIndex(0);
                                }
                        }
                }); 
                
                top.setFocusable(false);  
                right.setFocusable(false);  
                rightMeta.setFocusable(false);  
                read.setFocusable(false);  
                modify.setFocusable(false);  
                alpha.setFocusable(false);  
                random.setFocusable(false);  
                undo.setFocusable(false);  
                
                linearizationArea.addKeyListener(tree);            
                this.setSize(800, 600);
                outputPanelUp.setPreferredSize(new Dimension(400,230));
                treePanel.setDividerLocation(0.3);
                //nodeTable.put(new TreePath(tree.rootNode.getPath()), "");
                
                JRadioButton termButton = new JRadioButton("Term");
                termButton.setActionCommand("term");
                termButton.setSelected(true);  
                JRadioButton linButton = new JRadioButton("Text");
                linButton.setActionCommand("lin");
                // Group the radio buttons.
                saveTypeGroup.add(linButton);
                saveTypeGroup.add(termButton);
                JPanel buttonPanel = new JPanel();
                buttonPanel.setPreferredSize(new Dimension(70, 70));
                buttonPanel.add(new JLabel("Format:"));
                buttonPanel.add(linButton);
                buttonPanel.add(termButton);
                saveFc.setAccessory(buttonPanel);

                fontEveryWhere(font);
                this.setVisible(true);
                
        }
        
        /**
         * send a command to GF and reads the returned XML
         * @param text the command, exacltly the string that is going to be sent
         */
        protected void send(String text){
                send(text, true, 1);
        }
        
        /**
         * send a command to GF (indirectly).
         * @param text the command, exactly the string that is going to be sent
         * @param andRead if true, the returned XML will be read an displayed accordingly
         * @param undoSteps How many undo steps need to be done to undo this command.
         * If undoSteps == 0, then nothing is done. If it is &lt; 0, it gets 
         * subtracted from the last number on the undoStack. That way, both
         * this command and the last one get undone together (since the undo
         * value is actually increased). 
         */
        protected void send(String text, boolean andRead, int undoSteps) {
                if (sendLogger.isLoggable(Level.FINE)) {
                        sendLogger.fine("## send: '" + text + "', undo steps: " + undoSteps);
                }

                this.display.resetLin();
                display(false, true, false);
                linearization.reset();
                if (undoSteps > 0) { //undo itself should not push sth. on the stack, only pop
                        undoStack.push(new Integer(undoSteps));
                } else if (undoSteps < 0) {
                        final int oldUndo = ((Integer)undoStack.pop()).intValue();
                        final int newUndo = oldUndo - undoSteps;
                        if (sendLogger.isLoggable(Level.FINER)) {
                                sendLogger.finer("modified undoStack, top was " + oldUndo + ", but is now: " + newUndo);
                        }
                        undoStack.push(new Integer(newUndo));
                }
                gfCapsule.realSend(text);

                if (andRead) {
                        processGfedit();
                }
        }
        

        
        /**
         * Asks the respective read methods to read the front matter of GF.
         * That can be the greetings and loading messages.
         * The latter are always read.
         * When &lt;gfinit&gt; is read, the function returns.
         * @param pm to monitor the loading progress. May be null
         * @param greetingsToo if the greeting text from GF is expected
         */
        private void processInit(ProgressMonitor pm, boolean greetingsToo) {
                String next = null;
                if (greetingsToo) {
                        StringTuple greetings = gfCapsule.readGfGreetings(); 
                        next = greetings.first;
                        this.display.addToStages(greetings.second, greetings.second.replaceAll("\\n", "<br>"));
                        display(true, true, false);
                }
                Utils.tickProgress(pm, 5300, null);
                StringTuple loading = gfCapsule.readGfLoading(next, pm); 
                next = loading.first;
                this.display.addToStages(loading.second, Utils.replaceAll(loading.second, "\n", "<br>\n"));
                display(true, true, false);

                if (next.equals("<gfinit>")) {
                        processGfinit();
                }
        }
        
        
        /**
         * Takes care of reading the &lt;gfinit&gt; part
         * Fills the new category menu.
         */
        private void processGfinit() {
                NewCategoryMenuResult ncmr = gfCapsule.readGfinit();
                if (ncmr != null) {
                        formNewMenu(ncmr);
                }
        }

        /**
         * Takes care of reading the output from GF starting with 
         * &gt;gfedit&lt; and last reads &gt;/gfedit&lt;. 
         * Feeds the editor with what was read.
         * This makes this method nearly the central method of the editor.
         */
        private void processGfedit() {
                final GfeditResult gfedit = gfCapsule.readGfedit(newObject);
                formHmsg(gfedit.hmsg);
                //now the form methods are called:
                DefaultMutableTreeNode topNode = null;
                TreeAnalysisResult tar = new TreeAnalysisResult(null, -1, false, true, false, false, null, null);
                TreeAnalyser treeAnalyser = new TreeAnalyser(autoCoerce, coerceReduceRM, easyAttributes, hideCoerce, hideCoerceAggressive, highlightSubtypingErrors, showSelfResult);
                if (gfedit.hmsg.treeChanged && newObject) {
                        topNode = formTree(gfedit.treeString); 
                        tar = treeAnalyser.analyseTree(topNode);
                        focusPosition = tar.focusPosition;
                        currentNode = tar.currentNode;
                }
                //only sent sth. to GF directly, if we have sth. to send, and if it is not forbidden
                if (tar.command == null || !gfedit.hmsg.recurse) {
                        //for normal grammars (not the OCL ones),
                        //the nextCommand feature is not used, thus
                        //only this branch is executed.
                        
                        // nothing special is to be done here, 
                        // the tree analysis has
                        // not told us to send sth. to GF,
                        // so display the rest and do most of the 
                        // expensive stuff
                        
                        if (topNode != null) { //the case of !treeChanged or !newObject
                                DefaultMutableTreeNode transformedTreeRoot = TreeAnalyser.transformTree(topNode);
                                showTree(tree, transformedTreeRoot);
                        }
                        
                        
                        if (gfedit.gfCommands != null) {
                                final Vector usedCommandVector = RefinementMenuTransformer.transformRefinementMenu(tar, gfedit.gfCommands, gfCapsule);
                                final boolean isAbstract = "Abstract".equals(selectedMenuLanguage);
                                refinementMenu.formRefinementMenu(usedCommandVector, gfedit.hmsg.appendix, currentNode, isAbstract, tar.easyAttributes && tar.reduceCoerce, focusPosition, gfCapsule);
                        }
                        if (newObject) {
                                //MUST come after readLin, but since formLin is called later on too,
                                //this cannot be enforced with a local this.linearization
                                String linString = gfedit.linearizations;
                                //is set only here, when it is fresh
                                linearization.setLinearization(linString);
                                formLin();
                        }
                        if (gfedit.message != null && gfedit.message.length()>1) {
                                logger.fine("message found: '" + gfedit.message + "'");
                                this.display.addToStages("\n-------------\n" + gfedit.message, "<br><hr>" + gfedit.message);
                                //in case no language is displayed
                                display(true, false, false);
                        }
                } else {
                        // OK, sth. has to be sent to GF without displaying 
                        // the linearization of this run
                        send(tar.command, true, - tar.undoSteps);
                }
                refinementMenu.requestFocus();
        }

        /**
         * prints the available command line options
         */
        private static void printUsage() {                                          
                System.err.println("Usage: java -jar [-h/--html] [-b/--base baseURL] [-o/--ocl] [grammarfile(s)]");
                System.err.println("where -h activates the HTML mode");
                System.err.println("and -b sets the base location to which links in HTML are relative to. "
                                + "Default is the current directory.");
        }
        
        /**
         * starts the editor
         * @param args only the first parameter is used, it has to be a complete GF command,
         * which is executed and thus should load the needed grammars
         */
        public static void main(String args[]) {
                //command line parsing
                CmdLineParser parser = new CmdLineParser();                             
                CmdLineParser.Option optHtml = parser.addBooleanOption('h', "html");
                CmdLineParser.Option optBase = parser.addStringOption('b', "base");
                CmdLineParser.Option optOcl = parser.addBooleanOption('o', "ocl");
                CmdLineParser.Option gfBin = parser.addStringOption('g', "gfbin");
                // Parse the command line options.                                      
                
                try {                                                                   
                        parser.parse(args);                                                 
                }                                                                       
                catch (CmdLineParser.OptionException e) {                               
                        System.err.println(e.getMessage());                                 
                        printUsage();                                                       
                        System.exit(2);                                                     
                }
                Boolean isHtml = (Boolean)parser.getOptionValue(optHtml, Boolean.FALSE);
                String baseString = (String)parser.getOptionValue(optBase, null);
                String gfBinString = (String)parser.getOptionValue(gfBin, null);
                Boolean isOcl = (Boolean)parser.getOptionValue(optOcl, Boolean.FALSE);
                String[] otherArgs = parser.getRemainingArgs();
                
                URL myBaseURL;
                if (baseString != null) {
		                try {
		                        myBaseURL = new URL(baseString);
		                } catch (MalformedURLException me) {
		                        logger.warning(me.getLocalizedMessage());
		                        me.printStackTrace();
		                        myBaseURL = null;
		                }
                } else {
                        myBaseURL = null;
                }
                
//                if (logger.isLoggable(Level.FINER)) {
//                        logger.finer(isHtml + " : " + baseString + " : " + otherArgs);
//                }
                //construct the call to GF
                String gfCall = ((gfBinString != null && !gfBinString.equals(""))? gfBinString : "gf");
                gfCall += " -java";
                for (int i = 0; i < otherArgs.length; i++) {
                        gfCall = gfCall + " " + otherArgs[i];
                }
                Locale.setDefault(Locale.US);
                logger.info("call to GF: " + gfCall);
                GFEditor2 gui = new GFEditor2(gfCall, isHtml.booleanValue(), myBaseURL, isOcl.booleanValue());
                if (logger.isLoggable(Level.FINER)) {
                        logger.finer("main finished");
                }
        }

        /**
         * Calls the Java GF GUI to edit an OCL constraint. To be called by GFinterface
         * @param gfCmd the command to start the GF, must include the -java and all modules
         * @param callback the callback class that knows how to store the constraints
         * @param initAbs the initial abstract syntax tree (not OCL)
         * @param initDefault if initAbs is empty, then initDefault is used
         * @param pm to monitor the loading progress. May be null
         */
        static void mainConstraint(String gfCmd, ConstraintCallback callback, String initAbs, String initDefault, ProgressMonitor pm) {
                Locale.setDefault(Locale.US);
                GFEditor2 gui;
                if (initAbs.equals("")) {
                        gui = new GFEditor2(gfCmd, callback, "[ctn] g " + initDefault, pm);
                } else {
                        gui = new GFEditor2(gfCmd, callback, "[ctn] g " + initAbs, pm);
                }
                        
        }
        
        
        /** 
         * we should not end the program, just close the GF editor
         * possibly sending something back to KeY 
         */
        private void endProgram(){
                String saveQuestion;
                if (this.callback == null) {
                        saveQuestion = "Save text before exiting?";
                } else {
                        send("' ;; >>");
                        if (this.currentNode.isMeta()) { 
                                saveQuestion = "Incomplete OCL found.\nThis can only be saved (and loaded again) in an internal representation.\nStill save before exiting?";
                        } else {
                                saveQuestion = "Save constraint before exiting?";
                        }
                }
                int returnStatus;
                if (this.newObject) {
                        returnStatus = JOptionPane.showConfirmDialog(this, saveQuestion, "Save before quitting?", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE  );
                } else {
                        returnStatus = JOptionPane.NO_OPTION;
                }
                if (returnStatus == JOptionPane.CANCEL_OPTION) {
                        return;
                } else if (returnStatus == JOptionPane.NO_OPTION) {
                        shutDown();
                        return;
                } 
                if (this.callback != null) {
                        try {  
                                // quit should always work even if we cannot send something proper
                                // back to Together/KeY.
                                // Hence this try-catch
                                if (returnStatus == JOptionPane.YES_OPTION) {
                                        //check, if there are open metavariables
                                        //send("' ;; >>"); already done above
                                        if (!this.currentNode.isMeta()) {
                                                logger.info("No metavariables found, saving OCL");
                                                //no open nodes, we can save OCL
                                                String ocl = (String)linearization.getLinearizations().get(modelModulName + "OCL");
                                                if (ocl == null) {
                                                        //OCL not present, so switch it on
                                                        langMenuModel.setActive(modelModulName + "OCL", true);
                                                        send("on " + modelModulName + "OCL");
                                                        ocl = (String)linearization.getLinearizations().get(modelModulName + "OCL");
                                                } 
                                                ocl = Utils.compactSpaces(ocl.trim()).trim();
                                                
                                                this.callback.sendConstraint(ocl);
                                        } else {
                                                logger.info("Metavariables found, saving AST");
                                                //Abstract is always present
                                                String abs = (String)linearization.getLinearizations().get("Abstract");
                                                //then remove duplicate white space
                                                abs = removeMetavariableNumbers(abs).replaceAll("\\s+", " ").trim();
                                                this.callback.sendAbstract(abs);
                                        }
                                        
                                }
                        } catch (Exception e) { // just print information about the exception
                                System.err.println("GFEditor2.endProgram() Caught an Exception.");
                                System.err.println("e.getLocalizedMessage(): " + e.getLocalizedMessage());
                                System.err.println("e.toString(): " + e);
                                System.err.println("e.printStackTrace():");
                                e.printStackTrace(System.err);
                        } finally {
                                if (this.callback != null) { // send linearization as a class invariant
                                        Utils.cleanupFromUMLTypes(callback.getGrammarsDir());
                                }
                                shutDown();
                        }
                } else if (returnStatus == JOptionPane.YES_OPTION) {
                        final Action saveAction = new SaveAction();
                        saveAction.actionPerformed(null);
                        shutDown();
                }
        }

        /**
         * In the GF AST, all metavariables have numbers behind them,
         * like ?4. But GF cannot parse these, so the numbers have to be
         * removed.
         * Be aware, that this method also replaces ?n inside String literals!
         * @param abs The GF AST
         * @return abs, but without numbers behind the '?'
         */
        private static String removeMetavariableNumbers(String abs) {
                return abs.replaceAll("\\?\\d+", "\\?");
        }

        
        /**
         * Shuts down GF and terminates the edior
         */
        private void shutDown() {
                try {
                        send("q", false, 1); // tell external GF process to quit
                } finally {
		                removeAll();
		                dispose();
                }
        }

        /**
         * Performs some global settings like setting treeChanged and newObject,
         * which can depend on the hmsg.
         * Also the display gets cleared of wished so.
         * @param hmsg The parsed hmsg.
         */
        private void formHmsg(Hmsg hmsg){
                if (hmsg.clear) {
                        //clear output before linearization
                        this.display.resetLin();
                        display(true, false, false);
                        linearization.reset();
                }
                if (hmsg.newObject) {
                        this.newObject = true;
                }
        }
        
        /**
         * Fills the new category menu and sets the label 'grammar' to
         * display the name of the abstract grammar.
         * Fills langMenuModel and registers the presence of the
         * loaded languages in linearization.linearizations.
         */
        private void formNewMenu (NewCategoryMenuResult nmr) {
                //fill newCategoryMenu
                for (int i = 0; i < nmr.menuContent.length; i++) {
                        newCategoryMenu.addItem(nmr.menuContent[i]);
                }
                //add the languages to the menu
                for (int i = 0; i < nmr.languages.length; i++) {
                        final boolean active;
                        if (nmr.languages[i].equals("Abstract")) {
                                active = false;
                        } else { 
                                active = true;
                        }
                        this.langMenuModel.add(nmr.languages[i], active);

                        //select FromUMLTypesOCL by default
                        if (nmr.languages[i].equals(modelModulName + "OCL")) {
                                this.selectedMenuLanguage = modelModulName + "OCL";
                                //TODO select OCL also in the menu
                        }
                        //'register' the presence of this language if possible
                        if (linearization != null) {
                                linearization.getLinearizations().put(nmr.languages[i], null);
                        }
                }
                //tell the user, which abstract grammar is used
                //and save the import path
                grammar.setText(nmr.grammarName);
                for (int i = 0; i < nmr.paths.length; i++) {
                        fileString +="--" + nmr.paths[i] +"\n";
                        if (nmr.paths[i].lastIndexOf('.')!=nmr.paths[i].indexOf('.'))
                                grammar.setText(nmr.paths[i].substring(0,
                                                nmr.paths[i].indexOf('.')).toUpperCase()+"          ");
                }
                
        }
        
        

        
    	/**
         * Parses the GF-output between <linearization> </linearization>  tags
         * 
         * Expects the linearization string to be given to this.linearization.
         */
        private void formLin(){
                //reset previous output
                this.display.resetLin();
                
                linearization.parseLin(langMenuModel);
                display(true, false, true);

                //do highlighting
                this.linearizationArea.getHighlighter().removeAllHighlights();
                this.htmlLinPane.getHighlighter().removeAllHighlights();

                Vector mahsVector = linearization.calculateHighlights(focusPosition); 
                for (Iterator it = mahsVector.iterator(); it.hasNext();)  {
                        MarkedAreaHighlightingStatus mahs = (MarkedAreaHighlightingStatus)it.next();
                        //now highlight
                        if (mahs.focused && mahs.incorrect) {
                                highlight(mahs.ma, Color.ORANGE);
                                highlightHtml(mahs.ma, Color.ORANGE);
                        } else if (mahs.focused) {
                                highlight(mahs.ma, linearizationArea.getSelectionColor());
                                highlightHtml(mahs.ma, linearizationArea.getSelectionColor());
                        } else if (mahs.incorrect) {
                                highlight(mahs.ma, Color.RED);
                                highlightHtml(mahs.ma, Color.RED);
                        }
                }
        }

        
        

        
        /**
         * Small method that takes this.display and displays its content 
         * accordingly to what it is (pure text/HTML)
         * @param doDisplay If the text should get displayed
         * @param saveScroll if the old scroll state should be saved
         * @param restoreScroll if the old scroll state should be restored
         */
        private void display(boolean doDisplay, boolean saveScroll, boolean restoreScroll) {
                //Display the pure text
                final String text = this.display.getText();
                if (doDisplay) {
                        this.linearizationArea.setText(text);
                }
                if (restoreScroll) {
                        //this.outputPanelText.getVerticalScrollBar().setValue(this.display.scrollText);
                        this.linearizationArea.scrollRectToVisible(this.display.recText);
                }
                if (saveScroll) {
                        //this.display.scrollText = this.outputPanelText.getVerticalScrollBar().getValue();
                        this.display.recText = this.linearizationArea.getVisibleRect();
                }
                
                //Display the HTML
                final String html = this.display.getHtml(this.font);
                if (doDisplay) {
                        this.htmlLinPane.setText(html);
                }
                if (restoreScroll) {
                        //this.outputPanelHtml.getVerticalScrollBar().setValue(this.display.scrollHtml);
                        this.htmlLinPane.scrollRectToVisible(this.display.recHtml);
                }
                if (saveScroll) {
                        //this.display.scrollHtml = this.outputPanelHtml.getVerticalScrollBar().getValue();
                        this.display.recHtml = this.htmlLinPane.getVisibleRect();
                }
        }

        /**
         * Highlights the given MarkedArea in htmlLinPane
         * @param ma the MarkedArea
         * @param color the color the highlight should get
         */
        private void highlightHtml(final MarkedArea ma, Color color) {
                try {
                        int begin = ma.htmlBegin;
                        int end = ma.htmlEnd;
                        //When creating the HtmlMarkedArea, we don't know, if
                        //it is going to be the last or not.
                        if (end > this.htmlLinPane.getDocument().getLength()) {
                                end = this.htmlLinPane.getDocument().getLength();
                        }
                        this.htmlLinPane.getHighlighter().addHighlight(begin, end, new DefaultHighlighter.DefaultHighlightPainter(color));
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer("HTML HIGHLIGHT: " + this.htmlLinPane.getDocument().getText(begin, end - begin) + "; Color:" + color);
                        }
                } catch (BadLocationException e) {
                        redLogger.warning("HTML highlighting problem!\n" + e.getLocalizedMessage() + " : " + e.offsetRequested() + "\nHtmlMarkedArea: " + ma + "\nhtmlLinPane length: " + this.htmlLinPane.getDocument().getLength());
                }
        }

        /**
         * Highlights the given MarkedArea in linearizationArea
         * @param ma the MarkedArea
         * @param color the color the highlight should get
         */
        private void highlight(final MarkedArea ma, Color color) {
                try {
                        int begin = ma.begin;
                        int end = ma.end ;
                        //When creating the MarkedArea, we don't know, if
                        //it is going to be the last or not.
                        if (end > this.linearizationArea.getText().length()) {
                                end = this.linearizationArea.getText().length() + 1;
                        }
                        this.linearizationArea.getHighlighter().addHighlight(begin, end, new DefaultHighlighter.DefaultHighlightPainter(color));
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer("HIGHLIGHT: " + this.linearizationArea.getText(begin, end - begin) + "; Color:" + color);
                        }
                } catch (BadLocationException e) {
                        redLogger.warning("highlighting problem!\n" + e.getLocalizedMessage() + " : " + e.offsetRequested() + "\nMarkedArea: " + ma + "\nlinearizationArea length: " + this.linearizationArea.getText().length());
                }
        }
        
        
        /**
         * Sets the font on all the GUI-elements to font.
         * @param newFont the font everything should have afterwards
         */
        private void fontEveryWhere(Font newFont) {                          
                linearizationArea.setFont(newFont);
                htmlLinPane.setFont(newFont);
                parseField.setFont(newFont);  
                tree.tree.setFont(newFont);
                refinementMenu.setFont(newFont);
                save.setFont(newFont);  
                grammar.setFont(newFont);  
                open.setFont(newFont);  
                newTopic.setFont(newFont);  
                gfCommand.setFont(newFont);  
                leftMeta.setFont(newFont);  
                left.setFont(newFont);  
                top.setFont(newFont);  
                right.setFont(newFont);  
                rightMeta.setFont(newFont);
                subtermDescLabel.setFont(newFont);
                subtermNameLabel.setFont(newFont);
                read.setFont(newFont);
                alpha.setFont(newFont);  
                random.setFont(newFont);  
                undo.setFont(newFont);  
                checkSubtyping.setFont(newFont);
                filterMenu.setFont(newFont);
                setSubmenuFont(filterMenu, newFont, false);
                modify.setFont(newFont);  
                statusLabel.setFont(newFont);  
                menuBar.setFont(newFont);
                newCategoryMenu.setFont(newFont);
                readDialog.setFont(newFont);
                mlMenu.setFont(newFont);  
                setSubmenuFont(mlMenu, newFont, false);
                modeMenu.setFont(newFont);  
                setSubmenuFont(modeMenu, newFont, false);
                langMenu.setFont(newFont);
                setSubmenuFont(langMenu, newFont, false);
                fileMenu.setFont(newFont);
                setSubmenuFont(fileMenu, newFont, false);
                usabilityMenu.setFont(newFont);
                setSubmenuFont(usabilityMenu, newFont, false);
                viewMenu.setFont(newFont);  
                setSubmenuFont(viewMenu, newFont, false);
                setSubmenuFont(sizeMenu, newFont, false);
                setSubmenuFont(fontMenu, newFont, true);
                //update also the HTML with the new size
                display(true, false, true);
        }
        
        /**
         * Set the font in the submenus of menu.
         * Recursion depth is 1, so subsubmenus don't get fontified.
         * @param subMenu The menu whose submenus should get fontified
         * @param font the chosen font
         * @param onlySize If only the font size or the whole font should
         * be changed
         */
        private void setSubmenuFont(JMenu subMenu, Font font, boolean onlySize) {  
                for (int i = 0; i<subMenu.getItemCount(); i++)
                { 
                        JMenuItem item = subMenu.getItem(i);
                        if (item != null) {
                                //due to a bug in the jvm (already reported) deactivated
                                if (false && onlySize) {
                                        Font newFont = new Font(item.getFont().getName(), Font.PLAIN, font.getSize());
                                        item.setFont(newFont);
                                } else {
                                        item.setFont(font);
                                }
                                //String name = item.getClass().getName();
                                //if (logger.isLoggable(Level.FINER)) logger.finer(name);
                        }
                }
        }
        
        /**
         * Writes the given String to the given Filename
         * @param str the text to be written
         * @param fileName the name of the file that is to be filled
         */
        static void writeOutput(String str, String fileName) {
                
                try {
                        FileOutputStream fos = new FileOutputStream(fileName);
                        Writer out = new OutputStreamWriter(fos, "UTF8");
                        out.write(str);
                        out.close();
                } catch (IOException e) {
                        JOptionPane.showMessageDialog(null, 
                                        "Document is empty!","Error", JOptionPane.ERROR_MESSAGE);
                }
        }
        
        /**
         * Parses the GF-output between <tree> </tree>  tags
         * and build the corresponding tree.
         * 
         * parses the already read XML for the tree and stores the tree nodes
         * in nodeTable with their numbers as keys
         * 
         * Also does some tree analyzing, if other actions have to be taken.
         * 
         * @param treeString the string representation for the XML tree
         * @return null, if no commands have to be executed afterwards.
         * If the result is non-null, then result.s should be sent to GF
         * afterwards, and no other form-method on this read-run is to be executed.
         * result.i is the amount of undo steps that this command needs.
         */
        private DefaultMutableTreeNode formTree(String treeString) {
                if (treeLogger.isLoggable(Level.FINER)) {
                        treeLogger.finer("treeString: "+ treeString);
                }

                /** 
                 * stores the nodes and the indention of their children.
                 * When all children of a node are read,
                 * the next brethren / uncle node 'registers' with the same
                 * indention depth to show that the next children are his.
                 */
                Hashtable parentNodes = new Hashtable();
                String s = treeString;
                /** consecutive node numbering */
                int index = 0;
                /** the node that gets created from the current line */
                DefaultMutableTreeNode newChildNode=null;
                /** is a star somewhere in treestring? 1 if so, 0 otherwise */
                int star = 0;
                if (s.indexOf('*')!=-1) {
                        star = 1;
                }
                DefaultMutableTreeNode topNode = null;
                while (s.length()>0) {
                        /** 
                         * every two ' ' indicate one tree depth level
                         * shift first gets assigned the indention depth in 
                         * characters, later the tree depth
                         */
                        int shift = 0;
                        boolean selected = false;
                        while ((s.length()>0) && ((s.charAt(0)=='*')||(s.charAt(0)==' '))){      
                                if (s.charAt(0) == '*') {
                                        selected = true;
                                }
                                s = s.substring(1);     
                                shift++;  
                        }             
                        if (s.length()>0) {
                                /** to save the top node*/
                                boolean isTop = false;                      
                                int j = s.indexOf("\n");
                                //is sth like "andS : Sent ", i.e. "fun : type " before trimming  
                                String gfline = s.substring(0, j).trim();
                                GfAstNode node = new GfAstNode(gfline);
                                // use indentation to calculate the parent
                                index++;
                                s = s.substring(j+1);    
                                shift = (shift - star)/2;
                                
                                /**
                                 * we know the parent, so we can ask it for the param information
                                 * for the next child (the parent knows how many it has already)
                                 * and save it in an AstNodeData
                                 */
                                DefaultMutableTreeNode parent = (DefaultMutableTreeNode)parentNodes.get(new Integer(shift));
                                
                                /** compute the now child's position */
                                String newPos;
                                if ((parent != null) && (parent.getUserObject() instanceof AstNodeData) && parent.getUserObject() != null) {
                                        AstNodeData pand = (AstNodeData)parent.getUserObject();
                                        newPos = LinPosition.calculateChildPosition(pand.position, pand.childNum++);
                                } else {
                                        //only the case for the root node
                                        newPos = "[]";
                                        isTop = true;
                                }
                                
                                //default case, if we can get more information, this is overwritten
                                AstNodeData and;
                                Printname childPrintname = null;
                                if (!node.isMeta()) {
                                        childPrintname = this.printnameManager.getPrintname(node.getFun());
                                }
                                Printname parentPrintname = null;
                                AstNodeData parentAnd = null;
                                String parentConstraint = "";
                                if (parent != null) {
                                        parentAnd = (AstNodeData)parent.getUserObject();
                                        if (parentAnd != null) {
                                                parentConstraint = parentAnd.constraint;
                                        }
                                }
                                if (childPrintname != null) {
                                        //we know this one
                                        and = new RefinedAstNodeData(childPrintname, node, newPos, selected, parentConstraint);
                                } else if (parent != null && node.isMeta()) {
                                        //new child without refinement
                                        if (parentAnd != null) {
                                                parentPrintname = parentAnd.getPrintname();
                                        }
                                        if (parentPrintname != null) {
                                                int paramPosition = parent.getChildCount();
                                                String paramName = parentPrintname.getParamName(paramPosition);
                                                if (paramName == null) {
                                                        paramName = node.getFun();
                                                }
                                                //if tooltip turns out to be null that's OK 
                                                String paramTooltip = parentPrintname.htmlifySingleParam(paramPosition);
//                                                if (logger.isLoggable(Level.FINER)) {
//                                                        logger.finer("new node-parsing: '" + name + "', fun: '" + fun + "', type: '" + paramType + "'");
//                                                }
                                                and = new UnrefinedAstNodeData(paramTooltip, node, newPos, selected, parentConstraint);

                                        } else {
                                                and = new RefinedAstNodeData(null, node, newPos, selected, parentConstraint);
                                        }
                                } else {
                                        //something unparsable, bad luck
                                        //or refined and not described
                                        and = new RefinedAstNodeData(null, node, newPos, selected, parentConstraint);
                                }
                                
                                //add to the parent node
                                newChildNode = new DefaultMutableTreeNode(and);
                                if ((parent != null) && (newChildNode != null)) {
                                        parent.add(newChildNode);
                                }
                                parentNodes.put(new Integer(shift+1), newChildNode);
                                if (isTop) {
                                        topNode = newChildNode;
                                }
                        }
                }
                //to be deferred to later step in readGfEdit
                return topNode;
        }
        
        /**
         * Shows the tree, scrolls to the selected node and updates the
         * mapping table between displayed node paths and AST positions.
         * @param myTreePanel the panel of GFEditor2
         * @param topNode The root node of the tree, that has the other nodes
         * already as its children
         */
        private void showTree(DynamicTree2 myTreePanel, DefaultMutableTreeNode topNode) {
                myTreePanel.clear();
                nodeTable.clear();
                //the rootNode is not shown, therefore, a dummy node plays this role
                final DefaultMutableTreeNode rootNode = new DefaultMutableTreeNode();
                rootNode.add(topNode);
                ((DefaultTreeModel)(myTreePanel.tree.getModel())).setRoot(rootNode);
                /** 
                 * the path in the JTree (not in GF repesentation!) to the
                 * current new node.
                 */ 
                TreePath path=null;
                TreePath selectionPath = null;
                // now fill nodeTable
                for (Enumeration e = rootNode.breadthFirstEnumeration() ; e.hasMoreElements() ;) {
                        DefaultMutableTreeNode currNode = (DefaultMutableTreeNode)e.nextElement();
                        AstNodeData and = (AstNodeData)currNode.getUserObject();

                        path = new TreePath(currNode.getPath());
                        if (and == null) {
                                //only the case for the root node
                                nodeTable.put(path, "[]");
                        } else {
                                nodeTable.put(path, and.position);
                                if (and.selected) {
                                        selectionPath = path;
                                        if (treeLogger.isLoggable(Level.FINE)) {
                                                treeLogger.fine("new selectionPath: " + selectionPath);
                                        }
                                        
                                        DefaultMutableTreeNode parent = null;
                                        if (currNode.getParent() instanceof DefaultMutableTreeNode) {
                                                parent = (DefaultMutableTreeNode)currNode.getParent();
                                        }
                                        Printname parentPrintname = null;
                                        //display the current refinement description
                                        if ((parent != null) 
                                                        && (parent.getUserObject() != null) 
                                                        && (parent.getUserObject() instanceof AstNodeData)
                                                        ) {
                                                AstNodeData parentAnd = (AstNodeData)parent.getUserObject();
                                                parentPrintname = parentAnd.getPrintname();
                                        }
                                        // set the description of the current parameter to a more
                                        // prominent place
                                        String paramName = null;
                                        int paramPosition = -1;
                                        if (parentPrintname != null) {
                                                paramPosition = parent.getIndex(currNode);
                                                paramName = parentPrintname.getParamName(paramPosition);
                                        }
                                        if (paramName == null) {
                                                subtermNameLabel.setText(actionOnSubtermString);
                                                subtermDescLabel.setText("");
                                        } else {
                                                subtermNameLabel.setText("<html><b>" + paramName + ": </b></html>");
                                                String paramDesc = parentPrintname.getParamDescription(paramPosition);
                                                if (paramDesc == null) {
                                                        subtermDescLabel.setText("");
                                                } else {
                                                        subtermDescLabel.setText("<html>" + paramDesc + "</html>");
                                                }
                                        }
                                        statusLabel.setText(and.node.getType());
                                }
                        }
                }
                //also set the old selectionPath since we know that we do know,
                //that the selectionChanged event is bogus.
                myTreePanel.oldSelection = selectionPath;
                myTreePanel.tree.setSelectionPath(selectionPath);
                myTreePanel.tree.scrollPathToVisible(selectionPath);
                //show the selected as the 'selected' one in the JTree
                myTreePanel.tree.makeVisible(selectionPath);
                gui2.toFront();
        }
        
        
        /**
         * Removes anything but the "new" from the new category menu
         */
        private void resetNewCategoryMenu() {
                //remove everything except "New"
                while (1< newCategoryMenu.getItemCount())
                        newCategoryMenu.removeItemAt(1);
        }

        
        /**
         * Pops up a window for input of the wanted data and asks ic
         * afterwards, if the data has the right format.
         * Then gives that to GF.
         * TODO Is called from RefinementMenu, but uses display. Where to put?
         * @param ic the InputCommand that specifies the wanted format/type
         */
        protected void executeInputCommand(InputCommand ic) {
                String s = (String)JOptionPane.showInputDialog(
                                this,
                                ic.getTitleText(),
                                ic.getTitleText(),
                                JOptionPane.QUESTION_MESSAGE,
                                null,
                                null,
                                "");
                StringBuffer reason = new StringBuffer();
                Object value = ic.validate(s, reason);
                if (value != null) {
                        send("[t] g "+value); 
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("sending string " + value);
                        }
                } else {
                        this.display.addToStages("\n" + reason.toString(), "<p>" + reason.toString() + "</p>");
                        display(true, false, false);
                }
        }

        

        /**
         * Handles the showing of the popup menu and the parse field
         * @param e the MouseEvent, that caused the call of this function
         */
        protected void maybeShowPopup(MouseEvent e) {
                //int i=outputVector.size()-1;
                // right click:
                if (e.isPopupTrigger()) {
                        if (popUpLogger.isLoggable(Level.FINER)) {
                                popUpLogger.finer("changing pop-up menu2!");
                        }
                        JPopupMenu popup2 = refinementMenu.producePopup();
                        popup2.show(e.getComponent(), e.getX(), e.getY());
                } 
                // middle click
                if (e.getButton() == MouseEvent.BUTTON2) {
                        // selection Exists:
                        if (popUpLogger.isLoggable(Level.FINER)) {
                                popUpLogger.finer(e.getX() + " " + e.getY());
                        }
                        String selectedText;
                        
                        if (currentNode.isMeta()) {
                                // we do not want the ?3 to be in parseField, that disturbs
                                selectedText = "";
                        } else {
                                final String language;
                                //put together the currently focused text
                                if (e.getComponent() instanceof JTextComponent) {
                                        JTextComponent jtc = (JTextComponent)e.getComponent();
                                        int pos = jtc.viewToModel(e.getPoint());
                                        final boolean htmlClicked = (jtc instanceof JTextPane); 
                                        language = linearization.getLanguageForPos(pos, htmlClicked);
                                } else {
                                        language = "Abstract";
                                }
                                selectedText = linearization.getSelectedLinearization(language, focusPosition);
                                
                        }
                        //compute the size of parseField
                        if (selectedText.length()<5)
//                                if (treeCbMenuItem.isSelected())
//                                        parseField.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, 400, 40);
//                                else
                                        parseField.setBounds(e.getX(), e.getY()+80, 400, 40); 
                        else
//                                if (treeCbMenuItem.isSelected())
//                                          parseField.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, selectedText.length()*20, 40);
//                                else
                                        parseField.setBounds(e.getX(), e.getY()+80, selectedText.length()*20, 40);
                        getLayeredPane().add(parseField, new Integer(1), 0);  
                        parseField.setText(selectedText);
                        parseField.requestFocusInWindow();
                }
        }

        /**
         * Adds toHmsg to the [hmsg] part of command, if that is present.
         * If not, prepends toHmsg in square brackets to command
         * @param command The command for GF
         * @param toHmsg the text, that should occur inside [] before the command
         * @return the updated command (s.a.)
         */
        private static String addToHmsg(String command, String toHmsg) {
                command = command.trim();
                if (command.startsWith("[")) {
                        command = "[" + toHmsg + command.substring(1);
                } else {
                        command = "[" + toHmsg + "] " + command; 
                }
                return command;
        }

        /**
         * pop-up menu (adapted from DynamicTree2):
         * @author janna
         */ 
        class PopupListener extends MouseAdapter {
                public void mousePressed(MouseEvent e) {
                        //            int selStart = tree.getRowForLocation(e.getX(), e.getY());
                        //            output.setSelectionRow(selStart);
                        if (popUpLogger.isLoggable(Level.FINER)) {
                                popUpLogger.finer("mouse pressed2: "+linearizationArea.getSelectionStart()+" "+linearizationArea.getSelectionEnd());
                        }
                        maybeShowPopup(e);
                }
                
                public void mouseReleased(MouseEvent e) {
                        //nothing to be done here
                }
        }

        /**
         * Encapsulates the opening of terms or linearizations to a file.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever.
         * @author daniels
         */
        class OpenAction extends AbstractAction {
                public OpenAction() {
                        super("Open Text", null);
                        putValue(SHORT_DESCRIPTION, "Opens abstract syntax trees or linearizations for the current grammar");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_O));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_O, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (saveFc.getChoosableFileFilters().length<2)
                                saveFc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = saveFc.showOpenDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                resetNewCategoryMenu();
                                langMenuModel.resetLanguages();
                                
                                File file = saveFc.getSelectedFile();
                                // opening the file for editing :
                                if (logger.isLoggable(Level.FINER)) logger.finer("opening: "+ file.getPath().replace('\\', File.separatorChar));
                                if (saveTypeGroup.getSelection().getActionCommand().equals("term")) {
                                        if (logger.isLoggable(Level.FINER)) logger.finer(" opening as a term ");
                                        send("[nt] open "+ file.getPath().replace('\\', File.separatorChar));         
                                }
                                else {
                                        if (logger.isLoggable(Level.FINER)) logger.finer(" opening as a linearization ");
                                        send("[nt] openstring "+ file.getPath().replace('\\', File.separatorChar));
                                }
                                
                                fileString ="";
                                grammar.setText("No Topic          ");
                        }           
                }
        }

        /**
         * Encapsulates the saving of terms or linearizations to a file.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class SaveAction extends AbstractAction {
                public SaveAction() {
                        super("Save As", null);
                        putValue(SHORT_DESCRIPTION, "Saves either the current linearizations or the AST");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_S));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (saveFc.getChoosableFileFilters().length<2)
                                saveFc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = saveFc.showSaveDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                File file = saveFc.getSelectedFile();
                                if (logger.isLoggable(Level.FINER)) logger.finer("saving as " + file);
                                final String abstractLin = linearization.getLinearizations().get("Abstract").toString();

                                if (saveTypeGroup.getSelection().getActionCommand().equals("term")) {
                                        // saving as a term                                        
                                        writeOutput(removeMetavariableNumbers(abstractLin), file.getPath());
                                } else {
                                        // saving as a linearization:
                                        /** collects the show linearizations */
                                        StringBuffer text = new StringBuffer();
                                        /** if sth. at all is shown already*/
                                        boolean sthAtAll = false;
                                        for (Iterator it = linearization.getLinearizations().keySet().iterator(); it.hasNext();) {
                                                Object key = it.next();
                                                if (!key.equals("Abstract")) {
                                                        if (sthAtAll) {
                                                                text.append("\n\n");
                                                        }
                                                        text.append(linearization.getLinearizations().get(key));
                                                        sthAtAll = true;
                                                }
                                        }
                                        if (sthAtAll) {
                                                writeOutput(text.toString(), file.getPath());
                                                if (logger.isLoggable(Level.FINER)) logger.finer(file + " saved.");
                                        } else {
                                                if (logger.isLoggable(Level.FINER)) logger.warning("no concrete language shown, saving abstract");
                                                writeOutput(removeMetavariableNumbers(abstractLin), file.getPath());
                                                if (logger.isLoggable(Level.FINER)) logger.finer(file + " saved.");
                                        }
                                }
                        }           
                        
                }
        }

        /**
         * Encapsulates adding new languages for the current abstract grammar.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ImportAction extends AbstractAction {
                public ImportAction() {
                        super("Add", null);
                        putValue(SHORT_DESCRIPTION, "add another concrete language for the current abstract grammar");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_A));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_A, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        //add another language (Add...)
                                if (fc.getChoosableFileFilters().length<2)
                                        fc.addChoosableFileFilter(new GrammarFilter()); 
                                int returnVal = fc.showOpenDialog(GFEditor2.this);
                                if (returnVal == JFileChooser.APPROVE_OPTION) {
                                        File file = fc.getSelectedFile();

                                        resetNewCategoryMenu();
                                        langMenuModel.resetLanguages();
                                        // importing a new language :
                                        if (logger.isLoggable(Level.FINER)) logger.finer("importing: "+ file.getPath().replace('\\','/'));
                                        fileString ="";
                                        //TODO does that load paths in UNIX-notation under windows? 
                                        send("i "+ file.getPath().replace('\\',File.separatorChar), false, 1);
                                        processGfinit();
                                        processGfedit();
                                }           
                        }
                        
        }

        /**
         * Encapsulates starting over with a new grammar.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class NewTopicAction extends AbstractAction {
                public NewTopicAction() {
                        super("New Grammar", null);
                        putValue(SHORT_DESCRIPTION, "dismiss current editing and load a new grammar");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_N));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_N, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (fc.getChoosableFileFilters().length<2)
                                fc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = fc.showOpenDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                int n = JOptionPane.showConfirmDialog(GFEditor2.this,
                                                "This will dismiss the previous editing. Would you like to continue?",
                                                "Starting a new topic", JOptionPane.YES_NO_OPTION);
                                if (n == JOptionPane.YES_OPTION){
                                        File file = fc.getSelectedFile();
                                        // importing a new grammar :                
                                        newObject = false; 
                                        statusLabel.setText(status);
                                        subtermDescLabel.setText("");
                                        subtermNameLabel.setText("");
                                        refinementMenu.reset();
                                        tree.resetTree();
                                        resetNewCategoryMenu();                                        
                                        langMenuModel.resetLanguages();
                                        selectedMenuLanguage = "Abstract";
                                        rbMenuItemShort.setSelected(true);
                                        rbMenuItemUnTyped.setSelected(true);
                                        typedMenuItems = false;
                                        
                                        fileString="";
                                        grammar.setText("No Topic          ");
                                        display.resetLin();
                                        display(true, true, false);
                                        undoStack.clear();
                                        send(" e "+ file.getPath().replace('\\',File.separatorChar), false, 1);
                                        processInit(null, false);
                                        processGfedit();
                                        resetPrintnames(true);
                                }
                        }           
                }
                        
        }

        /**
         * Encapsulates starting over without loading new grammars
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ResetAction extends AbstractAction {
                public ResetAction() {
                        super("Reset", null);
                        putValue(SHORT_DESCRIPTION, "discard everything including the loaded grammars");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_R));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_R, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                                newObject = false; 
                                statusLabel.setText(status);
                                subtermDescLabel.setText("");
                                subtermNameLabel.setText("");
                                refinementMenu.reset();
                                tree.resetTree();
                                langMenuModel.resetLanguages();
                                resetNewCategoryMenu();
                                selectedMenuLanguage = "Abstract";
                                
                                rbMenuItemShort.setSelected(true);
                                rbMenuItemUnTyped.setSelected(true);
                                typedMenuItems = false;
                                
                                fileString="";
                                grammar.setText("No Topic          ");
                                undoStack.clear();
                                send("e", false, 1);
                                processGfinit();
                }
                        
        }

        /**
         * Encapsulates exiting the program
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class QuitAction extends AbstractAction {
                public QuitAction() {
                        super("Quit", null);
                        putValue(SHORT_DESCRIPTION, "exit the editor");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_Q));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_Q, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        endProgram();
                }
                        
        }

        /**
         * Encapsulates the random command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class RandomAction extends AbstractAction {
                public RandomAction() {
                        super("Random", null);
                        putValue(SHORT_DESCRIPTION, "build a random AST from the current cursor position");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_M));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_M, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        send("[t] a");
                }
                        
        }
        
        /**
         * Encapsulates the undo command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class UndoAction extends AbstractAction {
                public UndoAction() {
                        super("Undo", null);
                        putValue(SHORT_DESCRIPTION, "undo the last command");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_U));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_U, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        int undoSteps = 1;
                        if (!undoStack.empty()) {
                                undoSteps = ((Integer)undoStack.pop()).intValue();
                        }
                        send("[t] u " + undoSteps, true, 0);
                }
        }       

        /**
         * Encapsulates alpha command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class AlphaAction extends AbstractAction {
                public AlphaAction() {
                        super("Alpha", null);
                        putValue(SHORT_DESCRIPTION, "Performing alpha-conversion, rename bound variables");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_P));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_P, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        String s = JOptionPane.showInputDialog("Type string:", alphaInput);
                        if (s!=null) {
                                alphaInput = s;
                                send("[t] x "+s);
                        }      
                }
                        
        }
        
        /**
         * Encapsulates the input dialog and sending of arbitrary commands to GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class GfCommandAction extends AbstractAction {
                public GfCommandAction() {
                        super("GF command", null);
                        putValue(SHORT_DESCRIPTION, "send a command to GF");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_G));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_G, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        String s = JOptionPane.showInputDialog("Command:", commandInput);
                        if (s!=null) {
                                commandInput = s;
                                s = addToHmsg(s, "t");
                                if (logger.isLoggable(Level.FINER)) logger.finer("sending: "+ s);
                                send(s);
                        }
                }
        }     
        
        /**
         * Encapsulates the showing of the read dialog
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ReadAction extends AbstractAction {
                public ReadAction() {
                        super("Read", null);
                        putValue(SHORT_DESCRIPTION, "Refining with term or linearization from typed string or file");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_E));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_E, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        readDialog.show();
                }
                        
        }
        
        /**
         * Encapsulates the splitting of the main window
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class SplitAction extends AbstractAction {
                public SplitAction() {
                        super("Split Windows", null);
                        putValue(SHORT_DESCRIPTION, "Splits the refinement menu into its own window");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_L));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_L, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        coverPanel.remove(centerPanel);
                        centerPanel2.add(middlePanelUp, BorderLayout.SOUTH);
                        if (((JCheckBoxMenuItem)viewMenu.getItem(0)).isSelected()) {             
                                centerPanel2.add(treePanel, BorderLayout.CENTER);
                        }
                        else {
                                centerPanel2.add(outputPanelUp, BorderLayout.CENTER);
                        } 
                        coverPanel.add(centerPanel2, BorderLayout.CENTER);                 
                        gui2.getContentPane().add(refinementMenu.getRefinementListsContainer());
                        gui2.setVisible(true);
                        pack();
                        repaint();
                }
                        
        }

        /**
         * Encapsulates the combining of the main window
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class CombineAction extends AbstractAction {
                public CombineAction() {
                        super("One Window", null);
                        putValue(SHORT_DESCRIPTION, "Refinement menu and linearization areas in one window");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_W));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_W, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        coverPanel.remove(centerPanel2);  
                        middlePanel.add(middlePanelUp, BorderLayout.NORTH);
                        if (((JCheckBoxMenuItem)viewMenu.getItem(0)).isSelected()) {                         gui2.setVisible(false);
                        centerPanel.setLeftComponent(treePanel);
                        }
                        else {
                                centerPanel.setLeftComponent(outputPanelUp);
                                gui2.setVisible(false);
                        } 
                        coverPanel.add(centerPanel, BorderLayout.CENTER);
                        centerPanelDown.add(refinementMenu.getRefinementListsContainer(), BorderLayout.CENTER);
                        //centerPanelDown.add(refinementMenu.refinementSubcatPanel, BorderLayout.EAST);
                        pack();
                        repaint();
                }
                        
        }

        /**
         * Starts a run on the AST to hunt down open subtyping witnesses 
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class SubtypeAction extends AbstractAction {
                public SubtypeAction() {
                        super("Close Subtypes", null);
                        putValue(SHORT_DESCRIPTION, "try to automatically refine Subtype relations");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_U));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_T, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        String resetCommand;
                        int  usteps ;
                        if (focusPosition != null) {
                                //go back to where we come from
                                resetCommand = "[t] mp " + focusPosition.position;
                                usteps = 1;
                        } else {
                                resetCommand = "[t] gf";
                               usteps = 0;
                        }
                        SubtypingProber sp = new SubtypingProber(gfCapsule);
                        int undos = sp.checkSubtyping();
                        send(resetCommand , true, undos + usteps); 
                }
        }       
        
        
        
        /**
         * Takes care, which classes are present and which states they have.
         * @author daniels
         */
        class LangMenuModel implements LanguageManager{
                Logger menuLogger = Logger.getLogger("de.uka.ilkd.key.ocl.gf.GFEditor2.MenuModel");
                /**
                 * Just a mutable tuple of language name and whether this language
                 * is displayed or not. 
                 */
                class LangActiveTuple {
                        String lang;
                        boolean active;
                        public LangActiveTuple(String lang, boolean active) {
                                this.lang = lang;
                                this.active = active;
                        }
                        public String toString() {
                                return lang + " : " + active;
                        }
                }
                
                private Vector languages = new Vector();
                /** the group containing RadioButtons for the language the menus 
                 * should have 
                 */
                private ButtonGroup languageGroup = new ButtonGroup();
                
                void updateMenus() {
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple lat = (LangActiveTuple)it.next();
                                boolean alreadyPresent = false;       
                                // language already in the list of available languages?
                                for (int i=0; i<langMenu.getItemCount()-2;i++)        
                                        if ((langMenu.getItem(i) != null) && langMenu.getItem(i).getText().equals(lat.lang)) {
                                                alreadyPresent = true;
                                                break; 
                                        }
                                if (!alreadyPresent) {
                                        //add item to the language list:
                                        JCheckBoxMenuItem cbMenuItem = new JCheckBoxMenuItem(lat.lang);
                                        if (menuLogger.isLoggable(Level.FINER)) menuLogger.finer("menu item: " + lat.lang);   
                                        cbMenuItem.setSelected(lat.active);
                                        cbMenuItem.setActionCommand("lang");
                                        cbMenuItem.addActionListener(this.langDisplayListener);
                                        langMenu.insert(cbMenuItem, langMenu.getItemCount()-2);
                                        
                                        JRadioButtonMenuItem rbMenuItem = new JRadioButtonMenuItem(lat.lang);
                                        rbMenuItem.setActionCommand(lat.lang);
                                        rbMenuItem.addActionListener(this.menuLanguageListener);
                                        languageGroup.add(rbMenuItem);
                                        if (lat.lang.equals(selectedMenuLanguage)) {
                                                if (menuLogger.isLoggable(Level.FINER)) {
                                                        menuLogger.finer("Selecting " + selectedMenuLanguage);
                                                }
                                                rbMenuItem.setSelected(true);
                                        }
                                        mlMenu.add(rbMenuItem);
                                        
                                }
                        }
                        //stolen from fontEverywhere
                        setSubmenuFont(langMenu, font, false);
                        setSubmenuFont(mlMenu, font, false);
                }
                
                /**
                 * Sets language myLang to myActive.
                 * Does nothing, if myLang is not already there.
                 * @param myLang The name of the language
                 * @param myActive whether the language is displayed or not
                 */
                void setActive(String myLang, boolean myActive) {
                        boolean alreadyThere = false;
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        current.active = myActive;
                                        alreadyThere = true;
                                }
                        }
                        if (!alreadyThere) {
                                menuLogger.warning(myLang + " not yet known");
                        }
                }
                
                /**
                 * Checks if myLang is already present, and if not,
                 * adds it. In that case, myActive is ignored.
                 * @param myLang The name of the language
                 * @param myActive whether the language is displayed or not
                 */
                public void add(String myLang, boolean myActive) {
                        boolean alreadyThere = false;
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        alreadyThere = true;
                                }
                        }
                        if (!alreadyThere) {
                                if (menuLogger.isLoggable(Level.FINER)) {
                                        menuLogger.finer(myLang + " added");
                                }
                                LangActiveTuple lat = new LangActiveTuple(myLang, myActive);
                                this.languages.add(lat);
                        }
                        updateMenus();
                }
                
                /**
                 * @param myLang The language in question
                 * @return true iff the language is present and set to active,
                 * false otherwise.
                 */
                public boolean isLangActive(String myLang) {
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        return current.active;
                                }
                        }
                        return false;
                }

                /**
                 * initializes a virgin languages menu
                 */
                public LangMenuModel() {
                        resetLanguages();
                }
                
                
                /**
                 * Resets the Languages menu so that it only contains a seperator and the Add button.
                 * Resets the shown menu languages.
                 * Resets the CheckBoxes that display the available languages.
                 */
                void resetLanguages() {
                        langMenu.removeAll();
                        langMenu.addSeparator();
                        JMenuItem fileMenuItem = new JMenuItem(new ImportAction());
                        langMenu.add(fileMenuItem);
                        
                        mlMenu.removeAll();
                        this.languageGroup = new ButtonGroup();
                        this.languages = new Vector();
                        updateMenus();
                }
                
                
                /**
                 * Listens to the language menu RadioButtons and sends the 
                 * menu language changing commands suiting to the respective
                 * button to GF.
                 * Operates on selectedMenuLanguage from GFEditor2.
                 */
                private ActionListener menuLanguageListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                final String action = e.getActionCommand();
                                // must be a menu language
                                selectedMenuLanguage = action;
                                final String sendLang;
                                if (action.equals("Abstract")) {
                                        sendLang = "Abs";
                                } else {
                                        sendLang = action;
                                }
                                send("ml " + sendLang);
                                resetPrintnames(true);

                                return;
                        }
                };
                
                /**
                 * listens to the CheckBoxes in the Language menu and switches the 
                 * correspondend languages on or off when the user clicks on them
                 */
                private ActionListener langDisplayListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                if (newObject) {
                                        //clear display of text and HTML
                                        display.resetLin();
                                        display(true, false, true);
                                        formLin();
                                }
                                final String lang = ((JCheckBoxMenuItem)e.getSource()).getText();
                                if (((JCheckBoxMenuItem)e.getSource()).isSelected()){
                                        if (menuLogger.isLoggable(Level.FINER)) {
                                                menuLogger.finer("turning on language '" + lang + "'");
                                        }
                                        setActive(lang, true);
                                        send("on " + lang);
                                }
                                else{
                                        if (menuLogger.isLoggable(Level.FINER)) {
                                                menuLogger.finer("turning off language '" + lang + "'");
                                        }
                                        setActive(lang, false);
                                        send("off " + lang);
                                }
                                return;
                        }
                };
        }
}
