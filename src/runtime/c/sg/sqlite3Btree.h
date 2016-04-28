/*
** 2001 September 15
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** This header file defines the interface that the sqlite B-Tree file
** subsystem.  See comments in the source code for a detailed description
** of what each interface routine does.
*/
#ifndef _BTREE_H_
#define _BTREE_H_

/*
** The SQLITE_THREADSAFE macro must be defined as 0, 1, or 2.
** 0 means mutexes are permanently disable and the library is never
** threadsafe.  1 means the library is serialized which is the highest
** level of threadsafety.  2 means the library is multithreaded - multiple
** threads can use SQLite as long as no two threads try to use the same
** database connection at the same time.
**
** Older versions of SQLite used an optional THREADSAFE macro.
** We support that for legacy.
*/
#if !defined(SQLITE_THREADSAFE)
# if defined(THREADSAFE)
#   define SQLITE_THREADSAFE THREADSAFE
# else
#   define SQLITE_THREADSAFE 1 /* IMP: R-07272-22309 */
# endif
#endif

/*
** CAPI3REF: 64-Bit Integer Types
** KEYWORDS: sqlite_int64 sqlite_uint64
**
** Because there is no cross-platform way to specify 64-bit integer types
** SQLite includes typedefs for 64-bit signed and unsigned integers.
**
** The sqlite3_int64 and sqlite3_uint64 are the preferred type definitions.
** The sqlite_int64 and sqlite_uint64 types are supported for backwards
** compatibility only.
**
** ^The sqlite3_int64 and sqlite_int64 types can store integer values
** between -9223372036854775808 and +9223372036854775807 inclusive.  ^The
** sqlite3_uint64 and sqlite_uint64 types can store integer values 
** between 0 and +18446744073709551615 inclusive.
*/
#ifdef SQLITE_INT64_TYPE
  typedef SQLITE_INT64_TYPE sqlite_int64;
  typedef unsigned SQLITE_INT64_TYPE sqlite_uint64;
#elif defined(_MSC_VER) || defined(__BORLANDC__)
  typedef __int64 sqlite_int64;
  typedef unsigned __int64 sqlite_uint64;
#else
  typedef long long int sqlite_int64;
  typedef unsigned long long int sqlite_uint64;
#endif
typedef sqlite_int64 sqlite3_int64;
typedef sqlite_uint64 sqlite3_uint64;

/*
** Integers of known sizes.  These typedefs might change for architectures
** where the sizes very.  Preprocessor macros are available so that the
** types can be conveniently redefined at compile-type.  Like this:
**
**         cc '-DUINTPTR_TYPE=long long int' ...
*/
#ifndef UINT32_TYPE
# ifdef HAVE_UINT32_T
#  define UINT32_TYPE uint32_t
# else
#  define UINT32_TYPE unsigned int
# endif
#endif
#ifndef UINT16_TYPE
# ifdef HAVE_UINT16_T
#  define UINT16_TYPE uint16_t
# else
#  define UINT16_TYPE unsigned short int
# endif
#endif
#ifndef INT16_TYPE
# ifdef HAVE_INT16_T
#  define INT16_TYPE int16_t
# else
#  define INT16_TYPE short int
# endif
#endif
#ifndef UINT8_TYPE
# ifdef HAVE_UINT8_T
#  define UINT8_TYPE uint8_t
# else
#  define UINT8_TYPE unsigned char
# endif
#endif
#ifndef INT8_TYPE
# ifdef HAVE_INT8_T
#  define INT8_TYPE int8_t
# else
#  define INT8_TYPE signed char
# endif
#endif
#ifndef LONGDOUBLE_TYPE
# define LONGDOUBLE_TYPE long double
#endif
typedef sqlite_int64 i64;          /* 8-byte signed integer */
typedef sqlite_uint64 u64;         /* 8-byte unsigned integer */
typedef UINT32_TYPE u32;           /* 4-byte unsigned integer */
typedef UINT16_TYPE u16;           /* 2-byte unsigned integer */
typedef INT16_TYPE i16;            /* 2-byte signed integer */
typedef UINT8_TYPE u8;             /* 1-byte unsigned integer */
typedef INT8_TYPE i8;              /* 1-byte signed integer */

/* TODO: This definition is just included so other modules compile. It
** needs to be revisited.
*/
#define SQLITE_N_BTREE_META 16

/*
** If defined as non-zero, auto-vacuum is enabled by default. Otherwise
** it must be turned on for each database using "PRAGMA auto_vacuum = 1".
*/
#ifndef SQLITE_DEFAULT_AUTOVACUUM
  #define SQLITE_DEFAULT_AUTOVACUUM 0
