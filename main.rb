require './EarthQuake'


if ARGV.length != 1
  puts "We need exactly one argument"
  exit
end 
earthquake=Earthquake.new
for arg in ARGV
    case arg
    when "--top5"
      earthquake.get_top_states(5).map { |e| puts "#{e[0]},#{e[1]}"  }
    when "--california"
      state=arg[2..-1].capitalize 
      earthquake.get_top_n_earthquakes(state,25).each do | e |
        earthquake_date=Time.strptime(e["properties"]["time"].to_s, '%Q')
        eartquake_place=e["properties"]["place"]
        earthquake_magntitude=e["properties"]["mag"]
        puts "A #{earthquake_magntitude} eartquake" +
        " happened #{eartquake_place}"+ 
        " at #{earthquake_date}"
      end
    else
      puts "Wrong argument!"
    end
end
