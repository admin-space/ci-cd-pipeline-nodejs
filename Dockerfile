FROM node:18

WORKDIR /app

# Copy app folder contents
COPY app/package*.json ./
RUN npm install

# Copy rest of the app
COPY app .

EXPOSE 3000
CMD ["node", "app.js"]
