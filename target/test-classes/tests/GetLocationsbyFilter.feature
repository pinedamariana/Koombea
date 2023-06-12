Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'
    * def query = {type:'Planet', dimension:'Replacement Dimension'}

  Scenario: TC_024_Validate_Location_by filter type & dimension_statuscode
    Given path '/location'
    And params query
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_025_Validate_Location_by filter type & dimension_responseTime
    Given path '/location'
    And params query
    When method get
    Then status 200
    Then assert responseTime < 1500

  Scenario: TC_026_Validate_Location_by filter type & dimension__responseHeader
    Given path '/location'
    And params query
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('server') == 'Netlify'

  Scenario: TC_027_Validate_Location_by filter type & dimension___Response Payload
    Given path '/location'
    And params query
    And def reqBody = read("data5.json")
    And print reqBody
    When method get
    Then status 200
    And match $ == reqBody
    And match $.info != null
    And match $.results[0].id == '#number'
    And match $.results[0].name == 'Purge Planet'

  Scenario: TC_028_Validate_Location_by filter type & dimension_Notfound
    Given path '/location'
    And def new = {type:'Planet', dimension:'lalalala'}
    And params new
    When method get
    And print response
    And print responseStatus
    Then assert responseStatus == 404
