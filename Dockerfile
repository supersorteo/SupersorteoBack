# Usar una imagen base de Eclipse Temurin Java 23
#FROM eclipse-temurin:23-jdk


#RUN mkdir -p /app/uploads /app/videos
#RUN chmod -R 777 /app/uploads /app/videos

#COPY target/rifa-0.0.1-SNAPSHOT.jar java-app.jar


# Exponer el puerto 8080
#EXPOSE 8080

# Configurar el comando de entrada para ejecutar la aplicación
#ENTRYPOINT ["java", "-jar", "java-app.jar"]

# Stage 1: compila con Maven
FROM maven:3.8-jdk-23 AS builder
WORKDIR /app

# Copia solo lo mínimo para aprovechar cache
COPY pom.xml .
COPY src ./src

# Genera el JAR; skip tests para acelerar
RUN mvn clean package -DskipTests

# Stage 2: imagen ligera de producción
FROM eclipse-temurin:23-jdk
WORKDIR /app

# Carpetas de uploads/videos (si tu app las usa)
RUN mkdir -p uploads videos \
 && chmod -R 777 uploads videos

# Copia el JAR compilado desde el builder
COPY --from=builder /app/target/rifa-0.0.1-SNAPSHOT.jar java-app.jar

# Expón otro puerto, por ejemplo 8081
ENV SERVER_PORT=8081
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "java-app.jar"]
