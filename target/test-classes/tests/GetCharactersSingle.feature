Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_010_Validate_CharacterSingle_statuscode <nombreCaso>
    Given path '/character/<ID>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso          | ID   | estadoHTTP |
      | Character found     |    2 |        200 |
      | Character found     |   78 |        200 |
      | Character found     |  826 |        200 |
      | Character not found |  827 |        404 |
      | Provide an id       | mmmm |        500 |

  Scenario: TC_011_Validate_CharacterSingle__responseHeader
    Given path '/character/2'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_012_Validate_CharacterSingle_Response Payload
    Given path '/character/2'
    And def reqBody = read("data1.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $.id == '#number'
    And match $.status == '#string'
    And match $.gender == '#string'
