#ifndef fonctionsAVL_h
#define fonctionsAVL_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Définition de la structure AVL
typedef struct AVL {
int id_trajet; // Identifiant du trajet
int id_etape; // Identifiant de l'étape
float distance; // Distance de l'étape
float min; // Valeur minimale pour la distance
float max; // Valeur maximale pour la distance
float moy; // Valeur moyenne pour la distance
float diff; // Différence max-min pour la distance
char ville[50]; // Ville de départ ou d'arrivée d'une étape
int *tab_id; // Tableau d'identifiants de trajet
float *tab_distance; // Tableau de distances
int compteur_total; // Compteur pour savoir combien de fois une ville est traversée
int compteur_depart; // Compteur pour savoir combien de fois une ville est la ville de départ d'un trajet
int compteur_distance; // Compteur pour savoir combien il y a de distances dans le tableau
struct AVL *fg; // Fils gauche de l'AVL
struct AVL *fd; // Fils droit de l'AVL
int equilibre; // Facteur d'équilibre d'un nœud
} AVL;

int maxi(int a, int b);
int mini(int a, int b);
AVL *rotationGauche(AVL *a);
AVL *rotationDroite(AVL *a);
AVL *doubleRotationGauche(AVL *a);
AVL *doubleRotationDroite(AVL *a);
AVL *equilibrerAVL(AVL *a);
void libererMemoire(AVL *a);

#endif
