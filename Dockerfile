# Use official Node.js 18 image as base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY app/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY app ./

# Expose the port your app runs on
EXPOSE 3000

# Command to start your app
CMD ["node", "app.js"]
