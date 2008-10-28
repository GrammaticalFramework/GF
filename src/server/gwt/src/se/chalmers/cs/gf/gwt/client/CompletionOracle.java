package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.google.gwt.user.client.ui.SuggestOracle;

public class CompletionOracle extends SuggestOracle {

	private static final int LIMIT_SCALE_FACTOR = 10;

	private PGF pgf;

	private ErrorHandler errorHandler;

	private List<String> inputLangs = null;

	private JSONRequest jsonRequest = null;

	private String oldQuery = null;

	private List<CompletionSuggestion> oldSuggestions = Collections.emptyList();


	public CompletionOracle (PGF pgf) {
		this(pgf, null);
	}

	public CompletionOracle (PGF pgf, ErrorHandler errorHandler) {
		this.pgf = pgf;
		this.errorHandler = errorHandler;
	}

	public void setInputLangs(List<String> inputLangs) {
		this.inputLangs = inputLangs;
		this.oldQuery = null;
		this.oldSuggestions = Collections.emptyList();
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

	public void requestSuggestions(SuggestOracle.Request request, SuggestOracle.Callback callback) {

		// Only allow a single completion request at a time
		if (jsonRequest != null)
			jsonRequest.cancel();

		List<CompletionSuggestion> suggestions = filterOldSuggestions(request);
		if (suggestions != null) {
			suggestionsReady(request, callback, suggestions);
		} else {
			retrieveSuggestions(request, callback);
		}
	}

	/** Filters old suggestions and checks if we still have enough suggestions. */
	private List<CompletionSuggestion> filterOldSuggestions(SuggestOracle.Request request) {
		List<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
		if (oldQuery != null && request.getQuery().startsWith(oldQuery)) {
			for (CompletionSuggestion c : oldSuggestions) {
				if (c.getReplacementString().startsWith(request.getQuery())) {
					suggestions.add(c);
				}
			}
			if (suggestions.size() > 1 && (suggestions.size() >= request.getLimit() || oldSuggestions.size() < request.getLimit())) {
				return suggestions;
			}
		}
		return null;
	}

	private void retrieveSuggestions(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {
		// hack: first report no completions, to hide suggestions until we get the new completions
		callback.onSuggestionsReady(request, new SuggestOracle.Response(Collections.<CompletionSuggestion>emptyList()));

		jsonRequest = pgf.complete(request.getQuery(), getInputLangs(), null, LIMIT_SCALE_FACTOR * request.getLimit(), 
				new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				List<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
				for (PGF.Completion completion : completions.iterable()) {
					suggestions.add(new CompletionSuggestion(completion.getText()));
				}
				suggestionsReady(request, callback, suggestions);
			}

			public void onError(Throwable e) {
				errorHandler.onError(e);
			}

		});
	}

	private void suggestionsReady(SuggestOracle.Request request, SuggestOracle.Callback callback, List<CompletionSuggestion> suggestions) {
		this.oldQuery = request.getQuery();
		this.oldSuggestions = suggestions;
		suggestions = suggestions.size() <= request.getLimit() ? suggestions : SubList.makeSubList(suggestions, 0, request.getLimit());
		callback.onSuggestionsReady(request, new SuggestOracle.Response(suggestions));
	}

}
