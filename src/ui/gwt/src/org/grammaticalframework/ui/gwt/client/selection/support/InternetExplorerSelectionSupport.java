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
import com.google.gwt.user.client.DOM;
import com.google.gwt.user.client.Element;

/**
 * A specialised SelectionSupport class that is adapted to handle
 * InternetExplorer differences from the standard implementation.
 * 
 * @author Miroslav Pokorny (mP)
 */
public class InternetExplorerSelectionSupport extends SelectionSupport {

	final static String PARENT_NODE = "parentNode";

	@Override
	native public Selection getSelection()/*-{
			 return $wnd.document.selection;
			 }-*/;

	@Override
	public SelectionEndPoint getStart(final Selection selection) {
		return this.getStart0(selection);
	}

	native protected SelectionEndPoint getStart0(final Selection selection) /*-{
	 var selectionRange = selection.createRange();        
	 var element = selectionRange.parentElement();

		return this.@org.grammaticalframework.ui.gwt.client.selection.support.InternetExplorerSelectionSupport::getStart1(Lorg/grammaticalframework/ui/gwt/client/selection/Selection;Lcom/google/gwt/user/client/Element;)(selection,element);       
	 }-*/;

	native protected SelectionEndPoint getStart1(final Selection selection, final Element element)/*-{
			 var endPoint = null;
			 
			 if(! selection.createRange ){
			 	alert( "selection.createRange" + selection.createRange );
			 }
			 
			 var selectionRange = selection.createRange();

			 var range = selectionRange.duplicate();
			 range.moveToElementText( element );
			 range.collapse();        
			 
			 // loop thru all the childNodes belonging to element.
			 var childNodes = element.childNodes;
			 for( var i = 0; i < childNodes.length; i++ ){
			 var node = childNodes[ i ];
			 var nodeType = node.nodeType;
			 
			 // found an element check its child nodes...
			 if( 1 == nodeType ){
			 endPoint = this.@org.grammaticalframework.ui.gwt.client.selection.support.InternetExplorerSelectionSupport::getStart1(Lorg/grammaticalframework/ui/gwt/client/selection/Selection;Lcom/google/gwt/user/client/Element;)(selection,node);
			 
			 if( null == endPoint ){
			 range.move( "character", node.innerText.toString().length );
			 continue;
			 }
			 // endPoint found stop searching....
			 break;                
			 }
			 
			 // found a textNode...
			 if( 3 == nodeType ){
			 var text = node.data;
			 for( var j = 0; j < text.length; j++ ){
			 // found selection start stop searching!
			 if( selectionRange.compareEndPoints( "StartToStart", range ) == 0 ){
			 endPoint = @org.grammaticalframework.ui.gwt.client.selection.SelectionEndPoint::new(Lcom/google/gwt/dom/client/Text;I)(node,j);
			 break;
			 }
			 range.move("character", 1 );
			 }
			 // did the above for loop find the start ? if so stop escape!
			 if( null != endPoint ){
			 break;
			 }
			 }         
			 }
			 
			 return endPoint;
			 }-*/;

	@Override
	public void select(final Selection selection, final SelectionEndPoint start, final SelectionEndPoint end) {
		this.setStart0(selection, start.getTextNode(), start.getOffset());
		this.setEnd0(selection, end.getTextNode(), end.getOffset());
	}

	native private void setStart0(final Selection selection, final Text textNode, final int offset)/*-{
		 var rangeOffset = offset;
		 var moveToElement = null;
			 
		 // try an element before $textNode counting the number of characters one has moved backwards...
		 var node = textNode.previousSibling;
			 
		 while( node ){
			 // if a textNode is try its previous sibling...
			 if( node.nodeType == 3 ){
			 rangeOffset = rangeOffset + node.data.length;
			 continue;
			 }
			 
			 // found an element stop searching...
			 if( node.nodeType == 1 ){
			 moveToElement = node; 
			 rangeOffset = rangeOffset + node.innerText.toString().length;
			 break;
			 }
			 
			 // ignore other types...
			 node = node.previousSibling;
		 }
			 
		 // if moveToElement is null use textNode's parent.
		 if( ! moveToElement ){
		 moveToElement = textNode.parentNode;
		 }
			 
		 // update the start of selection range...
		 var range = selection.createRange();
		 range.moveToElementText( moveToElement );
		 range.moveStart( "character", rangeOffset );
		 range.select();                        
	}-*/;

