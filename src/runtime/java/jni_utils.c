#include <jni.h>
#include <gu/utf8.h>
#include <gu/string.h>
#include <pgf/pgf.h>
#include <pgf/linearizer.h>
#include "jni_utils.h"
#ifndef __MINGW32__
#include <alloca.h>
#else
#include <malloc.h>
#endif

#define l2p(x) ((void*) (intptr_t) (x))
#define p2l(x) ((jlong) (intptr_t) (x))

JPGF_INTERNAL jstring
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

JPGF_INTERNAL jstring
gu2j_string_len(JNIEnv *env, const char* s, size_t len) {
	const char* utf8 = s;

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

JPGF_INTERNAL jstring
gu2j_string_buf(JNIEnv *env, GuStringBuf* sbuf) {
	return gu2j_string_len(env, gu_string_buf_data(sbuf), gu_string_buf_length(sbuf));
}

JPGF_INTERNAL jstring
gu2j_string_capit(JNIEnv *env, GuString s, PgfCapitState capit) {
	const char* utf8 = s;
	size_t len = strlen(s);

	jchar* utf16 = alloca(len*sizeof(jchar));
	jchar* dst   = utf16;
	while (s-utf8 < len) {
		GuUCS ucs = gu_utf8_decode((const uint8_t**) &s);

		if (capit == PGF_CAPIT_FIRST) {
			ucs = gu_ucs_to_upper(ucs);
			capit = PGF_CAPIT_NONE;
		} else if (capit == PGF_CAPIT_NEXT) {
			ucs = gu_ucs_to_upper(ucs);
		}

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

JPGF_INTERNAL GuString
j2gu_string(JNIEnv *env, jstring s, GuPool* pool) {
	GuString str = (*env)->GetStringUTFChars(env, s, 0);
	GuString copy = gu_string_copy(str, pool);
	(*env)->ReleaseStringUTFChars(env, s, str);
	return copy;
}

JPGF_INTERNAL size_t
gu2j_string_offset(GuString s, size_t offset) {
	const char* utf8 = s;
	size_t joffset = 0;
	while (utf8-s < offset) {
		gu_utf8_decode((const uint8_t**) &utf8);
		joffset++;
	}
	return joffset;
}

JPGF_INTERNAL size_t
j2gu_string_offset(GuString s, size_t joffset) {
	const char* utf8 = s;
	while (joffset > 0) {
		gu_utf8_decode((const uint8_t**) &utf8);
		joffset--;
	}
	return utf8-s;
}

JPGF_INTERNAL void*
get_ref(JNIEnv *env, jobject self) {
	jfieldID refId = (*env)->GetFieldID(env, (*env)->GetObjectClass(env, self), "ref", "J");
	return l2p((*env)->GetLongField(env, self, refId));
}

JPGF_INTERNAL void
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

JPGF_INTERNAL void
throw_string_exception(JNIEnv *env, const char* class_name, const char* msg)
{
	jstring jmsg = (*env)->NewStringUTF(env, msg);
	if (!jmsg)
		return;
	throw_jstring_exception(env, class_name, jmsg);
}

