package se.chalmers.phrasebook.backend.syntax;

import java.io.*;

public class SyntacticChoice implements Serializable {
	private int choice;
	private SyntaxNode node;

	public SyntacticChoice(SyntaxNode node) {
		this.node   = node;
		this.choice = node.getDefaultChoice();
	}

	public SyntaxNode getNode() {
		return node;
	}

	public int getChoice() {
		return choice;
	}

	public void setChoice(int choice) {
		this.choice = choice;
	}
}
