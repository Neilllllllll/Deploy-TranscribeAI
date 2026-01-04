#!/bin/bash

# Sécurités Bashœ
set -e
set -o pipefail

echo "===================================================="
echo "🎯 Script de Déploiement Automatisé TranscribeAI"
echo "===================================================="

# --- 1. VÉRIFICATION DES DÉPENDANCES ---
check_dependencies() {
    echo "--- 1. VÉRIFICATION DES DÉPENDANCES ---" 
    if docker compose version >/dev/null 2>&1; then
        DOCKER_CMD="docker compose"
    elif docker-compose version >/dev/null 2>&1; then
        DOCKER_CMD="docker-compose"
    else
        echo "❌ Erreur: Docker Compose n'est pas installé. Veuillez l'installer avec la commande : sudo apt install docker compose"
        exit 1
    fi
    echo "✅ Docker Compose détecté ($DOCKER_CMD)"
}

# --- 2. GESTION DES DÉPÔTS ---
manage_repos() {
    REPOS=(
        "https://github.com/Neilllllllll/Frontend-TranscribeAI.git"
        "https://github.com/Neilllllllll/Backend-TranscribeAI.git"
        "https://github.com/Neilllllllll/Reverse-Proxy-TranscribeAI.git"
        "https://github.com/Neilllllllll/whisperservice-transcribeAI.git"
    )

    for repo in "${REPOS[@]}"; do
        dir_name=$(basename "$repo" .git)
        if [ -d "$dir_name" ]; then
            echo "🗑️  Nettoyage : Suppression de $dir_name existant..."
            rm -rf "$dir_name"
        fi
        echo "📥 Clonage de $dir_name..."
        git clone "$repo"
    done
}

# --- 4. CONFIGURATION INTERACTIVE .ENV ---
manage_env() {
    ENV_FILE=".env"
    SHOULD_FILL=true

    if [ -f "$ENV_FILE" ]; then
        read -p "📝 Un fichier .env existe déjà. Voulez-vous le modifier ? (y/n) : " change_env
        if [[ ! "$change_env" =~ ^[Yy]$ ]]; then
            SHOULD_FILL=false
        fi
    fi

    if [ "$SHOULD_FILL" = true ]; then
        echo "⚙️  Remplissage interactif du .env :"
        read -p "DB Password [password123]: " DB_PASS
        DB_PASS=${DB_PASS:-password123}
        
        read -p "API Secret Key [1234]: " API_SEC
        API_SEC=${API_SEC:-1234}

        read -p "Modèle Whisper par défaut [${SELECTED_MODEL:-base}]: " WHISP_NAME
        WHISP_NAME=${WHISP_NAME:-${SELECTED_MODEL:-base}}

        cat <<EOF > .env
DB_USER=postgres
DB_PASSWORD=$DB_PASS
DB_NAME=job_db
DB_HOST=postgres
DB_PORT=5432
REDIS_HOST=redis
REDIS_PORT=6379
API_SECRET_KEY=$API_SEC
FRONTEND_API_KEY=$API_SEC
WHISPER_MODEL_NAME=$WHISP_NAME
WHISPER_MODEL_PATH=/models
LOCAL_MODELS_DIR=$HOME/models
AUDIO_STORAGE_PATH=/shared_storage/audio
WHISPER_SERVICE_URL=http://batch-transcription:5001
FRONTEND_URL=http://localhost:3000
EOF
        echo "✅ Fichier .env mis à jour."
    fi
}

# --- EXÉCUTION ---
check_dependencies
manage_repos
manage_env

echo "🏗️  Lancement de Docker Compose..."
$DOCKER_CMD up --build -d

echo "🎉 Déploiement terminé !"