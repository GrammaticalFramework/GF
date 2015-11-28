package org.grammaticalframework.ui.android;

import java.io.*;
import android.content.Context;

import org.grammaticalframework.sg.*;
import org.grammaticalframework.pgf.*;

public class SemanticGraphManager implements Closeable {
    private final Context mContext;
    private SG mDB;

	public static final String GLOSSES_FILE_NAME = "glosses.txt";
	public static final String TOPICS_FILE_NAME  = "topics.txt";
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

		loadFile(GLOSSES_FILE_NAME);
		loadFile(TOPICS_FILE_NAME);
    }

	private void loadFile(String assetName) throws IOException {
		BufferedReader br = new BufferedReader(
			new InputStreamReader(
				mContext.getAssets().open(assetName)));

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
	
	public TripleResult queryTriple(Expr subj, Expr pred, Expr obj) throws IOException {
		createDatabaseFromAssets();
		return mDB.queryTriple(subj, pred, obj);
	}
}