#endif

#define BTREE_AUTOVACUUM_NONE 0        /* Do not do auto-vacuum */
#define BTREE_AUTOVACUUM_FULL 1        /* Do full auto-vacuum */
#define BTREE_AUTOVACUUM_INCR 2        /* Incremental vacuum */

/*
** CAPI3REF: Initialize The SQLite Library
**
** ^The sqlite3BtreeInitialize() routine initializes the
** SQLite library.  ^The sqlite3BtreeShutdown() routine
** deallocates any resources that were allocated by sqlite3BtreeInitialize().
** These routines are designed to aid in process initialization and
** shutdown on embedded systems.  Workstation applications using
** SQLite normally do not need to invoke either of these routines.
**
** A call to sqlite3BtreeInitialize() is an "effective" call if it is
** the first time sqlite3BtreeInitialize() is invoked during the lifetime of
** the process, or if it is the first time sqlite3BtreeInitialize() is invoked
** following a call to sqlite3BtreeShutdown().  ^(Only an effective call
** of sqlite3BtreeInitialize() does any initialization.  All other calls
** are harmless no-ops.)^
**
** A call to sqlite3BtreeShutdown() is an "effective" call if it is the first
** call to sqlite3BtreeShutdown() since the last sqlite3BtreeInitialize().  ^(Only
** an effective call to sqlite3BtreeShutdown() does any deinitialization.
** All other valid calls to sqlite3BtreeShutdown() are harmless no-ops.)^
**
** The sqlite3BtreeInitialize() interface is threadsafe, but sqlite3BtreeShutdown()
** is not.  The sqlite3BtreeShutdown() interface must only be called from a
** single thread.  All open [database connections] must be closed and all
** other SQLite resources must be deallocated prior to invoking
** sqlite3BtreeShutdown().
**
** Among other things, ^sqlite3BtreeInitialize() will invoke
** sqlite3_os_init().  Similarly, ^sqlite3BtreeShutdown()
** will invoke sqlite3_os_end().
**
** ^The sqlite3BtreeInitialize() routine returns [SQLITE_OK] on success.
** ^If for some reason, sqlite3BtreeInitialize() is unable to initialize
** the library (perhaps it is unable to allocate a needed resource such
** as a mutex) it returns an [error code] other than [SQLITE_OK].
**
** ^The sqlite3BtreeInitialize() routine is called internally by many other
** SQLite interfaces so that an application usually does not need to
** invoke sqlite3BtreeInitialize() directly.  For example, [sqlite3_open()]
** calls sqlite3BtreeInitialize() so the SQLite library will be automatically
** initialized when [sqlite3_open()] is called if it has not be initialized
** already.  ^However, if SQLite is compiled with the [SQLITE_OMIT_AUTOINIT]
** compile-time option, then the automatic calls to sqlite3BtreeInitialize()
** are omitted and the application must call sqlite3BtreeInitialize() directly
** prior to using any other SQLite interface.  For maximum portability,
** it is recommended that applications always invoke sqlite3BtreeInitialize()
** directly prior to using any other SQLite interface.  Future releases
** of SQLite may require this.  In other words, the behavior exhibited
** when SQLite is compiled with [SQLITE_OMIT_AUTOINIT] might become the
** default behavior in some future release of SQLite.
**
** The sqlite3_os_init() routine does operating-system specific
** initialization of the SQLite library.  The sqlite3_os_end()
** routine undoes the effect of sqlite3_os_init().  Typical tasks
** performed by these routines include allocation or deallocation
** of static resources, initialization of global variables,
** setting up a default [sqlite3_vfs] module, or setting up
** a default configuration using [sqlite3_config()].
**
** The application should never invoke either sqlite3_os_init()
** or sqlite3_os_end() directly.  The application should only invoke
** sqlite3BtreeInitialize() and sqlite3BtreeShutdown().  The sqlite3_os_init()
** interface is called automatically by sqlite3BtreeInitialize() and
** sqlite3_os_end() is called by sqlite3BtreeShutdown().  Appropriate
** implementations for sqlite3_os_init() and sqlite3_os_end()
** are built into SQLite when it is compiled for Unix, Windows, or OS/2.
** When [custom builds | built for other platforms]
** (using the [SQLITE_OS_OTHER=1] compile-time
** option) the application must supply a suitable implementation for
** sqlite3_os_init() and sqlite3_os_end().  An application-supplied
** implementation of sqlite3_os_init() or sqlite3_os_end()
** must return [SQLITE_OK] on success and some other [error code] upon
** failure.
*/
int sqlite3BtreeInitialize(void);
int sqlite3BtreeShutdown(void);

