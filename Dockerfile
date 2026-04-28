FROM node:18-slim

# Instalacja narzędzia systemowe, które mogą być potrzebne przy kompilacji paczek
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json ./
# Instalacja paczki (pomijając locka, żeby uniknąć konfliktów wersji)
RUN npm install

COPY . .

EXPOSE 4004

CMD ["npx", "cds-serve"]