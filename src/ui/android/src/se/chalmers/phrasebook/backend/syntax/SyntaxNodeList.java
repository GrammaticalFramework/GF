package se.chalmers.phrasebook.backend.syntax;

import java.io.Serializable;
import java.util.ArrayList;

import se.chalmers.phrasebook.backend.syntax.SyntaxNode;

/**
 * Created by David on 2016-04-01.
 */
public class SyntaxNodeList implements Serializable {
    private SyntaxNode selectedChild;
    private ArrayList<SyntaxNode> children;
    private String question;


    public SyntaxNodeList() {
        children = new ArrayList<SyntaxNode>();
    }

    public ArrayList<SyntaxNode> getChildren() {
        return children;
    }

    public boolean add(SyntaxNode object) {
        if (selectedChild == null)
            selectedChild = object;
        return children.add(object);
    }

    public SyntaxNode getSelectedChild() {
        return selectedChild;
    }

    public boolean setSelectedChild(SyntaxNode selectedChild) {
        if(children.contains(selectedChild)) {
            this.selectedChild = selectedChild;
            return true;
        }
        return false;
    }

    public boolean selectChild(String description) {
        for (SyntaxNode s : children) {
            if (s.getDesc().equals(description)) {
                setSelectedChild(s);
                return true;
            }
        }
        return false;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }


}
