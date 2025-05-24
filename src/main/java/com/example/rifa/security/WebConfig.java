package com.example.rifa.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry
                .addMapping("/**")                    // Aplica a todas las rutas del backend
                .allowedOrigins("*")                  // Permite cualquier origen
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*");                 // Permite cualquier cabecera
        // No incluimos allowCredentials(true) para evitar conflictos con "*"
    }
}