/*
** CAPI3REF: Result Codes
** KEYWORDS: {result code definitions}
**
** Many SQLite functions return an integer result code from the set shown
** here in order to indicate success or failure.
**
** New error codes may be added in future versions of SQLite.
**
** See also: [extended result code definitions]
*/
#define SQLITE_OK           0   /* Successful result */
/* beginning-of-error-codes */
#define SQLITE_ERROR        1   /* SQL error or missing database */
#define SQLITE_INTERNAL     2   /* Internal logic error in SQLite */
#define SQLITE_PERM         3   /* Access permission denied */
#define SQLITE_ABORT        4   /* Callback routine requested an abort */
#define SQLITE_BUSY         5   /* The database file is locked */
#define SQLITE_LOCKED       6   /* A table in the database is locked */
#define SQLITE_NOMEM        7   /* A malloc() failed */
#define SQLITE_READONLY     8   /* Attempt to write a readonly database */
#define SQLITE_INTERRUPT    9   /* Operation terminated by sqlite3_interrupt()*/
#define SQLITE_IOERR       10   /* Some kind of disk I/O error occurred */
#define SQLITE_CORRUPT     11   /* The database disk image is malformed */
#define SQLITE_NOTFOUND    12   /* Unknown opcode in sqlite3_file_control() */
#define SQLITE_FULL        13   /* Insertion failed because database is full */
#define SQLITE_CANTOPEN    14   /* Unable to open the database file */
#define SQLITE_PROTOCOL    15   /* Database lock protocol error */
#define SQLITE_EMPTY       16   /* Database is empty */
#define SQLITE_SCHEMA      17   /* The database schema changed */
#define SQLITE_TOOBIG      18   /* String or BLOB exceeds size limit */
#define SQLITE_CONSTRAINT  19   /* Abort due to constraint violation */
#define SQLITE_MISMATCH    20   /* Data type mismatch */
#define SQLITE_MISUSE      21   /* Library used incorrectly */
#define SQLITE_NOLFS       22   /* Uses OS features not supported on host */
#define SQLITE_AUTH        23   /* Authorization denied */
#define SQLITE_FORMAT      24   /* Auxiliary database format error */
#define SQLITE_RANGE       25   /* 2nd parameter to sqlite3_bind out of range */
#define SQLITE_NOTADB      26   /* File opened that is not a database file */
#define SQLITE_NOTICE      27   /* Notifications from sqlite3_log() */
#define SQLITE_WARNING     28   /* Warnings from sqlite3_log() */
#define SQLITE_ROW         100  /* sqlite3_step() has another row ready */
#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */
/* end-of-error-codes */

