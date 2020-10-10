require 'rest-client'
require 'json'

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
  url = HOURLY_URL.sub('{office}', OFFICE_CODE)
                  .sub('{grid X}', GRID_X_CODE.to_s)
                  .sub('{grid Y}', GRID_Y_CODE.to_s)

  @response = RestClient.get(url)
end

Then('I receive a response with the hourly weather for that region') do
  response_json = JSON.parse(@response.body)
  expect(response_json['properties']['periods'].size).to be > 1
  validate_period_format(response_json['properties']['periods'].first)
end


def validate_period_format(period)
  expect(period['number']).to be_a(Integer)
  expect(period['name']).to be_a(String)
  expect(DateTime.parse(period['startTime'])).to be_a(DateTime)
  expect(DateTime.parse(period['endTime'])).to be_a(DateTime)
  expect(period['isDaytime'].class).to satisfy { |clazz| clazz == TrueClass || clazz == FalseClass }
  expect(period['temperature']).to be_a(Integer)
  expect(period['temperatureUnit']).to be_a(String)
  expect(period['temperatureTrend']).to be_nil
  expect(period['windSpeed']).to be_a(String)
  expect(period['windDirection']).to be_a(String)
  expect(period['icon']).to be_a(String)
  expect(period['shortForecast']).to be_a(String)
  expect(period['detailedForecast']).to be_a(String)
end