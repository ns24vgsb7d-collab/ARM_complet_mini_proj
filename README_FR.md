# Mini-projet Datapath ARM

> 🇬🇧 [English version of the README](README.md)

## 1. Aperçu
Ce dépôt contient la conception et la simulation d’un datapath ARM simplifié en VHDL avec le logiciel Xilinx Vivado.  
Le projet a été réalisé dans le cadre du mini-projet du cours d’Architecture des ordinateurs à l’UQTR (Automne 2025).

## 2. Objectifs
L’objectif est d’implémenter un petit processeur ARM simplifié comprenant :
- une ALU (unité arithmétique et logique)  
- un fichier de registres  
- un décodeur d’instructions  
- une logique conditionnelle  
- un compteur ordinal (PC)  
- une mémoire d’instructions  
- des registres de drapeaux (flags)
- rigistre de decalage (shifter)
Chaque module a été testé avec un testbench VHDL et validé à l’aide des simulations d’onde.

## 3. Structure du dépôt
- `src/` : fichiers VHDL  
- `tb/` : testbenches  
- `doc/` : schémas et notes  
- `.gitignore` : fichiers exclus (Vivado, Vitis, etc.)  
- `LICENSE` : licence Apache 2.0  
- `README_FR.md` : documentation du projet  

## 4. Construction et simulation
1. Ouvrir le projet dans Vivado ou exécuter un script TCL.  
2. Lancer les testbenches (`tb_*`) pour vérifier le comportement du système.  
3. Synthétiser le design (les fichiers bitstream ne sont pas inclus dans le dépôt).

## 5. Licence et responsabilité
Le projet est sous la **licence Apache 2.0**.  
Elle permet à toute personne d’utiliser, de modifier ou de partager le code à condition de mentionner l’auteur.  
Cette licence a été choisie car elle est ouverte, facile à réutiliser et inclut une clause de brevet absente de la licence MIT.  
La GPL n’a pas été retenue pour éviter l’obligation d’ouvrir le code dérivé.

### Clause de non-responsabilité
Ce projet est fourni à des fins académiques.  
Je ne suis **pas responsable** des problèmes, dommages ou pertes de données pouvant découler de son utilisation ou de sa modification.  
L’utilisation du code se fait aux risques de l’utilisateur.

## 6. Publication du code
- Le code est partagé pour des raisons de transparence académique.  
- Aucune garantie d’utilisation en contexte industriel.  
- Utiliser un versionnement (`main`, `feat/*`, `fix/*`) et des tags pour les versions.  
- Corriger les bogues avec des tests avant publication.  
- Ne jamais publier d’informations sensibles (mots de passe, clés privées, etc.).

## 7. Sécurité FPGA
En cas d’implémentation sur FPGA :
- utiliser un **démarrage sécurisé (Secure Boot)**,  
- activer le **chiffrement et la signature du bitstream**,  
- désactiver ou protéger le port **JTAG**,  
- stocker les clés dans des zones sûres (eFUSE ou BBRAM).  

Ces mesures limitent les risques de modification non autorisée du matériel.

## 8. Auteur
**Daniel Kabeya**  
Université du Québec à Trois-Rivières (UQTR)  
Département de génie électrique et informatique – Automne 2025