/*
** CAPI3REF: Extended Result Codes
** KEYWORDS: {extended result code definitions}
**
** In its default configuration, SQLite API routines return one of 30 integer
** [result codes].  However, experience has shown that many of
** these result codes are too coarse-grained.  They do not provide as
** much information about problems as programmers might like.  In an effort to
** address this, newer versions of SQLite (version 3.3.8 and later) include
** support for additional result codes that provide more detailed information
** about errors. These [extended result codes] are enabled or disabled
** on a per database connection basis using the
** [sqlite3_extended_result_codes()] API.  Or, the extended code for
** the most recent error can be obtained using
** [sqlite3_extended_errcode()].
*/
#define SQLITE_IOERR_READ              (SQLITE_IOERR | (1<<8))
#define SQLITE_IOERR_SHORT_READ        (SQLITE_IOERR | (2<<8))
#define SQLITE_IOERR_WRITE             (SQLITE_IOERR | (3<<8))
#define SQLITE_IOERR_FSYNC             (SQLITE_IOERR | (4<<8))
#define SQLITE_IOERR_DIR_FSYNC         (SQLITE_IOERR | (5<<8))
#define SQLITE_IOERR_TRUNCATE          (SQLITE_IOERR | (6<<8))
#define SQLITE_IOERR_FSTAT             (SQLITE_IOERR | (7<<8))
#define SQLITE_IOERR_UNLOCK            (SQLITE_IOERR | (8<<8))
#define SQLITE_IOERR_RDLOCK            (SQLITE_IOERR | (9<<8))
#define SQLITE_IOERR_DELETE            (SQLITE_IOERR | (10<<8))
#define SQLITE_IOERR_BLOCKED           (SQLITE_IOERR | (11<<8))
#define SQLITE_IOERR_NOMEM             (SQLITE_IOERR | (12<<8))
#define SQLITE_IOERR_ACCESS            (SQLITE_IOERR | (13<<8))
#define SQLITE_IOERR_CHECKRESERVEDLOCK (SQLITE_IOERR | (14<<8))
#define SQLITE_IOERR_LOCK              (SQLITE_IOERR | (15<<8))
#define SQLITE_IOERR_CLOSE             (SQLITE_IOERR | (16<<8))
#define SQLITE_IOERR_DIR_CLOSE         (SQLITE_IOERR | (17<<8))
#define SQLITE_IOERR_SHMOPEN           (SQLITE_IOERR | (18<<8))
#define SQLITE_IOERR_SHMSIZE           (SQLITE_IOERR | (19<<8))
#define SQLITE_IOERR_SHMLOCK           (SQLITE_IOERR | (20<<8))
#define SQLITE_IOERR_SHMMAP            (SQLITE_IOERR | (21<<8))
#define SQLITE_IOERR_SEEK              (SQLITE_IOERR | (22<<8))
#define SQLITE_IOERR_DELETE_NOENT      (SQLITE_IOERR | (23<<8))
#define SQLITE_IOERR_MMAP              (SQLITE_IOERR | (24<<8))
#define SQLITE_IOERR_GETTEMPPATH       (SQLITE_IOERR | (25<<8))
#define SQLITE_IOERR_CONVPATH          (SQLITE_IOERR | (26<<8))
#define SQLITE_IOERR_VNODE             (SQLITE_IOERR | (27<<8))
#define SQLITE_LOCKED_SHAREDCACHE      (SQLITE_LOCKED |  (1<<8))
#define SQLITE_BUSY_RECOVERY           (SQLITE_BUSY   |  (1<<8))
#define SQLITE_BUSY_SNAPSHOT           (SQLITE_BUSY   |  (2<<8))
#define SQLITE_CANTOPEN_NOTEMPDIR      (SQLITE_CANTOPEN | (1<<8))
#define SQLITE_CANTOPEN_ISDIR          (SQLITE_CANTOPEN | (2<<8))
#define SQLITE_CANTOPEN_FULLPATH       (SQLITE_CANTOPEN | (3<<8))
#define SQLITE_CANTOPEN_CONVPATH       (SQLITE_CANTOPEN | (4<<8))
#define SQLITE_CORRUPT_VTAB            (SQLITE_CORRUPT | (1<<8))
#define SQLITE_READONLY_RECOVERY       (SQLITE_READONLY | (1<<8))
#define SQLITE_READONLY_CANTLOCK       (SQLITE_READONLY | (2<<8))
#define SQLITE_READONLY_ROLLBACK       (SQLITE_READONLY | (3<<8))
#define SQLITE_READONLY_DBMOVED        (SQLITE_READONLY | (4<<8))
#define SQLITE_ABORT_ROLLBACK          (SQLITE_ABORT | (2<<8))
#define SQLITE_CONSTRAINT_CHECK        (SQLITE_CONSTRAINT | (1<<8))
#define SQLITE_CONSTRAINT_COMMITHOOK   (SQLITE_CONSTRAINT | (2<<8))
#define SQLITE_CONSTRAINT_FOREIGNKEY   (SQLITE_CONSTRAINT | (3<<8))
#define SQLITE_CONSTRAINT_FUNCTION     (SQLITE_CONSTRAINT | (4<<8))
#define SQLITE_CONSTRAINT_NOTNULL      (SQLITE_CONSTRAINT | (5<<8))
#define SQLITE_CONSTRAINT_PRIMARYKEY   (SQLITE_CONSTRAINT | (6<<8))
#define SQLITE_CONSTRAINT_TRIGGER      (SQLITE_CONSTRAINT | (7<<8))
#define SQLITE_CONSTRAINT_UNIQUE       (SQLITE_CONSTRAINT | (8<<8))
#define SQLITE_CONSTRAINT_VTAB         (SQLITE_CONSTRAINT | (9<<8))
#define SQLITE_CONSTRAINT_ROWID        (SQLITE_CONSTRAINT |(10<<8))
#define SQLITE_NOTICE_RECOVER_WAL      (SQLITE_NOTICE | (1<<8))
#define SQLITE_NOTICE_RECOVER_ROLLBACK (SQLITE_NOTICE | (2<<8))
#define SQLITE_WARNING_AUTOINDEX       (SQLITE_WARNING | (1<<8))
#define SQLITE_AUTH_USER               (SQLITE_AUTH | (1<<8))

