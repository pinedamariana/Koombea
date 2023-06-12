Feature: Test The Rick and Morty API 

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario: TC_001_Validate_Character_statusCode
    Given path '/character'
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_002_Validate_Character_responseTime
    Given path '/character'
    When method get
    Then status 200
    Then assert responseTime < 1000

  Scenario: TC_003_Validate_Character_responseHeader
    Given path '/character'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_004_Validate_Character_responsePayload
    Given path '/character'
    When method get
    Then status 200
    And match $.info != null
    And match $.results[0].id == '#number'
    And match $.results[0].name == 'Rick Sanchez'
    And match $.results[0].episode != null
    
	Scenario: TC_005_Validate_Character_documentsperPage
    Given path '/character'
    When method get
    Then status 200
    And def jsonResponse = response
    And def userCount = jsonResponse.results.length
    And print userCount
    And match userCount == 20
    
    
    
