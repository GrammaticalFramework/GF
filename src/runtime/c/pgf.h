#ifndef PGF_H
#define PGF_H

typedef struct _CId     *CId;
typedef struct _String  *String;
typedef struct _Literal *Literal ;
typedef struct _Type    *Type ;
typedef struct _Expr    *Expr ;
typedef struct _PGF     *PGF ;

PGF readPGF(char *filename);
void freePGF(PGF pgf);

#endif