/* Reserved:                         0x00F00000 */

/*
** Forward declarations of structure
*/
typedef struct Btree Btree;
typedef struct BtCursor BtCursor;
typedef struct BtShared BtShared;
typedef struct Mem Mem;
typedef struct KeyInfo KeyInfo;
typedef struct UnpackedRecord UnpackedRecord;


int sqlite3BtreeOpen(
  const char *zVfs,        /* VFS to use with this b-tree */
  const char *zFilename,   /* Name of database file to open */
  Btree **ppBtree,         /* Return open Btree* here */
  int flags,               /* Flags */
  int vfsFlags             /* Flags passed through to VFS open */
);

/* The flags parameter to sqlite3BtreeOpen can be the bitwise or of the
** following values.
**
** NOTE:  These values must match the corresponding PAGER_ values in
** pager.h.
*/
#define BTREE_OMIT_JOURNAL  1  /* Do not create or use a rollback journal */
#define BTREE_MEMORY        2  /* This is an in-memory DB */
#define BTREE_SINGLE        4  /* The file contains at most 1 b-tree */
#define BTREE_UNORDERED     8  /* Use of a hash implementation is OK */

/*
** CAPI3REF: Flags For File Open Operations
**
** These bit values are intended for use in the
** 3rd parameter to the [sqlite3_open_v2()] interface and
** in the 4th parameter to the [sqlite3_vfs.xOpen] method.
*/
#define SQLITE_OPEN_READONLY         0x00000001  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_READWRITE        0x00000002  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_CREATE           0x00000004  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_DELETEONCLOSE    0x00000008  /* VFS only */
#define SQLITE_OPEN_EXCLUSIVE        0x00000010  /* VFS only */
#define SQLITE_OPEN_AUTOPROXY        0x00000020  /* VFS only */
#define SQLITE_OPEN_URI              0x00000040  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_MEMORY           0x00000080  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_MAIN_DB          0x00000100  /* VFS only */
#define SQLITE_OPEN_TEMP_DB          0x00000200  /* VFS only */
#define SQLITE_OPEN_TRANSIENT_DB     0x00000400  /* VFS only */
#define SQLITE_OPEN_MAIN_JOURNAL     0x00000800  /* VFS only */
#define SQLITE_OPEN_TEMP_JOURNAL     0x00001000  /* VFS only */
#define SQLITE_OPEN_SUBJOURNAL       0x00002000  /* VFS only */
#define SQLITE_OPEN_MASTER_JOURNAL   0x00004000  /* VFS only */
#define SQLITE_OPEN_NOMUTEX          0x00008000  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_FULLMUTEX        0x00010000  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_SHAREDCACHE      0x00020000  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_PRIVATECACHE     0x00040000  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_WAL              0x00080000  /* VFS only */

int sqlite3BtreeClose(Btree*);
int sqlite3BtreeSetCacheSize(Btree*,int);
#if SQLITE_MAX_MMAP_SIZE>0
  int sqlite3BtreeSetMmapLimit(Btree*,sqlite3_int64);
#endif
int sqlite3BtreeSetPagerFlags(Btree*,unsigned);
int sqlite3BtreeSyncDisabled(Btree*);
int sqlite3BtreeSetPageSize(Btree *p, int nPagesize, int nReserve, int eFix);
int sqlite3BtreeGetPageSize(Btree*);
int sqlite3BtreeMaxPageCount(Btree*,int);
u32 sqlite3BtreeLastPage(Btree*);
int sqlite3BtreeSecureDelete(Btree*,int);
int sqlite3BtreeGetOptimalReserve(Btree*);
int sqlite3BtreeGetReserveNoMutex(Btree *p);
int sqlite3BtreeSetAutoVacuum(Btree *, int);
int sqlite3BtreeGetAutoVacuum(Btree *);
int sqlite3BtreeBeginTrans(Btree*,int);
int sqlite3BtreeCommitPhaseOne(Btree*, const char *zMaster);
int sqlite3BtreeCommitPhaseTwo(Btree*, int);
int sqlite3BtreeCommit(Btree*);
int sqlite3BtreeRollback(Btree*,int,int);
int sqlite3BtreeBeginStmt(Btree*,int);
int sqlite3BtreeCreateTable(Btree*, int*, int flags);
int sqlite3BtreeIsInTrans(Btree*);
int sqlite3BtreeIsInReadTrans(Btree*);
int sqlite3BtreeIsInBackup(Btree*);
void *sqlite3BtreeSchema(Btree *, int, void(*)(void *));
int sqlite3BtreeSchemaLocked(Btree *pBtree);
int sqlite3BtreeLockTable(Btree *pBtree, int iTab, u8 isWriteLock);
int sqlite3BtreeSavepoint(Btree *, int, int);

