package se.chalmers.phrasebook.backend.syntax;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by Björn on 2016-03-03.
 */

public class SyntaxNode implements Serializable {
    private String data;
    private String desc;
    private ArrayList<SyntaxNodeList> syntaxNodes;

    public SyntaxNode(String data) {
        syntaxNodes = new ArrayList<SyntaxNodeList>();
        this.data = data;
    }

    public void setSelectedChild(int listIndex, SyntaxNode newChild) {
        syntaxNodes.get(listIndex).setSelectedChild(newChild);
    }

    public ArrayList<SyntaxNodeList> getSyntaxNodes() {
        return syntaxNodes;
    }

    public ArrayList<SyntaxNodeList> getModularSyntaxNodes() {
        ArrayList<SyntaxNodeList> result = new ArrayList<SyntaxNodeList>();
        for (SyntaxNodeList snl : syntaxNodes) {
            if (snl.getChildren().size() > 1) result.add(snl);
        }
        return result;
    }

    public String getData() {
        return data;
    }

    public boolean isModular() {
        for (SyntaxNodeList s : syntaxNodes) if (s.getChildren().size() > 1) return true;
        return false;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public boolean equals(Object o) {

        if (this == o) {
            return true;
        }
        if (!(o instanceof SyntaxNode)) {
            return false;
        }
        SyntaxNode n = (SyntaxNode) o;

        return this.data.equals(n.data);
    }

}