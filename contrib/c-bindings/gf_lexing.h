/* GF C Bindings
   Copyright (C) 2010 Kevin Kofler

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, see <http://www.gnu.org/licenses/>.
*/

/* Function pointer type which applies a string operation to str, which is
   assumed to be non-NULL.
   The resulting string can be assumed to be non-NULL and must be freed using
   free. */
typedef char *(*GF_StringOp)(const char *str);

/* Returns a GF_StringOp applying the operation op if available, otherwise
   NULL. op is assumed to be non-NULL. The GF_StringOp MUST NOT be freed. */
GF_StringOp gf_stringOp(const char *op);