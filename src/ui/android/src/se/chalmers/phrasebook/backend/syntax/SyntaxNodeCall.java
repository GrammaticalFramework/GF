package se.chalmers.phrasebook.backend.syntax;

import java.util.*;

public class SyntaxNodeCall extends SyntaxNode {
    private String id;
    private SyntaxNode ref;
    private SyntaxNode[] arguments;

	public SyntaxNodeCall(String desc, String id, SyntaxNode[] arguments) {
		super(desc);
		this.id   = id;
        this.ref  = null;
        this.arguments = arguments;
    }

    public String getDesc() {
		String desc = super.getDesc();
		if (desc == null || desc.isEmpty())
			return ref.getDesc();
        return desc;
    }

	@Override
    public String getAbstractSyntax(ChoiceContext context) {
		context.push(arguments);
		String res = ref.getAbstractSyntax(context);
		context.pop();
		return res;
	}

	@Override
	public SyntaxNode unlink() {
		return ref.unlink();
	}

	public String getId() {
		return id;
	}

	public SyntaxNode getRef() {
		return ref;
	}
	
	public void bind(Map<String,SyntaxNode> ids) {
		if (ref == null) {
			ref = ids.get(id);
			if (ref == null)
				throw new IllegalArgumentException("Missing reference to "+id);
		}
	}
}
