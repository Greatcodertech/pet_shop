# 1. Use official Tomcat image
FROM tomcat:9.0

# 2. Set working directory to the Tomcat webapps folder
WORKDIR /usr/local/tomcat/webapps/

# 3. Remove default ROOT webapp (optional)
RUN rm -rf ROOT

# 4. Copy your WAR file from pet_shop/target/ into Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# 5. Expose port
EXPOSE 8080

# 6. Start Tomcat
CMD ["catalina.sh", "run"]
