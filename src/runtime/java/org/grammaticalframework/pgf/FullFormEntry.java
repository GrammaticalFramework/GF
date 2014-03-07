package org.grammaticalframework.pgf;

import java.util.List;

public class FullFormEntry {
	private String form;
	private long ref;
	private Concr concr;

	public FullFormEntry(String form, long ref, Concr concr) {
		this.form  = form;
		this.ref   = ref;
		this.concr = concr;
	}

	public String getForm() {
		return form;
	}
	
	public native List<MorphoAnalysis> getAnalyses();
}
