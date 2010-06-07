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

#include "gf_lexing.h"
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef char **(*GF_Lexer)(const char *str);
typedef char *(*GF_Unlexer)(char **arr);

static inline void freev(char **p)
{
  char **q = p;
  while (*q)
    free(*(q++));
  free(p);
}

static char **words(const char *str)
{
  unsigned char *buf = (unsigned char *) strdup(str);
  unsigned char *p = buf, *q;
  char **result, **r;
  size_t count = 0u;
  while (isspace(*p)) p++;
  q = p;
  if (*p) count++;
  while (*p) {
    if (isspace(*p)) {
      *(p++) = 0;
      while (isspace(*p)) *(p++) = 0;
      if (*p) count++;
    } else p++;
  }
  r = result = malloc((count+1)*sizeof(char *));
  if (count) while (1) {
    *(r++) = strdup((char *) q);
    if (!--count) break;
    while (*q) q++;
    while (!*q) q++;
  }
  *r = NULL;
  return result;
}

static char *unwords(char **arr)
{
  size_t len = 0u;
  char **p = arr, *result, *r;
  while (*p)
    len += strlen(*(p++)) + 1u;
  if (!len) return calloc(1, 1);
  r = result = malloc(len);
  p = arr;
  while (1) {
    size_t l = strlen(*p);
    strcpy(r, *(p++));
    if (!*p) break;
    r += l;
    *(r++) = ' ';
  }
  return result;
}

static char **lines(const char *str)
{
  unsigned char *buf = (unsigned char *) strdup(str);
  unsigned char *p = buf, *q;
  char **result, **r;
  size_t count = 0u;
  while (*p == '\n') p++;
  q = p;
  if (*p) count++;
  while (*p) {
    if (*p == '\n') {
      *(p++) = 0;
      while (*p == '\n') *(p++) = 0;
      if (*p) count++;
    } else p++;
  }
  r = result = malloc((count+1)*sizeof(char *));
  if (count) while (1) {
    *(r++) = strdup((char *) q);
    if (!--count) break;
    while (*q) q++;
    while (!*q) q++;
  }
  *r = NULL;
  return result;
}

static char *unlines(char **arr)
{
  size_t len = 0u;
  char **p = arr, *result, *r;
  while (*p)
    len += strlen(*(p++)) + 1u;
  if (!len) return calloc(1, 1);
  r = result = malloc(len);
  p = arr;
  while (1) {
    size_t l = strlen(*p);
    strcpy(r, *(p++));
    if (!*p) break;
    r += l;
    *(r++) = '\n';
  }
  return result;
}

static char *appLexer(GF_Lexer f, const char *str)
{
  char **arr = f(str), **p = arr, *result;
  int ofs = 0;
  while (*p && **p) p++;
  while (*p) {
    if (**p) p[-ofs] = *p; else ofs++;
    p++;
  }
  p[-ofs] = NULL;
  result = unwords(arr);
  freev(arr);
  return result;
}

static char *appUnlexer(GF_Unlexer f, const char *str)
{
  char **arr = lines(str), **p = arr, *result;
  while (*p) {
    char **warr = words(*p);
    free(*p);
    *(p++) = f(warr);
    freev(warr);
  }
  result = unlines(arr);
  freev(arr);
  return result;
}

static inline int isPunct(char c)
{
  return c && strchr(".?!,:;", c);
}

static inline int isMajorPunct(char c)
{
  return c && strchr(".?!", c);
}

static inline int isMinorPunct(char c)
{
  return c && strchr(",:;", c);
}

static char *charToStr(char c)
{
  char *result = malloc(2), *p = result;
  *(p++) = c;
  *p = 0;
  return result;
}

static char **lexChars(const char *str)
{
  char **result = malloc((strlen(str)+1)*sizeof(char *)), **r = result;
  const char *p = str;
  while (*p) {
    if (!isspace(*p)) *(r++) = charToStr(*p);
    p++;
  }
  *r = NULL;
  return result;
}

static char **lexText(const char *str)
{
  char **result = malloc((strlen(str)+1)*sizeof(char *)), **r = result;
  const char *p = str;
  int uncap = 1;
  while (*p) {
    if (isMajorPunct(*p)) {
      *(r++) = charToStr(*(p++));
      uncap = 1;
    } else if (isMinorPunct(*p)) {
      *(r++) = charToStr(*(p++));
      uncap = 0;
    } else if (isspace(*p)) {
      p++;
      uncap = 0;
    } else {
      const char *q = p;
      char *word;
      size_t l;
      while (*p && !isspace(*p) && !isPunct(*p)) p++;
      l = p - q;
      word = malloc(l + 1);
      strncpy(word, q, l);
      word[l] = 0;
      if (uncap) *word = tolower(*word);
      *(r++) = word;
      uncap = 0;
    }
  }
  *r = NULL;
  return result;
}

static char *unlexText(char **arr)
{
  size_t len = 0u;
  char **p = arr, *result, *r;
  int cap = 1;
  while (*p)
    len += strlen(*(p++)) + 1u;
  if (!len) return calloc(1, 1);
  r = result = malloc(len);
  p = arr;
  while (1) {
    size_t l = strlen(*p);
    char *word = *(p++);
    if (*word == '"' && word[l-1] == '"') word++, l--;
    strncpy(r, word, l);
    if (cap) *r = toupper(*r);
    if (!*p) break;
    r += l;
    if (isPunct(**p) && !(*p)[1]) {
      *(r++) = **p;
      if (!p[1]) break;
      cap = isMajorPunct(**(p++));
    } else cap = 0;
    *(r++) = ' ';
  }
  *r = 0;
  return result;

}

static char *stringop_chars(const char *str)
{
  return appLexer(lexChars, str);
}

static char *stringop_lextext(const char *str)
{
  return appLexer(lexText, str);
}

static char *stringop_words(const char *str)
{
  return appLexer(words, str);
}

static char *stringop_unlextext(const char *str)
{
  return appUnlexer(unlexText, str);
}

static char *stringop_unwords(const char *str)
{
  return appUnlexer(unwords, str);
}

GF_StringOp gf_stringOp(const char *op)
{
  if (!strcmp(op, "chars")) return stringop_chars;
  if (!strcmp(op, "lextext")) return stringop_lextext;
  if (!strcmp(op, "words")) return stringop_words;
  if (!strcmp(op, "unlextext")) return stringop_unlextext;
  if (!strcmp(op, "unwords")) return stringop_unwords;
  return NULL;
}
