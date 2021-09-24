package fr.sid.eurekdiscovery.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class controleurEureka {

    @Autowired
    Environment environment;

    public Map<String,String> getProperties() {

        List<String> listProperties = new ArrayList<>();

        Map<String, String> param = new HashMap<>();

        param.put("name", environment.getProperty("spring.application.name"));
        param.put("Profile", environment.getProperty("info.profile"));

        param.put("server.port", environment.getProperty("server.port"));
        param.put("path logging file", environment.getProperty("logging.file.path"));
        param.put("Level logging Controller Spring", environment.getProperty("logging.level.org.springframework.controller"));
        param.put("Level logging hibernate", environment.getProperty("logging.level.org.hibernate"));

        param.put("management.endpoints.web.exposure.include", environment.getProperty("management.endpoints.web.exposure.include"));

        return param;
    }


}
