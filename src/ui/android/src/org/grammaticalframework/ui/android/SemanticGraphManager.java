package org.grammaticalframework.ui.android;

import java.io.*;
import android.content.Context;
import android.util.Log;

import org.grammaticalframework.sg.*;
import org.grammaticalframework.pgf.*;

public class SemanticGraphManager implements Closeable {
    private final Context mContext;
    private SG mDB;

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

		if (!extractDatabase(file))
			return;

		mDB = SG.openSG(path);
		if (exists)
			return;
    }

	private boolean extractDatabase(File outFile) {
        InputStream in = null;
        OutputStream out = null;
        try {
          in = mContext.getAssets().open(DATABASE_FILE_NAME);
          out = new FileOutputStream(outFile);
          copyFile(in, out);
          return true;
        } catch(IOException e) {
            Log.e("tag", "Failed to copy asset file: " + DATABASE_FILE_NAME, e);
        }
        finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    // NOOP
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    // NOOP
                }
            }
        }
        
        return false;
    }

	private void copyFile(InputStream in, OutputStream out) throws IOException {
		byte[] buffer = new byte[1024];
		int read;
		while((read = in.read(buffer)) != -1){
			out.write(buffer, 0, read);
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
