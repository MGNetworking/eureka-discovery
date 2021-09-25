package fr.sid.eurekdiscovery.component;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.*;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.StreamSupport;

@Component
@Slf4j
public class ConfigurationService {

    @Autowired
    private Environment environment;

    public Map<String,String> getProperties() {

        List<String> listProperties = new ArrayList<>();

        Map<String, String> param = new HashMap<>();

        param.put("name", environment.getProperty("spring.application.name"));
        param.put("Profile", environment.getProperty("info.profile"));

        param.put("eureka hostname", environment.getProperty("eureka.instance.hostname"));
        param.put("eureka fetch-registry", environment.getProperty("eureka.client.fetch-registry"));
        param.put("eureka register-with-eureka", environment.getProperty("eureka.client.register-with-eureka"));

        param.put("logging file name", environment.getProperty("logging.file.name"));
        param.put("logging level spring controller", environment.getProperty("logging.level.org.springframework.controller"));
        param.put("logging level hibernate", environment.getProperty("logging.level.org.hibernate"));

        param.put("management.endpoints.web.exposure.include", environment.getProperty("management.endpoints.web.exposure.include"));


        return param;
    }


}
