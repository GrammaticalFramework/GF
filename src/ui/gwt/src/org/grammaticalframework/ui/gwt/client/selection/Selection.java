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

import org.grammaticalframework.ui.gwt.client.selection.support.SelectionSupport;

import com.google.gwt.core.client.GWT;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.user.client.Element;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * The Selection class is a singleton that represents any selection made by the
 * user typically done with the mouse.
 * 
 * @author Miroslav Pokorny (mP)
 */
public class Selection extends JavaScriptObject {

	/**
	 * The browser aware support that takes care of browser difference nasties.
	 */
	static private SelectionSupport support = (SelectionSupport) GWT.create(SelectionSupport.class);

	static SelectionSupport getSupport() {
		return Selection.support;
	}

	/**
	 * Returns the document Selection singleton
	 * 
	 * @return The singleton instance
	 */
	static public Selection getSelection() {
		return Selection.support.getSelection();
	}

	protected Selection() {
		super();
	}

	final public SelectionEndPoint getStart() {
		return Selection.getSupport().getStart(this);
	}

	final public SelectionEndPoint getEnd() {
		return Selection.getSupport().getEnd(this);
	}

	final public void select(final SelectionEndPoint start, final SelectionEndPoint end) {
		Selection.getSupport().select(this, start, end);
	}
}
