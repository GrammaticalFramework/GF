package se.chalmers.phrasebook.backend.syntax;

public class SyntaxNodeArgument extends SyntaxNode {
    private int index;

	public SyntaxNodeArgument(String desc, int index) {
		super(desc);
		this.index = index;
    }

	@Override
    public String getAbstractSyntax(ChoiceContext context) {
		return context.getArgument(index).getAbstractSyntax(context);
	}
}
