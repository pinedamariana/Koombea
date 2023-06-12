Feature: Test The Rick and Morty API

  Background: 
    * url 'https://rickandmortyapi.com/api'
    * def query = {episode:'S01E01'}

  Scenario: TC_043_Validate_Episode_by filter episode_statuscode
    Given path '/episode'
    And params query
    When method get
    Then status 200
    And print response
    Then assert responseStatus == 200

  Scenario: TC_044_Validate_Episode_by filter episode_responseTime
    Given path '/episode'
    And params query
    When method get
    Then status 200
    Then assert responseTime < 1000

  Scenario: TC_045_Validate_Episode_by filter episode__responseHeader
    Given path '/episode'
    And params query
    When method get
    Then status 200
    And match karate.response.header('content-type') == 'application/json; charset=utf-8'
    And match karate.response.header('server') == 'Netlify'

  Scenario: TC_046_Validate_Episode_by filter episode_Response Payload
    Given path '/episode'
    And params query
    And def reqBody = read("data9.json")
    And print reqBody
    When method get
    Then status 200
    And match $ == reqBody
    And match $.info != null
    And match $.results[0].id == '#number'
    And match $.results[0].url == '#string'
    And match $.results[0].name == 'Pilot'

  Scenario: TC_047_Validate_Episode_by filter episode_Notfound
    Given path '/episode'
    And def new = {episode:'S01E01', name:'lalalala'}
    And params new
    When method get
    And print response
    And print responseStatus
    Then assert responseStatus == 404
