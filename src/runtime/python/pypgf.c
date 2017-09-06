#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "structmember.h"

#include <gu/mem.h>
#include <gu/map.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/linearizer.h>

#if PY_MAJOR_VERSION >= 3
	#define PyIntObject                  PyLongObject
	#define PyInt_Type                   PyLong_Type
	#define PyInt_Check(op)              PyLong_Check(op)
	#define PyInt_CheckExact(op)         PyLong_CheckExact(op)
	#define PyInt_FromString             PyLong_FromString
	#define PyInt_FromUnicode            PyLong_FromUnicode
	#define PyInt_FromLong               PyLong_FromLong
	#define PyInt_FromSize_t             PyLong_FromSize_t
	#define PyInt_FromSsize_t            PyLong_FromSsize_t
	#define PyInt_AsLong                 PyLong_AsLong
	#define PyInt_AS_LONG                PyLong_AS_LONG
	#define PyInt_AsSsize_t              PyLong_AsSsize_t
	#define PyInt_AsUnsignedLongMask     PyLong_AsUnsignedLongMask
	#define PyInt_AsUnsignedLongLongMask PyLong_AsUnsignedLongLongMask
#endif

#if PY_MAJOR_VERSION >= 3
	#define PyString_Check				 PyUnicode_Check
	#define PyString_FromString		 	 PyUnicode_FromString
	#define PyString_FromStringAndSize 	 PyUnicode_FromStringAndSize
	#define PyString_FromFormat		 	 PyUnicode_FromFormat
	#define PyString_Concat(ps,s)		 {PyObject* tmp = *(ps); *(ps) = PyUnicode_Concat(tmp,s); Py_DECREF(tmp);}
#endif

static PyObject* PGFError;

static PyObject* ParseError;

static PyObject* TypeError;

typedef struct {
    PyObject_HEAD
    GuPool* pool;
    PgfPGF* pgf;
} PGFObject;

typedef struct {
	PyObject_HEAD
	PyObject* master;
	GuPool* pool;
    PgfExpr expr;
} ExprObject;

static ExprObject*
Expr_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    ExprObject* self = (ExprObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->master = NULL;
		self->pool   = NULL;
		self->expr   = gu_null_variant;
    }

    return self;
}

static void
Expr_dealloc(ExprObject* self)
{
	if (self->master != NULL) {
		Py_DECREF(self->master);
	}
	if (self->pool != NULL) {
		gu_pool_free(self->pool);
	}

    Py_TYPE(self)->tp_free((PyObject*)self);
}

static PyObject*
Expr_getattro(ExprObject *self, PyObject *attr_name);

static int
Expr_initMeta(ExprObject *self);

static int
Expr_initLiteral(ExprObject *self, PyObject *lit);

static int
Expr_initApp(ExprObject *self, const char* fname, PyObject *args);

static ExprObject*
Expr_call(ExprObject* e, PyObject* args, PyObject* kw);

static PyObject*
Expr_unpack(ExprObject* self, PyObject *args);

static PyObject*
Expr_visit(ExprObject* self, PyObject *args);

static PyObject*
Expr_reduce_ex(ExprObject* self, PyObject *args);

static int
Expr_init(ExprObject *self, PyObject *args, PyObject *kwds)
{
	Py_ssize_t tuple_size = PyTuple_Size(args);

	if (tuple_size == 0) {
		return Expr_initMeta(self);
	} else if (tuple_size == 1) {
		PyObject* lit = NULL;
		if (!PyArg_ParseTuple(args, "O", &lit))
			return -1;
		return Expr_initLiteral(self, lit);
	} else if (tuple_size == 2) {
		const char* fname;
		PyObject* list = NULL;
		if (!PyArg_ParseTuple(args, "sO!", &fname, &PyList_Type, &list))
			return -1;
		return Expr_initApp(self, fname, list);
	} else {
		PyErr_Format(PyExc_TypeError, "function takes 0, 1 or 2 arguments (%d given)", (int) tuple_size);
		return -1;
	}
	
	return 0;
}

static PyObject *
Expr_repr(ExprObject *self)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	pgf_print_expr(self->expr, NULL, 0, out, err);

	PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));
	
	gu_pool_free(tmp_pool);
	return pystr;
}

static PyObject *
Expr_richcompare(ExprObject *e1, ExprObject *e2, int op)
{
	bool cmp = pgf_expr_eq(e1->expr,e2->expr);
	
	if (op == Py_EQ) {
		if (cmp) Py_RETURN_TRUE;  else Py_RETURN_FALSE;
	} else if (op == Py_NE) {
		if (cmp) Py_RETURN_FALSE; else Py_RETURN_TRUE;
	} else {
		PyErr_SetString(PyExc_TypeError, "the operation is not supported");
		return NULL;
	}
}

static long
Expr_hash(ExprObject *e)
{
	return (long) pgf_expr_hash(0, e->expr);
}

static PyMethodDef Expr_methods[] = {
    {"unpack", (PyCFunction)Expr_unpack, METH_VARARGS,
     "Decomposes an expression into its components"
    },
    {"visit", (PyCFunction)Expr_visit, METH_VARARGS,
     "Implementation of the visitor pattern for abstract syntax trees. "
     "If e is an expression equal to f a1 .. an then "
     "e.visit(self) calls method self.on_f(a1,..an). "
     "If the method doesn't exist then the method self.default(e) "
     "is called."
    },
    {"__reduce_ex__", (PyCFunction)Expr_reduce_ex, METH_VARARGS,
     "This method allows for transparent pickling/unpickling of expressions."
    },
    {NULL}  /* Sentinel */
};

static PyGetSetDef Expr_getseters[] = {
    {"fun", 
     NULL, NULL,
     "this is the function in a function application",
     NULL},
    {"arg", 
     NULL, NULL,
     "this is the argument in a function application",
     NULL},
    {"val", 
     NULL, NULL,
     "this is the value of a literal",
     NULL},
    {"id", 
     NULL, NULL,
     "this is the id of a meta variable",
     NULL},
    {"name", 
     NULL, NULL,
     "this is the name of a function",
     NULL},
    {"index", 
     NULL, NULL,
     "this is the de Bruijn index of a variable",
     NULL},
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_ExprType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.Expr",                /*tp_name*/
    sizeof(ExprObject),        /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Expr_dealloc,  /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    (hashfunc) Expr_hash,      /*tp_hash */
    (ternaryfunc) Expr_call,   /*tp_call*/
    (reprfunc) Expr_repr,      /*tp_str*/
    (getattrofunc) Expr_getattro,/*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "abstract syntax tree",    /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    (richcmpfunc) Expr_richcompare, /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Expr_methods,              /*tp_methods */
    0,                         /*tp_members */
    Expr_getseters,            /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Expr_init,       /*tp_init */
    0,                         /*tp_alloc */
    (newfunc) Expr_new,        /*tp_new */
};

static int
Expr_initMeta(ExprObject *self)
{
	self->master = NULL;
	self->pool = gu_new_pool();
	PgfExprMeta* e =
		gu_new_variant(PGF_EXPR_META,
					   PgfExprMeta,
					   &self->expr, self->pool);
	e->id = 0;
	return 0;
}

static int
Expr_initLiteral(ExprObject *self, PyObject *lit)
{
	self->master = NULL;
	self->pool   = gu_new_pool();
	PgfExprLit* e =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &self->expr, self->pool);
	e->lit = gu_null_variant;

	if (PyString_Check(lit)) {
		char* s;
		Py_ssize_t len;

#if PY_MAJOR_VERSION >= 3
		PyObject* bytes = PyUnicode_AsUTF8String(lit);
		if (bytes == NULL)
			return -1;
		if (PyBytes_AsStringAndSize(bytes,&s,&len) < 0)
			return -1;
#else
		if (PyString_AsStringAndSize(lit,&s,&len) < 0)
			return -1;
#endif

		PgfLiteralStr* slit =
			gu_new_flex_variant(PGF_LITERAL_STR,
			                    PgfLiteralStr,
			                    val, len+1,
			                    &e->lit, self->pool);
		memcpy(slit->val, s, len+1);

#if PY_MAJOR_VERSION >= 3
		Py_DECREF(bytes);
#endif
	} else if (PyInt_Check(lit)) {
		PgfLiteralInt* ilit =
			gu_new_variant(PGF_LITERAL_INT,
			               PgfLiteralInt,
			               &e->lit, self->pool);
		ilit->val = PyInt_AsLong(lit);
	} else if (PyFloat_Check(lit)) {
		PgfLiteralFlt* flit =
			gu_new_variant(PGF_LITERAL_FLT,
			               PgfLiteralFlt,
			               &e->lit, self->pool);
		flit->val = PyFloat_AsDouble(lit);
	} else {
		PyErr_SetString(PyExc_TypeError, "the literal must be a string, an integer, or a float");
		return -1;
	}
	return 0;
}

static int
Expr_initApp(ExprObject *self, const char* fname, PyObject *args)
{
	Py_ssize_t n_args = PyList_Size(args);

	self->master = PyTuple_New(n_args);
	if (self->master == NULL)
		return -1;

	self->pool = gu_new_pool();
	PgfExprFun* e =
		gu_new_flex_variant(PGF_EXPR_FUN,
					        PgfExprFun,
					        fun, strlen(fname)+1,
					        &self->expr, self->pool);
	strcpy(e->fun, fname);

	for (Py_ssize_t i = 0; i < n_args; i++) {
		PyObject* obj = PyList_GetItem(args, i);
		if (obj->ob_type != &pgf_ExprType) {
			PyErr_SetString(PyExc_TypeError, "the arguments in the list must be expressions");
			return -1;
		}

		PyTuple_SetItem(self->master, i, obj);
		Py_INCREF(obj);

		PgfExpr fun = self->expr;
		PgfExpr arg = ((ExprObject*) obj)->expr;

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &self->expr, self->pool);
		e->fun = fun;
		e->arg = arg;
	}
	
	return 0;
}

static ExprObject*
Expr_call(ExprObject* self, PyObject* args, PyObject* kw)
{
	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL)
		return NULL;

	size_t n_args = PyTuple_Size(args);

	pyexpr->master = PyTuple_New(n_args+1);
	if (pyexpr->master == NULL) {
		Py_DECREF(pyexpr);
		return NULL;
	}

	PyTuple_SetItem(pyexpr->master, 0, (PyObject*) self);
	Py_INCREF(self);

	pyexpr->pool = gu_new_pool();
	pyexpr->expr = self->expr;

	for (Py_ssize_t i = 0; i < n_args; i++) {
		PyObject* obj = PyTuple_GetItem(args, i);
		if (obj->ob_type != &pgf_ExprType) {
			PyErr_SetString(PyExc_TypeError, "the arguments must be expressions");
			return NULL;
		}

		PyTuple_SetItem(pyexpr->master, i+1, obj);
		Py_INCREF(obj);

		PgfExpr fun = pyexpr->expr;
		PgfExpr arg = ((ExprObject*) obj)->expr;

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &pyexpr->expr, pyexpr->pool);
		e->fun = fun;
		e->arg = arg;
	}

	return pyexpr;
}

