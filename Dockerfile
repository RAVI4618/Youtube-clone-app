# Use a smaller base image to reduce the final image size
FROM node:16-slim

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies, including Material-UI 5
RUN npm install --production

# Copy the rest of the application code to the working directory
COPY . .

# Build the React app
RUN npm run build

# Use a multi-stage build to reduce the final image size
# Start a new stage from a minimal base image
FROM nginx:alpine

# Copy the build output from the previous stage
COPY --from=0 /app/build /usr/share/nginx/html

# Expose the port that the app will run on
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
