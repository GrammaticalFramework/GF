#include <jni.h>
#include <sg/sg.h>
#include <pgf/expr.h>
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

JNIEXPORT jobjectArray JNICALL 
Java_org_grammaticalframework_sg_SG_readTriple(JNIEnv *env, jclass cls, jstring s)
{
	GuPool* pool = gu_new_pool();
	
	GuPool* tmp_pool = gu_local_pool();
	GuString buf = j2gu_string(env, s, tmp_pool);
	GuIn* in = gu_data_in((uint8_t*) buf, strlen(buf), tmp_pool);
	GuExn* err = gu_exn(tmp_pool);

	const int len = 3;

	PgfExpr exprs[len];
	int res = pgf_read_expr_tuple(in, 3, exprs, pool, err);
	if (!gu_ok(err) || res == 0) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be parsed");
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jclass expr_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Expr");
	jmethodID expr_constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");

	jobjectArray array = (*env)->NewObjectArray(env, len, expr_class, NULL);
	for (int i = 0; i < len; i++) {
		jobject obj = (*env)->NewObject(env, expr_class, expr_constrId, jpool, NULL, p2l(gu_variant_to_ptr(exprs[i])));
		(*env)->SetObjectArrayElement(env, array, i, obj);
		(*env)->DeleteLocalRef(env, obj);
	}

	return array;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_sg_SG_queryTriple(JNIEnv *env, jobject self,
                                                jobject jsubj,
                                                jobject jpred,
                                                jobject jobj)
{
	SgSG *sg = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	SgTriple triple;
	triple[0] = (jsubj == NULL) ? gu_null_variant
	                            : gu_variant_from_ptr((void*) get_ref(env, jsubj));
	triple[1] = (jpred == NULL) ? gu_null_variant
	                            : gu_variant_from_ptr((void*) get_ref(env, jpred));
	triple[2] = (jobj == NULL)  ? gu_null_variant
	                            : gu_variant_from_ptr((void*) get_ref(env, jobj));
	
	SgTripleResult* res = sg_query_triple(sg, triple, err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The query failed";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass res_class = (*env)->FindClass(env, "org/grammaticalframework/sg/TripleResult");
	jmethodID constrId = (*env)->GetMethodID(env, res_class, "<init>", "(JLorg/grammaticalframework/pgf/Expr;Lorg/grammaticalframework/pgf/Expr;Lorg/grammaticalframework/pgf/Expr;)V");
	jobject jres = (*env)->NewObject(env, res_class, constrId, p2l(res), jsubj, jpred, jobj);

	return jres;
}

JNIEXPORT jboolean JNICALL
Java_org_grammaticalframework_sg_TripleResult_hasNext(JNIEnv *env, jobject self)
{
	SgTripleResult *res = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();
	GuPool* out_pool = gu_new_pool();
	GuExn* err = gu_exn(tmp_pool);

	SgId key;
	SgTriple triple;
	int r = sg_triple_result_fetch(res, &key, triple, out_pool, err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The fetch failed";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(out_pool);
		gu_pool_free(tmp_pool);
		return JNI_FALSE;
	}

	gu_pool_free(tmp_pool);

	if (r) {
		SgTriple orig_triple;
		sg_triple_result_get_query(res, orig_triple);

		jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
		jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
		jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(out_pool));

		jclass expr_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Expr");
		jmethodID constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");

		jclass result_class = (*env)->GetObjectClass(env, self);

		jfieldID keyId = (*env)->GetFieldID(env, result_class, "key", "J");
		(*env)->SetLongField(env, self, keyId, key);

		if (triple[0] != orig_triple[0]) {
			jfieldID subjId = (*env)->GetFieldID(env, result_class, "subj", "Lorg/grammaticalframework/pgf/Expr;");
			jobject jsubj = (*env)->NewObject(env, expr_class, constrId, jpool, jpool, p2l(gu_variant_to_ptr(triple[0])));
			(*env)->SetObjectField(env, self, subjId, jsubj);
		}

		if (triple[1] != orig_triple[1]) {
			jfieldID predId = (*env)->GetFieldID(env, result_class, "pred", "Lorg/grammaticalframework/pgf/Expr;");
			jobject jpred = (*env)->NewObject(env, expr_class, constrId, jpool, jpool, p2l(gu_variant_to_ptr(triple[1])));
			(*env)->SetObjectField(env, self, predId, jpred);
		}

		if (triple[2] != orig_triple[2]) {
			jfieldID objId = (*env)->GetFieldID(env, result_class, "obj", "Lorg/grammaticalframework/pgf/Expr;");
			jobject jobj  = (*env)->NewObject(env, expr_class, constrId, jpool, jpool, p2l(gu_variant_to_ptr(triple[2])));
			(*env)->SetObjectField(env, self, objId, jobj);
		}

		return JNI_TRUE;
	} else {
		gu_pool_free(out_pool);
		return JNI_FALSE;
	}
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_TripleResult_close(JNIEnv *env, jobject self)
{
	SgTripleResult *res = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	
	sg_triple_result_close(res, err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "Closing the result failed";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_SG_beginTrans(JNIEnv *env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	sg_begin_trans(get_ref(env, self), err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The transaction cannot be started";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return;
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_SG_commit(JNIEnv *env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	sg_commit(get_ref(env, self), err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The transaction cannot be commited";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return;
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_sg_SG_rollback(JNIEnv *env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	sg_rollback(get_ref(env, self), err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The transaction cannot be rolled back";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return;
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT jlong JNICALL
Java_org_grammaticalframework_sg_SG_insertTriple(JNIEnv *env, jobject self,
                                                jobject jsubj,
                                                jobject jpred,
                                                jobject jobj)
{
	SgSG *sg = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	SgTriple triple;
	triple[0] = gu_variant_from_ptr((void*) get_ref(env, jsubj));
	triple[1] = gu_variant_from_ptr((void*) get_ref(env, jpred));
	triple[2] = gu_variant_from_ptr((void*) get_ref(env, jobj));

	SgId id = sg_insert_triple(sg, triple, err);
	if (!gu_ok(err)) {
		GuString msg;
		if (gu_exn_caught(err, SgError)) {
			msg = (GuString) gu_exn_caught_data(err);
		} else {
			msg = "The insertion failed";
		}
		throw_string_exception(env, "org/grammaticalframework/sg/SGError", msg);
		gu_pool_free(tmp_pool);
		return 0;
	}

	gu_pool_free(tmp_pool);

	return id;
}
