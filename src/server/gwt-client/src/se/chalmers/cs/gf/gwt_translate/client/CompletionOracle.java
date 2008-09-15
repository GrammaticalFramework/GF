package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.user.client.ui.SuggestOracle;

import java.util.*;

public class CompletionOracle extends SuggestOracle {

    private GF gf;

    private List<String> inputLangs;

    public CompletionOracle (GF gf) {
	this.gf = gf;
	inputLangs = new ArrayList<String>();
    }

    public void setInputLangs(List<String> inputLangs) {
	this.inputLangs = inputLangs;
    }

    public List<String> getInputLangs() {
	return inputLangs;
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
	    return string;
	}
    }

    public void requestSuggestions(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {
	gf.complete(request.getQuery(), getInputLangs(), null, request.getLimit(), 
		    new GF.CompleteCallback() {
		public void onCompleteDone(GF.Completions completions) {
		    Collection<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
		    for (int i = 0; i < completions.length(); i++) {
			String text = completions.get(i).getText();
			suggestions.add(new CompletionSuggestion(text));
		    }
		    callback.onSuggestionsReady(request, new SuggestOracle.Response(suggestions));
		}
	    });
    }    

}
