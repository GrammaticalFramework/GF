package org.grammaticalframework.pgf;

class Pool {
	final long ref;

	public Pool(long ref) {
		this.ref = ref;
	}

	public Pool() {
		this.ref = alloc();
	}

	public void finalize() {
		free(ref);
	}

	public static native long alloc();
	public static native void free(long ref);
}
