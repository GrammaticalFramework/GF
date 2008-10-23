package se.chalmers.cs.gf.gwt.client;

public class Arg {
	public final String name;
	public final String value;
	public Arg (String name, String value) {
		this.name = name;
		this.value = value;
	}
	public Arg (String name, int value) {
		this(name, Integer.toString(value));
	}
}