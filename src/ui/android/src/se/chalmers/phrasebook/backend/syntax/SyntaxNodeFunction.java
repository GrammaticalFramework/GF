package se.chalmers.phrasebook.backend.syntax;

import java.util.*;

public class SyntaxNodeFunction extends SyntaxNode {
    private String function;
    private SyntaxNode[] arguments;

    public SyntaxNodeFunction(String desc, String function, SyntaxNode[] arguments) {
		super(desc);
        this.function  = function;
        this.arguments = arguments;
    }

    public String getFunction() {
        return function;
    }

    public SyntaxNode[] getArguments() {
        return arguments;
    }

	@Override
    public String getAbstractSyntax(ChoiceContext context) {
		if (arguments == null || arguments.length == 0)
			return function;

		StringBuilder builder = new StringBuilder();
		builder.append(function);
		for (SyntaxNode argument : arguments) {
			builder.append(' ');
			builder.append('(');
			builder.append(argument.getAbstractSyntax(context));
			builder.append(')');
		}

		return builder.toString();
	}
}
