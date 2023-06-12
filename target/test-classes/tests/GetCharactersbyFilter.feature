Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'
    * def query = {gender:'female', status:'dead'}

  Scenario: TC_006_Validate_Character_by filter female & dead_statuscode
    Given path '/character'
    And params query
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_007_Validate_Character_by filter female & dead_responseTime
    Given path '/character'
    And params query
    When method get
    Then status 200
    Then assert responseTime < 1500

  Scenario: TC_008_Validate_Character_by filter female & dead__responseHeader
    Given path '/character'
    And params query
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_009_Validate_Character_by filter female & dead_Response Payload
    Given path '/character'
    And params query
    And def reqBody = read("data.json")
    And print reqBody
    When method get
    Then status 200
    And match $ == reqBody
    And match $.info != null
    And match $.results[0].name == 'Bearded Lady'

