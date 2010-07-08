package org.grammaticalframework.ui.gwt.client;

import java.util.AbstractList;
import java.util.List;

/** Work-around for missing List.subList() method in GWT JRE API emulation. */
public class SubList<T> extends AbstractList<T> {

	private List<T> list;

	private int fromIndex;

	private int toIndex;

	public SubList(List<T> list, int fromIndex, int toIndex) {
		this.list = list;
		this.fromIndex = fromIndex;
		this.toIndex = toIndex;
		if (fromIndex < 0 || toIndex > list.size())
			throw new IndexOutOfBoundsException("Endpoint index value out of range");
		if (fromIndex > toIndex)
			throw new IllegalArgumentException("Endpoint indices out of order");
	}

	public T get(int index) {
		return list.get(fromIndex + index);
	}

	public int size() {
		return toIndex - fromIndex;
	}

	public static <T> SubList<T> makeSubList(List<T> list, int fromIndex, int toIndex) {
		return new SubList<T>(list, fromIndex, toIndex);
	}

}
