# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if available)
# This helps leverage Docker cache for installing dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code into the container
COPY . .

# Expose the port that your app will run on
EXPOSE 3000

# Command to run your app
CMD ["npm", "start"]
