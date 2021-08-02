## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)

## General info

The purpose of this micro service is to list all the micro-services of the server to which it is assigned. 
All its micro services must register as soon as they are launched.

this service cannot be used alone, since it works in duo with a service Gateway type

## Technologies
this project is created with :
* Spring boot version : 2.4.5

## Setup 
To run this project, you will need to set up the application-dev.properties environment
file and must be set with Maven goals. For example Maven goals and running spring boot

`$ mvn clean install -Pdev spring.run`

