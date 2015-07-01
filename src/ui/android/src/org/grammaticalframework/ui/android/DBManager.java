package org.grammaticalframework.ui.android;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteOpenHelper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class DBManager extends SQLiteOpenHelper {
    private final Context mContext;

    public DBManager(Context context) {
        super(context, "defs.db", null, 1);
        mContext = context;
    }

    @Override
    public synchronized SQLiteDatabase getReadableDatabase() {
		copyDatabaseFromAssets();
        return super.getReadableDatabase();
    }

    @Override
    public synchronized SQLiteDatabase getWritableDatabase() {
        copyDatabaseFromAssets();
        return super.getWritableDatabase();
    }

    private void copyDatabaseFromAssets() throws SQLiteException {
		String path = mContext.getDatabasePath(getDatabaseName()).getPath();

		File file = new File(path);
		if (file.exists()) {
			return;
		}

		InputStream ins = null;
		OutputStream outs = null;

        try {
			File dir = new File(mContext.getApplicationInfo().dataDir + "/databases");
			if (!dir.exists()) {
				dir.mkdir();
			}

			ins = mContext.getAssets().open(getDatabaseName());
			outs = new FileOutputStream(path);

			byte[] buffer = new byte[1024];
			int length;
			while ((length = ins.read(buffer)) > 0) {
				outs.write(buffer, 0, length);
			}
			outs.flush();
        } catch (IOException e) {
            SQLiteException se = new SQLiteException("Unable to write " + path + " to data directory");
            se.setStackTrace(e.getStackTrace());

            if (outs != null) {
				try {
					outs.close();
				} catch (IOException e2) {
				}
				outs = null;
			}

            file.delete();
            throw se;
        } finally {
			try {
				if (outs != null)
					outs.close();
				if (ins != null)
					ins.close();
			} catch (IOException e) {
			}
		}
    }

	@Override
	public final void onCreate(SQLiteDatabase db) {
    }

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
	}
}
