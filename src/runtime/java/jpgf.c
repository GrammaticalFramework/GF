#include <pgf/pgf.h>
#include <gu/mem.h>
#include "org_grammaticalframework_PGF.h"

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_PGF_readPGF(JNIEnv *env, jclass cls, jstring s)
{ 
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	const char *fpath = (*env)->GetStringUTFChars(env, s, 0); 

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(fpath, pool, err);

	(*env)->ReleaseStringUTFChars(env, s, fpath);

	if (!gu_ok(err)) {
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(JJ)V");

	return (*env)->NewObject(env, cls, constrId, (long) pool, (long) pgf);
}

JNIEXPORT void JNICALL 
Java_org_grammaticalframework_PGF_free(JNIEnv* env, jclass cls, jlong pool)
{
	gu_pool_free((GuPool*) pool);
}
