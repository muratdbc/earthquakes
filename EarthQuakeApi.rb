require 'HTTParty'
class EarthQuakeApi
	URL='https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

  	def self.get_earthquakes
  	  response=HTTParty.get(URL)
  	  json = JSON.parse(response.body)["features"]
  	end

end