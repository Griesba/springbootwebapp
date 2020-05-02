# a linux runtime environment
FROM centos

# install java; `-y` defaults questions to 'yes'
RUN yum install -y java

# where Spring Boot will store temporary files
VOLUME /tmp

# self-explanatory
WORKDIR /

# add fat jar as "myapp.jar"
ADD /target/spring-boot-web-0.0.1-SNAPSHOT.jar myapp.jar

# updates dates on the application (important for caching)
RUN sh -c 'touch ./myapp.jar'

# provide a hook into the webapp
EXPOSE 8080

# run the application; the `urandom` gets tomcat to start faster
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]