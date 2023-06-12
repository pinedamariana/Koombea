Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario Outline: TC_037_Validate_EpisodeSingle_statuscode <nombreCaso>
    Given path '/episode/<ID>'
    When method get
    Then status <estadoHTTP>

    Examples: 
      | nombreCaso        | ID   | estadoHTTP |
      | Episode found     |    2 |        200 |
      | Episode found     |   51 |        200 |
      | Episode not found |   52 |        404 |
      | Provide an id     | mmmm |        500 |

  Scenario: TC_038_Validate_EpisodeSingle__responseHeader
    Given path '/episode/2'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('server') == 'Netlify'
    And match karate.response.header('vary') == 'Accept-Encoding'

  Scenario: TC_039_Validate_EpisodeSingle_Response Payload
    Given path '/episode/4'
    And def reqBody = read("data7.json")
    When method get
    Then status 200
    And match $ == reqBody
    And match $.id == '#number'
    And match $.name == '#string'
    And match $.episode == '#string'
    And match $.characters != null
