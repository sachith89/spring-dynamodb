package com.example.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedClient;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;

import java.net.URI;

@Configuration
public class AppConfig {

    @Value("${amazonProperties.accessKey:default_access_key}")
    private String accessKey;
    @Value("${amazonProperties.secretKey:default_secret_key}")
    private String secretKey;

    @Bean
    public DynamoDbClient getDynamoDbClient() {
//        AwsCredentialsProvider credentialsProvider = DefaultCredentialsProvider.builder()
//                .profileName("local")
//                .build();

        AwsBasicCredentials credentials = AwsBasicCredentials.create(this.accessKey, this.secretKey);

        return DynamoDbClient.builder()
                .endpointOverride(URI.create("http://localhost:8000"))

                .region(Region.US_WEST_2)

                .credentialsProvider(StaticCredentialsProvider.create(credentials))
                .build();
    }

    @Bean
    public DynamoDbEnhancedClient getDynamoDbEnhancedClient() {
        return DynamoDbEnhancedClient.builder()
                .dynamoDbClient(getDynamoDbClient())
                .build();
    }

}

