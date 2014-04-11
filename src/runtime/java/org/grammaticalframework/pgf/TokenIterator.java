package org.grammaticalframework.pgf;

import java.util.*;

class TokenIterator implements Iterator<TokenProb> {
	private Pool pool;
	private long ref;
	private TokenProb tp;
	private boolean fetched;

	public TokenIterator(long pool, long ref) {
		this.pool     = new Pool(pool);
		this.ref      = ref;
		this.tp       = null;
		this.fetched  = false;
	}

	private native static TokenProb fetchTokenProb(long ref, Pool pool);

	private void fetch() {
		if (!fetched) {
			tp = fetchTokenProb(ref, pool);
			fetched = true;
		}
	}

	public boolean hasNext() {
		fetch();
		return (tp != null);
	}

	public TokenProb next() {
		fetch();
		fetched = false;
		
		if (tp == null)
			throw new NoSuchElementException();
		return tp;
	}

	public void remove() {
		throw new UnsupportedOperationException();
	}
}
