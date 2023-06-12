Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_021_Validate_LocationSingle_statuscode <nombreCaso>
    Given path '/location/<ID>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso          | ID   | estadoHTTP |
      | Character found     |    2 |        200 |
      | Character found     |   78 |        200 |
      | Character found     |  126 |        200 |
      | Character not found |  127 |        404 |
      | Provide an id       | mmmm |        500 |

  Scenario: TC_022_Validate_LocationSingle__responseHeader
    Given path '/location/2'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('server') == 'Netlify'

  Scenario: TC_023_Validate_LocationSingle_Response Payload
    Given path '/location/4'
    And def reqBody = read("data4.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $.id == '#number'
    And match $.type == '#string'
    And match $.url == '#string'
    And match $.residents != null
