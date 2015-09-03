#include <jni.h>
#include <sg/sg.h>
#include "jni_utils.h"

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_sg_SG_openSG(JNIEnv *env, jclass cls, jstring path)
{
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	const char *fpath = (*env)->GetStringUTFChars(env, path, 0); 

	// Read the PGF grammar.
	SgSG* sg = sg_open(fpath, err);

	(*env)->ReleaseStringUTFChars(env, path, fpath);

	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The database cannot be opened";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(J)V");
	return (*env)->NewObject(env, cls, constrId, p2l(sg));
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_SG_close(JNIEnv *env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	sg_close(get_ref(env, self), err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The database cannot be closed";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return;
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_sg_SG_queryTriple(JNIEnv *env, jobject self,
                                                jobject subj,
                                                jobject pred,
                                                jobject obj)
{
	return NULL;
}

JNIEXPORT jboolean JNICALL
Java_org_grammaticalframework_sg_TripleResult_hasNext(JNIEnv *env, jobject self)
{
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_TripleResult_close(JNIEnv *env, jobject self)
{
}