static PyObject*
Expr_unpack(ExprObject* self, PyObject *fargs)
{
	PgfExpr expr = self->expr;
	PyObject* args = PyList_New(0);

	for (;;) {
		GuVariantInfo i = gu_variant_open(expr);
		switch (i.tag) {
		case PGF_EXPR_ABS: {
			PgfExprAbs* eabs = i.data;

			ExprObject* py_body = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
			if (py_body == NULL) {
				Py_DECREF(args);
				return NULL;
			}
			py_body->pool   = NULL;
			py_body->master = (self->master) ? self->master : (PyObject*) self;
			py_body->expr   = eabs->body;
			Py_INCREF(py_body->master);

			PyObject* py_bindtype = 
				(eabs->bind_type == PGF_BIND_TYPE_EXPLICIT) ? Py_True
				                                            : Py_False;
			PyObject* py_var = PyString_FromString(eabs->id);
			PyObject* res = 
				Py_BuildValue("OOOO", py_bindtype, py_var, py_body, args);
			Py_DECREF(py_var);
			Py_DECREF(py_body);
			Py_DECREF(args);
			return res;
		}
		case PGF_EXPR_APP: {
			PgfExprApp* eapp = i.data;
			
			ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
			if (pyexpr == NULL) {
				Py_DECREF(args);
				return NULL;
			}
			pyexpr->pool   = NULL;
			pyexpr->master = (self->master) ? self->master : (PyObject*) self;
			pyexpr->expr   = eapp->arg;
			Py_INCREF(pyexpr->master);

			if (PyList_Insert(args, 0, (PyObject*) pyexpr) == -1) {
				Py_DECREF(args);
				return NULL;
			}

			Py_DECREF((PyObject*) pyexpr);

			expr = eapp->fun;
			break;
		}
		case PGF_EXPR_LIT: {
			PgfExprLit* elit = i.data;

			Py_DECREF(args);
			
			GuVariantInfo i = gu_variant_open(elit->lit);
			switch (i.tag) {
			case PGF_LITERAL_STR: {
				PgfLiteralStr* lstr = i.data;
				return PyString_FromString(lstr->val);
			}
			case PGF_LITERAL_INT: {
				PgfLiteralInt* lint = i.data;
				return PyInt_FromLong(lint->val);
			}
			case PGF_LITERAL_FLT: {
				PgfLiteralFlt* lflt = i.data;
				return PyFloat_FromDouble(lflt->val);
			}
			default:
				gu_impossible();
				return NULL;
			}
		}
		case PGF_EXPR_META: {
			PyObject* res = Py_BuildValue("OO", Py_None, args);
			Py_DECREF(args);
			return res;
		}
		case PGF_EXPR_FUN: {
			PgfExprFun* efun = i.data;
			PyObject* fun = PyString_FromString(efun->fun);
			PyObject* res = Py_BuildValue("OO", fun, args);
			Py_DECREF(fun);
			Py_DECREF(args);
			return res;
		}
		case PGF_EXPR_VAR: {
			PgfExprVar* evar = i.data;
			PyObject* res = Py_BuildValue("iO", evar->var, args);
			Py_DECREF(args);
			return res;
		}
		case PGF_EXPR_TYPED: {
			PgfExprTyped* etyped = i.data;
			expr = etyped->expr;
			break;
		}
		case PGF_EXPR_IMPL_ARG: {
			PgfExprImplArg* eimpl = i.data;
			expr = eimpl->expr;
			break;
		}
		default:
			gu_impossible();
			return NULL;
		}
	}
	return NULL;
}

static PyObject*
Expr_visit(ExprObject* self, PyObject *args)
{
	PyObject* py_visitor = NULL;
	PgfExpr expr = self->expr;
	if (!PyArg_ParseTuple(args, "O", &py_visitor))
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	PgfApplication* app = pgf_expr_unapply(expr, tmp_pool);
	if (app != NULL) {
		char* method_name = gu_malloc(tmp_pool, strlen(app->fun)+4);
		strcpy(method_name, "on_");
		strcat(method_name, app->fun);

		if (PyObject_HasAttrString(py_visitor, method_name)) {
			PyObject* method_args = PyTuple_New(app->n_args);
			if (method_args == NULL) {
				gu_pool_free(tmp_pool);
				return NULL;
			}

			for (size_t i = 0; i < app->n_args; i++) {
				ExprObject* pyarg = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
				if (pyarg == NULL) {
					Py_DECREF(args);
					gu_pool_free(tmp_pool);
					return NULL;
				}
				pyarg->pool   = NULL;
				pyarg->master = (self->master) ? self->master : (PyObject*) self;
				pyarg->expr   = app->args[i];
				Py_INCREF(pyarg->master);

				if (PyTuple_SetItem(method_args, i, (PyObject*) pyarg) == -1) {
					Py_DECREF(args);
					gu_pool_free(tmp_pool);
					return NULL;
				}
			}
			
			PyObject* method =
				PyObject_GetAttrString(py_visitor, method_name);
			if (method == NULL) {
				Py_DECREF(args);
				gu_pool_free(tmp_pool);
				return NULL;
			}

			gu_pool_free(tmp_pool);

			return PyObject_CallObject(method, method_args);
		}
	}

	gu_pool_free(tmp_pool);

	return PyObject_CallMethod(py_visitor, "default", "O", self);
}

static PyObject*
Expr_reduce_ex(ExprObject* self, PyObject *args)
{
	int protocol;
	if (!PyArg_ParseTuple(args, "i", &protocol))
		return NULL;

	PyObject* myModule = PyImport_ImportModule("pgf");
	if (myModule == NULL)
		return NULL;
	PyObject* py_readExpr = PyObject_GetAttrString(myModule, "readExpr");
	Py_DECREF(myModule);
	if (py_readExpr == NULL)
		return NULL;

	PyObject* py_str = Expr_repr(self);
	if (py_str == NULL) {
		Py_DECREF(py_readExpr);
		return NULL;
	}

	PyObject* py_tuple =
		Py_BuildValue("O(O)", py_readExpr, py_str);

	Py_DECREF(py_str);
	Py_DECREF(py_readExpr);

	return py_tuple;
}

static PyObject*
Expr_getattro(ExprObject *self, PyObject *attr_name) {
#if PY_MAJOR_VERSION >= 3
#define IS_ATTR(attr) (PyUnicode_CompareWithASCIIString(attr_name,attr) == 0)
#else
	const char* name = PyString_AsString(attr_name);
#define IS_ATTR(attr) (strcmp(name, attr) == 0)
#endif

	PgfExpr expr = self->expr;
	
redo:;
    GuVariantInfo i = gu_variant_open(expr);
    switch (i.tag) {
	case PGF_EXPR_APP: {
		PgfExprApp* eapp = i.data;
		
		ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
		if (pyexpr == NULL)
			return NULL;
		pyexpr->pool   = NULL;
		pyexpr->master = (self->master) ? self->master : (PyObject*) self;
		pyexpr->expr   = gu_null_variant;
		Py_INCREF(pyexpr->master);

		if (IS_ATTR("fun")) {
			pyexpr->expr = eapp->fun;
			return ((PyObject*) pyexpr);
		} else if (IS_ATTR("arg")) {
			pyexpr->expr = eapp->arg;
			return ((PyObject*) pyexpr);
		} else {
			Py_DECREF(pyexpr);
		}
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = i.data;
		
		if (IS_ATTR("val")) {
			GuVariantInfo i = gu_variant_open(elit->lit);
			switch (i.tag) {
			case PGF_LITERAL_INT: {
				PgfLiteralInt* lint = i.data;
				return PyInt_FromLong(lint->val);
			}
			case PGF_LITERAL_FLT: {
				PgfLiteralFlt* lflt = i.data;
				return PyFloat_FromDouble(lflt->val);
			}
			case PGF_LITERAL_STR: {
				PgfLiteralStr* lstr = i.data;
				return PyString_FromString(lstr->val);
			}
			}
		}
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* emeta = i.data;
		if (IS_ATTR("id"))
			return PyInt_FromLong(emeta->id);
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* efun = i.data;
		if (IS_ATTR("name")) {
			return PyString_FromString(efun->fun);
		}
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = i.data;
		if (IS_ATTR("index")) {
			return PyInt_FromLong(evar->var);
		}
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = i.data;
		expr = etyped->expr;
		goto redo;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = i.data;
		expr = eimpl->expr;
		goto redo;
	}
	default:
		gu_impossible();
	}

	return PyObject_GenericGetAttr((PyObject*)self, attr_name);
}

typedef struct {
	PyObject_HEAD
	PyObject* master;
	GuPool* pool;
    PgfType* type;
} TypeObject;

static PyTypeObject pgf_TypeType;

static TypeObject*
Type_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    TypeObject* self = (TypeObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->master = NULL;
		self->pool   = NULL;
		self->type   = NULL;
    }

    return self;
}

static void
Type_dealloc(TypeObject* self)
{
	if (self->master != NULL) {
		Py_DECREF(self->master);
	}
	if (self->pool != NULL) {
		gu_pool_free(self->pool);
	}

    Py_TYPE(self)->tp_free((PyObject*)self);
}

