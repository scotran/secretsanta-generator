# Secret Santa Generator Application :santa:

A __secret santa generator web application__ built using __Spring Boot technologies__, __Thymeleaf views__, __JPA__, __MYSQL Database__, and more. The project features Spring Model, View, and Controller (MVC) architecture and Service and Repository layers.

This project is based on the popular Christmas game __Secret Santa__ where friends draw names from a hat to decide who they are required to give a present to. This project allows users to add names, and the project randomly generates secret santa matches (it isn't as simple as creating random pairs). There are different solutions to the "Secret Santa problem" as the problem essentially creates a directed graph. 

**Preview images** :small_red_triangle_down:
<details>
<summary>Some images of the application </summary>

* Welcome Page

![Welcome](https://github.com/NotTheBest/secretsanta-generator/blob/master/preview-images/welcomepage.png?raw=true)

* Add People

![Add](https://github.com/NotTheBest/secretsanta-generator/blob/master/preview-images/addpage.png?raw=true)

* Generate "Matches"

![Matches](https://github.com/NotTheBest/secretsanta-generator/blob/master/preview-images/generatepage.png?raw=true)

</details>

## Running the application locally

Secret Santa Generator is a Spring Boot application built using Maven. You can build a jar file and run it from the command line:

```
git clone https://github.com/NotTheBest/secretsanta-generator.git
cd secretsanta-generator
./mvnw package
java -jar target/*.jar
```
You can then access the application here: http://localhost:8080/

![Welcome](https://github.com/NotTheBest/secretsanta-generator/blob/master/preview-images/welcomepage.png?raw=true)

Or you can run it from Maven directly using the Spring Boot Maven plugin.

```
./mvnw spring-boot:run
```

## Database Configuration
This project uses an MYSQL database 
## About

This project was a personal project to learn more about Spring development, database management, and industry application architecture.

A small summary of the skills showcased during this project: :small_red_triangle_down:

* Java Spring Core, HTML5, CSS and similar topics
* Spring MVC Controller and View management & annotations
* Spring Boot capabilities, annotations, usage, and deployment
* Thymeleaf technology, syntax, usage, capabilities, more
* Client/Server data transfer
* JPA annotations and repository management
* MYSQL database management
* Software/web application development processes
* MVC architecture along with DAO, model, service layers, and similar
* Accessibility, web design
* Web application debugging
* Where Santa lives
* More! :)
