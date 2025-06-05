# Demo ArgoCD - Innov'Tech Talks

Ce dépôt contient une application de démonstration simple pour illustrer le déploiement avec ArgoCD.

## Structure du projet

- `/docker` : Contient tout le code source et les scripts pour builder et exécuter l'application
  - `Dockerfile` : Configuration pour conteneuriser l'application
  - `app.py` : Application Python simple
  - `build-color-demo.sh` : Script pour builder l'image Docker
  - `run-demo-apps.sh` : Script pour lancer les applications de démonstration
  - `delete-demo-apps.sh` : Script pour supprimer les applications de démonstration

## Prérequis

- Docker
- Docker Compose (optionnel)

## Comment lancer l'application

1. Construire l'image Docker :
   ```bash
   cd docker
   ./build-color-demo.sh
   ```

2. Lancer l'application :
   ```bash
   ./run-demo-apps.sh
   ```

3. Pour arrêter et nettoyer :
   ```bash
   ./delete-demo-apps.sh
   ```

## Utilisation

L'application est accessible sur `http://localhost:8080` par défaut après le démarrage.

---

*Ce projet est une démonstration pour les Innov'Tech Talks sur ArgoCD.*
