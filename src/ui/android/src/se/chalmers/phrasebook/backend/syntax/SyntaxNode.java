package se.chalmers.phrasebook.backend.syntax;

import java.io.Serializable;
import org.grammaticalframework.pgf.Expr;

public class SyntaxNode implements Serializable {
    private String desc;

    public SyntaxNode(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }

    public String getAbstractSyntax(ChoiceContext context) {
		return null;
	}

	public int getDefaultChoice() {
		return 0;
	}

	public SyntaxNode unlink() {
		return this;
	}
	
	@Override
	public String toString() {
		return desc;
	}
}
