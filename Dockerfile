# build-env
FROM maven:3.6.3-jdk-8-slim As build-env
WORKDIR /root
COPY pom.xml ./
RUN mvn dependency:resolve -PPROD
COPY src ./src
RUN mvn clean package -DskipTests

# runtime-env
FROM azul/zulu-openjdk-alpine:11-jre
ENV JAVA_OPTS="-Xms512m -Xmx1024m -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+PrintGCApplicationStoppedTime -XX:+PrintGCApplicationConcurrentTime -XX:+PrintHeapAtGC -Xloggc:/softleader/log/gc-%t.log"
COPY --from=build-env /root/target/app.jar /tmp/webapps/app.jar
CMD java $JAVA_OPTS -jar /tmp/webapps/app.jar