#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "phonebook_opt.h"

/* FILL YOUR OWN IMPLEMENTATION HERE! */
data *findName(char lastname[], entry *pHead)
{
    int key=lastname[0]%26;
    data *cur = pHead[key].pChild;
    while(cur!=NULL) {
        if(!strcmp(cur->lastName,lastname)) {
            return cur;
        }
        cur = cur->pNext;
    }
    return NULL;
}

entry *append(char lastName[], entry *e)
{
    int key=lastName[0]%26;
    data *newData = (data *)malloc(sizeof(data));
    strcpy(newData->lastName, lastName);
    newData->pNext = e[key].pChild;
    e[key].pChild = newData;
    return e;
}
