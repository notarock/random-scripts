#include <stdio.h>
#include <string.h>

typedef enum { false, true } bool;

// Parcours une phrase et compte de nombre de parenthèses ouvert et fermés
//
int main()
{

    // Vérifie si échec, affiche et quitte
    int exit(bool failed,int total)
    {
        if (failed)
            printf("Les parenthèses sont mal balancé!");
        else
            printf(" Il y a un total de %u couple de parenthèses", total);

        return 0;
    } // exit

    printf ("Entre une phrase à analysé: \n");
    char phrase[500];    // Peut lire 500 caractères maximum, sinon "stack smashing detected"
    scanf("%s",phrase);

    int total = (unsigned)strlen(phrase);
    int count = 0;
    int opened = 0;

    for (int i = 0; i <= total; i++)
    {
        if (phrase[i] == '(')
        {
            count = count + 1;
            opened = opened + 1;
        }
        else if (phrase[i] == ')')
        {
            opened = opened - 1;

            if (opened < 0)
            {
                return exit(true, 0);
            }
        }
    }

    // Vérifie qu'il reste pas de parens ouverte
    return exit((opened != 0 ), count);

} // main
