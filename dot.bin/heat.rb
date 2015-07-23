def color(str)
  temp = str.to_f
  if temp < 20.0
    "<fc=#268bd2>#{str}</fc>"
  elsif temp < 70.0
    "<fc=#b58900>#{str}</fc>"
  else
    "<fc=#dc322f>#{str}</fc>"
  end
end

output = %x[/usr/bin/sensors]

result = output.split("\n").reduce("") do |acc, l|
  if l =~ /Core/
    splitted = l.split(" ")
    "#{acc} #{splitted[1]} #{color(splitted[2])}"
  else
    acc
  end
end

puts result
