package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/")
    public Result get() {
        return Result.builder().id(1L).name("Rhys").empId("132").build();
    }
}
