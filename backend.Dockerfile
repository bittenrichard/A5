# backend.Dockerfile
# Use uma imagem base com Node.js para rodar sua aplicação
FROM node:18-alpine

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o package.json e o package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale todas as dependências (dev e prod) para o build funcionar
RUN npm install

# Copie o restante do código do backend para o container
COPY . .

# Execute o build do projeto para compilar o TypeScript para JavaScript
RUN npm run build:server

# Exponha a porta em que a aplicação Express está rodando
EXPOSE 3001

# Comando para iniciar a aplicação através do npm
CMD ["npm", "run", "start:prod"]