static int
Type_init(TypeObject *self, PyObject *args, PyObject *kwds)
{
	PyObject* py_hypos;
	const char* catname_s;
	PyObject* py_exprs;
	size_t n_exprs;
	size_t n_hypos;

	if (PyTuple_Size(args) == 1) {
		py_hypos = NULL;
		py_exprs = NULL;
		n_exprs  = 0;
		n_hypos  = 0;
		if (!PyArg_ParseTuple(args, "s", &catname_s))
			return -1;
	} else {
		if (!PyArg_ParseTuple(args, "O!sO!", 
				&PyList_Type, &py_hypos, 
				&catname_s, 
				&PyList_Type, &py_exprs))
			return -1;
			
		n_exprs = PyList_Size(py_exprs);
		n_hypos = PyList_Size(py_hypos);
	}

	self->pool = gu_new_pool();
	self->master =
		(n_exprs+n_hypos > 0) ? PyTuple_New(n_exprs+n_hypos) : NULL;

	self->type = gu_new_flex(self->pool, PgfType, exprs, n_exprs);

	self->type->hypos =
		gu_new_seq(PgfHypo, n_hypos, self->pool);

	for (size_t i = 0; i < n_hypos; i++) {
		PyObject* obj = PyList_GetItem(py_hypos, i);
		PyObject* py_bindtype;
		PgfCId cid;
		PyObject* py_type;

		if (Py_TYPE(obj) == &pgf_TypeType) {
			py_bindtype = Py_True;
			cid = "_";
			py_type = obj;
		} else {
			if (!PyTuple_Check(obj) ||
				PyTuple_GET_SIZE(obj) != 3) {
				PyErr_SetString(PyExc_TypeError, "the arguments in the first list must be triples of (boolean,string,pgf.Type)");
				return -1;
			}

			py_bindtype = PyTuple_GetItem(obj, 0);
			if (!PyBool_Check(py_bindtype)) {
				PyErr_SetString(PyExc_TypeError, "the arguments in the first list must be triples of (boolean,string,pgf.Type)");
				return -1;
			}

			PyObject* py_var = PyTuple_GetItem(obj, 1);
			if (!PyString_Check(py_var)) {
				PyErr_SetString(PyExc_TypeError, "the arguments in the first list must be triples of (boolean,string,pgf.Type)");
				return -1;
			}

			{
				char* s;
				Py_ssize_t len;

#if PY_MAJOR_VERSION >= 3
				PyObject* bytes = PyUnicode_AsUTF8String(py_var);
				if (bytes == NULL)
					return -1;
				if (PyBytes_AsStringAndSize(bytes,&s,&len) < 0)
					return -1;
#else
				if (PyString_AsStringAndSize(py_var,&s,&len) < 0)
					return -1;
#endif

				cid = gu_malloc(self->pool, len+1);
				memcpy((char*)cid, s, len+1);

#if PY_MAJOR_VERSION >= 3
				Py_DECREF(bytes);
#endif
			}

			py_type = PyTuple_GetItem(obj, 2);
			if (Py_TYPE(py_type) != &pgf_TypeType) {
				PyErr_SetString(PyExc_TypeError, "the arguments in the first list must be triples of (boolean,string,pgf.Type)");
				return -1;
			}
		}

		PgfHypo* hypo = gu_seq_index(self->type->hypos, PgfHypo, i);
		hypo->bind_type = 
			(py_bindtype == Py_True) ? PGF_BIND_TYPE_EXPLICIT
			                         : PGF_BIND_TYPE_IMPLICIT;
		hypo->cid = cid;
		hypo->type = ((TypeObject*) py_type)->type;

		PyTuple_SetItem(self->master, i, py_type);
		Py_INCREF(py_type);
	}

	self->type->cid = gu_string_copy(catname_s, self->pool);

	self->type->n_exprs = n_exprs;
	for (Py_ssize_t i = 0; i < n_exprs; i++) {
		PyObject* obj = PyList_GetItem(py_exprs, i);
		if (Py_TYPE(obj) != &pgf_ExprType) {
			PyErr_SetString(PyExc_TypeError, "the arguments in the second list must be expressions");
			return -1;
		}

		PyTuple_SetItem(self->master, n_hypos+i, obj);
		Py_INCREF(obj);

		self->type->exprs[i] = ((ExprObject*) obj)->expr;
	}

	return 0;
}

static PyObject *
Type_repr(TypeObject *self)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	pgf_print_type(self->type, NULL, 0, out, err);

	PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));

	gu_pool_free(tmp_pool);
	return pystr;
}

static PyObject *
Type_richcompare(TypeObject *t1, TypeObject *t2, int op)
{
	bool cmp = pgf_type_eq(t1->type,t2->type);

	if (op == Py_EQ) {
		if (cmp) Py_RETURN_TRUE;  else Py_RETURN_FALSE;
	} else if (op == Py_NE) {
		if (cmp) Py_RETURN_FALSE; else Py_RETURN_TRUE;
	} else {
		PyErr_SetString(PyExc_TypeError, "the operation is not supported");
		return NULL;
	}
}

static PyObject*
Type_getHypos(TypeObject *self, void *closure)
{
	PgfType* type = self->type;

	PyObject* py_hypos = PyList_New(0);
	if (py_hypos == NULL)
		return NULL;

	size_t n_hypos = gu_seq_length(type->hypos);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(type->hypos, PgfHypo, i);

		PyObject* py_bindtype = 
			(hypo->bind_type == PGF_BIND_TYPE_EXPLICIT) ? Py_True
						  							    : Py_False;

		PyObject* py_var = PyString_FromString(hypo->cid);
		if (py_var == NULL)
			goto fail;

		TypeObject* py_type = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
		if (py_type == NULL) {
			Py_DECREF(py_var);
			goto fail;
		}

		py_type->pool   = NULL;
		py_type->master = (PyObject*) self;
		py_type->type   = hypo->type;
		Py_INCREF(self);

		PyObject* py_hypo = 
			Py_BuildValue("OOO", py_bindtype, py_var, py_type);
		Py_DECREF(py_var);
		Py_DECREF(py_type);

		if (py_hypo == NULL)
			goto fail;

		if (PyList_Append(py_hypos, (PyObject*) py_hypo) == -1)
			goto fail;

		Py_DECREF(py_hypo);
	}

	return py_hypos;
	
fail:
	Py_DECREF(py_hypos);
	return NULL;
}

static PyObject*
Type_getCat(TypeObject *self, void *closure)
{
	return PyString_FromString(self->type->cid);
}

static PyObject*
Type_getExprs(TypeObject *self, void *closure)
{
	PgfType* type = self->type;

	PyObject* py_exprs = PyList_New(0);
	if (py_exprs == NULL)
		return NULL;

	for (size_t i = 0; i < type->n_exprs; i++) {
		ExprObject* py_expr = 
			(ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
		if (py_expr == NULL)
			goto fail;
		py_expr->pool   = NULL;
		py_expr->master = (PyObject*) self;
		py_expr->expr   = type->exprs[i];
		Py_INCREF(py_expr->master);

		if (PyList_Append(py_exprs, (PyObject*) py_expr) == -1)
			goto fail;

		Py_DECREF((PyObject*) py_expr);
	}

	return py_exprs;

fail:
	Py_DECREF(py_exprs);
	return NULL;
}

static PyObject*
Type_unpack(TypeObject* self, PyObject *fargs)
{
	PyObject* res = NULL;
	PyObject* py_hypos = NULL;
	PyObject* py_cat = NULL;
	PyObject* py_exprs = NULL;

	py_hypos = Type_getHypos(self, NULL);
	if (py_hypos == NULL)
		goto fail;

	py_cat = Type_getCat(self, NULL);
	if (py_cat == NULL)
		goto fail;

	py_exprs = Type_getExprs(self, NULL);
	if (py_exprs == NULL)
		goto fail;

	res = Py_BuildValue("OOO", py_hypos, py_cat, py_exprs);

fail:
	Py_XDECREF(py_hypos);
	Py_XDECREF(py_cat);
	Py_XDECREF(py_exprs);
	return res;
}

static PyObject*
Type_reduce_ex(TypeObject* self, PyObject *args)
{
	int protocol;
	if (!PyArg_ParseTuple(args, "i", &protocol))
		return NULL;

	PyObject* myModule = PyImport_ImportModule("pgf");
	if (myModule == NULL)
		return NULL;
	PyObject* py_readType = PyObject_GetAttrString(myModule, "readType");
	Py_DECREF(myModule);
	if (py_readType == NULL)
		return NULL;

	PyObject* py_str = Type_repr(self);
	if (py_str == NULL) {
		Py_DECREF(py_readType);
		return NULL;
	}

	PyObject* py_tuple =
		Py_BuildValue("O(O)", py_readType, py_str);

	Py_DECREF(py_str);
	Py_DECREF(py_readType);

	return py_tuple;
}

static PyMethodDef Type_methods[] = {
    {"unpack", (PyCFunction)Type_unpack, METH_VARARGS,
     "Decomposes a type into its components"
    },
    {"__reduce_ex__", (PyCFunction)Type_reduce_ex, METH_VARARGS,
     "This method allows for transparent pickling/unpickling of types."
    },
    {NULL}  /* Sentinel */
};

static PyGetSetDef Type_getseters[] = {
    {"hypos", 
     (getter)Type_getHypos, NULL,
     "this is the list of hypotheses in the type signature",
     NULL},
    {"cat", 
     (getter)Type_getCat, NULL,
     "this is the name of the category",
     NULL},
    {"exprs", 
     (getter)Type_getExprs, NULL,
     "this is the list of indices for the category",
     NULL},
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_TypeType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.Type",                /*tp_name*/
    sizeof(TypeObject),        /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Type_dealloc,  /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    (reprfunc) Type_repr,      /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "abstract syntax type",    /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    (richcmpfunc) Type_richcompare, /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Type_methods,              /*tp_methods */
    0,                         /*tp_members */
    Type_getseters,            /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Type_init,       /*tp_init */
    0,                         /*tp_alloc */
    (newfunc) Type_new,        /*tp_new */
};

typedef struct IterObject {
    PyObject_HEAD
    PyObject* source;
    PyObject* container;
    GuPool* pool;
    int max_count;
    int counter;
    GuEnum* res;
    PyObject* (*fetch)(struct IterObject* self);
} IterObject;

static PyObject*
Iter_fetch_expr(IterObject* self)
{
	PgfExprProb* ep = gu_next(self->res, PgfExprProb*, self->pool);
	if (ep == NULL)
		return NULL;

	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL)
		return NULL;
	pyexpr->pool   = NULL;
	pyexpr->expr   = ep->expr;
	pyexpr->master = self->container;
	Py_XINCREF(self->container);

	PyObject* res = Py_BuildValue("(f,O)", ep->prob, pyexpr);
	Py_DECREF(pyexpr);

	return res;
}

static PyObject*
Iter_fetch_token(IterObject* self)
{
	PgfTokenProb* tp = gu_next(self->res, PgfTokenProb*, self->pool);
	if (tp == NULL)
		return NULL;

	PyObject* py_tok = PyString_FromString(tp->tok);
	PyObject* py_cat = PyString_FromString(tp->cat);
	PyObject* res = Py_BuildValue("(f,O,O)", tp->prob, py_tok, py_cat);
	Py_DECREF(py_tok);

	return res;
}


static IterObject*
Iter_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    IterObject* self = (IterObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->source = NULL;
		self->container = NULL;
		self->pool = NULL;
		self->max_count = -1;
		self->counter   = 0;
		self->res  = NULL;
    }

    return self;
}

static void
Iter_dealloc(IterObject* self)
{
	if (self->pool != NULL)
		gu_pool_free(self->pool);

	Py_XDECREF(self->source);
	
	Py_XDECREF(self->container);

    Py_TYPE(self)->tp_free((PyObject*)self);
}

static int
Iter_init(IterObject *self, PyObject *args, PyObject *kwds)
{
    return -1;
}

