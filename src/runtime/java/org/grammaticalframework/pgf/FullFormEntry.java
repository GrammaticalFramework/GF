package org.grammaticalframework.pgf;

import java.util.List;

public class FullFormEntry {
	private String form;
	private double prob;
	private List<MorphoAnalysis> analyses;

	public FullFormEntry(String form, double prob, List<MorphoAnalysis> analyses) {
		this.form     = form;
		this.prob     = prob;
		this.analyses = analyses;
	}

	public String getForm() {
		return form;
	}

	public double getProb() {
		return prob;
	}

	public List<MorphoAnalysis> getAnalyses() {
		return analyses;
	}
}
