require 'json'
require_relative '../../support/compare_utils'

module HourlyAPI
  include CompareUtils

  HOURLY_URL = 'https://api.weather.gov/gridpoints/{office}/{grid X},{grid Y}/forecast/hourly'.freeze
  PERIOD_FORMAT = {
    number: Integer,
    name: String,
    startTime: DateTime,
    endTime: DateTime,
    isDaytime: TrueClass || FalseClass,
    temperature: Integer,
    temperatureUnit: String,
    temperatureTrend: NilClass,
    windSpeed: String,
    windDirection: String,
    icon: String,
    shortForecast: String,
    detailedForecast: String
  }.freeze

  def generate_hourly_url(office, grid_x, grid_y)
    HOURLY_URL.sub('{office}', office)
              .sub('{grid X}', grid_x.to_s)
              .sub('{grid Y}', grid_y.to_s)
  end

  def periods_json(response)
    JSON.parse(response.body)['properties']['periods']
  end

  def validate_period_format(period)
    PERIOD_FORMAT.keys.each do |key|
      if PERIOD_FORMAT[key] == DateTime
        period[key.to_s] = DateTime.parse(period[key.to_s]) 
      end

      if key == :isDaytime
        expect(boolean?(period['isDaytime'].class)).to eq(true)
        next
      end

      expect(period[key.to_s]).to be_a(PERIOD_FORMAT[key])
    end
  end
end