int sqlite3BtreeFileFormat(Btree *);
const char *sqlite3BtreeGetFilename(Btree *);
const char *sqlite3BtreeGetJournalname(Btree *);
int sqlite3BtreeCopyFile(Btree *, Btree *);

int sqlite3BtreeIncrVacuum(Btree *);

/* The flags parameter to sqlite3BtreeCreateTable can be the bitwise OR
** of the flags shown below.
**
** Every SQLite table must have either BTREE_INTKEY or BTREE_BLOBKEY set.
** With BTREE_INTKEY, the table key is a 64-bit integer and arbitrary data
** is stored in the leaves.  (BTREE_INTKEY is used for SQL tables.)  With
** BTREE_BLOBKEY, the key is an arbitrary BLOB and no content is stored
** anywhere - the key is the content.  (BTREE_BLOBKEY is used for SQL
** indices.)
*/
#define BTREE_INTKEY     1    /* Table has only 64-bit signed integer keys */
#define BTREE_BLOBKEY    2    /* Table has keys only - no data */

int sqlite3BtreeDropTable(Btree*, int, int*);
int sqlite3BtreeClearTable(Btree*, int, int*);
int sqlite3BtreeClearTableOfCursor(BtCursor*);
int sqlite3BtreeTripAllCursors(Btree*, int, int);

void sqlite3BtreeGetMeta(Btree *pBtree, int idx, u32 *pValue);
int sqlite3BtreeUpdateMeta(Btree*, int idx, u32 value);

int sqlite3BtreeNewDb(Btree *p);

/*
** The second parameter to sqlite3BtreeGetMeta or sqlite3BtreeUpdateMeta
** should be one of the following values. The integer values are assigned 
** to constants so that the offset of the corresponding field in an
** SQLite database header may be found using the following formula:
**
**   offset = 36 + (idx * 4)
**
** For example, the free-page-count field is located at byte offset 36 of
** the database file header. The incr-vacuum-flag field is located at
** byte offset 64 (== 36+4*7).
**
** The BTREE_DATA_VERSION value is not really a value stored in the header.
** It is a read-only number computed by the pager.  But we merge it with
** the header value access routines since its access pattern is the same.
** Call it a "virtual meta value".
*/
#define BTREE_FREE_PAGE_COUNT     0
#define BTREE_SCHEMA_VERSION      1
#define BTREE_FILE_FORMAT         2
#define BTREE_DEFAULT_CACHE_SIZE  3
#define BTREE_LARGEST_ROOT_PAGE   4
#define BTREE_TEXT_ENCODING       5
#define BTREE_USER_VERSION        6
#define BTREE_INCR_VACUUM         7
#define BTREE_APPLICATION_ID      8
#define BTREE_DATA_VERSION        15  /* A virtual meta-value */

/*
** An instance of the following structure holds information about a
** single index record that has already been parsed out into individual
** values.
**
** A record is an object that contains one or more fields of data.
** Records are used to store the content of a table row and to store
** the key of an index.  A blob encoding of a record is created by
** the OP_MakeRecord opcode of the VDBE and is disassembled by the
** OP_Column opcode.
**
** This structure holds a record that has already been disassembled
** into its constituent fields.
**
** The r1 and r2 member variables are only used by the optimized comparison
** functions vdbeRecordCompareInt() and vdbeRecordCompareString().
*/
struct UnpackedRecord {
  KeyInfo *pKeyInfo;  /* Collation and sort-order information */
  u16 nField;         /* Number of entries in apMem[] */
  i8 default_rc;      /* Comparison result if keys are equal */
  u8 errCode;         /* Error detected by xRecordCompare (CORRUPT or NOMEM) */
  Mem *aMem;          /* Values */
  int r1;             /* Value to return if (lhs > rhs) */
  int r2;             /* Value to return if (rhs < lhs) */
};

