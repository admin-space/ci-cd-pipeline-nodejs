# Use official Node.js 18 image as base
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy package files and install dependencies
COPY app/package*.json ./
RUN npm install

# Copy rest of the app code
COPY app ./

# Expose port (if your app listens on 3000)
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
