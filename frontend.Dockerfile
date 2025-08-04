# Use uma imagem base do Node.js para o estágio de build
FROM node:18 AS build

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o .npmrc, package.json e o package-lock.json
COPY .npmrc package*.json ./

# Instale todas as dependências
RUN npm install

# Copie o restante do código do frontend
COPY . .

# Execute o build do projeto para produção
RUN npm run build

# Use uma imagem leve do Nginx para servir os arquivos estáticos
FROM nginx:alpine AS serve

# Copie o arquivo de configuração do Nginx para o local correto
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie a pasta 'dist' gerada pelo build para o diretório padrão do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exponha a porta 80, que é a porta padrão do Nginx
EXPOSE 80

# Inicie o Nginx
CMD ["nginx", "-g", "daemon off;"]