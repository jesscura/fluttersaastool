# Multi-stage Dockerfile for Flutter Web App
# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the web app for production
RUN flutter build web --release --web-renderer html

# Stage 2: Serve the app with nginx
FROM nginx:alpine

# Copy the built web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port (Railway will set PORT env var)
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
