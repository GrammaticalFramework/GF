#include <Python.h>
#include "HsFFI.h"

#ifdef __GLASGOW_HASKELL__
#include "PyGF_stub.h"

extern void __stginit_PyGF ( void );
#endif

static inline void gf_init(int *argc, char ***argv)
{
  hs_init(argc, argv);
#ifdef __GLASGOW_HASKELL__
  hs_add_root(__stginit_PyGF);
#endif
}

static inline void gf_exit(void)
{
  hs_exit();
}

typedef HsStablePtr GF_PGF;
typedef HsStablePtr GF_CId;
typedef HsStablePtr GF_Language;
typedef HsStablePtr GF_Type;
typedef HsStablePtr GF_Tree;
typedef HsStablePtr GF_Expr;
typedef struct {
  PyObject_HEAD;
  HsStablePtr sp;
} PyGF;


#define NEWOBJECT(OBJ, GFTYPE) typedef struct {\
  PyObject_HEAD \
  GFTYPE obj; \
  } OBJ;

#define PYTYPE(OBJ) OBJ ## Type
#define NEWCONSTRUCTOR(OBJ) inline OBJ* new ## OBJ () {\
    return (OBJ*)PYTYPE(OBJ).tp_new(&PYTYPE(OBJ),NULL,NULL); }

#define NEWTYPE(TYPE,NAME,OBJECT,DOC) static PyTypeObject TYPE = {\
    PyObject_HEAD_INIT(NULL)\
    0,                         /*ob_size*/\
    NAME,             /*tp_name*/\
    sizeof(OBJECT), /*tp_basicsize*/\
    0,                         /*tp_itemsize*/\
    0,                         /*tp_dealloc*/\
    0,                         /*tp_print*/\
    0,                         /*tp_getattr*/\
    0,                         /*tp_setattr*/\
    0,                         /*tp_compare*/\
    0,                         /*tp_repr*/\
    0,                         /*tp_as_number*/\
    0,                         /*tp_as_sequence*/\
    0,                         /*tp_as_mapping*/\
    0,                         /*tp_hash */\
    0,                         /*tp_call*/\
    0,                         /*tp_str*/\
    0,                         /*tp_getattro*/\
    0,                         /*tp_setattro*/\
    0,                         /*tp_as_buffer*/\
    Py_TPFLAGS_DEFAULT,        /*tp_flags*/\
    DOC,           /* tp_doc */\
  };
#define NEWGF(OBJ,GFTYPE,TYPE,NAME,DOC) NEWOBJECT(OBJ,GFTYPE)   \
  NEWTYPE(TYPE,NAME,OBJ,DOC)\
  NEWCONSTRUCTOR(OBJ)


// NEWOBJECT(CID, GF_CId)

#ifdef DEBUG
#define DEALLOCFN(delname,t,cb,cbname) static void \
delname(t *self){ cb(self);\
	printf("gf_%s has been called for stable pointer 0x%x\n", cbname, self->obj);\
	self->ob_type->tp_free((PyObject*)self); }
#else
#define DEALLOCFN(delname,t,cb,cbname) static void \
delname(t *self){ cb(self);\
	self->ob_type->tp_free((PyObject*)self); }
#endif

#ifdef DEBUG
#define REPRCB(cbid,t,gfcb) static PyObject* \
cbid(t *self) { \
	const char *str = gfcb(self); \
 	return PyString_FromFormat("0x%x: %s", self->obj, str); }
#else
#define REPRCB(cbid,t,gfcb) static PyObject* \
cbid(t *self) { \
	const char *str = gfcb(self); \
 	return PyString_FromString(str); }
#endif
