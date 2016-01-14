package org.grammaticalframework.pgf;

import java.io.Serializable;

/** The class represents a possible morphological analysis of
 * a word from the lexicon in the grammar
 */
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
	
	/** The lemma, i.e. the abstract function name in the lexicon. */
	public String getLemma() {
		return lemma;
	}

	/** The name of the slot in the inflection table for the lemma. */
	public String getField() {
		return field;
	}

	/** Returns the negative logarithmic probability. */
	public double getProb() {
		return prob;
	}
}
