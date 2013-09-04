#include <gu/exn.h>
#include <gu/assert.h>


GuExn*
gu_new_exn(GuExn* parent, GuKind* catch, GuPool* pool)
{
	GuExn* exn = gu_new(GuExn, pool);
	exn->state = GU_EXN_OK;
	exn->parent = parent;
	exn->catch = catch;
	exn->caught = NULL;
	exn->data.pool = pool;
	exn->data.data = NULL;
	return exn;
}

void
gu_exn_block(GuExn* err)
{
	if (err && err->state == GU_EXN_RAISED) {
		err->state = GU_EXN_BLOCKED;
	}
}

void
gu_exn_unblock(GuExn* err)
{
	if (err && err->state == GU_EXN_BLOCKED) {
		err->state = GU_EXN_RAISED;
	}
}

GuExnData*
gu_exn_raise_debug_(GuExn* base, GuType* type, 
		      const char* filename, const char* func, int lineno)
{
	gu_require(type);

	// TODO: log the error, once there's a system for dumping
	// error objects.

	GuExn* err = base;
	
	while (err && !(err->catch && gu_type_has_kind(type, err->catch))) {
		err->state = GU_EXN_RAISED;
		err = err->parent;
	}
	if (!err) {
		gu_abort_(GU_ASSERT_ASSERTION, filename, func, lineno,
			  "Unexpected error raised");
	}
	GuExnState old_state = err->state;
	err->state = GU_EXN_RAISED;
	if (old_state == GU_EXN_OK) {
		err->caught = type;
		if (err->data.pool) {
			return &err->data;
		}
	}
	// Exceptian had already been raised, possibly blocked, or no
	// exception value is required.
	return NULL;
}

GuExnData*
gu_exn_raise_(GuExn* base, GuType* type)
{
	return gu_exn_raise_debug_(base, type, NULL, NULL, -1);
}

GuType*
gu_exn_caught(GuExn* err)
{
	return err->caught;
}

void
gu_raise_errno(GuExn* err)
{
	GuExnData* err_data = gu_raise(err, GuErrno);
	if (err_data) {
		GuErrno* gu_errno = gu_new(GuErrno, err_data->pool);
		*gu_errno = errno;
		err_data->data = gu_errno;
	}
}

GU_DEFINE_TYPE(GuErrno, signed, _);
