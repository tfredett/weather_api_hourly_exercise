Feature: Weather API

  Scenario: Hourly weather report obtainable for a given latitude and longitude
    Given I have a valid latitude and longitude
    When I make a GET request to the hourly weather service
    Then I receive a response with the hourly weather for that region