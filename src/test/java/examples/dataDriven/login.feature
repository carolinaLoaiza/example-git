Feature: Caso login

  @login
  Scenario: Caso Exitoso
    Given url urlBase
    And path '/api/login'
    And request {"email" : #(correo), "password": #(contrasena)}
    When method post
    Then status 200
    * def authToken = response.token

  Scenario Outline: Caso Exitoso 2
    Given url urlBase
    And path '/api/login'
    And request {"email" : <correo>, "password": <contrasena>}
    When method post
    Then status 200
    * print response

    Examples:
      | correo             | contrasena |
      | eve.holt@reqres.in | cityslicka |