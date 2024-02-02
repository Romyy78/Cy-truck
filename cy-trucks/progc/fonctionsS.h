#ifndef fonctionsS_h
#define fonctionsS_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Déclarations des fonctions pour les opérations sur la structure AVL
AVL* creerAVL_s(int id_trajet, float distance);
float moyenne(AVL* a);
AVL* ajouterAVL_s(AVL* a, float distance, int id_trajet, int* h);
AVL* creerAVLtrier_s(float min, float max, float moy, int id_trajet);
AVL* ajouterAVLtrier_s(AVL* a, float min, float max, float moy, int id_trajet, int* h);
AVL* copier_trier_s(AVL* ancienAVL, AVL** nouveauAVL, int* h);
void stockageDonnees_s(AVL* a, char* mode, FILE* fichierSortie, int* compteur);

#endif

