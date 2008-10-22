package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.user.client.ui.SuggestOracle;

import com.google.gwt.core.client.GWT;

import java.util.*;

public class CompletionOracle extends SuggestOracle {

    private PGF pgf;

    private ErrorHandler errorHandler;

    private List<String> inputLangs = null;

    private PGFRequest pgfRequest = null;


    public CompletionOracle (PGF pgf) {
	this(pgf, null);
    }

    public CompletionOracle (PGF pgf, ErrorHandler errorHandler) {
	this.pgf = pgf;
	this.errorHandler = errorHandler;
    }

    public void setInputLangs(List<String> inputLangs) {
	this.inputLangs = inputLangs;
    }

    public List<String> getInputLangs() {
	return inputLangs;
    }

    public void setErrorHandler(ErrorHandler errorHandler) {
	this.errorHandler = errorHandler;
    }

    public static interface ErrorHandler {
	public void onError(Throwable e);
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

	// only allow a single completion request at a time
	if (pgfRequest != null)
	    pgfRequest.cancel();

	pgfRequest = pgf.complete(request.getQuery(), getInputLangs(), null, request.getLimit(), 
		    new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
			    Collection<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
			    for (int i = 0; i < completions.length(); i++) {
				String text = completions.get(i).getText();
				suggestions.add(new CompletionSuggestion(text));
			    }
			    callback.onSuggestionsReady(request, new SuggestOracle.Response(suggestions));
			}

			public void onError(Throwable e) {
			    errorHandler.onError(e);
			}

	    });
    }    

}
