# Slim version of node
FROM node:lts-alpine3.17

# Set the working directory
WORKDIR /app

# Copy the package file
COPY ./data/bapi/package.json /app

# Copy the code into the container
COPY ./data/bapi/app.js /app

# Install dependencies
RUN npm install

# Set the command to run your application
CMD ["npm", "start"]