#include <pgf/pgf.h>
#include <pgf/linearizer.h>
#include <gu/mem.h>
#include <gu/exn.h>
#include <math.h>
#include <jni.h>
#include "jni_utils.h"

static JavaVM* cachedJVM;

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *jvm, void *reserved)
{
    cachedJVM = jvm;
    return JNI_VERSION_1_6;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_PGF_readPGF__Ljava_lang_String_2(JNIEnv *env, jclass cls, jstring s)
{ 
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	const char *fpath = (*env)->GetStringUTFChars(env, s, 0); 

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(fpath, pool, err);

	(*env)->ReleaseStringUTFChars(env, s, fpath);

	if (!gu_ok(err)) {
		if (gu_exn_caught(err, GuErrno)) {
			throw_jstring_exception(env, "java/io/FileNotFoundException", s);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The grammar cannot be loaded");
		}
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(JJ)V");
	return (*env)->NewObject(env, cls, constrId, p2l(pool), p2l(pgf));
}

typedef struct {
	GuInStream stream;
	jobject java_stream;
	JNIEnv *env;
	jmethodID read_method;
	jbyteArray buf_array;
	jbyte *buf;
} JInStream;

static const uint8_t*
jpgf_jstream_begin_buffer(GuInStream* self, size_t* sz_out, GuExn* err)
{
	*sz_out = 0;

	JInStream* jstream = (JInStream*) self;
	int sz = (*jstream->env)->CallIntMethod(jstream->env, jstream->java_stream, jstream->read_method, jstream->buf_array);
	if ((*jstream->env)->ExceptionOccurred(jstream->env)) {
		gu_raise(err, PgfExn);
		return NULL;
	}

	jboolean isCopy;
	jstream->buf = (*jstream->env)->GetByteArrayElements(jstream->env, jstream->buf_array, &isCopy);
	if ((*jstream->env)->ExceptionOccurred(jstream->env)) {
		gu_raise(err, PgfExn);
		return NULL;
	}

	*sz_out = (size_t) sz;
	return ((uint8_t*) jstream->buf);
}

static void
jpgf_jstream_end_buffer(GuInStream* self, size_t consumed, GuExn* err)
{
	JInStream* jstream = (JInStream*) self;
	(*jstream->env)->ReleaseByteArrayElements(jstream->env, jstream->buf_array, jstream->buf, JNI_ABORT);
}

static GuInStream*
jpgf_new_java_stream(JNIEnv* env, jobject java_stream, GuPool* pool)
{
	jclass java_stream_class = (*env)->GetObjectClass(env, java_stream);

	JInStream* jstream = gu_new(JInStream, pool);
	jstream->stream.begin_buffer = jpgf_jstream_begin_buffer;
	jstream->stream.end_buffer = jpgf_jstream_end_buffer;
	jstream->stream.input = NULL;
	jstream->java_stream = java_stream;
	jstream->env = env;

	jstream->read_method = (*env)->GetMethodID(env, java_stream_class, "read", "([B)I");
	if (!jstream->read_method) {
		return NULL;
	}

	jstream->buf_array = (*env)->NewByteArray(env, 1024);
	if (!jstream->buf_array) {
		return NULL;
	}

	jstream->buf = NULL;

	return &jstream->stream;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_readPGF__Ljava_io_InputStream_2(JNIEnv *env, jclass cls, jobject java_stream)
{
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	GuInStream* jstream =
		jpgf_new_java_stream(env, java_stream, tmp_pool);
	if (!jstream) {
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	GuIn* in = gu_new_in(jstream, tmp_pool);

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read_in(in, pool, tmp_pool, err);
	if (!gu_ok(err)) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The grammar cannot be loaded");
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(JJ)V");
	return (*env)->NewObject(env, cls, constrId, p2l(pool), p2l(pgf));
}

JNIEXPORT jstring JNICALL 
Java_org_grammaticalframework_pgf_PGF_getAbstractName(JNIEnv* env, jobject self)
{
	return gu2j_string(env, pgf_abstract_name(get_ref(env, self)));
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_PGF_getStartCat(JNIEnv* env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();
	PgfType* type = pgf_start_cat(get_ref(env, self), tmp_pool);
	jstring jcat = gu2j_string(env, type->cid);
	gu_pool_free(tmp_pool);
	return jcat;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_getFunctionType(JNIEnv* env, jobject self, jstring jid)
{
	PgfPGF* pgf = get_ref(env, self);
	GuPool* tmp_pool = gu_new_pool();
	PgfCId id = j2gu_string(env, jid, tmp_pool);
	PgfType* tp = pgf_function_type(pgf, id);
	gu_pool_free(tmp_pool);

	if (tp == NULL)
		return NULL;

	jclass type_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Type");
	jmethodID constrId = (*env)->GetMethodID(env, type_class, "<init>", "(Ljava/lang/Object;J)V");
	jobject jtype = (*env)->NewObject(env, type_class, constrId, self, p2l(tp));

	return jtype;
}

JNIEXPORT jdouble JNICALL
Java_org_grammaticalframework_pgf_PGF_getFunctionProb(JNIEnv* env, jobject self, jstring jid)
{
	PgfPGF* pgf = get_ref(env, self);
	GuPool* tmp_pool = gu_local_pool();
	PgfCId id = j2gu_string(env, jid, tmp_pool);
	double prob = pgf_function_prob(pgf, id);
	gu_pool_free(tmp_pool);

	return prob;
}

typedef struct {
	GuMapItor fn;
	JNIEnv *env;
	jobject grammar;
	jobject object;
	jmethodID method_id;
} JPGFClosure;

static void
pgf_collect_langs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    PgfConcr* concr = *((PgfConcr**) value);
    JPGFClosure* clo = (JPGFClosure*) fn;

	jstring jname = gu2j_string(clo->env, name);

	jclass concr_class = (*clo->env)->FindClass(clo->env, "org/grammaticalframework/pgf/Concr");
	jmethodID constrId = (*clo->env)->GetMethodID(clo->env, concr_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;J)V");
	jobject jconcr = (*clo->env)->NewObject(clo->env, concr_class, constrId, clo->grammar, p2l(concr));

	(*clo->env)->CallObjectMethod(clo->env, clo->object, clo->method_id, jname, jconcr);
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_getLanguages(JNIEnv* env, jobject self)
{
	jclass map_class = (*env)->FindClass(env, "java/util/HashMap");
	if (!map_class)
		return NULL;
	jmethodID constrId = (*env)->GetMethodID(env, map_class, "<init>", "()V");
	if (!constrId)
		return NULL;
	jobject languages = (*env)->NewObject(env, map_class, constrId);
	if (!languages)
		return NULL;
	jmethodID put_method = (*env)->GetMethodID(env, map_class, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");
	if (!put_method)
		return NULL;

	PgfPGF* pgf = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	JPGFClosure clo = { { pgf_collect_langs }, env, self, languages, put_method };
	pgf_iter_languages(pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}
	
	gu_pool_free(tmp_pool);

	return languages;
}

static void
pgf_collect_names(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    JPGFClosure* clo = (JPGFClosure*) fn;

	jstring jname = gu2j_string(clo->env, name);

	(*clo->env)->CallBooleanMethod(clo->env, clo->object, clo->method_id, jname);
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_getCategories(JNIEnv* env, jobject self)
{
	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	if (!list_class)
		return NULL;
	jmethodID constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	if (!constrId)
		return NULL;
	jobject categories = (*env)->NewObject(env, list_class, constrId);
	if (!categories)
		return NULL;
	jmethodID add_method = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");
	if (!add_method)
		return NULL;

	PgfPGF* pgf = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);
	
	JPGFClosure clo = { { pgf_collect_names }, env, self, categories, add_method };
	pgf_iter_categories(pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return categories;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_getFunctions(JNIEnv* env, jobject self)
{
	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	if (!list_class)
		return NULL;
	jmethodID constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	if (!constrId)
		return NULL;
	jobject functions = (*env)->NewObject(env, list_class, constrId);
	if (!functions)
		return NULL;
	jmethodID add_method = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");
	if (!add_method)
		return NULL;

	PgfPGF* pgf = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);
	
	JPGFClosure clo = { { pgf_collect_names }, env, self, functions, add_method };
	pgf_iter_functions(pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return functions;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_getFunctionsByCat(JNIEnv* env, jobject self, jstring jcat)
{
	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	if (!list_class)
		return NULL;
	jmethodID constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	if (!constrId)
		return NULL;
	jobject functions = (*env)->NewObject(env, list_class, constrId);
	if (!functions)
		return NULL;
	jmethodID add_method = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");
	if (!add_method)
		return NULL;

	PgfPGF* pgf = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();

	PgfCId cat = j2gu_string(env, jcat, tmp_pool);

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);
	
	JPGFClosure clo = { { pgf_collect_names }, env, self, functions, add_method };
	pgf_iter_functions_by_cat(pgf, cat, &clo.fn, err);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return functions;
}

JNIEXPORT jstring JNICALL 
Java_org_grammaticalframework_pgf_Concr_getName(JNIEnv* env, jobject self)
{
	return gu2j_string(env, pgf_concrete_name(get_ref(env, self)));
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_pgf_Concr_load__Ljava_io_InputStream_2(JNIEnv* env, jobject self, jobject java_stream)
{
	GuPool* tmp_pool = gu_local_pool();

	GuInStream* jstream =
		jpgf_new_java_stream(env, java_stream, tmp_pool);
	if (!jstream) {
		gu_pool_free(tmp_pool);
		return;
	}

	GuIn* in = gu_new_in(jstream, tmp_pool);

	// Create an exception frame that catches all errors.
	GuExn* err = gu_exn(tmp_pool);

	pgf_concrete_load(get_ref(env, self), in, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The language cannot be loaded");
		}
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_pgf_Concr_unload(JNIEnv* env, jobject self)
{
	pgf_concrete_unload(get_ref(env, self));
}

JNIEXPORT jlong JNICALL 
Java_org_grammaticalframework_pgf_Parser_newCallbacksMap
  (JNIEnv* env, jclass clazz, jobject jconcr, jobject jpool)
{
	return p2l(pgf_new_callbacks_map(get_ref(env, jconcr), get_ref(env, jpool)));
}

typedef struct {
	PgfLiteralCallback callback;
	jobject jcallback;
	jmethodID match_methodId;
	jmethodID predict_methodId;
	GuFinalizer fin;
} JPgfLiteralCallback;

typedef struct {
	GuEnum en;
	jobject jiterator;
	GuFinalizer fin;
} JPgfTokenProbEnum;

static PgfExprProb*
jpgf_literal_callback_match(PgfLiteralCallback* self, PgfConcr* concr,
                            size_t lin_idx,
                            GuString sentence, size_t* poffset,
                            GuPool *out_pool)
{
	JPgfLiteralCallback* callback = gu_container(self, JPgfLiteralCallback, callback);

	JNIEnv *env;
    (*cachedJVM)->AttachCurrentThread(cachedJVM, (void**)&env, NULL);

	size_t  joffset   = gu2j_string_offset(sentence, *poffset);
	jobject result = (*env)->CallObjectMethod(env, callback->jcallback, callback->match_methodId, lin_idx, joffset);
	if (result == NULL)
		return NULL;

	jclass result_class = (*env)->GetObjectClass(env, result);
	
	jfieldID epId = (*env)->GetFieldID(env, result_class, "ep", "Lorg/grammaticalframework/pgf/ExprProb;");
	jobject jep = (*env)->GetObjectField(env, result, epId);
	jclass ep_class = (*env)->GetObjectClass(env, jep);
	jfieldID exprId = (*env)->GetFieldID(env, ep_class, "expr", "Lorg/grammaticalframework/pgf/Expr;");
	jobject jexpr = (*env)->GetObjectField(env, jep, exprId);
	jfieldID probId = (*env)->GetFieldID(env, ep_class, "prob", "D");
	double prob = (*env)->GetDoubleField(env, jep, probId);

	jfieldID offsetId = (*env)->GetFieldID(env, result_class, "offset", "I");
	*poffset = j2gu_string_offset(sentence, (*env)->GetIntField(env, result, offsetId));

	PgfExprProb* ep = gu_new(PgfExprProb, out_pool);
	ep->expr = gu_variant_from_ptr(get_ref(env, jexpr));
	ep->prob = prob;

	
	{
		// This is an uggly hack. We first show the expression ep->expr
		// and then we read it back but in out_pool. The whole purpose
		// of this is to copy the expression from the temporary pool
		// that was created in the Java binding to the parser pool.
		// There should be a real copying function or even better
		// there must be a way to avoid copying at all.

		GuPool* tmp_pool = gu_local_pool();

		GuExn* err = gu_exn(tmp_pool);
		GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		pgf_print_expr(ep->expr, NULL, 0, out, err);

		GuString str = gu_string_buf_data(sbuf);
		size_t   len = gu_string_buf_length(sbuf);
		GuIn* in = gu_data_in((uint8_t*) str, len, tmp_pool);

		ep->expr = pgf_read_expr(in, out_pool, err);
		if (!gu_ok(err) || gu_variant_is_null(ep->expr)) {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be parsed");
			gu_pool_free(tmp_pool);
			return NULL;
		}

		gu_pool_free(tmp_pool);
	}

	return ep;
}

static void 
jpgf_token_prob_enum_fin(GuFinalizer* self)
{
	JPgfTokenProbEnum* en = gu_container(self, JPgfTokenProbEnum, fin);
	
	JNIEnv *env;
    (*cachedJVM)->AttachCurrentThread(cachedJVM, (void**)&env, NULL);

	(*env)->DeleteGlobalRef(env, en->jiterator);
}

static GuEnum*
jpgf_literal_callback_predict(PgfLiteralCallback* self, PgfConcr* concr,
	                          size_t lin_idx,
	                          GuString prefix,
	                          GuPool *out_pool)
{
	JPgfLiteralCallback* callback = gu_container(self, JPgfLiteralCallback, callback);

	JNIEnv *env;
    (*cachedJVM)->AttachCurrentThread(cachedJVM, (void**)&env, NULL);

	jstring jprefix = gu2j_string(env, prefix);
	jobject jiterator = (*env)->CallObjectMethod(env, callback->jcallback, callback->predict_methodId, lin_idx, jprefix);
	if (jiterator == NULL)
		return NULL;

	JPgfTokenProbEnum* en = gu_new(JPgfTokenProbEnum, out_pool);
	en->en.next = NULL;
	en->jiterator = (*env)->NewGlobalRef(env, jiterator);
	en->fin.fn = jpgf_token_prob_enum_fin;

	gu_pool_finally(out_pool, &en->fin);

	return &en->en;
}

static void 
jpgf_literal_callback_fin(GuFinalizer* self)
{
	JPgfLiteralCallback* callback = gu_container(self, JPgfLiteralCallback, fin);
	
	JNIEnv *env;
    (*cachedJVM)->AttachCurrentThread(cachedJVM, (void**)&env, NULL);

	(*env)->DeleteGlobalRef(env, callback->jcallback);
}

JNIEXPORT void JNICALL Java_org_grammaticalframework_pgf_Parser_addLiteralCallback
  (JNIEnv* env, jclass clazz, jobject jconcr, jlong callbacksRef, jstring jcat, jobject jcallback, jobject jpool)
{
	PgfConcr* concr = get_ref(env, jconcr);
	GuPool* pool = get_ref(env, jpool);

	JPgfLiteralCallback* callback = gu_new(JPgfLiteralCallback, pool);
	callback->callback.match   = jpgf_literal_callback_match;
	callback->callback.predict = jpgf_literal_callback_predict;
	callback->jcallback = (*env)->NewGlobalRef(env, jcallback);
	callback->fin.fn = jpgf_literal_callback_fin;

	jclass callback_class = (*env)->GetObjectClass(env, jcallback);
	callback->match_methodId = (*env)->GetMethodID(env, callback_class, "match", "(II)Lorg/grammaticalframework/pgf/LiteralCallback$CallbackResult;");
	callback->predict_methodId = (*env)->GetMethodID(env, callback_class, "predict", "(ILjava/lang/String;)Ljava/util/Iterator;");

	gu_pool_finally(pool, &callback->fin);
	
	pgf_callbacks_map_add_literal(concr, l2p(callbacksRef),
                                  j2gu_string(env, jcat, pool), &callback->callback);
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_Parser_parseWithHeuristics
  (JNIEnv* env, jclass clazz, jobject jconcr, jstring jstartCat, jstring js, jdouble heuristics, jlong callbacksRef, jobject jpool)
{
	GuPool* pool = get_ref(env, jpool);
	GuPool* out_pool = gu_new_pool();

    GuString startCat = j2gu_string(env, jstartCat, pool);
    GuString s = j2gu_string(env, js, pool);
    GuExn* parse_err = gu_new_exn(pool);

	PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
	type->hypos   = gu_empty_seq();
	type->cid     = startCat;
	type->n_exprs = 0;

	GuEnum* res =
		pgf_parse_with_heuristics(get_ref(env, jconcr), type, s, heuristics, l2p(callbacksRef), parse_err, pool, out_pool);

	if (!gu_ok(parse_err)) {
		if (gu_exn_caught(parse_err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else if (gu_exn_caught(parse_err, PgfParseError)) {
			GuString tok = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/ParseError", tok);
		}

		gu_pool_free(out_pool);
		return NULL;
	}

	jfieldID refId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, jconcr), "gr", "Lorg/grammaticalframework/pgf/PGF;");
	jobject jpgf = (*env)->GetObjectField(env, jconcr, refId);

	jclass expiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprIterator");
	jmethodID constrId = (*env)->GetMethodID(env, expiter_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;Lorg/grammaticalframework/pgf/Pool;JJ)V");
	jobject jexpiter = (*env)->NewObject(env, expiter_class, constrId, jpgf, jpool, p2l(out_pool), p2l(res));

	return jexpiter;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Completer_complete(JNIEnv* env, jclass clazz, jobject jconcr, jstring jstartCat, jstring js, jstring jprefix)
{
	GuPool* pool = gu_new_pool();

    GuString startCat = j2gu_string(env, jstartCat, pool);
    GuString s = j2gu_string(env, js, pool);
    GuString prefix = j2gu_string(env, jprefix, pool);
    GuExn* parse_err = gu_new_exn(pool);

	PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
	type->hypos   = gu_empty_seq();
	type->cid     = startCat;
	type->n_exprs = 0;

	GuEnum* res =
		pgf_complete(get_ref(env, jconcr), type, s, prefix, parse_err, pool);

	if (!gu_ok(parse_err)) {
		if (gu_exn_caught(parse_err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else if (gu_exn_caught(parse_err, PgfParseError)) {
			GuString tok = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/ParseError", tok);
		}

		gu_pool_free(pool);
		return NULL;
	}

	jclass tokiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/TokenIterator");
	jmethodID constrId = (*env)->GetMethodID(env, tokiter_class, "<init>", "(JJ)V");
	jobject jtokiter = (*env)->NewObject(env, tokiter_class, constrId, p2l(pool), p2l(res));

	return jtokiter;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_SentenceExtractor_lookupSentence
  (JNIEnv* env, jclass clazz, jobject jconcr, jstring jstartCat, jstring js, jobject jpool)
{
	GuPool* pool = get_ref(env, jpool);
	GuPool* out_pool = gu_new_pool();

    GuString startCat = j2gu_string(env, jstartCat, pool);
    GuString s = j2gu_string(env, js, pool);

	PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
	type->hypos   = gu_empty_seq();
	type->cid     = startCat;
	type->n_exprs = 0;

	GuEnum* res =
		pgf_lookup_sentence(get_ref(env, jconcr), type, s, pool, out_pool);

	jfieldID refId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, jconcr), "gr", "Lorg/grammaticalframework/pgf/PGF;");
	jobject jpgf = (*env)->GetObjectField(env, jconcr, refId);

	jclass expiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprIterator");
	jmethodID constrId = (*env)->GetMethodID(env, expiter_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;Lorg/grammaticalframework/pgf/Pool;JJ)V");
	jobject jexpiter = (*env)->NewObject(env, expiter_class, constrId, jpgf, jpool, p2l(out_pool), p2l(res));

	return jexpiter;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_TokenIterator_fetchTokenProb(JNIEnv* env, jclass clazz, jlong enumRef, jobject jpool)
{
	GuEnum* res = (GuEnum*) l2p(enumRef);

	PgfTokenProb* tp = gu_next(res, PgfTokenProb*, get_ref(env, jpool));
	if (tp == NULL)
		return NULL;

	jclass tp_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/TokenProb");
	jmethodID tp_constrId = (*env)->GetMethodID(env, tp_class, "<init>", "(DLjava/lang/String;Ljava/lang/String;)V");
	jobject jtp = (*env)->NewObject(env, tp_class, tp_constrId, tp->prob, gu2j_string(env,tp->tok), gu2j_string(env,tp->cat));

	return jtp;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_ExprIterator_fetchExprProb
  (JNIEnv* env, jclass clazz, jlong enumRef, jobject jpool, jobject gr)
{
	GuEnum* res = (GuEnum*) l2p(enumRef);
	GuPool* pool = get_ref(env, jpool);

	PgfExprProb* ep = gu_next(res, PgfExprProb*, pool);
	if (ep == NULL)
		return NULL;

	jclass expprob_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprProb");
	jmethodID methodId = (*env)->GetStaticMethodID(env, expprob_class, "mkExprProb", 
	           "(Lorg/grammaticalframework/pgf/Pool;Lorg/grammaticalframework/pgf/PGF;JD)Lorg/grammaticalframework/pgf/ExprProb;");
	jobject jexpprob = (*env)->CallStaticObjectMethod(env, expprob_class, methodId, 
	           jpool, gr, p2l(gu_variant_to_ptr(ep->expr)), (double) ep->prob);

	return jexpprob;
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Concr_linearize(JNIEnv* env, jobject self, jobject jexpr)
{
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	
	pgf_linearize(get_ref(env, self), gu_variant_from_ptr((void*) get_ref(env, jexpr)), out, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfLinNonExist)) {
			gu_pool_free(tmp_pool);
			return NULL;
		} else if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be linearized");
		}
		gu_pool_free(tmp_pool);
		return NULL;
	}

	jstring jstr = gu2j_string_buf(env, sbuf);

	gu_pool_free(tmp_pool);
	
	return jstr;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Concr_linearizeAll(JNIEnv* env, jobject self, jobject jexpr)
{
	PgfConcr* concr = get_ref(env, self);
	
	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	jmethodID list_constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	jobject strings = (*env)->NewObject(env, list_class, list_constrId);
	
	jmethodID addId = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	
	GuEnum* cts =
		pgf_lzr_concretize(concr,
		                   gu_variant_from_ptr((void*) get_ref(env, jexpr)),
		                   err, tmp_pool);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	for (;;) {
		PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
		if (gu_variant_is_null(ctree))
			break;

		GuPool* step_pool = gu_local_pool();
		GuStringBuf* sbuf = gu_new_string_buf(step_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		ctree = pgf_lzr_wrap_linref(ctree, step_pool);
		pgf_lzr_linearize_simple(concr, ctree, 0, out, err, step_pool);
		if (!gu_ok(err)) {
			gu_pool_free(step_pool);

			if (gu_exn_caught(err, PgfLinNonExist)) {				
				continue;
			} else if (gu_exn_caught(err, PgfExn)) {
				GuString msg = (GuString) gu_exn_caught_data(err);
				throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
			} else {
				throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be linearized");
			}
			gu_pool_free(tmp_pool);
			return NULL;
		}

		jstring jstr = gu2j_string_buf(env, sbuf);

		(*env)->CallBooleanMethod(env, strings, addId, jstr);
		
		gu_pool_free(step_pool);
	}

	gu_pool_free(tmp_pool);

	return strings;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_Concr_tabularLinearize(JNIEnv* env, jobject self, jobject jexpr)
{
	jclass map_class = (*env)->FindClass(env, "java/util/HashMap");
	if (!map_class)
		return NULL;
	jmethodID constrId = (*env)->GetMethodID(env, map_class, "<init>", "()V");
	if (!constrId)
		return NULL;
	jobject table = (*env)->NewObject(env, map_class, constrId);
	if (!table)
		return NULL;

	jmethodID put_method = (*env)->GetMethodID(env, map_class, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");
	if (!put_method)
		return NULL;
		
	PgfConcr* concr = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	GuEnum* cts = 
		pgf_lzr_concretize(concr,
		                   gu_variant_from_ptr((void*) get_ref(env, jexpr)),
		                   err,
		                   tmp_pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be concretized");
		}
		gu_pool_free(tmp_pool);
		return NULL;
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	size_t n_lins;
	GuString* labels;
	pgf_lzr_get_table(concr, ctree, &n_lins, &labels);

	for (size_t lin_idx = 0; lin_idx < n_lins; lin_idx++) {
		GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		pgf_lzr_linearize_simple(concr, ctree, lin_idx, out, err, tmp_pool);

		jstring jstr = NULL;
		if (gu_ok(err)) {
			jstr = gu2j_string_buf(env, sbuf);
		} else {
			gu_exn_clear(err);
		}

		jstring jname = gu2j_string(env, labels[lin_idx]);

		(*env)->CallObjectMethod(env, table, put_method, jname, jstr);

		(*env)->DeleteLocalRef(env, jname);
		
		if (jstr != NULL)
			(*env)->DeleteLocalRef(env, jstr);
	}
	
	gu_pool_free(tmp_pool);

	return table;
}

typedef struct {
	PgfLinFuncs* funcs;
	JNIEnv* env;
	GuPool* tmp_pool;
	GuBuf* stack;
	GuBuf* list;
	jclass object_class;
	jclass bracket_class;
	jmethodID bracket_constrId;
} PgfBracketLznState;

static void
pgf_bracket_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);
	JNIEnv* env = state->env;

	jstring jname = gu2j_string(env, tok);
	gu_buf_push(state->list, jobject, jname);
}

static void
pgf_bracket_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);
	
	gu_buf_push(state->stack, GuBuf*, state->list);
	state->list = gu_new_buf(jobject, state->tmp_pool);
}

static void
pgf_bracket_lzn_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);
	JNIEnv* env = state->env;

	GuBuf* parent = gu_buf_pop(state->stack, GuBuf*);

	if (gu_buf_length(state->list) > 0) {
		jstring jcat = gu2j_string(env, cat);
		jstring jfun = gu2j_string(env, fun);

		size_t len = gu_buf_length(state->list);
		jobjectArray jchildren = (*env)->NewObjectArray(env, len, state->object_class, NULL);
		for (int i = 0; i < len; i++) {
			jobject obj = gu_buf_get(state->list, jobject, i);
			(*env)->SetObjectArrayElement(env, jchildren, i, obj);
			(*env)->DeleteLocalRef(env, obj);
		}

		jobject jbracket = (*env)->NewObject(env, 
		                                     state->bracket_class,
		                                     state->bracket_constrId, 
		                                     jcat,
		                                     jfun,
		                                     fid,
		                                     lindex,
		                                     jchildren);

		(*env)->DeleteLocalRef(env, jchildren);
		(*env)->DeleteLocalRef(env, jfun);
		(*env)->DeleteLocalRef(env, jcat);

		gu_buf_push(parent, jobject, jbracket);
	}

	state->list = parent;
}

static void
pgf_bracket_lzn_symbol_meta(PgfLinFuncs** funcs, PgfMetaId id)
{
	pgf_bracket_lzn_symbol_token(funcs, "?");
}

static PgfLinFuncs pgf_bracket_lin_funcs = {
	.symbol_token  = pgf_bracket_lzn_symbol_token,
	.begin_phrase  = pgf_bracket_lzn_begin_phrase,
	.end_phrase    = pgf_bracket_lzn_end_phrase,
	.symbol_ne     = NULL,
	.symbol_bind   = NULL,
	.symbol_capit  = NULL,
	.symbol_meta   = pgf_bracket_lzn_symbol_meta
};

JNIEXPORT jobjectArray JNICALL 
Java_org_grammaticalframework_pgf_Concr_bracketedLinearize(JNIEnv* env, jobject self, jobject jexpr)
{
	jclass object_class = (*env)->FindClass(env, "java/lang/Object");
	if (!object_class)
		return NULL;

	jclass bracket_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Bracket");
	if (!bracket_class)
		return NULL;
	jmethodID bracket_constrId = (*env)->GetMethodID(env, bracket_class, "<init>", "(Ljava/lang/String;Ljava/lang/String;II[Ljava/lang/Object;)V");
	if (!bracket_constrId)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	PgfConcr* concr = get_ref(env, self);

	GuEnum* cts = 
		pgf_lzr_concretize(concr, gu_variant_from_ptr((void*) get_ref(env, jexpr)), err, tmp_pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be concretized");
		}
		gu_pool_free(tmp_pool);
		return NULL;
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be concretized");
		gu_pool_free(tmp_pool);
		return NULL;
	}

	ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);

	PgfBracketLznState state;
	state.funcs = &pgf_bracket_lin_funcs;
	state.env   = env;
	state.tmp_pool = tmp_pool;
	state.stack = gu_new_buf(GuBuf*, tmp_pool);
	state.list  = gu_new_buf(jobject, tmp_pool);
	state.object_class = object_class;
	state.bracket_class = bracket_class;
	state.bracket_constrId = bracket_constrId;
	pgf_lzr_linearize(concr, ctree, 0, &state.funcs, tmp_pool);

	size_t len = gu_buf_length(state.list);
	jobjectArray array = (*env)->NewObjectArray(env, len, object_class, NULL);
	for (int i = 0; i < len; i++) {
		jobject obj = gu_buf_get(state.list, jobject, i);
		(*env)->SetObjectArrayElement(env, array, i, obj);
		(*env)->DeleteLocalRef(env, obj);
	}

	gu_pool_free(tmp_pool);

	return array;
}

typedef struct {
	PgfMorphoCallback fn;
	jobject analyses;
	prob_t prob;
	JNIEnv* env;
	jmethodID addId;
	jclass an_class;
	jmethodID an_constrId;
} JMorphoCallback;

static void
jpgf_collect_morpho(PgfMorphoCallback* self,
                    PgfCId lemma, GuString analysis, prob_t prob,
	                GuExn* err)
{
	JMorphoCallback* callback = (JMorphoCallback*) self;
	JNIEnv* env = callback->env;
	
	jstring jlemma = gu2j_string(env,lemma);
	jstring janalysis = gu2j_string(env,analysis);
	jobject jan = (*env)->NewObject(env, 
	                                callback->an_class,
	                                callback->an_constrId, 
	                                jlemma,
	                                janalysis,
	                                (double) prob);
	(*env)->CallBooleanMethod(env, callback->analyses, callback->addId, jan);
	(*env)->DeleteLocalRef(env, jan);
	(*env)->DeleteLocalRef(env, janalysis);
	(*env)->DeleteLocalRef(env, jlemma);
	
	callback->prob += exp(-prob);
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Concr_lookupMorpho(JNIEnv* env, jobject self, jstring sentence)
{
	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	jmethodID list_constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	jobject analyses = (*env)->NewObject(env, list_class, list_constrId);
	
	jmethodID addId = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");

	jclass an_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/MorphoAnalysis");
	jmethodID an_constrId = (*env)->GetMethodID(env, an_class, "<init>", "(Ljava/lang/String;Ljava/lang/String;D)V");

	GuPool* tmp_pool = gu_new_pool();
	
	GuExn* err = gu_exn(tmp_pool);

	JMorphoCallback callback = { { jpgf_collect_morpho }, analyses, 0, env, addId, an_class, an_constrId };
	pgf_lookup_morpho(get_ref(env, self), j2gu_string(env, sentence, tmp_pool),
	                  &callback.fn, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The lookup failed");
		}
		analyses = NULL;
	}

	gu_pool_free(tmp_pool);

	return analyses;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Lexicon_lookupWordPrefix
   (JNIEnv* env, jclass clazz, jobject jconcr, jstring prefix)
{
	GuPool* pool = gu_new_pool();	
	GuExn* err = gu_new_exn(pool);

	GuEnum* en = 
		(prefix == NULL) ? pgf_fullform_lexicon(get_ref(env, jconcr), 
	                                            pool)
	                     : pgf_lookup_word_prefix(get_ref(env, jconcr), j2gu_string(env, prefix, pool),
	                                              pool, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The lookup failed");
		}
		return NULL;
	}

	jclass iter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/FullFormIterator");
	jmethodID iter_constrId = (*env)->GetMethodID(env, iter_class, "<init>", "(Lorg/grammaticalframework/pgf/Concr;JJ)V");
	jobject iter = (*env)->NewObject(env, iter_class, iter_constrId, jconcr, p2l(pool), p2l(en));

	return iter;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_FullFormIterator_fetchFullFormEntry
  (JNIEnv* env, jobject clazz, jlong enumRef, jobject jpool, jobject jconcr)
{
	GuEnum* res = (GuEnum*) l2p(enumRef);

	PgfFullFormEntry* entry = gu_next(res, PgfFullFormEntry*, get_ref(env, jpool));
	if (entry == NULL)
		return NULL;

	GuString form = pgf_fullform_get_string(entry);

	jclass list_class = (*env)->FindClass(env, "java/util/ArrayList");
	jmethodID list_constrId = (*env)->GetMethodID(env, list_class, "<init>", "()V");
	jobject analyses = (*env)->NewObject(env, list_class, list_constrId);

	jmethodID addId = (*env)->GetMethodID(env, list_class, "add", "(Ljava/lang/Object;)Z");

	jclass an_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/MorphoAnalysis");
	jmethodID an_constrId = (*env)->GetMethodID(env, an_class, "<init>", "(Ljava/lang/String;Ljava/lang/String;D)V");

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	JMorphoCallback callback = { { jpgf_collect_morpho }, analyses, 0, env, addId, an_class, an_constrId };
	pgf_fullform_get_analyses(entry, &callback.fn, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The lookup failed");
		}
		analyses = NULL;
	}

	gu_pool_free(tmp_pool);

	jclass entry_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/FullFormEntry");
	jmethodID entry_constrId = (*env)->GetMethodID(env, entry_class, "<init>", "(Ljava/lang/String;DLjava/util/List;)V");
	jobject jentry = (*env)->NewObject(env, entry_class, entry_constrId, gu2j_string(env,form), - log(callback.prob), analyses);

	return jentry;
}

JNIEXPORT jboolean JNICALL
Java_org_grammaticalframework_pgf_Concr_hasLinearization(JNIEnv* env, jobject self, jstring jid)
{
	PgfConcr* concr = get_ref(env, self);
	GuPool* tmp_pool = gu_local_pool();
	PgfCId id = j2gu_string(env, jid, tmp_pool);
	bool res = pgf_has_linearization(concr, id);
	gu_pool_free(tmp_pool);
	return res;
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Concr_getPrintName(JNIEnv* env, jobject self, jstring jid)
{
	PgfConcr* concr = get_ref(env, self);
	GuPool* tmp_pool = gu_local_pool();
	PgfCId id = j2gu_string(env, jid, tmp_pool);
	GuString name = pgf_print_name(concr, id);
	jstring jname = (name == NULL) ? NULL : gu2j_string(env, name);
	gu_pool_free(tmp_pool);

	return jname;
}

JNIEXPORT jlong JNICALL
Java_org_grammaticalframework_pgf_Pool_alloc(JNIEnv* env, jclass clazz)
{
	return p2l(gu_new_pool());
}

JNIEXPORT void JNICALL 
Java_org_grammaticalframework_pgf_Pool_free(JNIEnv* env, jclass clazz, jlong ref)
{
	gu_pool_free((GuPool*) l2p(ref));
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Expr_showExpr(JNIEnv* env, jclass clazz, jlong ref)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	pgf_print_expr(gu_variant_from_ptr(l2p(ref)), NULL, 0, out, err);

	jstring jstr = gu2j_string_buf(env, sbuf);

	gu_pool_free(tmp_pool);
	return jstr;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_Expr_readExpr(JNIEnv* env, jclass clazz, jstring s)
{
	GuPool* pool = gu_new_pool();
	
	GuPool* tmp_pool = gu_local_pool();
	GuString buf = j2gu_string(env, s, tmp_pool);
	GuIn* in = gu_data_in((uint8_t*) buf, strlen(buf), tmp_pool);
	GuExn* err = gu_exn(tmp_pool);

	PgfExpr e = pgf_read_expr(in, pool, err);
	if (!gu_ok(err) || gu_variant_is_null(e)) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be parsed");
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jmethodID constrId = (*env)->GetMethodID(env, clazz, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");
	return (*env)->NewObject(env, clazz, constrId, jpool, NULL, p2l(gu_variant_to_ptr(e)));
}

JNIEXPORT jlong JNICALL 
Java_org_grammaticalframework_pgf_Expr_initStringLit(JNIEnv* env, jclass clazz, jstring jstr, jlong jpool)
{
	GuPool* pool = l2p(jpool);
	PgfExpr expr;

	PgfExprLit* e =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &expr, pool);

	GuString str = (*env)->GetStringUTFChars(env, jstr, 0);
	PgfLiteralStr* slit =
		gu_new_flex_variant(PGF_LITERAL_STR,
		                    PgfLiteralStr,
		                    val, strlen(str)+1,
		                    &e->lit, pool);
	strcpy(slit->val, str);
	(*env)->ReleaseStringUTFChars(env, jstr, str);

	return expr;
}

JNIEXPORT jlong JNICALL 
Java_org_grammaticalframework_pgf_Expr_initIntLit(JNIEnv* env, jclass clazz, jint jd, jlong jpool)
{
	GuPool* pool = l2p(jpool);
	PgfExpr expr;

	PgfExprLit* e =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &expr, pool);

	PgfLiteralInt* nlit =
		gu_new_variant(PGF_LITERAL_INT,
					   PgfLiteralInt,
					   &e->lit, pool);
	nlit->val = jd;

	return expr;
}

JNIEXPORT jlong JNICALL 
Java_org_grammaticalframework_pgf_Expr_initFloatLit(JNIEnv* env, jclass clazz, jdouble jf, jlong jpool)
{
	GuPool* pool = l2p(jpool);
	PgfExpr expr;

	PgfExprLit* e =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &expr, pool);

	PgfLiteralFlt* flit =
		gu_new_variant(PGF_LITERAL_FLT,
					   PgfLiteralFlt,
					   &e->lit, pool);
	flit->val = jf;

	return expr;
}

JNIEXPORT jlong JNICALL
Java_org_grammaticalframework_pgf_Expr_initApp__Lorg_grammaticalframework_pgf_Expr_2_3Lorg_grammaticalframework_pgf_Expr_2J
(JNIEnv* env, jclass clazz, jobject jfun, jobjectArray args, jlong jpool)
{
	GuPool* pool = l2p(jpool);
	PgfExpr expr = gu_variant_from_ptr(get_ref(env, jfun));

	size_t n_args = (*env)->GetArrayLength(env, args);
	for (size_t i = 0; i < n_args; i++) {
		PgfExpr fun = expr;
		PgfExpr arg = gu_variant_from_ptr(get_ref(env, (*env)->GetObjectArrayElement(env, args, i)));

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &expr, pool);
		e->fun = fun;
		e->arg = arg;
	}

	return expr;
}

JNIEXPORT jlong JNICALL 
Java_org_grammaticalframework_pgf_Expr_initApp__Ljava_lang_String_2_3Lorg_grammaticalframework_pgf_Expr_2J
(JNIEnv* env, jclass clazz, jstring jfun, jobjectArray args, jlong jpool)
{
	GuPool* pool = l2p(jpool);
	PgfExpr expr;

	GuString fun = (*env)->GetStringUTFChars(env, jfun, 0);
	PgfExprFun* e =
		gu_new_flex_variant(PGF_EXPR_FUN,
					        PgfExprFun,
					        fun, strlen(fun)+1,
					        &expr, pool);
	strcpy(e->fun, fun);
	(*env)->ReleaseStringUTFChars(env, jfun, fun);

	size_t n_args = (*env)->GetArrayLength(env, args);
	for (size_t i = 0; i < n_args; i++) {
		PgfExpr fun = expr;
		PgfExpr arg = gu_variant_from_ptr(get_ref(env, (*env)->GetObjectArrayElement(env, args, i)));

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &expr, pool);
		e->fun = fun;
		e->arg = arg;
	}

	return expr;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Expr_unApp(JNIEnv* env, jobject self)
{
	jclass expr_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Expr");
	if (!expr_class)
		return NULL;
	jmethodID expr_constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");
	jclass app_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprApplication");
	if (!app_class)
		return NULL;
	jmethodID app_constrId = (*env)->GetMethodID(env, app_class, "<init>", "(Ljava/lang/String;[Lorg/grammaticalframework/pgf/Expr;)V");
	if (!app_constrId)
		return NULL;

	PgfExpr expr = gu_variant_from_ptr(get_ref(env, self));
	
	GuPool* tmp_pool = gu_local_pool();
	PgfApplication* app = pgf_expr_unapply(expr, tmp_pool);
	
	jobject japp = NULL;
	if (app != NULL) {
		jstring jfun = gu2j_string(env, app->fun);
		jobject jargs = (*env)->NewObjectArray(env, app->n_args, expr_class, NULL);
		for (size_t i = 0; i < app->n_args; i++) {
			jobject jarg = (*env)->NewObject(env, expr_class, expr_constrId, NULL, self, p2l(app->args[i]));
			(*env)->SetObjectArrayElement(env, jargs, i, jarg);
			(*env)->DeleteLocalRef(env, jarg);
		}
		japp = (*env)->NewObject(env, app_class, app_constrId, jfun, jargs);
	}

	gu_pool_free(tmp_pool);

	return japp;
}

JNIEXPORT jint JNICALL
Java_org_grammaticalframework_pgf_Expr_unMeta(JNIEnv* env, jobject self)
{
	PgfExpr expr = gu_variant_from_ptr(get_ref(env, self));

	PgfExprMeta* pmeta = pgf_expr_unmeta(expr);
	if (pmeta != NULL) {
		return pmeta->id;
	}

	return -1;
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Expr_unStr(JNIEnv* env, jobject self)
{
	PgfExpr expr = gu_variant_from_ptr(get_ref(env, self));

	PgfLiteralStr* pstr = pgf_expr_unlit(expr, PGF_LITERAL_STR);
	if (pstr != NULL) {
		return gu2j_string(env, pstr->val);
	}

	return NULL;
}

JNIEXPORT void JNICALL
Java_org_grammaticalframework_pgf_Expr_visit(JNIEnv* env, jobject self, jobject visitor)
{
	PgfExpr e = gu_variant_from_ptr(l2p(get_ref(env, self)));

	GuPool* tmp_pool = gu_local_pool();

	PgfApplication* app = pgf_expr_unapply(e, tmp_pool);
	if (app != NULL) {
		char* method_name = gu_malloc(tmp_pool, strlen(app->fun)+4);
		strcpy(method_name, "on_");
		strcat(method_name, app->fun);
		
		GuExn* err = gu_exn(tmp_pool);
		GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		gu_putc('(', out, err);
		for (size_t i = 0; i < app->n_args; i++) {
			gu_puts("Lorg/grammaticalframework/pgf/Expr;", out, err);
		}
		gu_puts(")V", out, err);
		gu_putc('\0', out, err);

		char* sig = gu_string_buf_data(sbuf);

		jclass visitor_class = (*env)->GetObjectClass(env, visitor);
		jmethodID methodID = (*env)->GetMethodID(env, visitor_class, method_name, sig);
		
		if (methodID != NULL) {
			jclass expr_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Expr");
			jmethodID expr_constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");

			jvalue* args = gu_malloc(tmp_pool, sizeof(jvalue)*app->n_args);
			for (size_t i = 0; i < app->n_args; i++) {
				args[i].l = (*env)->NewObject(env, expr_class, expr_constrId, NULL, self, p2l(app->args[i]));
			}
			(*env)->CallVoidMethodA(env, visitor, methodID, args);
		} else {
			(*env)->ExceptionClear(env);

			methodID = (*env)->GetMethodID(env, visitor_class, "defaultCase", "(Lorg/grammaticalframework/pgf/Expr;)V");
			if (methodID != NULL) {
				(*env)->CallVoidMethod(env, visitor, methodID, self);
			} else {
				(*env)->ExceptionClear(env);
			}
		}
	}

	gu_pool_free(tmp_pool);
}

JNIEXPORT jboolean JNICALL
Java_org_grammaticalframework_pgf_Expr_equals(JNIEnv* env, jobject self, jobject other)
{
	jclass self_class  = (*env)->GetObjectClass(env, self);
	jclass other_class = (*env)->GetObjectClass(env, other);

	if (!(*env)->IsAssignableFrom(env, other_class, self_class))
		return JNI_FALSE;

	PgfExpr e_self  = gu_variant_from_ptr(l2p(get_ref(env, self)));
	PgfExpr e_other = gu_variant_from_ptr(l2p(get_ref(env, other)));
	
	if (pgf_expr_eq(e_self, e_other))
		return JNI_TRUE;
	else
		return JNI_FALSE;
}

JNIEXPORT jint JNICALL
Java_org_grammaticalframework_pgf_Expr_hashCode(JNIEnv* env, jobject self)
{
	PgfExpr e = gu_variant_from_ptr(l2p(get_ref(env, self)));
	return pgf_expr_hash(0, e);
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Type_getCategory(JNIEnv* env, jobject self)
{
	PgfType* tp = get_ref(env, self);
	return gu2j_string(env, tp->cid);
}

JNIEXPORT jobjectArray JNICALL
Java_org_grammaticalframework_pgf_Type_getHypos(JNIEnv* env, jobject self)
{
	PgfType* tp = get_ref(env, self);

	jclass hypo_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Hypo");
	jmethodID constrId = (*env)->GetMethodID(env, hypo_class, "<init>", "(Ljava/lang/Object;J)V");

	size_t n_hypos = gu_seq_length(tp->hypos);
	jobjectArray jhypos = (*env)->NewObjectArray(env, n_hypos, hypo_class, NULL);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo *hypo = gu_seq_index(tp->hypos, PgfHypo, i);
		jobject jhypo = (*env)->NewObject(env, hypo_class, constrId, self, p2l(hypo));
		(*env)->SetObjectArrayElement(env, jhypos, i, jhypo);
		(*env)->DeleteLocalRef(env, jhypo);
	}
	return jhypos;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_Type_readType(JNIEnv* env, jclass clazz, jstring s)
{
	GuPool* pool = gu_new_pool();

	GuPool* tmp_pool = gu_local_pool();
	GuString buf = j2gu_string(env, s, tmp_pool);
	GuIn* in = gu_data_in((uint8_t*) buf, strlen(buf), tmp_pool);
	GuExn* err = gu_exn(tmp_pool);

	PgfType* ty = pgf_read_type(in, pool, err);
	if (!gu_ok(err)) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The type cannot be parsed");
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jmethodID constrId = (*env)->GetMethodID(env, clazz, "<init>", "(Ljava/lang/Object;J)V");
	return (*env)->NewObject(env, clazz, constrId, jpool, p2l(ty));
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Type_toString(JNIEnv* env, jobject self)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	pgf_print_type(get_ref(env, self), NULL, 0, out, err);

	jstring jstr = gu2j_string_buf(env, sbuf);

	gu_pool_free(tmp_pool);
	return jstr;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Hypo_getType(JNIEnv* env, jobject self)
{
	PgfHypo* hypo = get_ref(env, self);

	jclass type_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Type");
	jmethodID constrId = (*env)->GetMethodID(env, type_class, "<init>", "(Ljava/lang/Object;J)V");
	jobject jtype = (*env)->NewObject(env, type_class, constrId, self, p2l(hypo->type));

	return jtype;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Generator_generateAll(JNIEnv* env, jclass clazz, jobject jpgf, jstring jstartCat)
{
	GuPool* pool = gu_new_pool();
	GuPool* out_pool = gu_new_pool();
    GuString startCat = j2gu_string(env, jstartCat, pool);
    GuExn* err = gu_exn(pool);

	PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
	type->hypos   = gu_empty_seq();
	type->cid     = startCat;
	type->n_exprs = 0;

	GuEnum* res =
		pgf_generate_all(get_ref(env, jpgf), type, err, pool, out_pool);
	if (res == NULL) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The generation failed");
		gu_pool_free(pool);
		return NULL;
	}

	jclass expiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprIterator");
	jmethodID constrId = (*env)->GetMethodID(env, expiter_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;JJJ)V");
	jobject jexpiter = (*env)->NewObject(env, expiter_class, constrId, jpgf, p2l(pool), p2l(out_pool), p2l(res));

	return jexpiter;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_compute(JNIEnv* env, jobject self, jobject jexpr)
{
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	PgfExpr res =
		pgf_compute(get_ref(env, self), gu_variant_from_ptr((void*) get_ref(env, jexpr)), err, tmp_pool, pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be computed");
		}
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jclass expr_class  = (*env)->GetObjectClass(env, jexpr);
	jmethodID constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");
	jexpr = (*env)->NewObject(env, expr_class, constrId, jpool, NULL, p2l(gu_variant_to_ptr(res)));

	return jexpr;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_inferExpr(JNIEnv* env, jobject self, jobject jexpr)
{
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	PgfExpr expr =
		gu_variant_from_ptr((void*) get_ref(env, jexpr));
	PgfType* tp  =
		pgf_infer_expr(get_ref(env, self), &expr, err, pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else if (gu_exn_caught(err, PgfTypeError)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/TypeError", msg);
 		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The type cannot be inferred");
		}
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jclass expr_class  = (*env)->GetObjectClass(env, jexpr);
	jmethodID expr_constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");
	jexpr = (*env)->NewObject(env, expr_class, expr_constrId, jpool, NULL, p2l(gu_variant_to_ptr(expr)));

	jclass type_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Type");
	jmethodID type_constrId = (*env)->GetMethodID(env, type_class, "<init>", "(Ljava/lang/Object;J)V");
	jobject jtype = (*env)->NewObject(env, type_class, type_constrId, jpool, p2l(tp));
	
	jclass typed_expr_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/TypedExpr");
	jmethodID typed_expr_constrId = (*env)->GetMethodID(env, typed_expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Expr;Lorg/grammaticalframework/pgf/Type;)V");
	jobject jtyped_expr = (*env)->NewObject(env, typed_expr_class, typed_expr_constrId, jexpr, jtype);

	return jtyped_expr;
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_checkExpr(JNIEnv* env, jobject self, jobject jexpr, jobject jtp)
{
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	PgfExpr expr =
		gu_variant_from_ptr((void*) get_ref(env, jexpr));
	PgfType* tp  =
		get_ref(env, jtp);
	pgf_check_expr(get_ref(env, self), &expr, tp, err, pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else if (gu_exn_caught(err, PgfTypeError)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/TypeError", msg);
 		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The type cannot be inferred");
		}
		gu_pool_free(tmp_pool);
		gu_pool_free(pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jclass pool_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/Pool");
	jmethodID pool_constrId = (*env)->GetMethodID(env, pool_class, "<init>", "(J)V");
	jobject jpool = (*env)->NewObject(env, pool_class, pool_constrId, p2l(pool));

	jclass expr_class  = (*env)->GetObjectClass(env, jexpr);
	jmethodID expr_constrId = (*env)->GetMethodID(env, expr_class, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Ljava/lang/Object;J)V");
	jexpr = (*env)->NewObject(env, expr_class, expr_constrId, jpool, NULL, p2l(gu_variant_to_ptr(expr)));

	return jexpr;
}
