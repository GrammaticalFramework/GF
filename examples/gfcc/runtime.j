.class public runtime
.super java/lang/Object
;
; standard initializer
.method public <init>()V
  aload_0
  invokenonvirtual java/lang/Object/<init>()V
  return
.end method

.method public static ilt(II)I
.limit locals 2
.limit stack 2
    iload_0
    iload_1
    if_icmpge Label0
    iconst_1
    ireturn
  Label0:
    iconst_0
    ireturn
.end method

.method public static flt(FF)I
.limit locals 2
.limit stack 2
    fload_0
    fload_1
    fcmpl
    ifge Label0
    iconst_1
    ireturn
  Label0:
    iconst_0
    ireturn
.end method

.method public static iprintf(I)V
.limit locals 1
.limit stack 1000
  getstatic java/lang/System/out Ljava/io/PrintStream;
  iload_0
  invokevirtual java/io/PrintStream/println(I)V
  return
.end method

.method public static fprintf(F)V
.limit locals 1
.limit stack 1000
  getstatic java/lang/System/out Ljava/io/PrintStream;
  fload_0
  invokevirtual java/io/PrintStream/println(F)V
  return
.end method

