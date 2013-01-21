# encoding: utf-8

require 'json'
require 'net/http'

def styled_temp(temp)
  if temp < 15.0
    "<fc=#AAC0FF>#{temp}</fc>"
  elsif temp < 20.0
    "<fc=#FFFF00>#{temp}</fc>"
  else
    "<fc=#FF0000>#{temp}</fc>"
  end
end

begin
  uri = URI('http://weather.yahooapis.com/forecastjson?w=638242&u=c')
  info = JSON.parse(Net::HTTP.get(uri))

  temp_today = styled_temp(info["condition"]["temperature"])
  cond_today = info["condition"]["text"].downcase
  temp_next = styled_temp(info["forecast"].first["high_temperature"])
  cond_next = info["forecast"].first["condition"].downcase
  temp_tomorrow = styled_temp(info["forecast"].last["high_temperature"])
  cond_tomorrow = info["forecast"].last["condition"].downcase

  puts "#{cond_today} #{temp_today} (f: #{cond_next} #{temp_next}, #{cond_tomorrow} #{temp_tomorrow})"
rescue
  puts "N/A"
end
