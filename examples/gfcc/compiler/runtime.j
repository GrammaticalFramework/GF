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
  Label1:
.end method

; TODO: flt missing
