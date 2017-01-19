#include<stdio.h>
#include<string.h>

//Global Variables
int intVarCount = 0;

typedef struct {
    char key[50];
    int value;
} varInt;

varInt getInt(char *key, varInt *ints) {
    for(int c =0;c<10;c++) {
        if(strcmp(ints[c].key, key) == 0) {
            return ints[c];
        }
    }
    varInt x;
    strcpy(x.key, "null");
    x.value = -1;
    return x;
}


void setInt(char *key, int value, varInt *ints) {
    varInt res = getInt(key, ints);
    if(strcmp(res.key, key) == 0) {
        res.key = key;
        res.value = value;
    } else {
        ints[intVarCount].key = key;
        ints[intVarCount].value = value;
    }

}


void printInt(varInt *intx) {
	printf("Key: %s\n", (intx)->key);
	printf("Value: %d\n", intx->value);
}

int main() {
    varInt ints[10];

    strcpy(ints[0].key, "name");
    ints[0].value = 5;

    varInt result = getInt(&"name", &ints);
	printInt(&result);
	return 0;
}