package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.event.logical.shared.*;
import com.google.gwt.event.shared.*;
import com.google.gwt.dom.client.Node;
import com.google.gwt.dom.client.Text;
import com.google.gwt.dom.client.Element;
import com.google.gwt.dom.client.Document;
import org.grammaticalframework.ui.gwt.client.selection.*;

public class MagnetSearchBox extends FocusWidget {
	public MagnetSearchBox() {
    		this(Document.get().createDivElement());
	}

	public MagnetSearchBox(Element elem) {
		super(elem);
		elem.setAttribute("contentEditable", "true");
		setStyleName("searchbox");
	}

	public String getText() {
		return getElement().getInnerText();
	}

	public void setText(String s) {
		getElement().setInnerText(s);
	}
	
	public int getCursorPos() {
		return 0;
	}

	public void setCursorPos(int pos) {
		Node child = getElement().getFirstChild();
		if (child instanceof Text) {
			SelectionEndPoint selPoint = new SelectionEndPoint((Text) child,pos);
			Selection sel = Selection.getSelection();
			sel.select(selPoint,selPoint);
		}
		return;
	}
}
