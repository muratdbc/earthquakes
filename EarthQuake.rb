require './EarthQuakeApi'
require './StatesHelper'

class Earthquake
	include StatesHelper

	def initialize
		earthquake_file=File.read('earthquakes.json')
		@earthquakes=JSON.parse(earthquake_file)
		# to read from the api 	uncomment the line below 
		# and comment the line above 
		# @earthquakes=EarthQuakeApi.get_earthquakes() 
	end

	def get_top_n_earthquakes(place,n)
		@earthquakes
		.sort_by { |e| -e['properties']['mag'].to_f }
		.select {|e| e['properties']['place'].include?(place)}[0..n-1]
	end
	def get_top_states(n)
		@earthquakes
		.reject{|e| e['properties']['place'].scan(/, (.+)/).last.nil?}
		.select{|e| name=e['properties']['place'].scan(/, (.+)/).last.first; 
			STATES_J.key?(name) 
		}
		.map! { |e| name=e['properties']['place'].scan(/, (.+)/).last.first;
			if STATES_H.key?(name)
				e.merge!({"state"=>STATES_H[name]})
			else
				e.merge!({"state"=>name})
			end
		}
		.group_by{|e|  e["state"]}
		.map{|k,v| [k,v.size]}
		.sort_by{ |e| -e[1].to_i}[0..n-1]
	end
	
end

