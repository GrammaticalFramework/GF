#include <pgf/pgf.h>
#include <pgf/reader.h>
#include <pgf/linearizer.h>
#include <gu/mem.h>
#include <gu/exn.h>
#include <gu/utf8.h>
#include <jni.h>
#ifndef __MINGW32__
#include <alloca.h>
#else
#include <malloc.h>
#endif

#define l2p(x) ((void*) (intptr_t) (x))
#define p2l(x) ((jlong) (intptr_t) (x))

static jstring
gu2j_string(JNIEnv *env, GuString s) {
	const char* utf8 = s;
	size_t len = strlen(s);

	jchar* utf16 = alloca(len*sizeof(jchar));
	jchar* dst   = utf16;
	while (s-utf8 < len) {
		GuUCS ucs = gu_utf8_decode((const uint8_t**) &s);

		if (ucs <= 0xFFFF) {
			*dst++ = ucs;
		} else {
			ucs -= 0x10000;
			*dst++ = 0xD800+((ucs >> 10) & 0x3FF);
			*dst++ = 0xDC00+(ucs & 0x3FF);
		}
	}

	return (*env)->NewString(env, utf16, dst-utf16);
}

static GuString
j2gu_string(JNIEnv *env, jstring s, GuPool* pool) {
	GuString str = (*env)->GetStringUTFChars(env, s, 0);
	GuString copy = gu_string_copy(str, pool);
	(*env)->ReleaseStringUTFChars(env, s, str);
	return copy;
}

static void*
get_ref(JNIEnv *env, jobject self) {
	jfieldID refId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, self), "ref", "J");
	return l2p((*env)->GetLongField(env, self, refId));
}

static void
throw_jstring_exception(JNIEnv *env, const char* class_name, jstring msg)
{
	jclass exception_class = (*env)->FindClass(env, class_name);
	if (!exception_class)
		return;
	jmethodID constrId = (*env)->GetMethodID(env, exception_class, "<init>", "(Ljava/lang/String;)V");
	if (!constrId)
		return;
	jobject exception = (*env)->NewObject(env, exception_class, constrId, msg);
	if (!exception)
		return;
	(*env)->Throw(env, exception);
}

