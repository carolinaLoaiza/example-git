Feature: Ejercicios data driven

  Background:
    * def responseLogin = call read('login.feature@login') {'correo' : 'eve.holt@reqres.in', 'contrasena': 'cityslicka'}
    * def token = responseLogin.authToken
    * header Authorization = token
    * url urlBase

    Scenario: Listado de usuarios
      Given path '/api/users'
      When method get
      Then status 200

  Scenario: Crear un usuario
    Given path '/api/users'
    And request {"name": "Toby","job": "dog"}
    When method post
    Then status 201
    And match response == {"id": #string, "name": #string, "job": #string, "createdAt": #string}

    Scenario Outline: Crear usuario con csv - <name>
      Given path '/api/users'
      And request {"name": <name>,"job": <job>}
      When method post
      Then status 201
      And match response.createdAt == "#notnull"
    Examples:
      |read('dataUser.csv')|

  @setup
  Scenario:
    * def data = read ('classpath:examples/dataDriven/data.json')

  Scenario Outline: Listar usuario con json
    Given path '/api/users/' + <id>
    When method get
    Then status 200

    Examples:
      | karate.setup().data |




  Scenario Outline: Listar usuario con json sencillo
    Given path '/api/users/' + <id>
    When method get
    Then status 200

    Examples:
      |  read ('classpath:examples/dataDriven/data.json') |


  Scenario: Crear usuario dinamico
    Given path '/api/users'
    And request read(bodyUserDinamic.json) { nombre: "Toby", profesion:"dog"}
    When method post
    Then status 201
