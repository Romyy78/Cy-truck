#include "fonctionsAVL.h"

// Fonction qui renvoie le maximum entre deux entiers
int maximum(int a, int b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

// Fonction qui renvoie le minimum entre deux entiers
int minimum(int a, int b) {
    if (a > b) {
        return b;
    } else {
        return a;
    }
}

// Fonction qui effectue une rotation vers la gauche
AVL* rotationGauche(AVL* a) {
    if (a == NULL) {
        exit(1);
    }
    AVL* pivot;
    int eq_a, eq_p;
    pivot = a->fd;
    a->fd = pivot->fg;
    pivot->fg = a;
    eq_a = a->equilibre;
    eq_p = pivot->equilibre;
    a->equilibre = eq_a - maximum(eq_p, 0) - 1;
    pivot->equilibre = minimum(minimum(eq_a - 2, eq_a + eq_p - 2), eq_p - 1);
    a = pivot;
    return a;
}

// Fonction qui effectue une rotation vers la droite
AVL* rotationDroite(AVL* a) {
    if (a == NULL) {
        exit(1);
    }
    AVL* pivot;
    int eq_a, eq_p;
    pivot = a->fg;
    a->fg = pivot->fd;
    pivot->fd = a;
    eq_a = a->equilibre;
    eq_p = pivot->equilibre;
    a->equilibre = eq_a - minimum(eq_p, 0) + 1;
    pivot->equilibre = maximum(maximum(eq_a + 2, eq_a + eq_p + 2), eq_p + 1);
    a = pivot;
    return a;
}

// Fonction qui effectue une double rotation vers la gauche
AVL* doubleRotationGauche(AVL* a) {
    if (a == NULL) {
        exit(1);
    }
    a->fd = rotationDroite(a->fd);
    return rotationGauche(a);
}

// Fonction qui effectue une double rotation vers la droite
AVL* doubleRotationDroite(AVL* a) {
    if (a == NULL) {
        exit(1);
    }
    a->fg = rotationGauche(a->fg);
    return rotationDroite(a);
}

// Fonction qui équilibre l'AVL en fonction du facteur d'équilibre du nœud
AVL* equilibrerAVL(AVL* a) {
    if (a == NULL) {
        exit(1);
    }
    if (a->equilibre >= 2) {
        if (a->fd->equilibre >= 0) {
            return rotationGauche(a);
        } else {
            return doubleRotationGauche(a);
        }
    } else if (a->equilibre <= -2) {
        if (a->fg->equilibre <= 0) {
            return rotationDroite(a);
        } else {
            return doubleRotationDroite(a);
        }
    }
    return a;
}

// Fonction qui libère la mémoire de l'AVL
void libererMemoire(AVL* a) {
    if (a != NULL) {
        libererMemoire(a->fg);
        libererMemoire(a->fd);
        free(a);
    }
}

