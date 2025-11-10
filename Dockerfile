# Use official Node.js 18 image as base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json from the root
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code (including app folder)
COPY . .

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["node", "app/app.js"]
