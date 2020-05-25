package com.bciit.project.ChatBook;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(scanBasePackages = {"com.bciit.project.ChatBook"})
public class ChatBookApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChatBookApplication.class, args);
	}

}
