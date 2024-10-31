#!/bin/bash
# Créer un répertoire de build
BUILD_DIR="dist"
# Supprimer le dossier de build s'il existe déjà
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
# Créer un nouveau dossier de build
echo "Créer le dossier de build DIST"
mkdir "$BUILD_DIR"
# Copier les fichiers sources dans le dossier de build
echo "Copier les fichiers sources dans le dossier de build"
cp index.html "$BUILD_DIR/"
cp script.js "$BUILD_DIR/"
cp style.css "$BUILD_DIR/"
cp Dockerfile "$BUILD_DIR/"
cp build-app.sh "$BUILD_DIR/"
# Compresser les fichiers HTML, CSS et JS
echo "Compression des fichiers..."
for file in index.html script.js style.css; do
    gzip -c "$file" > "$BUILD_DIR/${file}.gz"
done
docker build -t image-from-jenkins .
docker run -d -p 2020:8080 --name container-from-jenkins image-from-jenkins
docker ps
echo "Build terminé."
