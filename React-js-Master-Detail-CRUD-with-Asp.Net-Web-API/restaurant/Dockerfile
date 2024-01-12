# Fetching the latest node image on apline linux
FROM node:16-alpine as builder

# Declaring env
ENV NODE_ENV production

# Setting up the work directory
WORKDIR /app

# Installing dependencies
COPY ./package.json ./
RUN npm install

# Copying all the files in our project
COPY . .

# Building our application
RUN npm run build

# Fetching the latest nginx image
FROM nginx:1.19.0
COPY nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
# # Copying our nginx.conf
# Fetching the latest node image on alpine linux
# FROM node:16-alpine AS development

# # Declaring env
# ENV NODE_ENV development

# # Setting up the work directory
# WORKDIR /react-app

# # Installing dependencies
# COPY ./package*.json /react-app

# RUN npm install

# # Copying all the files in our project
# COPY . .

# # Starting our application
# CMD ["npm","start"]