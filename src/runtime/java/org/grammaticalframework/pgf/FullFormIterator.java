package org.grammaticalframework.pgf;

import java.util.Iterator;
import java.util.NoSuchElementException;

class FullFormIterator implements Iterator<FullFormEntry> {
	private Concr concr;
	private Pool pool;
	private long ref;
	private FullFormEntry entry;
	private boolean fetched;

	public FullFormIterator(Concr concr, long pool, long ref) {
		this.concr    = concr;
		this.pool     = new Pool(pool);
		this.ref      = ref;
		this.entry    = null;
		this.fetched  = false;
	}

	private native static FullFormEntry fetchFullFormEntry(long ref, Pool pool, Concr concr);

	private void fetch() {
		if (!fetched) {
			entry = fetchFullFormEntry(ref, pool, concr);
			fetched = true;
		}
	}

	@Override
	public boolean hasNext() {
		fetch();
		return (entry != null);
	}

	@Override
	public FullFormEntry next() {
		fetch();
		fetched = false;
		
		if (entry == null)
			throw new NoSuchElementException();
		return entry;
	}

	@Override
	public void remove() {
		throw new UnsupportedOperationException();
	}
}