static PyObject*
Iter_iter(IterObject *self)
{
	Py_INCREF(self);
	return (PyObject*) self;
}

static PyObject*
Iter_iternext(IterObject *self)
{
	if (self->max_count >= 0 && self->counter >= self->max_count) {
		return NULL;
	}
	self->counter++;

	return self->fetch(self);
}

static PyMethodDef Iter_methods[] = {
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_IterType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.Iter",                /*tp_name*/
    sizeof(IterObject),        /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Iter_dealloc,  /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "an iterator over a sequence of expressions",/*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    (getiterfunc) Iter_iter,   /*tp_iter */
    (iternextfunc) Iter_iternext, /*tp_iternext */
    Iter_methods,              /*tp_methods */
    0,                         /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Iter_init,       /*tp_init */
    0,                         /*tp_alloc */
    (newfunc) Iter_new,        /*tp_new */
};

typedef struct {
    PyObject_HEAD
    PGFObject* grammar;
    PgfConcr* concr;
} ConcrObject;

static ConcrObject*
Concr_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    ConcrObject* self = (ConcrObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->grammar = NULL;
		self->concr   = NULL;
    }

    return self;
}

static void
Concr_dealloc(ConcrObject* self)
{
	Py_XDECREF(self->grammar);
    Py_TYPE(self)->tp_free((PyObject*)self);
}

static int
Concr_init(ConcrObject *self, PyObject *args, PyObject *kwds)
{
    return -1;
}

static PyObject*
Concr_printName(ConcrObject* self, PyObject *args)
{
	GuString id;
    if (!PyArg_ParseTuple(args, "s", &id))
        return NULL;

	GuString name = pgf_print_name(self->concr, id);
	if (name == NULL)
		Py_RETURN_NONE;

	return PyString_FromString(name);
}

#if (    (PY_VERSION_HEX <  0x02070000) \
     || ((PY_VERSION_HEX >= 0x03000000) \
      && (PY_VERSION_HEX <  0x03010000)) )

#define PyPool_New(pool) \
		PyCObject_FromVoidPtr(pool, gu_pool_free)

#else

#define PGF_CONTAINER_NAME "pgf.Container"

static void pypgf_container_descructor(PyObject *capsule)
{
	GuPool* pool = PyCapsule_GetPointer(capsule, PGF_CONTAINER_NAME);
	gu_pool_free(pool);
}

#define PyPool_New(pool) \
		PyCapsule_New(pool, PGF_CONTAINER_NAME, \
		              pypgf_container_descructor)

#endif

typedef struct {
	PgfLiteralCallback callback;
	PyObject* pycallback;
	GuFinalizer fin;
} PyPgfLiteralCallback;

static PgfExprProb*
pypgf_literal_callback_match(PgfLiteralCallback* self, PgfConcr* concr,
                             size_t lin_idx,
                             GuString sentence, size_t* poffset,
                             GuPool *out_pool)
{
	PyPgfLiteralCallback* callback = 
		gu_container(self, PyPgfLiteralCallback, callback);

	PyObject* result =
		PyObject_CallFunction(callback->pycallback, "ii",
		                      lin_idx, *poffset);
	if (result == NULL)
		return NULL;

	if (result == Py_None) {
		Py_DECREF(result);
		return NULL;
	}

	PgfExprProb* ep = gu_new(PgfExprProb, out_pool);

	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(result, "Ofi", &pyexpr, &ep->prob, poffset))
	    return NULL;

	ep->expr = pyexpr->expr;

	{
		// This is an uggly hack. We first show the expression ep->expr
		// and then we read it back but in out_pool. The whole purpose
		// of this is to copy the expression from the temporary pool
		// that was created in the Java binding to the parser pool.
		// There should be a real copying function or even better
		// there must be a way to avoid copying at all.

		GuPool* tmp_pool = gu_local_pool();

		GuExn* err = gu_exn(tmp_pool);
		GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);

		pgf_print_expr(ep->expr, NULL, 0, out, err);

		GuIn* in = gu_data_in((uint8_t*) gu_string_buf_data(sbuf),
		                      gu_string_buf_length(sbuf),
		                      tmp_pool);

		ep->expr = pgf_read_expr(in, out_pool, err);
		if (!gu_ok(err) || gu_variant_is_null(ep->expr)) {
			PyErr_SetString(PGFError, "The expression cannot be parsed");
			gu_pool_free(tmp_pool);
			return NULL;
		}

		gu_pool_free(tmp_pool);
	}

	Py_DECREF(result);

	return ep;
}

static GuEnum*
pypgf_literal_callback_predict(PgfLiteralCallback* self, PgfConcr* concr,
	                           size_t lin_idx,
	                           GuString prefix,
	                           GuPool *out_pool)
{
	return NULL;
}

static void 
pypgf_literal_callback_fin(GuFinalizer* self)
{
	PyPgfLiteralCallback* callback = 
		gu_container(self, PyPgfLiteralCallback, fin);

	Py_XDECREF(callback->pycallback);
}

static PgfCallbacksMap*
pypgf_new_callbacks_map(PgfConcr* concr, PyObject *py_callbacks,
                        GuPool* pool)
{
	PgfCallbacksMap* callbacks =
		pgf_new_callbacks_map(concr, pool);

	if (py_callbacks == NULL)
		return callbacks;

	size_t n_callbacks = PyList_Size(py_callbacks);
	for (size_t i = 0; i < n_callbacks; i++) {
		PyObject* item =
			PyList_GetItem(py_callbacks, i);

		PyObject* pycallback = NULL;
		const char* cat = NULL;
		if (!PyArg_ParseTuple(item, "sO", &cat, &pycallback))
			return NULL;

		PyPgfLiteralCallback* callback = gu_new(PyPgfLiteralCallback, pool);
		callback->callback.match   = pypgf_literal_callback_match;
		callback->callback.predict = pypgf_literal_callback_predict;
		callback->pycallback = pycallback;
		callback->fin.fn = pypgf_literal_callback_fin;

		Py_XINCREF(callback->pycallback);
		
		gu_pool_finally(pool, &callback->fin);

		pgf_callbacks_map_add_literal(concr, callbacks,
		                              cat, &callback->callback);
	}
	
	return callbacks;
}

static PgfType*
pgf_type_from_object(PyObject* obj, GuPool* pool) {
	if (PyString_Check(obj)) {
		PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
		type->hypos   = gu_empty_seq();
		type->cid     = "";
		type->n_exprs = 0;
		return type;
	} else if (obj->ob_type == &pgf_TypeType) {
		return ((TypeObject*) obj)->type;
	} else {
		PyErr_SetString(PyExc_TypeError, "the start category should be a string or a type");
		return NULL;
	}
}

static IterObject*
Concr_parse(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"sentence", "cat", "n", "heuristics", "callbacks", NULL};

	const char *sentence = NULL;
	PyObject* start = NULL;
	int max_count = -1;
	double heuristics = -1;
	PyObject* py_callbacks = NULL;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "s|OidO!", kwlist,
                                     &sentence, &start, &max_count,
                                     &heuristics,
                                     &PyList_Type, &py_callbacks))
        return NULL;

	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		return NULL;
	}

	pyres->source = (PyObject*) self->grammar;
	Py_XINCREF(pyres->source);

	GuPool* out_pool = gu_new_pool();

	PyObject* py_pool = PyPool_New(out_pool);
	pyres->container = PyTuple_Pack(2, pyres->source, py_pool);
	Py_DECREF(py_pool);

	pyres->pool      = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_expr;

	GuExn* parse_err = gu_exn(pyres->pool);

	PgfCallbacksMap* callbacks =
		pypgf_new_callbacks_map(self->concr, py_callbacks, pyres->pool);
	if (callbacks == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	sentence = gu_string_copy(sentence, pyres->pool);

	PgfType* type;
	if (start == NULL) {
		type = pgf_start_cat(self->grammar->pgf, pyres->pool);
	} else {
		type = pgf_type_from_object(start, pyres->pool);
	}
	if (type == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	pyres->res =
		pgf_parse_with_heuristics(self->concr, type, sentence, 
		                          heuristics, callbacks, parse_err,
		                          pyres->pool, out_pool);

	if (!gu_ok(parse_err)) {
		if (gu_exn_caught(parse_err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(parse_err);
			PyErr_SetString(PGFError, msg);
		} else if (gu_exn_caught(parse_err, PgfParseError)) {
			PgfParseError* err = (PgfParseError*) gu_exn_caught_data(parse_err);
			PyObject* py_offset = PyInt_FromLong(err->offset);
			if (err->incomplete) {
	            PyObject_SetAttrString(ParseError, "incomplete",  Py_True);
	            PyObject_SetAttrString(ParseError, "offset",      py_offset);
				PyErr_Format(ParseError, "The sentence is incomplete");
			} else {
				PyObject* py_tok    = PyString_FromStringAndSize(err->token_ptr,
	                                                             err->token_len);
	            PyObject_SetAttrString(ParseError, "incomplete",  Py_False);
				PyObject_SetAttrString(ParseError, "offset",      py_offset);
				PyObject_SetAttrString(ParseError, "token",       py_tok);
#if PY_MAJOR_VERSION >= 3
				PyErr_Format(ParseError, "Unexpected token: \"%U\"", py_tok);
#else
				PyErr_Format(ParseError, "Unexpected token: \"%s\"", PyString_AsString(py_tok));
#endif
				Py_DECREF(py_tok);
			}
			Py_DECREF(py_offset);
		}

		Py_DECREF(pyres);
		pyres = NULL;
	}

	return pyres;
}

static IterObject*
Concr_complete(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"sentence", "cat", "prefix", "n", NULL};

	const char *sentence = NULL;
	PyObject* start = NULL;
	GuString prefix = "";
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "s|Osi", kwlist,
                                     &sentence, &start,
                                     &prefix, &max_count))
        return NULL;

	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		return NULL;
	}

	pyres->source = (PyObject*) self->grammar;
	Py_XINCREF(pyres->source);
	
	pyres->container = NULL;

	pyres->pool = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_token;

	GuPool *tmp_pool = gu_local_pool();

	GuExn* parse_err = gu_new_exn(tmp_pool);

	PgfType* type;
	if (start == NULL) {
		type = pgf_start_cat(self->grammar->pgf, pyres->pool);
	} else {
		type = pgf_type_from_object(start, pyres->pool);
	}
	if (type == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	pyres->res =
		pgf_complete(self->concr, type, sentence, prefix, parse_err, pyres->pool);

	if (!gu_ok(parse_err)) {
		Py_DECREF(pyres);
		pyres = NULL;

		if (gu_exn_caught(parse_err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(parse_err);
			PyErr_SetString(PGFError, msg);
		} else if (gu_exn_caught(parse_err, PgfParseError)) {
			GuString tok = (GuString) gu_exn_caught_data(parse_err);
			PyObject* py_tok = PyString_FromString(tok);
			PyObject_SetAttrString(ParseError, "token", py_tok);
			PyErr_Format(ParseError, "Unexpected token: \"%s\"", tok);
			Py_DECREF(py_tok);
		}
	}

	gu_pool_free(tmp_pool);

	return pyres;
}

static PyObject*
Concr_parseval(ConcrObject* self, PyObject *args) {
	ExprObject* pyexpr = NULL;
	PyObject* start = NULL;
	if (!PyArg_ParseTuple(args, "O!s", &pgf_ExprType, &pyexpr, &start))
        return NULL;
        
    GuPool* tmp_pool = gu_local_pool();

	double precision = 0;
	double recall = 0;
	double exact = 0;

	PgfType* type = pgf_type_from_object(start, tmp_pool);
	if (type == NULL) {
		return NULL;
	}

    if (!pgf_parseval(self->concr, pyexpr->expr, type, 
                      &precision, &recall, &exact))
		return NULL;

    gu_pool_free(tmp_pool);

    return Py_BuildValue("ddd", precision, recall, exact);
}

static IterObject*
Concr_lookupSentence(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"sentence", "cat", NULL};

	const char *sentence = NULL;
	PyObject* start = NULL;
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "s|O", kwlist,
                                     &sentence, &start, &max_count))
        return NULL;

	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		return NULL;
	}

	pyres->source = (PyObject*) self->grammar;
	Py_XINCREF(pyres->source);

	GuPool* out_pool = gu_new_pool();

	PyObject* py_pool = PyPool_New(out_pool);
	pyres->container = PyTuple_Pack(2, pyres->source, py_pool);
	Py_DECREF(py_pool);

	pyres->pool      = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_expr;

	sentence = gu_string_copy(sentence, pyres->pool);

	PgfType* type;
	if (start == NULL) {
		type = pgf_start_cat(self->grammar->pgf, pyres->pool);
	} else {
		type = pgf_type_from_object(start, pyres->pool);
	}
	if (type == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	pyres->res =
		pgf_lookup_sentence(self->concr, type, sentence,
		                          pyres->pool, out_pool);

	return pyres;
}

