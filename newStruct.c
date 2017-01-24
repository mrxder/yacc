#include<stdio.h>
#include<string.h>
#include<stdlib.h>

//This is the definition of our struct
struct varDouble{
    char key[50];
    double value;
    struct varDouble *next;
};

//This is the global head variable
struct varDouble *headVarDouble = NULL;


//This function returns a pointer to the found Variable or NULL if it don't exists.
struct varDouble* getVarDouble(char *key) {
    struct varDouble *result = NULL;
    struct varDouble *pointer = NULL;
    pointer = headVarDouble;
    while(result == NULL && pointer != NULL) {
        if(strcmp(pointer->key, key) == 0) {
            return pointer;
        }
        pointer = pointer->next;
    }
    return NULL;
}

double getDoubleValue(char *key){
    struct varDouble *pointer = getVarDouble(key);
    double value = pointer->value;
    return value;    
    
}

//This function returns the pointer to the tail of the list
struct varDouble* getLastVarDouble() {
    struct varDouble *pointer = NULL;
    pointer = headVarDouble;
    while(1) {
        if(pointer->next == NULL) {
            return pointer;
        }
        pointer = pointer->next;
    }

}

//This function simply prints the variable
void printVarDouble(struct varDouble *varPointer) {
    if(varPointer != NULL) { 
        printf("Key:%s Value:%f Addres: %p\n", varPointer->key, varPointer->value, varPointer);
    } else {
        printf("The pointer points to NULL!\n");
    }
}


//This function create a variable or modifies the value if it allready exits
void setVarDouble(char *key, double value) {
    //If there are still no Variables a new one will be stored as head.
    if(headVarDouble == NULL) {
        struct varDouble *newOne;
        newOne = malloc(sizeof(struct varDouble));
        strcpy(newOne->key, key);
        newOne->value = value;
        newOne->next = NULL;
        headVarDouble = newOne;
    } else {
        //If the variable allready exits the value becomes overwritten.
        struct varDouble *result = getVarDouble(key);
        if(result != NULL) {
            result->value = value;
        } else { //If the variable doesn't exist a new one will be created.
            struct varDouble *last = getLastVarDouble();
            struct varDouble *newLast;
            newLast = malloc(sizeof(struct varDouble));
            strcpy(newLast->key, key);
            newLast->value = value;
            newLast->next = NULL;
            last->next = newLast;
        }
    }
}

