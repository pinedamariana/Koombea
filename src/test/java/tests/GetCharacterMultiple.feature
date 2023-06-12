Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_013_Validate_CharacterMultiple_statuscode <nombreCaso>
    Given path '/character/<ID1>, <ID2>, <ID3>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso       | ID1 | ID2 | ID3  | estadoHTTP |
      | Characters found |   2 |   3 | 8888 |        200 |
      | Characters found |   2 |   3 |      |        200 |
      | Number failed    |   2 |   3 | mmmm |        500 |

  Scenario: TC_014_Validate_CharacterMultiple__responseHeader
    Given path '/character/2,6,9'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_015_Validate_CharacterMultiple_Response Payload
    Given path '/character/2,89,222'
    And def reqBody = read("data3.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $[0] != null
    And match $[1] != null
    And match $[2] != null
