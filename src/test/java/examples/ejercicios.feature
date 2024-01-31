Feature: Ejercicios clase 4


  Scenario: Caso1
    Given url 'https://jsonplaceholder.typicode.com'
    And path '/posts/100'
    When method get
    Then status 200
    And match responseType == 'json'
    * print response
    And match $.id == 10


  Scenario: Caso2
    Given url 'https://reqres.in'
    And path '/api/users'
    And param page = 2
    When method get
    Then status 200
    And match responseType == 'json'
    * print response
    And match response.data[2].id == 9

  Scenario: Caso3
    Given url 'https://reqres.in'
    And path '/api/users'
    And request {"name": "Toby","job": "dog"}
    When method post
    Then status 201
    And match responseType == 'json'
    * print response
    And match response.name == 'Toby'

  Scenario: Caso3 - crear usuario con docString en variable
    * def body =
    """
      {
        "name": "Toby",
        "job": "dog"
      }
    """
    Given url 'https://reqres.in'
    And path '/api/users'
    And request body
    When method post
    Then status 201
    And match responseType == 'json'
    * print response
    And match response.name == 'Toby'


  Scenario: Caso5 - crear usuario con Json file
    * print read("bodyUser.json")
    Given url 'https://reqres.in'
    And path '/api/users'
    And request read("bodyUser.json")
    When method post
    Then status 201
    And match responseType == 'json'
    * print response
    And match response.name == 'Toby'

  Scenario: Caso6 - login (no nulo)
    Given url 'https://reqres.in'
    And path '/api/login'
    And form field email = 'eve.holt@reqres.in'
    And form field password = 'cityslicka'
    When method post
    Then status 200
    And match responseType == 'json'
    * print response
    And match response.token == "#notnull"

  Scenario: Caso7 - update user
    * def id = 3
    * def body =
    """
      {
        "name": "Toby",
        "job": "dog"
      }
    """
    Given url 'https://reqres.in'
    And path '/api/users/' + id
    And request body
    When method put
    Then status 200
    And match responseType == 'json'
    * print response
    And match response.name == 'Toby'
    And match response.job == 'dog'
    And match response.updatedAt == "#notnull"

  Scenario: Caso8 - login no exitoso
    Given url 'https://reqres.in'
    And path '/api/register'
    And form field email = 'eve.holt@reqres.in'
    When method post
    Then status 400
    And match responseType == 'json'
    * print response
    And match response.error == "Missing password"

  Scenario: Caso9 - Delete
    * def id = 3
    Given url 'https://reqres.in'
    And path '/api/users/' + id
    When method delete
    Then status 204
    * print response

