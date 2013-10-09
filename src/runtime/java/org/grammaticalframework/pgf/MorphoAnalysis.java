package org.grammaticalframework.pgf;

public class MorphoAnalysis {
	private String lemma;
	private String field;
	private double prob;

	public MorphoAnalysis(String lemma, String field, double prob) {
		this.lemma = lemma;
		this.field = field;
		this.prob  = prob;
	}
	
	public String getLemma() {
		return lemma;
	}

	public String getField() {
		return field;
	}

	public double getProb() {
		return prob;
	}
}
