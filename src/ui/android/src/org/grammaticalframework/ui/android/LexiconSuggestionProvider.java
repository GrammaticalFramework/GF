package org.grammaticalframework.ui.android;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.provider.BaseColumns;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.app.SearchManager;
import android.net.Uri;
import android.util.Log;
import android.view.inputmethod.CompletionInfo;

public class LexiconSuggestionProvider extends ContentProvider {
	private Translator mTranslator;

    public boolean onCreate() {
        return true;
    }

    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
		mTranslator = ((GFTranslator) getContext().getApplicationContext()).getTranslator();
		String[] columns = new String[] {
			BaseColumns._ID,
			SearchManager.SUGGEST_COLUMN_TEXT_1,
			SearchManager.SUGGEST_COLUMN_QUERY
		};

		String query = uri.getLastPathSegment();
		MatrixCursor cursor = new MatrixCursor(columns, 100);
		for (CompletionInfo info : mTranslator.lookupWordPrefix(query)) {
			cursor.addRow(new String[] {Long.toString(info.getId()),info.getText().toString(),info.getText().toString()});
		}

		return cursor;
	}

	public Uri insert (Uri uri, ContentValues values) {
		throw new UnsupportedOperationException();
	}

    public int update (Uri uri, ContentValues values, String selection, String[] selectionArgs) {
		throw new UnsupportedOperationException();
	}

	public int delete (Uri uri, String selection, String[] selectionArgs) {
		throw new UnsupportedOperationException();
	}

	public String getType (Uri uri) {
		return null;
	}
}
