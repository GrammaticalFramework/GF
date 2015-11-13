package org.grammaticalframework.ui.android;

import java.io.*;
import android.content.Context;

import org.grammaticalframework.sg.*;
import org.grammaticalframework.pgf.*;

public class SemanticGraphManager implements Closeable {
    private final Context mContext;
    private SG mDB;

	public static final String GLOSSES_FILE_NAME = "glosses.txt";
	public static final String DATABASE_FILE_NAME = "semantics.db";

    public SemanticGraphManager(Context context) {
        mContext = context;
        mDB = null;
    }

    private void createDatabaseFromAssets() throws SGError, IOException {
		if (mDB != null)
			return;

		String path = mContext.getDatabasePath(DATABASE_FILE_NAME).getPath();

		boolean exists = false;

		File file = new File(path);
		if (((GFTranslator) mContext.getApplicationContext()).getTranslator().isUpgraded("db_version")) {
			file.delete();
		} else {
			if (file.exists()) {
				exists = true;
			}
		}

		File dir = new File(mContext.getApplicationInfo().dataDir + "/databases");
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		mDB = SG.openSG(path);
		if (exists)
			return;

		BufferedReader br = new BufferedReader(
			new InputStreamReader(
				mContext.getAssets().open(GLOSSES_FILE_NAME)));

		try {
			mDB.beginTrans();

			String line;
			while ((line = br.readLine()) != null) {
				Expr[] triple = SG.readTriple(line);
				mDB.insertTriple(triple[0],triple[1],triple[2]);
			}

			mDB.commit();
		} catch (IOException e) {
			mDB.rollback();
			throw e;
		} catch (SGError e) {
			mDB.rollback();
			throw e;
		} finally {
			br.close();
		}
    }

	public void close() {
		if (mDB != null) {
			mDB.close();
			mDB = null;
		}
	}

    public Expr getGloss(Expr lemma) {
		Expr obj = null;

		try {
			createDatabaseFromAssets();
			TripleResult res = mDB.queryTriple(lemma, Expr.readExpr("gloss"), null);
			if (res.hasNext()) {
				obj = res.getObject();
			}
			res.close();
		} catch (IOException e) {
			// nothing
		} catch (SGError e) {
			// nothing
		}

		return obj;
	}
}