static void
throw_string_exception(JNIEnv *env, const char* class_name, const char* msg)
{
	jstring jmsg = (*env)->NewStringUTF(env, msg);
	if (!jmsg)
		return;
	throw_jstring_exception(env, class_name, jmsg);
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_PGF_readPGF__Ljava_lang_String_2(JNIEnv *env, jclass cls, jstring s)
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
		if (gu_exn_caught(err) == gu_type(GuErrno)) {
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
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	// Read the PGF grammar.
	PgfReader* rdr = pgf_new_reader(in, pool, tmp_pool, err);
	PgfPGF* pgf = pgf_read_pgf(rdr);
	pgf_reader_done(rdr, pgf);

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
	return gu2j_string(env, pgf_start_cat(get_ref(env, self)));
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
	jmethodID constrId = (*env)->GetMethodID(env, type_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;J)V");
	jobject jtype = (*env)->NewObject(env, type_class, constrId, self, p2l(tp));

	return jtype;
}

typedef struct {
	GuMapItor fn;
	JNIEnv *env;
	jobject grammar;
	jobject object;
} JPGFClosure;

static void
pgf_collect_langs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    PgfConcr* concr = *((PgfConcr**) value);
    JPGFClosure* clo = (JPGFClosure*) fn;

	jstring jname = gu2j_string(clo->env, name);
	
	jclass map_class = (*clo->env)->GetObjectClass(clo->env, clo->object);
	jmethodID put_method = (*clo->env)->GetMethodID(clo->env, map_class, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");

	jclass concr_class = (*clo->env)->FindClass(clo->env, "org/grammaticalframework/pgf/Concr");
	jmethodID constrId = (*clo->env)->GetMethodID(clo->env, concr_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;J)V");
	jobject jconcr = (*clo->env)->NewObject(clo->env, concr_class, constrId, clo->grammar, p2l(concr));

	(*clo->env)->CallObjectMethod(clo->env, clo->object, put_method, jname, jconcr);
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

	PgfPGF* pgf = get_ref(env, self);

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	JPGFClosure clo = { { pgf_collect_langs }, env, self, languages };
	pgf_iter_languages(pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}
	
	gu_pool_free(tmp_pool);

	return languages;
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
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	pgf_concrete_load(get_ref(env, self), in, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err) == gu_type(PgfExn)) {
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

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_Parser_parse
  (JNIEnv* env, jclass clazz, jobject concr, jstring jstartCat, jstring js)
{
	GuPool* pool = gu_new_pool();
	GuPool* out_pool = gu_new_pool();

    GuString startCat = j2gu_string(env, jstartCat, pool);
    GuString s = j2gu_string(env, js, pool);
    GuExn* parse_err = gu_new_exn(NULL, gu_kind(type), pool);

	GuEnum* res =
		pgf_parse(get_ref(env, concr), startCat, s, parse_err, pool, out_pool);

	if (!gu_ok(parse_err)) {
		if (gu_exn_caught(parse_err) == gu_type(PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else if (gu_exn_caught(parse_err) == gu_type(PgfParseError)) {
			GuString tok = (GuString) gu_exn_caught_data(parse_err);
			throw_string_exception(env, "org/grammaticalframework/pgf/ParseError", tok);
		}

		gu_pool_free(pool);
		gu_pool_free(out_pool);
		return NULL;
	}

	jfieldID refId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, concr), "gr", "Lorg/grammaticalframework/pgf/PGF;");
	jobject jpgf = (*env)->GetObjectField(env, concr, refId);

	jclass expiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprIterator");
	jmethodID constrId = (*env)->GetMethodID(env, expiter_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;JJJ)V");
	jobject jexpiter = (*env)->NewObject(env, expiter_class, constrId, jpgf, p2l(pool), p2l(out_pool), p2l(res));

	return jexpiter;
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_ExprIterator_fetchExprProb
  (JNIEnv* env, jobject self, jlong enumRef, jobject pool, jobject gr)
{
	GuEnum* res = (GuEnum*) l2p(enumRef);

	PgfExprProb* ep = gu_next(res, PgfExprProb*, NULL);
	if (ep == NULL)
		return NULL;

	jclass expprob_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprProb");
	jmethodID methodId = (*env)->GetStaticMethodID(env, expprob_class, "mkExprProb", 
	           "(Lorg/grammaticalframework/pgf/Pool;Lorg/grammaticalframework/pgf/PGF;JD)Lorg/grammaticalframework/pgf/ExprProb;");
	jobject jexpprob = (*env)->CallStaticObjectMethod(env, expprob_class, methodId, 
	           pool, gr, p2l(gu_variant_to_ptr(ep->expr)), (double) ep->prob);

	return jexpprob;
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Concr_linearize(JNIEnv* env, jobject self, jobject jexpr)
{
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	
	pgf_linearize(get_ref(env, self), gu_variant_from_ptr((void*) get_ref(env, jexpr)), out, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err) == gu_type(PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be linearized");
		}
		return NULL;
	}

	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	jstring jstr = gu2j_string(env, str);

	gu_pool_free(tmp_pool);
	
	return jstr;
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
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	GuEnum* cts = 
		pgf_lzr_concretize(concr,
		                   gu_variant_from_ptr((void*) get_ref(env, jexpr)),
		                   err,
		                   tmp_pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err) == gu_type(PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", msg);
		} else {
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The expression cannot be concretized");
		}
		return NULL;
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	size_t n_lins;
	GuString* labels;
	pgf_lzr_linearize_table(concr, ctree, &n_lins, &labels);

	for (size_t lin_idx = 0; lin_idx < n_lins; lin_idx++) {
		GuStringBuf* sbuf = gu_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		pgf_lzr_linearize_simple(concr, ctree, lin_idx, out, err);

		jstring jstr = NULL;
		if (gu_ok(err)) {
			GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
			jstr = gu2j_string(env, str);
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
	PgfMorphoCallback fn;
	jobject analyses;
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
	
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	JMorphoCallback callback = { { jpgf_collect_morpho }, analyses, env, addId, an_class, an_constrId };
	pgf_lookup_morpho(get_ref(env, self), j2gu_string(env, sentence, tmp_pool),
	                  &callback.fn, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err) == gu_type(PgfExn)) {
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

JNIEXPORT jboolean JNICALL
Java_org_grammaticalframework_pgf_Concr_hasLinearization(JNIEnv* env, jobject self, jstring jid)
{
	PgfConcr* concr = get_ref(env, self);
	GuPool* tmp_pool = gu_new_pool();
	PgfCId id = j2gu_string(env, jid, tmp_pool);
	bool res = pgf_has_linearization(concr, id);
	gu_pool_free(tmp_pool);
	return res;
}

JNIEXPORT void JNICALL 
Java_org_grammaticalframework_pgf_Pool_free(JNIEnv* env, jobject self, jlong ref)
{
	gu_pool_free((GuPool*) l2p(ref));
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Expr_showExpr(JNIEnv* env, jclass clazz, jlong ref)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	pgf_print_expr(gu_variant_from_ptr(l2p(ref)), NULL, 0, out, err);

	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	jstring jstr = gu2j_string(env, str);

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
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

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

	jmethodID constrId = (*env)->GetMethodID(env, clazz, "<init>", "(Lorg/grammaticalframework/pgf/Pool;Lorg/grammaticalframework/pgf/PGF;J)V");
	return (*env)->NewObject(env, clazz, constrId, jpool, NULL, p2l(gu_variant_to_ptr(e)));
}

JNIEXPORT jstring JNICALL
Java_org_grammaticalframework_pgf_Type_getCategory(JNIEnv* env, jobject self)
{
	PgfType* tp = get_ref(env, self);
	return gu2j_string(env, tp->cid);
}

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_Generator_generateAll(JNIEnv* env, jclass clazz, jobject jpgf, jstring jstartCat)
{
	GuPool* pool = gu_new_pool();

    GuString startCat = j2gu_string(env, jstartCat, pool);

	GuEnum* res =
		pgf_generate_all(get_ref(env, jpgf), startCat, pool);
	if (res == NULL) {
		throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", "The generation failed");
		gu_pool_free(pool);
		return NULL;
	}

	jclass expiter_class = (*env)->FindClass(env, "org/grammaticalframework/pgf/ExprIterator");
	jmethodID constrId = (*env)->GetMethodID(env, expiter_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;JJJ)V");
	jobject jexpiter = (*env)->NewObject(env, expiter_class, constrId, jpgf, p2l(pool), p2l(pool), p2l(res));

	return jexpiter;
}
