FROM node:18-slim

# Instalujemy narzędzia systemowe, które mogą być potrzebne przy kompilacji paczek
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Kopiujemy TYLKO package.json na początek
COPY package.json ./

# Instalujemy paczki (pomijając locka, żeby uniknąć konfliktów wersji)
RUN npm install

# Dopiero teraz kopiujemy resztę kodu
COPY . .

EXPOSE 4004

CMD ["npx", "cds-serve"]