static PyObject*
Concr_linearize(ConcrObject* self, PyObject *args)
{
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	
	pgf_linearize(self->concr, pyexpr->expr, out, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfLinNonExist)) {
			gu_pool_free(tmp_pool);
			Py_RETURN_NONE;
		}
		else if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
			gu_pool_free(tmp_pool);
			return NULL;
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
			gu_pool_free(tmp_pool);
			return NULL;
		}
	}

	PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));

	gu_pool_free(tmp_pool);
	return pystr;
}

static PyObject*
Iter_fetch_linearization(IterObject* self)
{
	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_new_exn(tmp_pool);

restart:;
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	

	PgfCncTree ctree = gu_next(self->res, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		gu_pool_free(tmp_pool);
		return NULL;
    }
	ctree = pgf_lzr_wrap_linref(ctree, tmp_pool); // to reduce tuple of strings to a single string;

    // Linearize the concrete tree as a simple sequence of strings.
	ConcrObject* pyconcr = (ConcrObject*)self->container;
	pgf_lzr_linearize_simple(pyconcr->concr, ctree, 0, out, err, tmp_pool);

    if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfLinNonExist)) {
			// encountered nonExist. Unfortunately there
			// might be some output printed already. The
			// right solution should be to use GuStringBuf.
			gu_exn_clear(err);
			goto restart;
		}
		else if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
			gu_pool_free(tmp_pool);
			return NULL;
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
			gu_pool_free(tmp_pool);
			return NULL;
		}
    }

    PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));
    gu_pool_free(tmp_pool);
    return pystr;
}

static PyObject*
Concr_linearizeAll(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"expression", "n", NULL};
	ExprObject* pyexpr = NULL;
	int max_count = -1;
	if (!PyArg_ParseTupleAndKeywords(args, keywds, "O!|i", kwlist,
	                                 &pgf_ExprType, &pyexpr, &max_count))
		return NULL;

	GuPool* pool = gu_new_pool();
	
	GuExn* err = gu_exn(pool);
	GuEnum* cts = pgf_lzr_concretize(self->concr, pyexpr->expr, err, pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
			gu_pool_free(pool);
			return NULL;
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
			gu_pool_free(pool);
			return NULL;
		}
	}

	IterObject* pyres = (IterObject*) pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		gu_pool_free(pool);
		return NULL;
	}

	pyres->source = (PyObject*)pyexpr;
	Py_INCREF(pyres->source);
	pyres->container = (PyObject*)self;
	Py_INCREF(pyres->container);
	pyres->pool = pool;
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_linearization;
	pyres->res       = cts;

    return (PyObject*)pyres;
}

static PyObject*
Concr_tabularLinearize(ConcrObject* self, PyObject *args)
{
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	PyObject* table = PyDict_New();
	if (table == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	GuEnum* cts = 
		pgf_lzr_concretize(self->concr,
		                   pyexpr->expr,
		                   err,
		                   tmp_pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfLinNonExist))
			Py_RETURN_NONE;
		else if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
			return NULL;
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
			return NULL;
		}
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	size_t n_lins;
	GuString* labels;
	pgf_lzr_get_table(self->concr, ctree, &n_lins, &labels);

	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	for (size_t lin_idx = 0; lin_idx < n_lins; lin_idx++) {
		

		pgf_lzr_linearize_simple(self->concr, ctree, lin_idx, out, err, tmp_pool);

		PyObject* pystr = NULL;
		if (gu_ok(err)) {
			pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
			                                   gu_string_buf_length(sbuf));
		} else {
			gu_exn_clear(err);
			pystr = Py_None;
			Py_INCREF(pystr);
		}

		gu_string_buf_flush(sbuf);

		if (PyDict_SetItemString(table, labels[lin_idx], pystr) < 0)
			return NULL;

		Py_XDECREF(pystr);
	}

	gu_pool_free(tmp_pool);

	return table;
}


typedef struct {
	PyObject_HEAD
	PyObject* cat;
	int fid;
	int lindex;
	PyObject* fun;
	PyObject* children;
} BracketObject;

static void
Bracket_dealloc(BracketObject* self)
{
	Py_XDECREF(self->cat);
	Py_XDECREF(self->fun);
	Py_XDECREF(self->children);
    Py_TYPE(self)->tp_free((PyObject*)self);
}

static PyObject *
Bracket_repr(BracketObject *self)
{
	PyObject *repr =
#if PY_MAJOR_VERSION >= 3
		PyString_FromFormat("(%U:%d", self->cat, self->fid);
#else
		PyString_FromFormat("(%s:%d", PyString_AsString(self->cat), self->fid);
#endif
	if (repr == NULL) {
		return NULL;
	}

	PyObject *space = PyString_FromString(" ");

	size_t len = PyList_Size(self->children);
	for (size_t i = 0; i < len; i++) {
		PyObject *child = PyList_GetItem(self->children, i);

		PyString_Concat(&repr, space);
		if (repr == NULL) {
			Py_DECREF(space);
			return NULL;
		}

		PyObject *child_str = Py_TYPE(child)->tp_str(child);
		if (child_str == NULL) {
			Py_DECREF(repr);
			Py_DECREF(space);
			return NULL;
		}

		PyString_Concat(&repr, child_str);
		if (repr == NULL) {
			Py_DECREF(space);
			return NULL;
		}

		Py_DECREF(child_str);
	}

	Py_DECREF(space);

	PyObject *str = PyString_FromString(")");
	PyString_Concat(&repr, str);
	if (repr == NULL) {
		Py_DECREF(str);
		return NULL;
	}
	Py_DECREF(str);

	return repr;
}

static PyMemberDef Bracket_members[] = {
    {"cat", T_OBJECT_EX, offsetof(BracketObject, cat), 0,
     "the syntactic category for this bracket"},
    {"fun", T_OBJECT_EX, offsetof(BracketObject, fun), 0,
     "the abstract function for this bracket"},
    {"fid", T_INT, offsetof(BracketObject, fid), 0,
     "an id which identifies this bracket in the bracketed string. If there are discontinuous phrases this id will be shared for all brackets belonging to the same phrase."},
    {"lindex", T_INT, offsetof(BracketObject, lindex), 0,
     "the constituent index"},
    {"children", T_OBJECT_EX, offsetof(BracketObject, children), 0,
     "a list with the children of this bracket"},
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_BracketType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.Bracket",             /*tp_name*/
    sizeof(BracketObject),     /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Bracket_dealloc,/*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    (reprfunc) Bracket_repr,   /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "a linearization bracket", /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    0,                         /*tp_methods */
    Bracket_members,           /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    0,                         /*tp_init */
    0,                         /*tp_alloc */
    0,                         /*tp_new */
};

typedef struct {
	PgfLinFuncs* funcs;
	GuBuf* stack;
	PyObject* list;
} PgfBracketLznState;

static void
pgf_bracket_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	PyObject* str = PyString_FromString(tok);
	PyList_Append(state->list, str);
	Py_DECREF(str);
}

static void
pgf_bracket_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);
	
	gu_buf_push(state->stack, PyObject*, state->list);
	state->list = PyList_New(0);
}

static void
pgf_bracket_lzn_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	PyObject* parent = gu_buf_pop(state->stack, PyObject*);

	if (PyList_Size(state->list) > 0) {
		BracketObject* bracket = (BracketObject *)
			pgf_BracketType.tp_alloc(&pgf_BracketType, 0);
		if (bracket != NULL) {
			bracket->cat = PyString_FromString(cat);
			bracket->fid = fid;
			bracket->lindex = lindex;
			bracket->fun = PyString_FromString(fun);
			bracket->children = state->list;
			PyList_Append(parent, (PyObject*) bracket);
			Py_DECREF(bracket);
		}
	} else {
		Py_DECREF(state->list);
	}

	state->list = parent;
}

static void
pgf_bracket_lzn_symbol_meta(PgfLinFuncs** funcs, PgfMetaId meta_id)
{
	pgf_bracket_lzn_symbol_token(funcs, "?");
}

static PgfLinFuncs pgf_bracket_lin_funcs = {
	.symbol_token  = pgf_bracket_lzn_symbol_token,
	.begin_phrase  = pgf_bracket_lzn_begin_phrase,
	.end_phrase    = pgf_bracket_lzn_end_phrase,
	.symbol_ne     = NULL,
	.symbol_bind   = NULL,
	.symbol_capit  = NULL,
	.symbol_meta   = pgf_bracket_lzn_symbol_meta
};

