#include <pgf/pgf.h>
#include <gu/mem.h>
#include <gu/exn.h>
#include <alloca.h>
#include "org_grammaticalframework_pgf_PGF.h"

static jstring
gu2j_string(JNIEnv *env, GuString s) {
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];

	uint8_t* utf8;
	size_t len;
	if (w & 1) {
		len = (w & 0xff) >> 1;
		gu_assert(len <= sizeof(GuWord));
		size_t i = len;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		utf8 = buf;
	} else {
		uint8_t* p = (void*) w;
		len = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		utf8 = &p[1];
	}

	const uint8_t* src = utf8;

	jchar* utf16 = alloca(len*sizeof(jchar));
	jchar* dst   = utf16;
	while (src-utf8 < len) {
		GuUCS ucs = gu_utf8_decode(&src);
		
		if (ucs <= 0xFFFF) {
			*dst++ = ucs;
		} else {
			ucs -= 0x10000;
			*dst++ = 0xD800+(ucs >> 10) & 0x3FF;
			*dst++ = 0xDC00+ucs & 0x3FF;
		}
	}

	return (*env)->NewString(env, utf16, dst-utf16);
}

static PgfPGF*
get_pgf(JNIEnv *env, jobject self) {
	jfieldID grId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, self), "gr", "J");
	return (PgfPGF*) (*env)->GetLongField(env, self, grId);
}

static PgfPGF*
get_concr(JNIEnv *env, jobject self) {
	jfieldID concrId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, self), "concr", "J");
	return (PgfPGF*) (*env)->GetLongField(env, self, concrId);
}

JNIEXPORT jobject JNICALL 
Java_org_grammaticalframework_pgf_PGF_readPGF(JNIEnv *env, jclass cls, jstring s)
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
			jclass exception_class = (*env)->FindClass(env, "java/io/FileNotFoundException");
			if (!exception_class)
				return NULL;
			jmethodID constrId = (*env)->GetMethodID(env, exception_class, "<init>", "(Ljava/lang/String;)V");
			if (!constrId)
				return NULL;
			jobject exception = (*env)->NewObject(env, exception_class, constrId, s);
			if (!exception)
				return NULL;
			(*env)->Throw(env, exception);
		} else {
			jclass exception_class = (*env)->FindClass(env, "org/grammaticalframework/PGFError");
			if (!exception_class)
				return NULL;
			jmethodID constrId = (*env)->GetMethodID(env, exception_class, "<init>", "(Ljava/lang/String;)V");
			if (!constrId)
				return NULL;
			jstring msg = (*env)->NewStringUTF(env, "The grammar cannot be loaded");
			if (!msg)
				return NULL;
			jobject exception = (*env)->NewObject(env, exception_class, constrId, msg);
			if (!exception)
				return NULL;
			(*env)->Throw(env, exception);
		}
		gu_pool_free(pool);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	jmethodID constrId = (*env)->GetMethodID(env, cls, "<init>", "(JJ)V");
	return (*env)->NewObject(env, cls, constrId, (jlong) pool, (jlong) pgf);
}

JNIEXPORT jstring JNICALL 
Java_org_grammaticalframework_pgf_PGF_getAbstractName(JNIEnv* env, jobject self)
{
	return gu2j_string(env, pgf_abstract_name(get_pgf(env, self)));
}

JNIEXPORT void JNICALL 
Java_org_grammaticalframework_pgf_PGF_free(JNIEnv* env, jclass cls, jlong pool)
{
	gu_pool_free((GuPool*) pool);
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
	PgfCId name = *((PgfCId*) key);
    PgfConcr* concr = *((PgfConcr**) value);
    JPGFClosure* clo = (JPGFClosure*) fn;

	jstring jname = gu2j_string(clo->env, name);
	
	jclass map_class = (*clo->env)->GetObjectClass(clo->env, clo->object);
	jmethodID put_method = (*clo->env)->GetMethodID(clo->env, map_class, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");

	jclass concr_class = (*clo->env)->FindClass(clo->env, "org/grammaticalframework/pgf/Concr");
	jmethodID constrId = (*clo->env)->GetMethodID(clo->env, concr_class, "<init>", "(Lorg/grammaticalframework/pgf/PGF;J)V");
	jobject jconcr = (*clo->env)->NewObject(clo->env, concr_class, constrId, clo->grammar, (jlong) concr);

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

	PgfPGF* pgf = get_pgf(env, self);

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
	return gu2j_string(env, pgf_concrete_name(get_concr(env, self)));
}
