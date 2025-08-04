# backend.Dockerfile
# Use uma imagem base com Node.js para rodar sua aplicação
FROM node:18-alpine

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o package.json e o package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale as dependências de produção
RUN npm install --omit=dev

# Copie o restante do código do backend para o container
COPY . .

# Exponha a porta em que a aplicação Express está rodando
EXPOSE 3001

# Comando para iniciar a aplicação
# -r dotenv/config carrega as variáveis de ambiente
# NODE_ENV=production define o ambiente como produção
CMD ["sh", "-c", "npm run build:server && cross-env NODE_ENV=production node -r dotenv/config ./dist-server/server.js"]