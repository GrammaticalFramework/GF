package se.chalmers.phrasebook.backend.syntax;

import java.util.*;

public class ChoiceContext {
	private int pos;
	private List<SyntacticChoice> choices;
	private List<SyntaxNode[]> stack;

	public ChoiceContext() {
		this.pos     = pos;
		this.choices = new ArrayList<SyntacticChoice>();
		this.stack   = new ArrayList<SyntaxNode[]>();
	}

	public void reset() {
		pos = 0;
		stack.clear();
	}

	public void trim() {
		while (pos < choices.size())
			choices.remove(choices.size()-1);
	}

	public int choose(SyntaxNode node) {
		SyntacticChoice choice = null;

		if (pos < choices.size()) {
			if (choices.get(pos).getNode().unlink() == node.unlink()) {
				choice = choices.get(pos);
			} else {
				trim();
			}
		}

		if (choice == null) {
			choice = new SyntacticChoice(node);
			choices.add(choice);
		}

		pos++;
		return choice.getChoice();
	}

	public void push(SyntaxNode[] args) {
		stack.add(args);
	}
	
	public SyntaxNode[] pop() {
		return stack.remove(stack.size()-1);
	}
	
	public SyntaxNode getArgument(int i) {
		return stack.get(stack.size()-1)[i];
	}

	public List<SyntacticChoice> getChoices() {
		return choices;
	}
}
