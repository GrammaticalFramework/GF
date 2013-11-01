#ifndef GU_EXN_H_
#define GU_EXN_H_

#include <gu/mem.h>
#include <gu/type.h>

/** @file
 *
 * @defgroup GuExn Exceptions
 * Defined in <gu/exn.h>.
 * @{
 */

/// An exception frame.
typedef struct GuExn GuExn;

/// @private
typedef enum {
	GU_EXN_RAISED,
	GU_EXN_OK,
	GU_EXN_BLOCKED
} GuExnState;

typedef struct GuExnData GuExnData;

/// A structure for storing exception values.
struct GuExnData
/**
 * When an exception is raised, if there is an associated value, it
 * must be allocated from a pool that still exists when control
 * returns to the handler of that exception. This structure is used to
 * communicate the exception from the raiser to the handler: the
 * handler sets #pool when setting up the exception frame, and the
 * raiser uses that pool to allocate the value and stores that in
 * #data. When control returns to the handler, it reads the value from
 * there.
 */
{
	
	/// The pool that the exception value should be allocated from.
	GuPool* pool;

	/// The exception value.
	void* data;
};

struct GuExn {
	/// @privatesection
	GuExnState state;
	GuExn* parent;
	GuKind* catch;
	GuType* caught;
	GuExnData data;
};


/// @name Creating exception frames
//@{


/// Allocate a new local exception frame.
#define gu_exn(parent_, catch_, pool_) &(GuExn){	\
	.state = GU_EXN_OK,	\
	.parent = parent_,	\
	.catch = gu_kind(catch_),	\
	.caught = NULL,	\
	.data.pool = pool_,		\
	.data.data = NULL \
}


/// Allocate a new exception frame.
GuExn*
gu_new_exn(GuExn* parent, GuKind* catch_kind, GuPool* pool);



bool
gu_exn_is_raised(GuExn* err);

static inline void
gu_exn_clear(GuExn* err) {
	err->caught = NULL;
	err->state = GU_EXN_OK;
}



GuType*
gu_exn_caught(GuExn* err);

static inline const void*
gu_exn_caught_data(GuExn* err)
{
	return err->data.data;
}

/// Temporarily block a raised exception.
void
gu_exn_block(GuExn* err);

/// Show again a blocked exception.
void
gu_exn_unblock(GuExn* err);

//@private
GuExnData*
gu_exn_raise_(GuExn* err, GuType* type);

//@private
GuExnData*
gu_exn_raise_debug_(GuExn* err, GuType* type,
		      const char* filename, const char* func, int lineno);

#ifdef NDEBUG
#define gu_exn_raise(err_, type_)	\
	gu_exn_raise_(err_, type_)
#else
#define gu_exn_raise(err_, type_)	\
	gu_exn_raise_debug_(err_, type_, \
			      __FILE__, __func__, __LINE__)
#endif

/// Raise an exception.
#define gu_raise(exn, T)		\
	gu_exn_raise(exn, gu_type(T))
/**< 
 * @param exn The current exception frame.
 *
 * @param T   The C type of the exception to raise.
 *
 * @return    A #GuExnData object that can be used to store the exception value, or
 * \c NULL if no value is required.
 * 
 * @note The associated #GuType object for type \p T must be visible.
 */

#define gu_raise_new(error_, t_, pool_, expr_)				\
	GU_BEGIN							\
	GuExnData* gu_raise_err_ = gu_raise(error_, t_);		\
	if (gu_raise_err_) {						\
		GuPool* pool_ = gu_raise_err_->pool;			\
		gu_raise_err_->data = expr_;				\
	}								\
	GU_END

/// Check the status of the current exception frame
static inline bool
gu_ok(GuExn* exn) {
	return !GU_UNLIKELY(gu_exn_is_raised(exn));
}
/**<
 * @return \c false if an exception has been raised in the frame \p exn
 * and it has not been blocked, \c true otherwise.
 */


/// Return from current function if an exception has been raised.
#define gu_return_on_exn(exn_, retval_)		\
	GU_BEGIN					\
	if (gu_exn_is_raised(exn_)) return retval_;	\
	GU_END
/**<
 * @showinitializer
 */


#include <errno.h>

typedef int GuErrno;

extern GU_DECLARE_TYPE(GuErrno, signed);

void
gu_raise_errno(GuExn* err);

/** @} */

#endif // GU_EXN_H_
