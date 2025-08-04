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

# Comando para iniciar a aplicação através do npm, que resolve o "cross-env"
# É necessário que no seu package.json tenha um script chamado "start:prod"
CMD ["npm", "run", "start:prod"]