#include <pgf/pgf.h>
#include <pgf/reader.h>
#include <gu/mem.h>
#include <gu/exn.h>
#include <gu/utf8.h>
#include <alloca.h>
#include <jni.h>

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

JNIEXPORT jobject JNICALL
Java_org_grammaticalframework_pgf_PGF_readPGF__Ljava_io_InputStream_2(JNIEnv *env, jclass cls, jobject java_stream)
{
	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	jclass java_stream_class = (*env)->GetObjectClass(env, java_stream);

	JInStream* jstream = gu_new(JInStream, tmp_pool);
	jstream->stream.begin_buffer = jpgf_jstream_begin_buffer;
	jstream->stream.end_buffer = jpgf_jstream_end_buffer;
	jstream->stream.input = NULL;
	jstream->java_stream = java_stream;
	jstream->env = env;

	jstream->read_method = (*env)->GetMethodID(env, java_stream_class, "read", "([B)I");
	if (!jstream->read_method) {
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	jstream->buf_array = (*env)->NewByteArray(env, 1024);
	if (!jstream->buf_array) {
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	jstream->buf = NULL;

	GuIn* in = gu_new_in(&jstream->stream, tmp_pool);

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
			jstring jmsg = gu2j_string(env, msg);
			throw_string_exception(env, "org/grammaticalframework/pgf/PGFError", jmsg);
		} else if (gu_exn_caught(parse_err) == gu_type(PgfParseError)) {
			GuString tok = (GuString) gu_exn_caught_data(parse_err);
			jstring jtok = gu2j_string(env, tok);
			throw_jstring_exception(env, "org/grammaticalframework/pgf/ParseError", jtok);
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
		//
		return NULL;
	}

	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	jstring jstr = gu2j_string(env, str);

	gu_pool_free(tmp_pool);
	
	return jstr;
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
