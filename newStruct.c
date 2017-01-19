#include<stdio.h>
#include<string.h>

struct varDouble{
    char key[50];
    double value;
    struct varDouble *next;
};

struct varDouble *headVarDouble = NULL;

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

void setVarDouble(char *key, double value) {
    if(headVarDouble == NULL) {
        struct varDouble newOne;
        strcpy(newOne.key, key);
        newOne.value = value;
        newOne.next = NULL;
        headVarDouble = &newOne;
    } else {
        struct varDouble *result = getVarDouble(key);
        if(result != NULL) {
            result->value = value;
        } else {
            struct varDouble *last = getLastVarDouble();
            struct varDouble newLast;
            strcpy(newLast.key, key);
            newLast.value = value;
            newLast.next = NULL;
            last->next = &newLast;
        }
    }
}

int main() {
    /*
    struct varDouble newOne;
    strcpy(newOne.key, "bo");
    newOne.value = 5.0;

    struct varDouble newTwo;
    strcpy(newTwo.key, "bob");
    newTwo.value = 9.0;
    newTwo.next = NULL;

    newOne.next = &newTwo;
    headVarDouble = &newOne;
    */
    setVarDouble("bo", 5.0);
    setVarDouble("boo", 6.0);
    printf("Key: %s, value %f\n", headVarDouble->key, headVarDouble->value);
    printf("Key: %s, value %f\n", headVarDouble->next->key, headVarDouble->next->value);
    

    struct varDouble *result = getVarDouble("bo");
    if(result != NULL) {
        printf("Key: %s, value %f\n", result->key, result->value);
    } else {
        printf("Not Found\n");
    }


    result = getVarDouble("bob");
    if(result != NULL) {
        printf("Key: %s, value %f\n", result->key, result->value);
    } else {
        printf("Not Found\n");
    }

    return 0;
}
