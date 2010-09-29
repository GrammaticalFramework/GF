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
package org.grammaticalframework.ui.gwt.client.selection.support;

import org.grammaticalframework.ui.gwt.client.selection.Selection;
import org.grammaticalframework.ui.gwt.client.selection.SelectionEndPoint;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.dom.client.Text;
import com.google.gwt.user.client.Element;

/**
 * This class provides the standard implementation of
 * 
 * @author Miroslav Pokorny (mP)
 */
public class SelectionSupport {

	public SelectionEndPoint getStart(final Selection selection) {
		return getStart0(selection);
	}
	
	native private SelectionEndPoint getStart0(final Selection selection) /*-{
		var node = selection.anchorNode || null;
		var offset = selection.anchorOffset;
		return @org.grammaticalframework.ui.gwt.client.selection.SelectionEndPoint::new(Lcom/google/gwt/dom/client/Text;I)(value,j);
	}-*/;

	public SelectionEndPoint getEnd(final Selection selection) {
		return getEnd0(selection);
	}

	native private SelectionEndPoint getEnd0(final Selection selection) /*-{
		var node = selection.focusNode || null;
		var offset = selection.focusOffset;
		return @org.grammaticalframework.ui.gwt.client.selection.SelectionEndPoint::new(Lcom/google/gwt/dom/client/Text;I)(value,j);
	}-*/;

	public void select(final Selection selection, final SelectionEndPoint start, final SelectionEndPoint end) {
		select0(selection, start.getTextNode(), start.getOffset(), end.getTextNode(), end.getOffset());
	}

	native private void select0(final Selection selection, final Text startNode, final int startOffset, final Text endNode, final int endOffset)/*-{
		 var range = startNode.ownerDocument.createRange();
		 range.setStart(startNode, startOffset);
		 range.setEnd(endNode, endOffset);
			 
		 // delete all ranges then recreate...
		 selection.removeAllRanges();
		 selection.addRange(range);
	}-*/;

	native public Selection getSelection()/*-{
		return $wnd.getSelection();
	}-*/;
}
