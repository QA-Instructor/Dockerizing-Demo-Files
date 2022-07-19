
# Set the base image to node:17-alpine
FROM node:17-alpine as build

# Specify where our app will live in the container
WORKDIR /app

# Copy the React App to the app directory in the container
COPY . /app/

# Install the app dependencies
RUN npm install
# Build a production version
RUN npm run build

# Prepare nginx
FROM nginx:1.21.6-alpine
# Copy the built react app from alpine container to nginx container
COPY --from=build /app/build /usr/share/nginx/html
# Copy our new config file for nginx
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
