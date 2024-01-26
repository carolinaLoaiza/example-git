Feature: Posts

  @case1
  Scenario: Caso1
    Given url 'https://jsonplaceholder.typicode.com'
    And path '/posts/100'
    When method get
    Then status 200

  @case2
  Scenario: Caso2
    * def id = 100
    Given url 'https://jsonplaceholder.typicode.com'
    And path '/posts/' + id
    When method get
    Then status 200
    * print response


