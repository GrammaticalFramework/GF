package org.grammaticalframework.pgf;

import java.util.List;

/** This is the class for entries in the full-form lexicon of the grammar*/
public class FullFormEntry {
	private String form;
	private double prob;
	private List<MorphoAnalysis> analyses;

	public FullFormEntry(String form, double prob, List<MorphoAnalysis> analyses) {
		this.form     = form;
		this.prob     = prob;
		this.analyses = analyses;
	}

	/** This is the word form. */
	public String getForm() {
		return form;
	}

	/** This is its negative logarithmic probability. */
	public double getProb() {
		return prob;
	}

	/** This is the list of possible morphological analyses. */
	public List<MorphoAnalysis> getAnalyses() {
		return analyses;
	}
}
