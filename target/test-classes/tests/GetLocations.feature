Feature: Test The Rick and Morty API 

  Background: 
    * url 'https://rickandmortyapi.com/api'

  Scenario: TC_016_Validate_Location_statusCode
    Given path '/location'
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_017_Validate_Location_responseTime
    Given path '/location'
    When method get
    Then status 200
    Then assert responseTime < 1000

  Scenario: TC_018_Validate_Location_responseHeader
    Given path '/location'
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('Vary') == 'Accept-Encoding'

  Scenario: TC_019_Validate_Location_responsePayload
    Given path '/location'
    When method get
    Then status 200
    And match $.info != null
    And match $.results[0].id == '#number'
    And match $.results[0].name == 'Earth (C-137)'
    And match $.results[0].residents != null
    
	Scenario: TC_020_Validate_Location_documentsperPage
    Given path '/location'
    When method get
    Then status 200
    And def jsonResponse = response
    And def userCount = jsonResponse.results.length
    And print userCount
    And match userCount == 20
    
    
    
