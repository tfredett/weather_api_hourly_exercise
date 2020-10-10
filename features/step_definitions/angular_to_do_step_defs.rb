require 'rest-client'
require_relative '../endpoints/forecast/hourly.rb'
include HourlyAPI
HOURLY_URL = 'https://api.weather.gov/gridpoints/{office}/{grid X},{grid Y}/forecast/hourly'.freeze

# Raleigh, NC Codes used by weather.gov
OFFICE_CODE = 'RAH'.freeze
GRID_X_CODE = 73.freeze
GRID_Y_CODE = 57.freeze

@response = nil

Given('I have a valid latitude and longitude') do
  # Empty Method here, its hard coded above for the coordinates of Raleigh, NC
end

When('I make a GET request to the hourly weather service') do
  url = generate_hourly_url(OFFICE_CODE, 
                            GRID_X_CODE,
                            GRID_Y_CODE)
  @response = RestClient.get(url)
end

Then('I receive a response with the hourly weather for that region') do
  periods_json = periods_json(@response)
  expect(periods_json.size).to be > 1
  validate_period_format(periods_json.first)
end