/* One or more of the following flags are set to indicate the validOK
** representations of the value stored in the Mem struct.
**
** If the MEM_Null flag is set, then the value is an SQL NULL value.
** No other flags may be set in this case.
**
** If the MEM_Str flag is set then Mem.z points at a string representation.
** Usually this is encoded in the same unicode encoding as the main
** database (see below for exceptions). If the MEM_Term flag is also
** set, then the string is nul terminated. The MEM_Int and MEM_Real 
** flags may coexist with the MEM_Str flag.
*/
#define MEM_Null      0x0001   /* Value is NULL */
#define MEM_Str       0x0002   /* Value is a string */
#define MEM_Int       0x0004   /* Value is an integer */
#define MEM_Real      0x0008   /* Value is a real number */
#define MEM_Blob      0x0010   /* Value is a BLOB */

#define MEM_Term      0x0200   /* String rep is nul terminated */
#define MEM_Dyn       0x0400   /* Need to call Mem.xDel() on Mem.z */
#define MEM_Static    0x0800   /* Mem.z points to a static string */
#define MEM_Ephem     0x1000   /* Mem.z points to an ephemeral string */
#define MEM_Zero      0x4000   /* Mem.i contains count of 0s appended to blob */

/*
** Internally, the vdbe manipulates nearly all SQL values as Mem
** structures. Each Mem struct may cache multiple representations (string,
** integer etc.) of the same value.
*/
struct Mem {
  union MemValue {
    double r;           /* Real value used when MEM_Real is set in flags */
    i64 i;              /* Integer value used when MEM_Int is set in flags */
    int nZero;          /* Used when bit MEM_Zero is set in flags */
  } u;
  u16 flags;          /* Some combination of MEM_Null, MEM_Str, MEM_Dyn, etc. */
  u8  enc;            /* SQLITE_UTF8, SQLITE_UTF16BE, SQLITE_UTF16LE */
  u8  eSubtype;       /* Subtype for this value */
  int n;              /* Number of characters in string value, excluding '\0' */
  char *z;            /* String or BLOB value */
  /* ShallowCopy only needs to copy the information above */
  char *zMalloc;      /* Space to hold MEM_Str or MEM_Blob if szMalloc>0 */
  int szMalloc;       /* Size of the zMalloc allocation */
  u32 uTemp;          /* Transient storage for serial_type in OP_MakeRecord */
  Btree *pBtree;      /* The associated database connection */
  void (*xDel)(void*);/* Destructor for Mem.z - only valid if MEM_Dyn */
#ifdef SQLITE_DEBUG
  Mem *pScopyFrom;    /* This Mem is a shallow copy of pScopyFrom */
  void *pFiller;      /* So that sizeof(Mem) is a multiple of 8 */
#endif
};

/*
** Values that may be OR'd together to form the second argument of an
** sqlite3BtreeCursorHints() call.
**
** The BTREE_BULKLOAD flag is set on index cursors when the index is going
** to be filled with content that is already in sorted order.
**
** The BTREE_SEEK_EQ flag is set on cursors that will get OP_SeekGE or
** OP_SeekLE opcodes for a range search, but where the range of entries
** selected will all have the same key.  In other words, the cursor will
** be used only for equality key searches.
**
*/
#define BTREE_BULKLOAD 0x00000001  /* Used to full index in sorted order */
#define BTREE_SEEK_EQ  0x00000002  /* EQ seeks only - no range seeks */

int sqlite3BtreeCursor(
  Btree*,                              /* BTree containing table to open */
  int iTable,                          /* Index of root page */
  int wrFlag,                          /* 1 for writing.  0 for read-only */
  int N, int X,                        /* index of N key columns and X extra columns */
  BtCursor **ppCursor                  /* Space to write cursor pointer */
);
int sqlite3BtreeCursorSize(void);

int sqlite3BtreeCloseCursor(BtCursor*);
void sqlite3BtreeInitUnpackedRecord(
  UnpackedRecord *pUnKey,
  BtCursor* pCur,
  int nField,
  int default_rc,
  Mem* pMem);
int sqlite3BtreeMovetoUnpacked(
  BtCursor*,
  UnpackedRecord *pUnKey,
  i64 intKey,
  int bias,
  int *pRes
);
int sqlite3BtreeCursorHasMoved(BtCursor*);
int sqlite3BtreeCursorRestore(BtCursor*, int*);
int sqlite3BtreeDelete(BtCursor*, int);
int sqlite3BtreeInsert(BtCursor*, const void *pKey, i64 nKey,
                                  const void *pData, int nData,
                                  int nZero, int bias, int seekResult);
