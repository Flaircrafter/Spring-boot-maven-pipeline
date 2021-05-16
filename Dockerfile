# Pull base image 
From tomcat:jdk8-adoptopenjdk-openj9 

# Maintainer 
MAINTAINER "random"
 
COPY ./SpringBootMavenExample-1.3.5.RELEASE.war /usr/local/tomcat/webapps
