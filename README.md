# 🚀 TranscribeAI - Script d'automatisation de déploiement

Ce dépôt contient le script de déploiement centralisé pour l'écosystème TranscribeAI. Il permet d'installer, de configurer et de lancer l'intégralité de l'infrastructure (Frontend, Backend, Workers, et Services IA) en une seule commande. Je vous recommande de lire toutes la documentation avec de lancer le script.

## 🛠️ Pré-requis

* Système : Linux (Ubuntu recommandé)

* Outils : git, docker et le plugin docker compose.

* Matériel : Un GPU NVIDIA architecture blackwell avec nvidia-container-toolkit installé et le runtime nvidia configuré.

## 📋 Présentation du script

### Vérification des Dépendances :
* Contrôle la présence de docker compose (ou de l'ancien exécutable docker-compose).
* Alerte l'utilisateur avec la commande d'installation en cas d'absence.

### Gestion des Sources :

* Télécharge les 4 micro-services depuis GitHub :
    - [Frontend-TranscribeAI](https://github.com/Neilllllllll/Frontend-TranscribeAI.git)
    - [Backend-TranscribeAI](https://github.com/Neilllllllll/Backend-TranscribeAI.git)
    - [Reverse-Proxy-TranscribeAI](https://github.com/Neilllllllll/Reverse-Proxy-TranscribeAI.git)
    - [whisperservice-transcribeAI](https://github.com/Neilllllllll/whisperservice-transcribeAI.git)

* Nettoyage automatique : Supprime les dossiers existants avant de re-cloner pour garantir que vous travaillez sur la version la plus récente du code (évite les conflits de merge).

### Configuration Interactive (.env) :

* Détecte si un fichier de configuration existe déjà.
* Propose un mode interactif pour définir vos secrets (Mot de passe DB, Clés API).
* Génère automatiquement le fichier .env utilisé par Docker Compose.

### Déploiement Docker :

* Lance le build des images.
* Démarre les conteneurs en mode "détaché" (-d).

## 📋 Présentation des micro-services

### Frontend-TranscribeAI

Interface web React dont le role est de récupérer les fichiers audio ou d'enregistrer l'utilisateur afin de l'envoyer au backend.

Documentation complète : https://github.com/Neilllllllll/Frontend-TranscribeAI.git

### Backend-TranscribeAI

Diviser en 2, un worker et une API REST 
Documentation complète : https://github.com/Neilllllllll/Frontend-TranscribeAI.git
- [Reverse-Proxy-TranscribeAI](https://github.com/Neilllllllll/Reverse-Proxy-TranscribeAI.git)
- [whisperservice-transcribeAI](https://github.com/Neilllllllll/whisperservice-transcribeAI.git)

