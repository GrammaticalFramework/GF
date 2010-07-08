package org.grammaticalframework.ui.gwt.client;

import java.util.Iterator;
import java.util.NoSuchElementException;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.core.client.JsArray;

public class IterableJsArray<T extends JavaScriptObject> extends JsArray<T> {

	protected IterableJsArray() {}
	
	public final boolean isEmpty() {
		return length() == 0;
	}

	public final Iterable<T> iterable() {
		return new Iterable<T>() {
			public Iterator<T> iterator() {
				return new Iterator<T>() {
					private int i = 0;
					public boolean hasNext() { 
						return i < length(); 
					}
					public T next() { 
						if (!hasNext()) { 
							throw new NoSuchElementException(); 
						}
						return get(i++); 
					}
					public void remove() { 
						throw new UnsupportedOperationException(); 
					}
				};
			}
		};
	}

}
