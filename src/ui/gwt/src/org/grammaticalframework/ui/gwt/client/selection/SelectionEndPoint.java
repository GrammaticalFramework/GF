/*
 * Copyright Miroslav Pokorny
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package org.grammaticalframework.ui.gwt.client.selection;

import com.google.gwt.dom.client.Text;

/**
 * An end point uses a combination of a textNode and offset to mark the
 * start/end of a selection
 * 
 * @author Miroslav Pokorny (mP)
 */
public class SelectionEndPoint {

	public SelectionEndPoint() {
		super();
	}

	public SelectionEndPoint(Text text, final int offset) {
		super();

		this.setTextNode(text);
		this.setOffset(offset);
	}

	/**
	 * The textNode containing the start/end of the selection.
	 */
	private Text textNode;

	public Text getTextNode() {
		return textNode;
	}

	public void setTextNode(final Text textNode) {
		this.textNode = textNode;
	}

	/**
	 * The number of characters starting from the beginning of the textNode
	 * where the selection begins/ends.
	 */
	public int offset;

	public int getOffset() {
		return offset;
	}

	public void setOffset(final int offset) {
		this.offset = offset;
	}

	public String toString() {
		return super.toString() + ", offset: " + offset + ", textNode\"" + this.textNode + "\"";
	}
}
