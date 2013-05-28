#include <pgf/pgf.h>
#include <gu/mem.h>
#include "org_grammaticalframework_PGF.h"

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_PGF_readPGF(JNIEnv *env, jclass cls, jstring s)
{
	const char *fpath = (*env)->GetStringUTFChars(env, s, 0); 
 
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(fpath, pool, err);
	if (!gu_ok(err)) {
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	(*env)->ReleaseStringUTFChars(env, s, fpath);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(II)V");

	return (*env)->NewObject(env, cls, constrId, (int) pool, (int) pgf);
}
