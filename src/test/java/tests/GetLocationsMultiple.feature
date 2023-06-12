Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_029_Validate_LocationMultiple_statuscode <nombreCaso>
    Given path '/location/<ID1>, <ID2>, <ID3>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso       | ID1 | ID2 | ID3  | estadoHTTP |
      | Locations found  |   4 |   8 | 8888 |        200 |
      | Locations found  |   4 |   8 |      |        200 |
      | Failed for value |   4 |   8 | mmmm |        500 |

  Scenario: TC_030_Validate_LocationMultiple__responseHeader
    Given path '/location/2,6,9'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_031_Validate_LocationMultiple_Response Payload
    Given path '/location/2,89,125'
    And def reqBody = read("data6.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $[0] != null
    And match $[1] != null
    And match $[2] != null
