package org.grammaticalframework.pgf;

class Pool {
	private long ref;
	
	public Pool(long ref) {
		this.ref = ref;
	}
	
	public void finalize() {
		free(ref);
	}
	
	private native void free(long ref);
}
