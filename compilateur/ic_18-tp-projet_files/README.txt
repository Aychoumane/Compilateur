Ichou Aymane L3B , 21007668 
Projet : Interprétation et compilation 

La commande pour compiler le projet est "dune build". 
Lors de l'exécution d'un fichier test situé dans le dossier ./tests. 
Pour tester un fichier test, il faut utiliser la commande suivante(après avoir compilé) : 
./main.exe ./tests./"nom_du_fichier"

Fonctionnalités implémentés. 

Le langage ressemble à une du C, dans le sens où chaque instruction doit terminer par ";" .
Les opérations + , - , / , * ont été implémentés. 
Les commentaires et le parenthésage fonctionne également. 
La déclaration de variable, assignation et les retours .
Une variable peut être déclarer et assigner en une seule fois : var zoo = 1 + 2 ; 
La gestion des entiers , des booléens , des variables.
Une variable commence forcement par une lettre, mais peut être constitué de minuscules et/ou majuscules et/ou chiffre.

Cependant une erreur reste permanente dans mon compilateur lors de l'execution dans spim: 
Exception 12  [Arithmetic overflow]  occurred and ignored
1Exception occurred at PC=0x00400094
Arithmetic overflow

Je pense que c'est une erreur de gestion de la pile, mais je n'en suis pas sur. Malheureusement, je m'en suis aperçu que trop tard. 


