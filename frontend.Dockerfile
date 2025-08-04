# Use uma imagem base do Node.js para o estágio de build
FROM node:18 AS build

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o package.json e o package-lock.json
COPY package*.json ./

# Instale as dependências (incluindo devDependencies) e garanta a instalação da dependência nativa
RUN npm install
RUN npm install @rollup/rollup-linux-x64-gnu
RUN npm rebuild

# Copie o restante do código do frontend
COPY . .

# Execute o build do projeto para produção
RUN npm run build

# Use uma imagem leve do Nginx para servir os arquivos estáticos
FROM nginx:alpine AS serve

# Copie a pasta 'dist' gerada pelo build para o diretório padrão do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exponha a porta 80, que é a porta padrão do Nginx
EXPOSE 80

# Inicie o Nginx
CMD ["nginx", "-g", "daemon off;"]