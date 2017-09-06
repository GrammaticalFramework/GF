#ifndef JNI_UTILS
#define JNI_UTILS

#if defined(_MSC_VER)

#define JPGF_INTERNAL_DECL
#define JPGF_INTERNAL

#else

#define JPGF_INTERNAL_DECL  __attribute__ ((visibility ("hidden")))
#define JPGF_INTERNAL       __attribute__ ((visibility ("hidden")))

#endif


#define l2p(x) ((void*) (intptr_t) (x))
#define p2l(x) ((jlong) (intptr_t) (x))

JPGF_INTERNAL_DECL jstring
gu2j_string(JNIEnv *env, GuString s);

JPGF_INTERNAL_DECL jstring
gu2j_string_len(JNIEnv *env, const char* s, size_t len);

JPGF_INTERNAL_DECL jstring
gu2j_string_buf(JNIEnv *env, GuStringBuf* sbuf);

JPGF_INTERNAL_DECL GuString
j2gu_string(JNIEnv *env, jstring s, GuPool* pool);

JPGF_INTERNAL_DECL size_t
gu2j_string_offset(GuString s, size_t offset);

JPGF_INTERNAL_DECL size_t
j2gu_string_offset(GuString s, size_t joffset);

JPGF_INTERNAL_DECL void*
get_ref(JNIEnv *env, jobject self);

JPGF_INTERNAL_DECL void
throw_jstring_exception(JNIEnv *env, const char* class_name, jstring msg);

JPGF_INTERNAL_DECL void
throw_string_exception(JNIEnv *env, const char* class_name, const char* msg);

#endif
