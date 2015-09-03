#ifndef JNI_UTILS
#define JNI_UTILS

#define l2p(x) ((void*) (intptr_t) (x))
#define p2l(x) ((jlong) (intptr_t) (x))

jstring
gu2j_string(JNIEnv *env, GuString s);

GuString
j2gu_string(JNIEnv *env, jstring s, GuPool* pool);

size_t
gu2j_string_offset(GuString s, size_t offset);

size_t
j2gu_string_offset(GuString s, size_t joffset);

void*
get_ref(JNIEnv *env, jobject self);

void
throw_jstring_exception(JNIEnv *env, const char* class_name, jstring msg);

void
throw_string_exception(JNIEnv *env, const char* class_name, const char* msg);

#endif
