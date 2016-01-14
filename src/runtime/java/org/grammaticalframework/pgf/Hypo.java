package org.grammaticalframework.pgf;

public class Hypo {
	public native boolean getBindType();
	
	/** The name of the bound variable or '_' if there is none */
	public native String getVariable();
	
	/** The type for this hypothesis */
	public native Type getType();
}
