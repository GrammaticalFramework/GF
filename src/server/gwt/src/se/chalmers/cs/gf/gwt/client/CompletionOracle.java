package se.chalmers.cs.gf.gwt.client;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.google.gwt.user.client.ui.SuggestOracle;

public class CompletionOracle extends SuggestOracle {

	private static final int LIMIT_SCALE_FACTOR = 4;

	private PGFWrapper pgf;

	private ErrorHandler errorHandler;

	private JSONRequest jsonRequest = null;

	private String oldQuery = null;

	private List<CompletionSuggestion> oldSuggestions = Collections.emptyList();


	public CompletionOracle (PGFWrapper pgf) {
		this(pgf, null);
	}

	public CompletionOracle (PGFWrapper pgf, ErrorHandler errorHandler) {
		this.pgf = pgf;
		this.errorHandler = errorHandler;
		pgf.addSettingsListener(new PGFWrapper.SettingsListener() {
			public void onAvailableGrammarsChanged() { clearState(); }
			public void onSelectedGrammarChanged() { clearState(); }
			public void onInputLanguageChanged() { clearState(); }
			public void onOutputLanguageChanged() { clearState(); }
			public void onStartCategoryChanged() { clearState(); }
			public void onSettingsError(String msg, Throwable e) { clearState(); }
		});
	}

	private void clearState () {
		this.oldQuery = null;
		this.oldSuggestions = Collections.emptyList();
		if (jsonRequest != null) {
			jsonRequest.cancel();
			jsonRequest = null;
		}
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
		if (jsonRequest != null) {
			jsonRequest.cancel();
			jsonRequest = null;
		}

		List<CompletionSuggestion> suggestions = filterOldSuggestions(request);
		if (suggestions != null) {
			suggestionsReady(request, callback, suggestions);
		} else {
			retrieveSuggestions(request, callback);
		}
	}

	/** Filters old suggestions and checks if we still have enough suggestions. */
	private List<CompletionSuggestion> filterOldSuggestions(SuggestOracle.Request request) {
		String query = request.getQuery();		
		if (query.length() > 0 && oldQuery != null && query.startsWith(oldQuery)) {
			// If the prefix had no completions, there is no way that the current input will.
			if (oldSuggestions.isEmpty()) {
				return Collections.emptyList();
			}
			// If the new input since the previous query ends in whitespace,
			// always get completions from the server,
			// since the old suggestions won't include the next word.
			if (query.indexOf(' ', oldQuery.length()) != -1) {
				return null;
			}
			List<CompletionSuggestion> suggestions = new ArrayList<CompletionSuggestion>();
			for (CompletionSuggestion c : oldSuggestions) {
				if (c.getReplacementString().startsWith(query)) {
					suggestions.add(c);
				}
			}			
			if (suggestions.size() >= request.getLimit() || oldSuggestions.size() < request.getLimit()) {
				return suggestions;
			}
		}
		return null;
	}

	private void retrieveSuggestions(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {
		// hack: first report no completions, to hide suggestions until we get the new completions
		callback.onSuggestionsReady(request, new SuggestOracle.Response(Collections.<CompletionSuggestion>emptyList()));

		jsonRequest = pgf.complete(request.getQuery(), LIMIT_SCALE_FACTOR * request.getLimit(), 
				new PGF.CompleteCallback() {
			public void onResult(PGF.Completions completions) {
				jsonRequest = null;
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
