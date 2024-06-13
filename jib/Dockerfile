# Use Azul Zulu OpenJDK 17 with Ubuntu as the base image
FROM azul/zulu-openjdk:17-ubuntu

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=dev3
ENV CMIS_USERID=your_userid
ENV CMIS_PASSWORD=your_password

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Set the working directory
WORKDIR /app

# Copy the Java application files
COPY target/your-app.jar /app/your-app.jar

# Copy the Node.js application files
COPY src/main/jib /app

# Install npm dependencies
RUN npm install

# Expose the application port
EXPOSE 3000

# Command to run your Java application
CMD ["java", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", "-Dcmis_userid=${CMIS_USERID}", "-Dcmis_password=${CMIS_PASSWORD}", "-jar", "/app/your-app.jar"]

# Command to start your Node.js application
ENTRYPOINT ["npm", "start"]
