FROM ubuntu:latest
LABEL maintainer="marley <kmma.960@gmail.com>"

# Installation de Node.js, Git et Nginx
RUN apt-get update && \
    apt-get install -y nodejs npm git nginx && \
    rm -rf /var/lib/apt/lists/*

# Clonage et Build
WORKDIR /app
RUN git clone https://github.com/geek-Konate/Todo-react-.git . && \
    npm install && \
    npm run build && \
    # Copie du résultat du build vers le dossier Nginx
    cp -r dist/* /var/www/html/ 

# Configuration Nginx (Assurez-vous que nginx.conf est à la racine du build ou copiez-le aussi)
# Pour ce test, on utilise une config basique intégrée ou on copie votre fichier local
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]   