static PyObject*
Concr_bracketedLinearize(ConcrObject* self, PyObject *args)
{
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	
	GuEnum* cts = 
		pgf_lzr_concretize(self->concr, pyexpr->expr, err, tmp_pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
			return NULL;
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be concretized");
		}
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		PyErr_SetString(PGFError, "The abstract tree cannot be concretized");
		gu_pool_free(tmp_pool);
		return NULL;
	}
	
	PyObject* list = PyList_New(0);

	ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);

	PgfBracketLznState state;
	state.funcs = &pgf_bracket_lin_funcs;
	state.stack = gu_new_buf(PyObject*, tmp_pool);
	state.list  = list;
	pgf_lzr_linearize(self->concr, ctree, 0, &state.funcs, tmp_pool);

	gu_pool_free(tmp_pool);

	return list;
}

static PyObject*
Iter_fetch_bracketedLinearization(IterObject* self)
{
    GuPool* tmp_pool = gu_local_pool();
    GuExn* err = gu_exn(tmp_pool);

restart:;

    PgfCncTree ctree = gu_next(self->res, PgfCncTree, tmp_pool); 
    if (gu_variant_is_null(ctree)) {
	gu_pool_free(tmp_pool);
	return NULL;
    }

    PyObject* list = PyList_New(0);
    ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);

    ConcrObject* pyconcr = (ConcrObject*) self->container; 

    PgfBracketLznState state;
    state.funcs = &pgf_bracket_lin_funcs;
    state.stack = gu_new_buf(PyObject*, tmp_pool);
    state.list  = list;
    pgf_lzr_linearize(pyconcr->concr, ctree, 0, &state.funcs, tmp_pool);

    if (!gu_ok(err)) {
	if (gu_exn_caught(err, PgfLinNonExist)) {
	    // encountered nonExist. Unfortunately there
	    // might be some output printed already. The
	    // right solution should be to use GuStringBuf.
	    gu_exn_clear(err);
	    goto restart;
	}
	else if (gu_exn_caught(err, PgfExn)) {
	    GuString msg = (GuString) gu_exn_caught_data(err);
	    PyErr_SetString(PGFError, msg);
	    gu_pool_free(tmp_pool);
	    return NULL;
	} else {
	    PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
	    gu_pool_free(tmp_pool);
	    return NULL;
	}
    }

    gu_pool_free(tmp_pool);
    return list;
}
    
static PyObject*
Concr_bracketedLinearizeAll(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"expression", "n", NULL};
	ExprObject* pyexpr = NULL;
	int max_count = -1;

	if (!PyArg_ParseTupleAndKeywords(args, keywds, "O!|i", kwlist,
	                                 &pgf_ExprType, &pyexpr, &max_count))
		return NULL;

	GuPool* pool = gu_new_pool();
	GuExn* err = gu_exn(pool);
	
	GuEnum* cts = 
		pgf_lzr_concretize(self->concr, pyexpr->expr, err, pool);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
		} else {
			PyErr_SetString(PGFError, "The abstract tree cannot be concretized");
		}
		return NULL;
	}

	IterObject* pyres = (IterObject*) pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		gu_pool_free(pool);
		return NULL;
	}

	pyres->source = (PyObject*)pyexpr;
	Py_INCREF(pyres->source);
	pyres->container = (PyObject*)self;
	Py_INCREF(pyres->container);
	pyres->pool = pool;
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_bracketedLinearization;
	pyres->res       = cts;

	return (PyObject*)pyres;
}

static PyObject*
Concr_hasLinearization(ConcrObject* self, PyObject *args)
{
	PgfCId id;
	if (!PyArg_ParseTuple(args, "s", &id))
        return NULL;

	if (pgf_has_linearization(self->concr, id))
		Py_RETURN_TRUE;
	else
		Py_RETURN_FALSE;
}

static PyObject*
Concr_getName(ConcrObject *self, void *closure)
{
    return PyString_FromString(pgf_concrete_name(self->concr));
}

static PyObject*
Concr_getLanguageCode(ConcrObject *self, void *closure)
{
    return PyString_FromString(pgf_language_code(self->concr));
}

static PyObject*
Concr_graphvizParseTree(ConcrObject* self, PyObject *args) {
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	
	pgf_graphviz_parse_tree(self->concr, pyexpr->expr, pgf_default_graphviz_options, out, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
		} else {
			PyErr_SetString(PGFError, "The parse tree cannot be visualized");
		}
		return NULL;
	}

	PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));

	gu_pool_free(tmp_pool);
	return pystr;
}

typedef struct {
	PgfMorphoCallback fn;
	PyObject* analyses;
} PyMorphoCallback;

static void
pypgf_collect_morpho(PgfMorphoCallback* self,
	                 PgfCId lemma, GuString analysis, prob_t prob,
	                 GuExn* err)
{
	PyMorphoCallback* callback = (PyMorphoCallback*) self;

	PyObject* py_lemma = PyString_FromString(lemma);
	PyObject* py_analysis = PyString_FromString(analysis);
	PyObject* res = 
		Py_BuildValue("OOf", py_lemma, py_analysis, prob);

    if (PyList_Append(callback->analyses, res) != 0) {
		gu_raise(err, PgfExn);
	}
	
	Py_DECREF(py_lemma);
	Py_DECREF(py_analysis);
	Py_DECREF(res);
}

static PyObject*
Concr_lookupMorpho(ConcrObject* self, PyObject *args) {
	GuString sent;
    if (!PyArg_ParseTuple(args, "s", &sent))
        return NULL;

	GuPool *tmp_pool = gu_local_pool();
	GuExn* err = gu_exn(tmp_pool);

	PyObject* analyses = PyList_New(0);

	PyMorphoCallback callback = { { pypgf_collect_morpho }, analyses };
	pgf_lookup_morpho(self->concr, sent, &callback.fn, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
		} else {
			PyErr_SetString(PGFError, "The lookup failed");
		}
		Py_DECREF(analyses);
		analyses = NULL;
	}

	gu_pool_free(tmp_pool);

    return analyses;
}

static PyObject*
Iter_fetch_fullform(IterObject* self)
{
	PgfFullFormEntry* entry = 
		gu_next(self->res, PgfFullFormEntry*, self->pool);
	if (entry == NULL)
		return NULL;

	PyObject* res = NULL;
	PyObject* py_tokens = NULL;
	PyObject* py_analyses = NULL;

	GuString tokens =
		pgf_fullform_get_string(entry);
		
	py_tokens = PyString_FromString(tokens);
	if (py_tokens == NULL)
		goto done;

	py_analyses = PyList_New(0);
	if (py_analyses == NULL)
		goto done;

	GuPool* tmp_pool = gu_local_pool();
    GuExn* err = gu_new_exn(tmp_pool);

	PyMorphoCallback callback = { { pypgf_collect_morpho }, py_analyses };
	pgf_fullform_get_analyses(entry, &callback.fn, err);
	
	if (!gu_ok(err))
		goto done;

	res = Py_BuildValue("OO", py_tokens, py_analyses);

done:
	Py_XDECREF(py_tokens);
	Py_XDECREF(py_analyses);

	return res;
}

static PyObject*
Concr_fullFormLexicon(ConcrObject* self, PyObject *args)
{
	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL)
		return NULL;

	pyres->source = (PyObject*) self->grammar;
	Py_XINCREF(pyres->source);

	pyres->container = NULL;
	pyres->pool      = gu_new_pool();
	pyres->max_count = -1;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_fullform;

	pyres->res = pgf_fullform_lexicon(self->concr, pyres->pool);
	if (pyres->res == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	return (PyObject*) pyres;
}

