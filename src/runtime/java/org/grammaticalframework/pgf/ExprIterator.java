package org.grammaticalframework.pgf;

import java.util.*;

class ExprIterator implements Iterator<ExprProb> {
	private Pool pool, out_pool;
	private long enumRef;
	private ExprProb ep;
	private boolean fetched;

	public ExprIterator(long pool, long out_pool, long enumRef) {
		this.pool = new Pool(pool);
		this.out_pool = new Pool(out_pool);
		this.enumRef = enumRef;
		this.ep = null;
		this.fetched = false;
	}

	private native ExprProb fetchExprProb(long enumRef, Pool out_pool);

	private void fetch() {
		if (!fetched) {
			ep = fetchExprProb(enumRef, out_pool);
			fetched = true;
		}
	}
	
	public boolean hasNext() {
		fetch();
		return (ep != null);
	}
	
	public ExprProb next() {
		fetch();
		fetched = false;
		
		if (ep == null)
			throw new NoSuchElementException();
		return ep;
	}

	public void remove() {
		throw new UnsupportedOperationException();
	}
}
