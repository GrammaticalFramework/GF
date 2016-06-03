package se.chalmers.phrasebook.backend.syntax;

import java.io.Serializable;
import org.grammaticalframework.pgf.Expr;

public class SyntaxTree implements Serializable {
    private String desc;
    private SyntaxNode root;

    public SyntaxTree(String desc, SyntaxNode root) {
        this.desc = desc;
        this.root = root;
    }

    public String getDesc() {
        return desc;
    }

    public SyntaxNode getRoot() {
        return root;
    }

    public Expr getAbstractSyntax(ChoiceContext choices) {
		Expr expr = Expr.readExpr(root.getAbstractSyntax(choices));
		choices.trim();
		return expr;
	}
	
	@Override
	public String toString() {
		return desc;
	}
}
