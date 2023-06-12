Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_040_Validate_EpisodeMultiple_statuscode <nombreCaso>
    Given path '/episode/<ID1>, <ID2>, <ID3>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso       | ID1 | ID2 | ID3  | estadoHTTP |
      | Episode found    |   4 |   8 | 8888 |        200 |
      | Episode found    |   4 |   8 |      |        200 |
      | Failed for value |   4 |   8 | mmmm |        500 |

  Scenario: TC_041_Validate_EpisodeMultiple__responseHeader
    Given path '/episode/2,6,9'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_042_Validate_EpisodeMultiple_Response Payload
    Given path '/episode/2,15,51'
    And def reqBody = read("data8.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $[0] != null
    And match $[1] != null
    And match $[2] != null