	native private void setEnd0(final Selection selection, final Text textNode, final int offset)/*-{    
		 var rangeOffset = offset;
		 var moveToElement = null;
			 
		 // try an element before $textNode counting the number of characters one has moved backwards...
		 var node = textNode.previousSibling;
			 
		 while( node ){
			 // if textNode is try its previous sibling...
			 if( node.nodeType == 3 ){        
			 rangeOffset = rangeOffset + node.data.length;
			 continue;
			 }
			 
			 // found an element stop searching...
			 if( node.nodeType == 1 ){
			 moveToElement = node;
			 rangeOffset = rangeOffset + node.innerText.toString().length;
			 break;
			 }
			 
			 // ignore other types...
			 node = node.previousSibling;
		 }           
			 
		 // if moveToElement is null use textNode's parent.
		 if( ! moveToElement ){
			 moveToElement = textNode.parentNode;
		 }
			 
		 // update the end of selection range...
		 var range = selection.createRange();
		 range.moveToElementText( moveToElement );
		 range.moveStart( "character", rangeOffset );
		 range.collapse();
			 
		 var selectionRange = selection.createRange();
		 selectionRange.setEndPoint( "EndToStart", range );
		 selectionRange.select();                                 
	}-*/;

	@Override
	public SelectionEndPoint getEnd(final Selection selection) {
		return this.getEnd0(selection);
	}

	protected native SelectionEndPoint getEnd0(final Selection selection) /*-{
	 var selectionRange = selection.createRange();        
	 var element = selectionRange.parentElement();

	 return this.@org.grammaticalframework.ui.gwt.client.selection.support.InternetExplorerSelectionSupport::getEnd1(Lorg/grammaticalframework/ui/gwt/client/selection/Selection;Lcom/google/gwt/user/client/Element;)(selection,element);       
	 }-*/;

	protected native SelectionEndPoint getEnd1(final Selection selection, final Element element)/*-{
			 var endPoint = null;
			 
			 var selectionRange = selection.createRange();

			 var range = selectionRange.duplicate();
			 range.moveToElementText( element );
			 range.collapse( true );        
			 
			 // loop thru all the childNodes belonging to element.
			 var childNodes = element.childNodes;
			 for( var i = 0; i < childNodes.length; i++ ){
			 var node = childNodes[ i ];
			 var nodeType = node.nodeType;
			 
			 // found an element check its child nodes...
			 if( 1 == nodeType ){
			 endPoint = this.@org.grammaticalframework.ui.gwt.client.selection.support.InternetExplorerSelectionSupport::getEnd1(Lorg/grammaticalframework/ui/gwt/client/selection/Selection;Lcom/google/gwt/user/client/Element;)(selection,node);
			 
			 if( null == endPoint ){
			 range.move( "character", node.innerText.toString().length );
			 continue;
			 }
			 // endPoint found stop searching....
			 break;                
			 }
			 
			 // found a textNode...
			 if( 3 == nodeType ){
			 var text = node.data;
			 for( var j = 0; j < text.length; j++ ){
			 // found selection end stop searching!
			 if( selectionRange.compareEndPoints( "EndToStart", range ) == 0 ){
			 endPoint = @org.grammaticalframework.ui.gwt.client.selection.SelectionEndPoint::new(Lcom/google/gwt/dom/client/Text;I)(node,j);
			 break;
			 }
			 range.move( "character", 1 );
			 }
			 // did the above for loop find the end ? if so stop escape!
			 if( null != endPoint ){
			 break;
			 }
			 }         
			 }
			 
			 return endPoint;
			 }-*/;
}
