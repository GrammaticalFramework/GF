//////////////////////////////////////////////////////////////////////////////
// This file is part of Teyjus.                                             //
//                                                                          //
// Teyjus is free software: you can redistribute it and/or modify           //
// it under the terms of the GNU General Public License as published by     //
// the Free Software Foundation, either version 3 of the License, or        //
// (at your option) any later version.                                      //
//                                                                          //
// Teyjus is distributed in the hope that it will be useful,                //
// but WITHOUT ANY WARRANTY; without even the implied warranty of           //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            //
// GNU General Public License for more details.                             //
//                                                                          //
// You should have received a copy of the GNU General Public License        //
// along with Teyjus.  If not, see <http://www.gnu.org/licenses/>.          //
//////////////////////////////////////////////////////////////////////////////
/****************************************************************************/
/* File types.c. This file contains "abstract syntax" representation of     */
/* type skeletons that is used for parsing those in pervasives.in.          */
/****************************************************************************/
#include <stdlib.h>
#include "types.h"
#include "../util/util.h"

Type mkSortType(char* name)
{
    Type rtPtr = (Type)UTIL_malloc(sizeof(Type_));
    rtPtr -> tag = SORT;
    rtPtr -> data.sort = name;
    return rtPtr;
}

Type mkSkVarType(char* index)
{
    Type rtPtr = (Type)UTIL_malloc(sizeof(Type_));
    rtPtr -> tag = SKVAR;
    rtPtr -> data.skvar = index;
    return rtPtr;
}

Type mkStrFuncType(char* name, char* arity)
{
    Type rtPtr = (Type)UTIL_malloc(sizeof(Type_));
    rtPtr -> tag = FUNC;
    rtPtr -> data.func.name = name;
    rtPtr -> data.func.arity = arity;
    return rtPtr;
}


Type mkStrType(Type func, int arity, TypeList args)
{
    Type rtPtr = (Type)UTIL_malloc(sizeof(Type_));
    rtPtr -> tag = STR;
    rtPtr -> data.str.functor = func;
    rtPtr -> data.str.arity   = arity;
    rtPtr -> data.str.args    = args;
    return rtPtr;
}

Type mkArrowType(Type lop, Type rop)
{
    Type rtPtr = (Type)UTIL_malloc(sizeof(Type_));
    rtPtr -> tag = ARROW;
    rtPtr -> data.arrow.lop = lop;
    rtPtr -> data.arrow.rop = rop;
    return rtPtr;

}

void freeType(Type ty)
{
    if (ty -> tag == SORT) free(ty->data.sort);
    else if (ty -> tag == SKVAR) free(ty->data.skvar);
    else if (ty -> tag == FUNC) {
        free(ty->data.func.name);
        free(ty->data.func.arity);
    } 
    free(ty);
}


TypeList addItem(Type data, TypeList typeList)
{
    TypeList new = (TypeList)UTIL_malloc(sizeof(TypeList_));
    new -> oneType = data;
    if (typeList) new -> next = typeList;
    else new -> next = NULL;
    typeList = new;        
    return typeList;
}

TypeList addItemToEnd(TypeList typeList, Type data)
{
    TypeList new = (TypeList)UTIL_malloc(sizeof(TypeList_));
    new -> oneType = data;
    new -> next = NULL;
    if (typeList) {
        TypeList temp = typeList;
        while (temp -> next) temp = temp -> next;
        temp -> next = new;
    } else typeList = new;
    return typeList;
}

TypeList append(TypeList typeList1, TypeList typeList2)
{
    if (typeList1) {
        TypeList temp = typeList1;
        while (temp -> next) temp = temp -> next;
        temp -> next = typeList2;
    } else typeList1 = typeList2;
    return typeList1;
}
