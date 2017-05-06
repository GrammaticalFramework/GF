package se.chalmers.phrasebook.backend;

import org.w3c.dom.*;
import org.xml.sax.*;
import org.w3c.dom.ls.*;

import java.io.*;
import java.util.*;
import javax.xml.parsers.*;

import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.ui.android.R;
import org.grammaticalframework.ui.android.GFTranslator;
import se.chalmers.phrasebook.backend.syntax.*;

public class Model {
    private static Model model;

    private List<SyntaxTree> phrases;
    private Map<String,List<SyntaxTree>> groups;

    private Model() {
        try {
            DocumentBuilder documentBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            InputStream is = GFTranslator.get().getAssets().open("phrases.xml");
			Document document = documentBuilder.parse(is);
			parseSentencesData(document);
            is.close();
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Model getInstance() {
        if (model == null) model = getSync();
        return model;
    }

    private synchronized static Model getSync() {
        if (model == null) model = new Model();
        return model;
    }

    public List<SyntaxTree> getSentences() {
		return phrases;
	}

    public List<SyntaxTree> getGroup(String id) {
		return groups.get(id);
	}

    private void parseSentencesData(Document document) {
		phrases = new ArrayList<SyntaxTree>();
		groups  = new HashMap<String,List<SyntaxTree>>();
		Map<String,SyntaxNode> ids = new HashMap<String,SyntaxNode>();
		List<SyntaxNodeCall> calls = new ArrayList<SyntaxNodeCall>();

		NodeList nodesList = document.getDocumentElement().getChildNodes();
		for (int i = 0; i < nodesList.getLength(); i++) {
			Node node = nodesList.item(i);
			
			if (node != null &&
			    node.getNodeType() == Node.ELEMENT_NODE &&
			    node.getNodeName().equals("sentence")) {
				NamedNodeMap attributes = node.getAttributes();

				if (attributes == null)
					continue;

				String desc = "";
				if (attributes.getNamedItem("desc") != null) {
					desc = attributes.getNamedItem("desc").getNodeValue();
				}

				SyntaxNode[] nodes = constructSyntaxNodeList(node, ids, calls);
				if (nodes.length > 0)
					phrases.add(new SyntaxTree(desc, nodes[0]));
			} else if (node != null &&
			           node.getNodeType() == Node.ELEMENT_NODE &&
			           node.getNodeName().equals("group")) {

				NamedNodeMap attributes = node.getAttributes();
				if (attributes == null)
					continue;

				String id = null;
				if (attributes.getNamedItem("id") != null) {
					id = attributes.getNamedItem("id").getNodeValue();
				}
				if (id == null)
					continue;

				List<SyntaxTree> group_phrases = new ArrayList<SyntaxTree>();

				NodeList nodesList2 = node.getChildNodes();
				for (int j = 0; j < nodesList2.getLength(); j++) {
					node = nodesList2.item(j);

					if (node != null &&
						node.getNodeType() == Node.ELEMENT_NODE &&
						node.getNodeName().equals("sentence")) {
						attributes = node.getAttributes();

						if (attributes == null)
							continue;

						String desc = "";
						if (attributes.getNamedItem("desc") != null) {
							desc = attributes.getNamedItem("desc").getNodeValue();
						}

						SyntaxNode[] nodes = constructSyntaxNodeList(node, ids, calls);
						if (nodes.length > 0) {
							SyntaxTree tree = new SyntaxTree(desc, nodes[0]);
							phrases.add(tree);
							group_phrases.add(tree);
						}
					}
				}
				
				groups.put(id, group_phrases);
			} else if (node.getAttributes() != null && node.getAttributes().getNamedItem("id") != null) {
				String id = node.getAttributes().getNamedItem("id").getNodeValue();
				SyntaxNode snode = constructSyntaxNode(node, ids, calls);
				if (snode == null) {
					throw new IllegalArgumentException(outerXml(node));
				}
				ids.put(id,snode);
			}
        }

        for (SyntaxNodeCall call : calls) {
			call.bind(ids);
		}
    }

    private SyntaxNode constructSyntaxNode(Node node, Map<String,SyntaxNode> ids, List<SyntaxNodeCall> calls) {
		NamedNodeMap attributes = node.getAttributes();
		if (attributes == null)
			return null;

		String desc = "";
		if (attributes.getNamedItem("desc") != null) {
			desc = attributes.getNamedItem("desc").getNodeValue();
		}

		if (node.getNodeName().equals("function")) {
			String function = attributes.getNamedItem("name").getNodeValue();
			SyntaxNode[] arguments = constructSyntaxNodeList(node, ids, calls);
			return new SyntaxNodeFunction(desc, function, arguments);
		} else if (node.getNodeName().equals("numeral")) {
			return new SyntaxNodeNumeral(desc, 1, 100);
		} else if (node.getNodeName().equals("option")) {
			SyntaxNode[] options = constructSyntaxNodeList(node, ids, calls);
			return new SyntaxNodeOption(desc, options);
		} else if (node.getNodeName().equals("boolean")) {
			SyntaxNode[] options = constructSyntaxNodeList(node, ids, calls);
			return new SyntaxNodeBoolean(desc, options);
		} else if (node.getNodeName().equals("call")) {
			if (attributes.getNamedItem("ref") == null)
				return null;

			String ref = attributes.getNamedItem("ref").getNodeValue();
			SyntaxNode[] arguments = constructSyntaxNodeList(node, ids, calls);
			SyntaxNodeCall call = new SyntaxNodeCall(desc, ref, arguments);
			calls.add(call);
			return call;
		} else if (node.getNodeName().equals("argument")) {
			int d = 0;
			if (attributes.getNamedItem("index") != null)
				d = Integer.parseInt(attributes.getNamedItem("index").getNodeValue());
			return new SyntaxNodeArgument(desc, d);
		}

		return null;
	}

    private SyntaxNode[] constructSyntaxNodeList(Node root, Map<String,SyntaxNode> ids, List<SyntaxNodeCall> calls) {
		NodeList nl = root.getChildNodes();

		int index = 0;
		SyntaxNode[] list = new SyntaxNode[nl.getLength()];
        for (int i = 0; i < nl.getLength(); i++) {
			Node node = nl.item(i);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
				list[index] = constructSyntaxNode(node, ids, calls);
				if (list[index] == null)
					throw new IllegalArgumentException(outerXml(node));
				index++;
            }
        }
        return Arrays.copyOf(list, index);
    }
    
    private String outerXml(Node node) {
		DOMImplementationLS lsImpl = (DOMImplementationLS)node.getOwnerDocument().getImplementation().getFeature("LS", "3.0");
		LSSerializer lsSerializer = lsImpl.createLSSerializer();
		lsSerializer.getDomConfig().setParameter("xml-declaration", false);
		return lsSerializer.writeToString(node);
	}
}

