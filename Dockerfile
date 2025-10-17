# Use official Tomcat image with JDK 11
FROM tomcat:9-jdk11
LABEL maintainer="bhupesh@thegreatcoder.com"

# Remove default apps from Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file built by Maven
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
