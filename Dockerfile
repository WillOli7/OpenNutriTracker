# Étape 1 : Flutter build (Web)
FROM cirrusci/flutter:latest AS builder

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web --release

# Étape 2 : Serveur Nginx
FROM nginx:alpine
COPY --from=builder /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
