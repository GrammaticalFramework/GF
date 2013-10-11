package org.grammaticalframework.pgf;

import java.io.Serializable;

public class MorphoAnalysis implements Serializable {
	private static final long serialVersionUID = 1L;

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
