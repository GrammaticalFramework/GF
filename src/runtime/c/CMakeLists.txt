project(libpgf)
cmake_minimum_required(VERSION 2.8)

set(GNU_LIGHTNING_ARCH "i386" CACHE STRING "Target architecture for GNU Lightning JIT")
#set(ADD_CFLAGS "-Wall -Wextra -Wno-missing-field-initializers -Wno-unused-parameter -Wno-unused-value" CACHE STRING "Additional C compiler options")
#set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-no-undefined")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 ${ADD_CFLAGS}")

set(GNU_LIGHTNING_ARCH_HEADERS
  pgf/lightning/${GNU_LIGHTNING_ARCH}/asm.h
  pgf/lightning/${GNU_LIGHTNING_ARCH}/fp.h
  pgf/lightning/${GNU_LIGHTNING_ARCH}/core.h
  pgf/lightning/${GNU_LIGHTNING_ARCH}/funcs.h
)

file(COPY        ${GNU_LIGHTNING_ARCH_HEADERS}
     DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/pgf/lightning/)


include_directories(.)
include_directories(./pgf)


set(libgu_la_SOURCES  
	gu/assert.c 
	gu/bits.c 
	gu/choice.c 
	gu/defs.c 
	gu/seq.c 
	gu/enum.c 
	gu/exn.c 
	gu/file.c 
	gu/fun.c 
	gu/hash.c 
	gu/in.c 
	gu/map.c 
	gu/mem.c 
	gu/out.c 
	gu/prime.c 
	gu/string.c 
	gu/utf8.c 
	gu/ucs.c 
	gu/variant.c
)

set(libpgf_la_SOURCES 
	pgf/data.c 
	pgf/data.h 
	pgf/expr.c 
	pgf/expr.h 
	pgf/parser.c 
	pgf/jit.c 
	pgf/parseval.c 
	pgf/literals.c 
	pgf/literals.h 
	pgf/reader.h 
	pgf/reader.c 
	pgf/linearizer.c 
	pgf/typechecker.c 
	pgf/reasoner.c 
	pgf/evaluator.c 
	pgf/hopu.c 
	pgf/printer.c 
	pgf/graphviz.c 
	pgf/aligner.c 
	pgf/pgf.c 
	pgf/pgf.h 
)

set(libsg_la_SOURCES 
	sg/sqlite3Btree.c 
	sg/sg.c
)


add_library(gu SHARED ${libgu_la_SOURCES})
#set_property(TARGET gu PROPERTY C_STANDARD 99)
#set_property(TARGET gu PROPERTY WINDOWS_EXPORT_ALL_SYMBOLS true)
target_compile_definitions(gu PRIVATE COMPILING_GU=1)

add_library(pgf SHARED ${libpgf_la_SOURCES})
#set_property(TARGET pgf PROPERTY C_STANDARD 99)
#set_property(TARGET pgf PROPERTY WINDOWS_EXPORT_ALL_SYMBOLS true)
target_compile_definitions(pgf PRIVATE COMPILING_PGF=1)
target_link_libraries(pgf gu)
if(UNIX)
  target_link_libraries(pgf m)
endif(UNIX)

install(TARGETS gu pgf DESTINATION lib)
