#include <stdio.h>

#define BUFFERSIZE    16
int main() {
    unsigned char     buf[BUFFERSIZE];
    while(fgets(buf, sizeof buf, stdin)){
        if (buf[strlen(buf)-1] == '\n') {
            // read full line
            printf("<pip-full-line>:%s", buf);
        } else {
            // line was truncated
            printf("<pip-truncated-line>:%s", buf);
        }
    }
    return 0;
}