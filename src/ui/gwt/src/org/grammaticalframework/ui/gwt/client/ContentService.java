package org.grammaticalframework.ui.gwt.client;

import org.grammaticalframework.ui.gwt.client.JSONRequestBuilder.Arg;

import java.util.*;
import com.google.gwt.core.client.*;

public class ContentService {
	String contentBaseURL;
	
	public ContentService(String contentBaseURL) {
		this.contentBaseURL = contentBaseURL;
	}
	
	public String getBaseURL() {
		return contentBaseURL;
	}

	public JSONRequest save(Object id, String content, SaveCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		if (id != null)
		  args.add(new Arg("id", id.toString()));
		args.add(new Arg("command", "save"));
		return JSONRequestBuilder.sendDataRequest(contentBaseURL, args, content, callback);
	}

	public interface SaveCallback extends JSONCallback<DocumentSignature> {}

	public JSONRequest load(Object id, LoadCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "load"));
		args.add(new Arg("id", id.toString()));
		return JSONRequestBuilder.sendRequest(contentBaseURL, args, callback);
	}

	public interface LoadCallback extends JSONCallback<Document> {}
		
	public JSONRequest search(String fullTextQuery, SearchCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "search"));
		args.add(new Arg("query", fullTextQuery));
		return JSONRequestBuilder.sendRequest(contentBaseURL, args, callback);
	}
	
	public interface SearchCallback extends JSONCallback<IterableJsArray<DocumentSignature>> {}
	
	public static class DocumentSignature extends JavaScriptObject {
		protected DocumentSignature() { }

		public final native int getId() /*-{ return this.id; }-*/;
		public final native String getTitle() /*-{ return this.title; }-*/;
		public final native String getCreated() /*-{ return this.created; }-*/;
		public final native String getModified() /*-{ return this.modified; }-*/;
	}
	
	public static class Document extends DocumentSignature {
		protected Document() { }
		
		public final native String getContent() /*-{ return this.content; }-*/;
	}
	
	public JSONRequest delete(List ids, DeleteCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "delete"));
		for (Object id : ids) {
			args.add(new Arg("id", id.toString()));
		}
		return JSONRequestBuilder.sendRequest(contentBaseURL, args, callback);
	}
	
	public interface DeleteCallback extends JSONCallback<DeleteResult> {}
	
	public static class DeleteResult extends JavaScriptObject {
		protected DeleteResult() { }
	}

}
