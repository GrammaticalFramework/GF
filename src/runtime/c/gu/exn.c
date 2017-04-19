#include <gu/exn.h>
#include <gu/assert.h>


GU_API GuExn*
gu_new_exn(GuPool* pool)
{
	GuExn* exn = gu_new(GuExn, pool);
	exn->state = GU_EXN_OK;
	exn->caught = NULL;
	exn->data.pool = pool;
	exn->data.data = NULL;
	return exn;
}

GU_API bool
gu_exn_is_raised(GuExn* err) {
	return err && (err->state == GU_EXN_RAISED);
}

GU_API bool
gu_exn_caught_(GuExn* err, const char* type)
{
	return (err->caught && strcmp(err->caught, type) == 0);
}

GU_API void
gu_exn_block(GuExn* err)
{
	if (err && err->state == GU_EXN_RAISED) {
		err->state = GU_EXN_BLOCKED;
	}
}

GU_API void
gu_exn_unblock(GuExn* err)
{
	if (err && err->state == GU_EXN_BLOCKED) {
		err->state = GU_EXN_RAISED;
	}
}

GU_API GuExnData*
gu_exn_raise_debug_(GuExn* err, const char* type, 
		            const char* filename, const char* func, int lineno)
{
	gu_require(type);

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

GU_API GuExnData*
gu_exn_raise_(GuExn* base, const char* type)
{
	return gu_exn_raise_debug_(base, type, NULL, NULL, -1);
}

GU_API void
gu_raise_errno(GuExn* err)
{
	GuExnData* err_data = gu_raise(err, GuErrno);
	if (err_data) {
		GuErrno* gu_errno = gu_new(GuErrno, err_data->pool);
		*gu_errno = errno;
		err_data->data = gu_errno;
	}
}
