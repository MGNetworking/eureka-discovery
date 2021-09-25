package fr.sid.eurekdiscovery.web;

import fr.sid.eurekdiscovery.component.ConfigurationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RefreshScope
@RestController
public class controleurEtatConfig {

    @Autowired
    ConfigurationService configurationService;

    @GetMapping(value = "/config-eureka")
    public ConfigurationService getConfigurationService(){
        return configurationService;
    }
}