static PyObject*
Concr_load(ConcrObject* self, PyObject *args)
{
    const char *fpath;
    if (!PyArg_ParseTuple(args, "s", &fpath))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	FILE* infile = fopen(fpath, "rb");
	if (infile == NULL) {
		PyErr_SetFromErrnoWithFilename(PyExc_IOError, fpath);
		return NULL;
	}

	// Create an input stream from the input file
	GuIn* in = gu_file_in(infile, tmp_pool);

	// Read the PGF grammar.
	pgf_concrete_load(self->concr, in, err);
	if (!gu_ok(err)) {
		fclose(infile);
		if (gu_exn_caught(err, GuErrno)) {
			errno = *((GuErrno*) gu_exn_caught_data(err));
			PyErr_SetFromErrnoWithFilename(PyExc_IOError, fpath);
		} else if (gu_exn_caught(err, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(err);
			PyErr_SetString(PGFError, msg);
		} else {
			PyErr_SetString(PGFError, "The language cannot be loaded");
		}
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	fclose(infile);

	Py_RETURN_NONE;
}

static PyObject*
Concr_unload(ConcrObject* self, PyObject *args)
{
	if (!PyArg_ParseTuple(args, ""))
        return NULL;

	pgf_concrete_unload(self->concr);

	Py_RETURN_NONE;
}

static PyGetSetDef Concr_getseters[] = {
    {"name", 
     (getter)Concr_getName, NULL,
     "the name of the concrete syntax",
    },
    {"languageCode", 
     (getter)Concr_getLanguageCode, NULL,
     "the language code for this concrete syntax",
    },
    {NULL}  /* Sentinel */
};

static PyMethodDef Concr_methods[] = {
    {"printName", (PyCFunction)Concr_printName, METH_VARARGS,
     "Returns the print name of a function or category"
    },
    {"parse", (PyCFunction)Concr_parse, METH_VARARGS | METH_KEYWORDS,
     "Parses a string and returns an iterator over the abstract trees for this sentence\n\n"
     "Named arguments:\n"
     "- sentence (string) or tokens (list of strings)\n"
     "- cat (string); OPTIONAL, default: the startcat of the grammar\n"
     "- n (int), max. trees; OPTIONAL, default: extract all trees\n"
     "- heuristics (double >= 0.0); OPTIONAL, default: taken from the flags in the grammar\n"
     "- callbacks (list of category and callback); OPTIONAL, default: built-in callbacks only for Int, String and Float"
    },
    {"complete", (PyCFunction)Concr_complete, METH_VARARGS | METH_KEYWORDS,
     "Parses a partial string and returns a list with the top n possible next tokens"
    },
    {"parseval", (PyCFunction)Concr_parseval, METH_VARARGS,
     "Computes precision, recall and exact match for the parser on a given abstract tree"
    },
    {"lookupSentence", (PyCFunction)Concr_lookupSentence, METH_VARARGS | METH_KEYWORDS,
     "Looks up a sentence from the grammar by a sequence of keywords\n\n"
     "Named arguments:\n"
     "- sentence (string) or tokens (list of strings)\n"
     "- cat (string); OPTIONAL, default: the startcat of the grammar\n"
     "- n (int), max. trees; OPTIONAL, default: extract all trees"
    },
    {"linearize", (PyCFunction)Concr_linearize, METH_VARARGS,
     "Takes an abstract tree and linearizes it to a string"
    },
    {"linearizeAll", (PyCFunction)Concr_linearizeAll, METH_VARARGS | METH_KEYWORDS,
     "Takes an abstract tree and linearizes with all variants"
    },
    {"tabularLinearize", (PyCFunction)Concr_tabularLinearize, METH_VARARGS,
     "Takes an abstract tree and linearizes it to a table containing all fields"
	},
    {"bracketedLinearize", (PyCFunction)Concr_bracketedLinearize, METH_VARARGS,
     "Takes an abstract tree and linearizes it to a bracketed string"
    },
    {"bracketedLinearizeAll", (PyCFunction)Concr_bracketedLinearizeAll, METH_VARARGS | METH_KEYWORDS,
     "Takes an abstract tree and linearizes all variants into bracketed strings"
    },
    {"hasLinearization", (PyCFunction)Concr_hasLinearization, METH_VARARGS,
     "hasLinearization(f) returns true if the function f has linearization in the concrete syntax"
    },
    {"graphvizParseTree", (PyCFunction)Concr_graphvizParseTree, METH_VARARGS,
     "Renders an abstract syntax tree as a parse tree in Graphviz format"
    },
    {"lookupMorpho", (PyCFunction)Concr_lookupMorpho, METH_VARARGS,
     "Looks up a word in the lexicon of the grammar"
    },
    {"fullFormLexicon", (PyCFunction)Concr_fullFormLexicon, METH_VARARGS,
     "Enumerates all words in the lexicon (useful for extracting full form lexicons)"
    },
    {"load", (PyCFunction)Concr_load, METH_VARARGS,
     "Loads the concrete syntax from a .pgf_c file"
    },
    {"unload", (PyCFunction)Concr_unload, METH_VARARGS,
     "Unloads the concrete syntax"
    },
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_ConcrType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.Concr",               /*tp_name*/
    sizeof(ConcrObject),       /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Concr_dealloc, /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "concrete syntax",         /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Concr_methods,             /*tp_methods */
    0,                         /*tp_members */
    Concr_getseters,           /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Concr_init,      /*tp_init */
    0,                         /*tp_alloc */
    (newfunc)Concr_new,        /*tp_new */
};

static void
PGF_dealloc(PGFObject* self)
{
	if (self->pool != NULL)
		gu_pool_free(self->pool);
    Py_TYPE(self)->tp_free((PyObject*)self);
}

static PyObject*
PGF_getAbstractName(PGFObject *self, void *closure)
{
    return PyString_FromString(pgf_abstract_name(self->pgf));
}

typedef struct {
	GuMapItor fn;
	PGFObject* grammar;
	PyObject* object;
} PyPGFClosure;

static void
pgf_collect_langs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    PgfConcr* concr = *((PgfConcr**) value);
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    PyObject* py_lang = NULL;
    
	py_name = PyString_FromString(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

	py_lang = pgf_ConcrType.tp_alloc(&pgf_ConcrType, 0);
	if (py_lang == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

	((ConcrObject *) py_lang)->concr = concr;
	((ConcrObject *) py_lang)->grammar = clo->grammar;
	Py_INCREF(clo->grammar);

    if (PyDict_SetItem(clo->object, py_name, py_lang) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_lang);
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getLanguages(PGFObject *self, void *closure)
{
	PyObject* languages = PyDict_New();
	if (languages == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	PyPGFClosure clo = { { pgf_collect_langs }, self, languages };
	pgf_iter_languages(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(languages);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	PyObject* proxy = PyDictProxy_New(languages);
	
	Py_DECREF(languages);
	gu_pool_free(tmp_pool);

    return proxy;
}

static void
pgf_collect_cats(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    
	py_name = PyString_FromString(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

    if (PyList_Append(clo->object, py_name) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getCategories(PGFObject *self, void *closure)
{
	PyObject* categories = PyList_New(0);
	if (categories == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	PyPGFClosure clo = { { pgf_collect_cats }, self, categories };
	pgf_iter_categories(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(categories);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return categories;
}

static TypeObject*
PGF_getStartCat(PGFObject *self, void *closure)
{
	TypeObject* pytype = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
	if (pytype == NULL)
		return NULL;

	pytype->pool = gu_new_pool();
	pytype->type = pgf_start_cat(self->pgf, pytype->pool);
	pytype->master = NULL;

	if (pytype->type == NULL) {
		PyErr_SetString(PGFError, "The start category cannot be found");
		Py_DECREF(pytype);
		return NULL;
	}

    return pytype;
}

static void
pgf_collect_funs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = (PgfCId) key;
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    
	py_name = PyString_FromString(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

    if (PyList_Append(clo->object, py_name) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getFunctions(PGFObject *self, void *closure)
{
	PyObject* functions = PyList_New(0);
	if (functions == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	PyPGFClosure clo = { { pgf_collect_funs }, self, functions };
	pgf_iter_functions(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return functions;
}

static PyObject*
PGF_functionsByCat(PGFObject* self, PyObject *args)
{
	PgfCId catname;
    if (!PyArg_ParseTuple(args, "s", &catname))
        return NULL;

	PyObject* functions = PyList_New(0);
	if (functions == NULL) {
		return NULL;
	}

	GuPool *tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	PyPGFClosure clo = { { pgf_collect_funs }, self, functions };
	pgf_iter_functions_by_cat(self->pgf, catname, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return functions;
}

static TypeObject*
PGF_functionType(PGFObject* self, PyObject *args)
{
	PgfCId funname;
    if (!PyArg_ParseTuple(args, "s", &funname))
        return NULL;

    PgfType* type =
		pgf_function_type(self->pgf, funname);
	if (type == NULL) {
		PyErr_Format(PyExc_KeyError, "Function '%s' is not defined", funname);
		return NULL;
	}

	TypeObject* pytype = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
	if (pytype == NULL)
		return NULL;
	pytype->pool   = NULL;
	pytype->type   = type;
	pytype->master = (PyObject*) self;
	Py_XINCREF(self);

    return pytype;
}

static IterObject*
PGF_generateAll(PGFObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"cat", "n", NULL};

	PyObject* start = NULL;
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "O|i", kwlist,
                                     &start, &max_count))
        return NULL;

	IterObject* pyres = (IterObject*)
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		return NULL;
	}

	pyres->source = (PyObject*) self;
	Py_INCREF(self);

	GuPool* out_pool = gu_new_pool();

	PyObject* py_pool = PyPool_New(out_pool);
	pyres->container = PyTuple_Pack(2, pyres->source, py_pool);
	Py_DECREF(py_pool);

	pyres->pool = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_expr;

	GuExn* err = gu_exn(pyres->pool);

	PgfType* type = pgf_type_from_object(start, pyres->pool);
	if (type == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	pyres->res =
		pgf_generate_all(self->pgf, type, err, pyres->pool, out_pool);
	if (pyres->res == NULL) {
		Py_DECREF(pyres);
		return NULL;
	}

	return pyres;
}

static ExprObject*
PGF_compute(PGFObject* self, PyObject *args)
{
	ExprObject* py_expr = NULL;
    if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &py_expr))
		return NULL;

	ExprObject* py_expr_res = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (py_expr_res == NULL)
		return NULL;

	GuPool* tmp_pool = gu_new_pool();
	GuExn* err = gu_new_exn(tmp_pool);

	py_expr_res->pool = gu_new_pool();
	py_expr_res->expr = pgf_compute(self->pgf, py_expr->expr, err, 
	                                tmp_pool, py_expr_res->pool);
	py_expr_res->master = (PyObject*) self;
	Py_INCREF(py_expr_res->master);

	if (!gu_ok(err)) {
		GuString msg = (GuString) gu_exn_caught_data(err);
		PyErr_SetString(PGFError, msg);

		Py_DECREF(py_expr_res);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
	return py_expr_res;
}

static ExprObject*
PGF_checkExpr(PGFObject* self, PyObject *args)
{
	ExprObject* py_expr = NULL;
	TypeObject* py_type = NULL;
    if (!PyArg_ParseTuple(args, "O!O!", &pgf_ExprType, &py_expr, &pgf_TypeType, &py_type))
		return NULL;

	ExprObject* new_pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (new_pyexpr == NULL)
		return NULL;

	new_pyexpr->pool = gu_new_pool();
	new_pyexpr->expr = py_expr->expr;
	new_pyexpr->master = NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* exn = gu_new_exn(tmp_pool);

	pgf_check_expr(self->pgf, &new_pyexpr->expr, py_type->type,
	               exn, new_pyexpr->pool);
	if (!gu_ok(exn)) {
		if (gu_exn_caught(exn, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(PGFError, msg);
		} else if (gu_exn_caught(exn, PgfTypeError)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(TypeError, msg);
		}

		Py_DECREF(new_pyexpr);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return new_pyexpr;
}

static PyObject*
PGF_inferExpr(PGFObject* self, PyObject *args)
{
	ExprObject* py_expr = NULL;
    if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &py_expr))
		return NULL;

	ExprObject* new_pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (new_pyexpr == NULL)
		return NULL;

	new_pyexpr->pool = gu_new_pool();
	new_pyexpr->expr = py_expr->expr;
	new_pyexpr->master = NULL;

	TypeObject* new_pytype = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
	if (new_pytype == NULL) {
		Py_DECREF(new_pyexpr);
		return NULL;
	}

	new_pytype->pool = NULL;
	new_pytype->type = NULL;
	new_pytype->master = (PyObject*) new_pyexpr;
	Py_INCREF(new_pyexpr);

	GuPool* tmp_pool = gu_local_pool();
	GuExn* exn = gu_new_exn(tmp_pool);

	new_pytype->type =
		pgf_infer_expr(self->pgf, &new_pyexpr->expr,
		               exn, new_pyexpr->pool);
	if (!gu_ok(exn)) {
		if (gu_exn_caught(exn, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(PGFError, msg);
		} else if (gu_exn_caught(exn, PgfTypeError)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(TypeError, msg);
		}

		Py_DECREF(new_pyexpr);
		Py_DECREF(new_pytype);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	PyObject* res =
		Py_BuildValue("OO", new_pyexpr, new_pytype);

	Py_DECREF(new_pyexpr);
	Py_DECREF(new_pytype);

	return res;
}

static TypeObject*
PGF_checkType(PGFObject* self, PyObject *args)
{
	TypeObject* py_type = NULL;
    if (!PyArg_ParseTuple(args, "O!", &pgf_TypeType, &py_type))
		return NULL;

	TypeObject* new_pytype = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
	if (new_pytype == NULL) {
		return NULL;
	}

	new_pytype->pool   = gu_new_pool();
	new_pytype->type   = py_type->type;
	new_pytype->master = NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* exn = gu_new_exn(tmp_pool);

	pgf_check_type(self->pgf, &new_pytype->type,
	               exn, new_pytype->pool);
	if (!gu_ok(exn)) {
		if (gu_exn_caught(exn, PgfExn)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(PGFError, msg);
		} else if (gu_exn_caught(exn, PgfTypeError)) {
			GuString msg = (GuString) gu_exn_caught_data(exn);
			PyErr_SetString(TypeError, msg);
		}

		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return new_pytype;
}

static PyObject*
PGF_graphvizAbstractTree(PGFObject* self, PyObject *args) {
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_new_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	
	pgf_graphviz_abstract_tree(self->pgf, pyexpr->expr, pgf_default_graphviz_options, out, err);
	if (!gu_ok(err)) {
		PyErr_SetString(PGFError, "The abstract tree cannot be visualized");
		return NULL;
	}

	PyObject* pystr = PyString_FromStringAndSize(gu_string_buf_data(sbuf),
	                                             gu_string_buf_length(sbuf));

	gu_pool_free(tmp_pool);
	return pystr;
}

static void
pgf_embed_funs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PyPGFClosure* clo = (PyPGFClosure*) fn;
	
	PgfCId name = (PgfCId) key;

	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL) {
		gu_raise(err, PgfExn);
		return;
	}

	pyexpr->master = (PyObject*) clo->grammar;
	pyexpr->expr   = pgf_fun_get_ep(value)->expr;

	Py_INCREF(pyexpr->master);

    if (PyModule_AddObject(clo->object, name, (PyObject*) pyexpr) != 0) {
		Py_DECREF(pyexpr);
		gu_raise(err, PgfExn);
	}
}

static PyObject*
PGF_embed(PGFObject* self, PyObject *args)
{
	PgfCId modname;
    if (!PyArg_ParseTuple(args, "s", &modname))
        return NULL;

    PyObject *m = PyImport_AddModule(modname);
    if (m == NULL)
        return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	PyPGFClosure clo = { { pgf_embed_funs }, self, m };
	pgf_iter_functions(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(m);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
	
	Py_INCREF(m);
    return m;
}

static PyGetSetDef PGF_getseters[] = {
    {"abstractName", 
     (getter)PGF_getAbstractName, NULL,
     "the abstract syntax name",
     NULL},
    {"languages", 
     (getter)PGF_getLanguages, NULL,
     "a map containing all concrete languages in the grammar",
     NULL},
    {"categories", 
     (getter)PGF_getCategories, NULL,
     "a list containing all categories in the grammar",
     NULL},
    {"startCat", 
     (getter)PGF_getStartCat, NULL,
     "the start category for the grammar",
     NULL},
    {"functions", 
     (getter)PGF_getFunctions, NULL,
     "a list containing all functions in the grammar",
     NULL},
    {NULL}  /* Sentinel */
};

static PyMemberDef PGF_members[] = {
    {NULL}  /* Sentinel */
};

static PyMethodDef PGF_methods[] = {
    {"functionsByCat", (PyCFunction)PGF_functionsByCat, METH_VARARGS,
     "Returns the list of functions for a given category"
    },
    {"functionType", (PyCFunction)PGF_functionType, METH_VARARGS,
     "Returns the type of a function"
    },
    {"generateAll", (PyCFunction)PGF_generateAll, METH_VARARGS | METH_KEYWORDS,
     "Generates abstract syntax trees of given category in decreasing probability order"
    },
    {"compute", (PyCFunction)PGF_compute, METH_VARARGS,
     "Computes the normal form of an abstract syntax tree"
    },
    {"checkExpr", (PyCFunction)PGF_checkExpr, METH_VARARGS,
     "Type checks an abstract syntax expression and returns the updated expression"
    },
    {"inferExpr", (PyCFunction)PGF_inferExpr, METH_VARARGS,
     "Type checks an abstract syntax expression and returns the updated expression"
    },
    {"checkType", (PyCFunction)PGF_checkType, METH_VARARGS,
     "Type checks an abstract syntax type and returns the updated type"
    },
    {"graphvizAbstractTree", (PyCFunction)PGF_graphvizAbstractTree, METH_VARARGS,
     "Renders an abstract syntax tree in a Graphviz format"
    },
    {"embed", (PyCFunction)PGF_embed, METH_VARARGS,
     "embed(mod_name) creates a Python module with name mod_name, which "
     "contains one Python object for every abstract function in the grammar. "
     "The module can be imported to make it easier to construct abstract "
     "syntax trees."
    },
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_PGFType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    //0,                         /*ob_size*/
    "pgf.PGF",                 /*tp_name*/
    sizeof(PGFObject),         /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)PGF_dealloc,   /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "PGF object",              /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    PGF_methods,               /*tp_methods */
    PGF_members,               /*tp_members */
    PGF_getseters,             /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    0,                         /*tp_init */
    0,                         /*tp_alloc */
    0,                         /*tp_new */
};

static PGFObject*
pgf_readPGF(PyObject *self, PyObject *args)
{
    const char *fpath;
    if (!PyArg_ParseTuple(args, "s", &fpath))
        return NULL;

	PGFObject* py_pgf = (PGFObject*) pgf_PGFType.tp_alloc(&pgf_PGFType, 0);
	py_pgf->pool = gu_new_pool();

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(tmp_pool);

	// Read the PGF grammar.
	py_pgf->pgf = pgf_read(fpath, py_pgf->pool, err);
	if (!gu_ok(err)) {
		if (gu_exn_caught(err, GuErrno)) {
			errno = *((GuErrno*) gu_exn_caught_data(err));
			PyErr_SetFromErrnoWithFilename(PyExc_IOError, fpath);
		} else {
			PyErr_SetString(PGFError, "The grammar cannot be loaded");
		}
		Py_DECREF(py_pgf);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
	return py_pgf;
}

static ExprObject*
pgf_readExpr(PyObject *self, PyObject *args) {
	Py_ssize_t len;
    const uint8_t *buf;
    if (!PyArg_ParseTuple(args, "s#", &buf, &len))
        return NULL;

	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuIn* in = gu_data_in(buf, len, tmp_pool);
	GuExn* err = gu_new_exn(tmp_pool);

	pyexpr->pool = gu_new_pool();
	pyexpr->expr = pgf_read_expr(in, pyexpr->pool, err);
	pyexpr->master = NULL;
	
	if (!gu_ok(err) || gu_variant_is_null(pyexpr->expr)) {
		PyErr_SetString(PGFError, "The expression cannot be parsed");
		Py_DECREF(pyexpr);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return pyexpr;
}

static TypeObject*
pgf_readType(PyObject *self, PyObject *args) {
	Py_ssize_t len;
    const uint8_t *buf;
    if (!PyArg_ParseTuple(args, "s#", &buf, &len))
        return NULL;

	TypeObject* pytype = (TypeObject*) pgf_TypeType.tp_alloc(&pgf_TypeType, 0);
	if (pytype == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuIn* in = gu_data_in(buf, len, tmp_pool);
	GuExn* err = gu_new_exn(tmp_pool);

	pytype->pool = gu_new_pool();
	pytype->type = pgf_read_type(in, pytype->pool, err);
	pytype->master = NULL;

	if (!gu_ok(err) || pytype->type == NULL) {
		PyErr_SetString(PGFError, "The type cannot be parsed");
		Py_DECREF(pytype);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return pytype;
}

static PyMethodDef module_methods[] = {
    {"readPGF",  (void*)pgf_readPGF,  METH_VARARGS,
     "Reads a PGF file in memory"},
    {"readExpr", (void*)pgf_readExpr, METH_VARARGS,
     "Parses a string as an abstract tree"},
    {"readType", (void*)pgf_readType, METH_VARARGS,
     "Parses a string as an abstract type"},
    {NULL, NULL, 0, NULL}        /* Sentinel */
};

#if PY_MAJOR_VERSION >= 3
  #define MOD_ERROR_VAL NULL
  #define MOD_SUCCESS_VAL(val) val
  #define MOD_INIT(name) PyMODINIT_FUNC PyInit_##name(void)
  #define MOD_DEF(ob, name, doc, methods) \
	          static struct PyModuleDef moduledef = { \
				              PyModuleDef_HEAD_INIT, name, doc, -1, methods, }; \
          ob = PyModule_Create(&moduledef);
#else
  #define MOD_ERROR_VAL
  #define MOD_SUCCESS_VAL(val)
  #define MOD_INIT(name) void init##name(void)
  #define MOD_DEF(ob, name, doc, methods) \
	          ob = Py_InitModule3(name, methods, doc);
#endif

MOD_INIT(pgf)
{
    PyObject *m;

    if (PyType_Ready(&pgf_PGFType) < 0)
        return MOD_ERROR_VAL;

    if (PyType_Ready(&pgf_ConcrType) < 0)
        return MOD_ERROR_VAL;

    if (PyType_Ready(&pgf_BracketType) < 0)
        return MOD_ERROR_VAL;

    if (PyType_Ready(&pgf_ExprType) < 0)
        return MOD_ERROR_VAL;

    if (PyType_Ready(&pgf_TypeType) < 0)
        return MOD_ERROR_VAL;

	if (PyType_Ready(&pgf_IterType) < 0)
		return MOD_ERROR_VAL;

	MOD_DEF(m, "pgf", "The Runtime for Portable Grammar Format in Python",
	        module_methods);
    if (m == NULL)
        return MOD_ERROR_VAL;
        
    PGFError = PyErr_NewException("pgf.PGFError", NULL, NULL);
    PyModule_AddObject(m, "PGFError", PGFError);
    Py_INCREF(PGFError);
    
    PyObject *dict = PyDict_New();
    PyDict_SetItemString(dict, "token", PyString_FromString("")); 
    ParseError = PyErr_NewException("pgf.ParseError", NULL, dict);
    PyModule_AddObject(m, "ParseError", ParseError);
    Py_INCREF(ParseError);

    TypeError = PyErr_NewException("pgf.TypeError", NULL, NULL);
    PyModule_AddObject(m, "TypeError", TypeError);
    Py_INCREF(TypeError);

    PyModule_AddObject(m, "Expr", (PyObject *) &pgf_ExprType);
    Py_INCREF(&pgf_ExprType);

    PyModule_AddObject(m, "Type", (PyObject *) &pgf_TypeType);
    Py_INCREF(&pgf_TypeType);

    Py_INCREF(&pgf_PGFType);
    Py_INCREF(&pgf_ConcrType);
    Py_INCREF(&pgf_IterType);
    Py_INCREF(&pgf_BracketType);

	return MOD_SUCCESS_VAL(m);
}
