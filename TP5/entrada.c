#include <stdio.h>
#include <stdlib.h>

int funcionUno(char a, float l){
    a += 2;
    return 1;
}

int funcionUno(char a, float l){ //debe tirar error
    a += 2;
    return 1;
}

int main(){
    int a = 1;
    char b = 'a';
    char* c= "Digame usteee, con quien ha venido seniorita";
    char* d = "Hola, que tal, vengo a presentar una denuncia contra la seniorita carolina blanco por violencia y por abuso de autoridad. no me parece que pueda ser autoritaria por hacer el liveshare. saluda atte el dr ezequiel horowitz licenciado en derecho penal";
    char* e = "Mira que la carcel de P E L E L E S es en otro convento CAPOOOOOOOOOOOOO";

    if(a){
        for(;;)
        {
            strcpy(c, "hola");
            while(a < 10){
                b += 2;
                a+= 1;
                continue;
            }

            break;
        }
    }

    printf("Cadena: %s", c);

    return 0;
}