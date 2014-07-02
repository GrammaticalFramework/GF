package org.grammaticalframework.pgf;

public class Bracket {
	public final String cat;
	public final String fun;
	public final int fid;
	public final int lindex;
	public final Object[] children;

	public Bracket(String cat, String fun, int fid, int lindex, Object[] children) {
		this.cat = cat;
		this.fun = fun;
		this.fid = fid;
		this.lindex = lindex;
		this.children = children;
	}
}
