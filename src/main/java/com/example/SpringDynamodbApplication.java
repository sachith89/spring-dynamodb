package com.example;

import com.example.domain.Order;
import com.example.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RequiredArgsConstructor
public class SpringDynamodbApplication implements CommandLineRunner {

    private final OrderRepository orderRepository;

    public static void main(String[] args) {
        SpringApplication.run(SpringDynamodbApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

        Order order = new Order();
        order.setOrderID("123");
        order.setCustomerID("qwe");
        orderRepository.save(order);

    }
}
