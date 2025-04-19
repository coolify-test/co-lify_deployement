# Utilise l'image Python officielle
FROM python:3.11-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du projet
COPY . .

# Expose le port (optionnel ici, utile pour info)
EXPOSE 3000

# Commande pour démarrer le serveur
CMD ["python", "manage.py", "runserver", "0.0.0.0:3000"]
