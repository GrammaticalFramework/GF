LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

jni_c_files := jpgf.c
pgf_c_files := data.c expr.c graphviz.c lexer.c linearizer.c literals.c parser.c parseval.c pgf.c printer.c reader.c reasoner.c
gu_c_files := assert.c  choice.c  exn.c   fun.c   in.c      list.c  map.c  out.c    str.c     type.c  utf8.c \
bits.c    defs.c    enum.c  file.c  hash.c  log.c   mem.c  prime.c  seq.c   string.c  ucs.c   variant.c

LOCAL_MODULE    := jpgf
LOCAL_SRC_FILES := $(addprefix ../../../runtime/java/, $(jni_c_files)) \
                   $(addprefix ../../../runtime/c/pgf/, $(pgf_c_files)) \
                   $(addprefix ../../../runtime/c/gu/, $(gu_c_files))
LOCAL_C_INCLUDES := ../../../runtime/c

include $(BUILD_SHARED_LIBRARY)
