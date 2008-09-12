package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.user.client.ui.SuggestOracle;

import java.util.*;

public class CompletionOracle extends SuggestOracle {

    private GF gf;

    public CompletionOracle (String gfBaseURL) {
	gf = new GF(gfBaseURL);
    }

    public static class CompletionSuggestion implements SuggestOracle.Suggestion {
	private String string;
	public CompletionSuggestion(String string) {
	    this.string = string;
	}

	public String getDisplayString() {
	    return string;
	}

	public String getReplacementString() {
	    return string + " ";
	}
    }

    public void requestSuggestions(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {
	gf.complete(request.getQuery(), request.getLimit(), new GF.CompleteCallback() {
		public void onCompleteDone(GF.Completions completions) {
		    Collection<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
		    for (String lang : completions.getCompletionLanguages()) {
			int c = completions.countCompletions(lang);
			for (int i = 0; i < c; i++) {
			    String text = request.getQuery() + " " + completions.getCompletion(lang,i);
			    suggestions.add(new CompletionSuggestion(text));
			}
		    }
		    callback.onSuggestionsReady(request, new SuggestOracle.Response(suggestions));
		}
	    });
    }    

}
