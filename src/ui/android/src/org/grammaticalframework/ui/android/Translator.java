package org.grammaticalframework.ui.android;

import android.content.Context;
import android.util.Log;

import org.grammaticalframework.pgf.Concr;
import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.pgf.PGF;
import org.grammaticalframework.pgf.ParseError;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;

public class Translator {

    private static final String TAG = "Translator";

    // TODO: allow changing
    private String mGrammar = "ResourceDemo.pgf";

    // TODO: build dynamically?
    private Language[] mLanguages = {
            new Language("en-US", "English", "ResourceDemoEng"),
            new Language("de-DE", "German", "ResourceDemoGer"),
            new Language("es-ES", "Spanish", "ResourceDemoSpa"),
            new Language("fr-FR", "French", "ResourceDemoFre"),
    };

    private final Context mContext;

    private Language mSourceLanguage;

    private Language mTargetLanguage;

    private PGF mPgf;

    public Translator(Context context) {
        mContext = context;
    }

    public Context getContext() {
        return mContext;
    }

    public List<Language> getAvailableSourceLanguages() {
        return Arrays.asList(mLanguages);
    }

    public List<Language> getAvailableTargetLanguages() {
        return Arrays.asList(mLanguages);
    }

    public void setSourceLanguage(Language language) {
        mSourceLanguage = language;
    }

    public void setTargetLanguage(Language language) {
        mTargetLanguage = language;
    }

    public Language getSourceLanguage() {
        return mSourceLanguage != null ? mSourceLanguage : mLanguages[0];
    }

    public Language getTargetLanguage() {
        return mTargetLanguage != null ? mTargetLanguage : mLanguages[1];
    }

    /**
     * Takes a lot of time. Must not be called on the main thread.
     */
    public void init() {
        ensureLoaded(mGrammar);
    }

    /**
     * Takes a lot of time. Must not be called on the main thread.
     */
    public String translate(String input) {
        ensureLoaded(mGrammar);
        return translateInternal(input);
    }

    private synchronized void ensureLoaded(String grammarName) {
        if (mPgf != null) return;

        try {
            // TODO: use PGF API to read this directly from assets
            Log.d(TAG, "Copying grammar...");
            File file = copyAsset(grammarName);
            Log.d(TAG, "Trying to open " + file);
            mPgf = PGF.readPGF(file.getPath());
        } catch (FileNotFoundException e) {
            Log.e(TAG, "File not found", e);
        } catch (IOException e) {
            Log.e(TAG, "Error loading grammar", e);
        }
    }

    private File copyAsset(String asset) throws IOException {
        InputStream in = null;
        OutputStream out = null;
        try {
            in = getContext().getAssets().open(asset);
            out = getContext().openFileOutput(asset, Context.MODE_PRIVATE);
            byte[] buf = new byte[4096];
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            return getContext().getFileStreamPath(asset);
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

    protected String translateInternal(String input) {
        try {
            Concr sourceGrammar = getConcr(getSourceLanguage().getConcrete());
            Expr expr = sourceGrammar.parseBest("S", input);
            Concr targetGrammar = getConcr(getTargetLanguage().getConcrete());
            String output = targetGrammar.linearize(expr);
            return output;
        } catch (ParseError e) {
            Log.e(TAG, "Parse error: " + e);
            return "parse error"; // TODO: no no no
        }
    }

    private Concr getConcr(String name) {
        return mPgf.getLanguages().get(name);
    }

}