int sqlite3BtreeFirst(BtCursor*, int *pRes);
int sqlite3BtreeLast(BtCursor*, int *pRes);
int sqlite3BtreeNext(BtCursor*, int *pRes);
int sqlite3BtreeEof(BtCursor*);
int sqlite3BtreePrevious(BtCursor*, int *pRes);
int sqlite3BtreeKeySize(BtCursor*, i64 *pSize);
int sqlite3BtreeKey(BtCursor*, u32 offset, u32 amt, void*);
const void *sqlite3BtreeKeyFetch(BtCursor*, u32 *pAmt);
const void *sqlite3BtreeDataFetch(BtCursor*, u32 *pAmt);
int sqlite3BtreeDataSize(BtCursor*, u32 *pSize);
int sqlite3BtreeData(BtCursor*, u32 offset, u32 amt, void*);

char *sqlite3BtreeIntegrityCheck(Btree*, int *aRoot, int nRoot, int, int*);
struct Pager *sqlite3BtreePager(Btree*);

int sqlite3BtreePutData(BtCursor*, u32 offset, u32 amt, void*);
void sqlite3BtreeIncrblobCursor(BtCursor *);
void sqlite3BtreeClearCursor(BtCursor *);
int sqlite3BtreeSetVersion(Btree *pBt, int iVersion);
void sqlite3BtreeCursorHints(BtCursor *, unsigned int mask);
#ifdef SQLITE_DEBUG
int sqlite3BtreeCursorHasHint(BtCursor*, unsigned int mask);
#endif
int sqlite3BtreeIsReadonly(Btree *pBt);

#ifndef NDEBUG
int sqlite3BtreeCursorIsValid(BtCursor*);
#endif

#ifndef SQLITE_OMIT_BTREECOUNT
int sqlite3BtreeCount(BtCursor *, i64 *);
#endif

#ifdef SQLITE_TEST
int sqlite3BtreeCursorInfo(BtCursor*, int*, int);
void sqlite3BtreeCursorList(Btree*);
#endif

#ifndef SQLITE_OMIT_WAL
  int sqlite3BtreeCheckpoint(Btree*, int, int *, int *);
#endif

/*
** If we are not using shared cache, then there is no need to
** use mutexes to access the BtShared structures.  So make the
** Enter and Leave procedures no-ops.
*/
#ifndef SQLITE_OMIT_SHARED_CACHE
  void sqlite3BtreeEnter(Btree*);
#else
# define sqlite3BtreeEnter(X) 
#endif

#if !defined(SQLITE_OMIT_SHARED_CACHE) && SQLITE_THREADSAFE
  int sqlite3BtreeSharable(Btree*);
  void sqlite3BtreeLeave(Btree*);
  void sqlite3BtreeEnterCursor(BtCursor*);
  void sqlite3BtreeLeaveCursor(BtCursor*);
#else

# define sqlite3BtreeSharable(X) 0
# define sqlite3BtreeLeave(X)
# define sqlite3BtreeEnterCursor(X)
# define sqlite3BtreeLeaveCursor(X)
#endif

u32 sqlite3BtreeSerialType(Mem *pMem, int file_format);
u32 sqlite3BtreeSerialTypeLen(u32);
u32 sqlite3BtreeSerialGet(const unsigned char*, u32, Mem *);
u32 sqlite3BtreeSerialPut(u8*, Mem*, u32);

/*
** Routines to read and write variable-length integers.  These used to
** be defined locally, but now we use the varint routines in the util.c
** file.
*/
int sqlite3BtreePutVarint(unsigned char*, u64);
u8 sqlite3BtreeGetVarint(const unsigned char *, u64 *);
u8 sqlite3BtreeGetVarint32(const unsigned char *, u32 *);
int sqlite3BtreeVarintLen(u64 v);

/*
** The common case is for a varint to be a single byte.  They following
** macros handle the common case without a procedure call, but then call
** the procedure for larger varints.
*/
#define getVarint32(A,B)  \
  (u8)((*(A)<(u8)0x80)?((B)=(u32)*(A)),1:sqlite3BtreeGetVarint32((A),(u32 *)&(B)))
#define putVarint32(A,B)  \
  (u8)(((u32)(B)<(u32)0x80)?(*(A)=(unsigned char)(B)),1:\
  sqlite3BtreePutVarint((A),(B)))
#define getVarint    sqlite3BtreeGetVarint
#define putVarint    sqlite3BtreePutVarint


int sqlite3BtreeIdxRowid(Btree*, BtCursor*, i64*);

int sqlite3BtreeRecordCompare(int,const void*,UnpackedRecord*);

const char *sqlite3BtreeErrName(int rc);

#endif /* _BTREE_H_ */
