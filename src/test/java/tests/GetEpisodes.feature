Feature: Test The Rick and Morty API 

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario: TC_032_Validate_Episode_statusCode
    Given path '/episode'
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_033_Validate_Episode_responseTime
    Given path '/episode'
    When method get
    Then status 200
    Then assert responseTime < 1000

  Scenario: TC_034_Validate_Episode_responseHeader
    Given path '/episode'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_035_Validate_Episode_responsePayload
    Given path '/episode'
    When method get
    Then status 200
    And match $.info != null
    And match $.results[0].id == '#number'
    And match $.results[0].name == 'Pilot'
    And match $.results[0].characters != null
    
	Scenario: TC_036_Validate_Episode_documentsperPage
    Given path '/episode'
    When method get
    Then status 200
    And def jsonResponse = response
    And def userCount = jsonResponse.results.length
    And print userCount
    And match userCount == 20
    
    
    
