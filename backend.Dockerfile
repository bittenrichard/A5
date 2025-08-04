# backend.Dockerfile
# Use uma imagem base com Node.js para rodar sua aplicação
FROM node:18-alpine

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o package.json e o package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale todas as dependências (dev e prod) para que o `tsc` esteja disponível
RUN npm install

# Copie o restante do código do backend
COPY . .

# Execute o build do projeto para compilar o TypeScript para JavaScript
# Esta etapa agora vai funcionar porque o `tsc` está instalado
RUN npm run build:server

# Remova as dependências de desenvolvimento para manter a imagem leve
RUN npm prune --production

# Exponha a porta em que a aplicação Express está rodando
EXPOSE 3001

# Comando para iniciar a aplicação
# -r dotenv/config carrega as variáveis de ambiente
CMD ["cross-env", "NODE_ENV=production", "node", "-r", "dotenv/config", "./dist-server/server.js"]