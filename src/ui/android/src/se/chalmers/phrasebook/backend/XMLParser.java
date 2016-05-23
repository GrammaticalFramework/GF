package se.chalmers.phrasebook.backend;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import se.chalmers.phrasebook.backend.syntax.NumeralSyntaxNode;
import se.chalmers.phrasebook.backend.syntax.SyntaxNode;
import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;
import se.chalmers.phrasebook.backend.syntax.SyntaxTree;

/**
 * Created by David on 2016-02-19.
 */
public class XMLParser {

    private DocumentBuilder documentBuilder;
    private Document document;
    private String currentId;

    public XMLParser(InputStream is) {
        try {
            documentBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            document = documentBuilder.parse(is);
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public HashMap<String, String> getSentencesData() {
        String[] result;
        HashMap<String, String> sentenceMap = new HashMap<String, String>();

        NodeList sentences = document.getElementsByTagName("sentence");
        int nbrOfSentences = sentences.getLength();

        for (int i = 0; i < nbrOfSentences; i++) {
            String desc = sentences.item(i).getAttributes().getNamedItem("desc").getNodeValue();
            String id = sentences.item(i).getAttributes().getNamedItem("id").getNodeValue();
            if (desc != null && id != null)
                sentenceMap.put(id, desc);
        }
        return sentenceMap;
    }

    public SyntaxTree getAdvancedOptionSyntaxTree() {
        NodeList advSentence = document.getElementsByTagName("advanced");
        advSentence = advSentence.item(0).getChildNodes();
        SyntaxTree s = new SyntaxTree(constructSyntaxNodeList(advSentence, new SyntaxNode("Root"), new SyntaxNodeList(), null, 1));
        return s;
    }


    public SyntaxTree getSyntaxTree(String sentenceTitle) {
        NodeList result = null;
        NodeList nl = document.getElementsByTagName("sentence");
        boolean isAdvanced = false;
        String id = "";
        for (int i = 0; i < nl.getLength(); i++) {
            NamedNodeMap attr = nl.item(i).getAttributes();
            id = attr.getNamedItem("id").getNodeValue();
            if (nl.item(i).getNodeType() == Node.ELEMENT_NODE && sentenceTitle.equals(id)) {
                result = nl.item(i).getChildNodes();
                if (attr.getNamedItem("advanced") != null) isAdvanced = true;
                break;
            }
        }
        SyntaxTree s = buildSyntaxTree(result);
        s.setId(id);
        if (isAdvanced) {
            s.setAdvancedTree(getAdvancedOptionSyntaxTree());
        }
        return s;
    }

    private SyntaxTree buildSyntaxTree(NodeList currentRoot) {
        SyntaxTree s = new SyntaxTree(constructSyntaxNodeList(currentRoot, new SyntaxNode("Root"), new SyntaxNodeList(), null, 1));
        return s;
    }

    /*
    "Abandon all hope, ye who enter here
     */
    private SyntaxNode constructSyntaxNodeList(NodeList nl, SyntaxNode parent, SyntaxNodeList list, SyntaxNode nextSequence, int nbrOfArgs) {
        if (nl == null || nl.getLength() < 1) {
            if (nextSequence != null && !(parent.getData().isEmpty() && nextSequence.getSyntaxNodes().isEmpty())) {
                list.add(nextSequence);
                parent.getSyntaxNodes().add(list);
            }
            return null;
        }
        int length = nl.getLength();

        //CurrentArgs counts the number of arguments for the current NodeList
        int currentArgs = 0;

        //If the parent node, or previous "recursion", calls for multiple args
        if (nbrOfArgs > 1) {
            currentArgs = nbrOfArgs;////Update currentArgs
            nbrOfArgs = 0;//Reset nbrOfArgs, important due to the other recursive calls which will happen before nbrOfArgs is actually used.
        }

        int args = 0;

        for (int i = 0; i < length; i++) {
            if (nl.item(i) != null && (nl.item(i).getNodeType() == Node.ELEMENT_NODE) && nl.item(i).getAttributes() != null) {
                String syntax = "", desc = "", option = "", question = "";

                NamedNodeMap attributes = nl.item(i).getAttributes();
                if (attributes.getNamedItem("syntax") != null) {
                    syntax = attributes.getNamedItem("syntax").getNodeValue();
                }

                if (attributes.getNamedItem("desc") != null) {
                    desc = attributes.getNamedItem("desc").getNodeValue();
                }

                if (attributes.getNamedItem("args") != null) {
                    args = Integer.parseInt(attributes.getNamedItem("args").getNodeValue());
                    nbrOfArgs = args;
                }

                if (attributes.getNamedItem("option") != null) {
                    question = attributes.getNamedItem("option").getNodeValue();
                    list.setQuestion(question);
                    constructSyntaxNodeList(nl.item(i).getChildNodes(), parent, list, nextSequence, nbrOfArgs);
                }

                if (attributes.getNamedItem("child") != null) {
                    option = attributes.getNamedItem("child").getNodeValue();

                    SyntaxNode mNextSequence = new SyntaxNode("");//This is a "holder" node to bind the child function calls nodes, contains no useful information in its syntax.
                    SyntaxNodeList mList = new SyntaxNodeList();
                    constructSyntaxNodeList(nl.item(i).getChildNodes(), mNextSequence, mList, nextSequence, nbrOfArgs);

                    constructSyntaxNodeList(jumpToChild("child", option), parent, list, mNextSequence, nbrOfArgs);
                }
                if (!syntax.isEmpty()) {
                    SyntaxNode node;

                    if (syntax.equals("NNumeral")) {
                        node = new NumeralSyntaxNode();
                    } else {
                        node = new SyntaxNode(syntax);
                        node.setDesc(desc);
                    }


                    list.add(node);
                    SyntaxNodeList mList = new SyntaxNodeList();

                    constructSyntaxNodeList(nl.item(i).getChildNodes(), node, mList, nextSequence, nbrOfArgs);
                }

                //Add the list to the current parent node list
                if (!list.getChildren().isEmpty() && !parent.getSyntaxNodes().contains(list)) {
                    parent.getSyntaxNodes().add(list);
                }
                //Check if current node is multiple arg nodes i.e. add another list to its syntaxNodes.
                if (currentArgs > 1 && parent.getSyntaxNodes().size() < currentArgs) {
                    list = new SyntaxNodeList();
                }

            }
        }
        return parent;

    }

    public NodeList jumpToChild(String tag, String id) {
        NodeList result = null;
        NodeList nl = document.getElementsByTagName(tag);

        for (int i = 0; i < nl.getLength(); i++) {
            String s = nl.item(i).getFirstChild().getNodeValue();
            if (nl.item(i).getNodeType() == Node.ELEMENT_NODE && nl.item(i).getAttributes().getNamedItem("id").getNodeValue().equals(id)) {
                result = nl.item(i).getChildNodes();
            }
        }
        return result;
    }
}
