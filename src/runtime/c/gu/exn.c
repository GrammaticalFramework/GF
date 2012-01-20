#include <gu/exn.h>
#include <gu/assert.h>


GuExn*
gu_new_exn(GuExn* parent, GuKind* catch, GuPool* pool)
{
	return gu_new_s(pool, GuExn,
			.state = GU_EXN_OK,
			.parent = parent,
			.catch = catch,
			.caught = NULL,
			.data.pool = pool,
			.data.data = NULL);
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


GU_DEFINE_TYPE(GuErrno, signed, _);
