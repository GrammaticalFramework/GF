package org.grammaticalframework.ui.gwt.client;

import org.grammaticalframework.ui.gwt.client.JSONRequestBuilder.Arg;

import java.util.*;
import com.google.gwt.core.client.*;

public class ContentService {
	
	// Event listeners
	private List<SettingsListener> listeners = new LinkedList<SettingsListener>();
	private List<GrammarInfo> grammars = null;

	
	public ContentService() {
	}

	public static class Init extends JavaScriptObject {
		protected Init() { }

		public final native String getUserId() /*-{ return this.userId; }-*/;
		public final native String getUserURL() /*-{ return this.userURL; }-*/;
		public final native String getUserEMail() /*-{ return this.userEMail; }-*/;
		public final native String getContentURL() /*-{ return this.contentURL; }-*/;
	}

	public static final native Init getInit() /*-{
		return $wnd.__gfInit;
	}-*/;

	public void addSettingsListener(SettingsListener listener) {
		listeners.add(listener);
	}
	
	public void updateAvailableGrammars() {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("userId", getInit().getUserId()));
		args.add(new Arg("command", "grammars"));
		JSONRequestBuilder.sendRequest(getInit().getContentURL(), args, new GrammarsCallback() {
			public void onResult(IterableJsArray<ContentService.GrammarInfo> grammars_) {
				grammars = new ArrayList<GrammarInfo>();
				for (ContentService.GrammarInfo grammar : grammars_.iterable()) {
					grammars.add(grammar);
				}
				
				for (SettingsListener listener : listeners) {
					listener.onAvailableGrammarsChanged();
				}
			}

			public void onError(Throwable e) {
			}
		});
	}

	public List<GrammarInfo> getGrammars() {
		return grammars;
	}

	public interface GrammarsCallback extends JSONCallback<IterableJsArray<GrammarInfo>> {}

	public static class GrammarInfo extends JavaScriptObject {
		protected GrammarInfo() { }

		public final native String getURL() /*-{ return this.url; }-*/;
		public final native String getName() /*-{ return this.name; }-*/;
		public final native String getDescription() /*-{ return this.description; }-*/;
	}

	public JSONRequest deleteGrammar(String grammarURL, DeleteCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("url", grammarURL));
		args.add(new Arg("userId", getInit().getUserId()));
		args.add(new Arg("command", "delete_grammar"));
		return JSONRequestBuilder.sendRequest(getInit().getContentURL(), args, callback);
	}

	public JSONRequest save(Object id, String content, SaveCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		if (id != null)
		  args.add(new Arg("id", id.toString()));
		args.add(new Arg("command", "save"));
		return JSONRequestBuilder.sendDataRequest(getInit().getContentURL(), args, content, callback);
	}

	public interface SaveCallback extends JSONCallback<DocumentSignature> {}

	public JSONRequest load(Object id, LoadCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "load"));
		args.add(new Arg("id", id.toString()));
		return JSONRequestBuilder.sendRequest(getInit().getContentURL(), args, callback);
	}

	public interface LoadCallback extends JSONCallback<Document> {}
		
	public JSONRequest search(String fullTextQuery, SearchCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "search"));
		args.add(new Arg("query", fullTextQuery));
		return JSONRequestBuilder.sendRequest(getInit().getContentURL(), args, callback);
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
		return JSONRequestBuilder.sendRequest(getInit().getContentURL(), args, callback);
	}
	
	public interface DeleteCallback extends JSONCallback<DeleteResult> {}
	
	public static class DeleteResult extends JavaScriptObject {
		protected DeleteResult() { }
	}

}
