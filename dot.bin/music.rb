# encoding: utf-8


def format_status(status)
  case status
  when "playing"
    "<fc=#859900>\u203A</fc>"
  when "paused"
    "<fc=#b58900>||</fc>"
  else
    "<fc=#dc322f>\u00d7</fc>"
  end
end

begin
  output = %x[/usr/bin/mpc].split("\n")
  track = output[0]
  status = format_status(output[1].split(" ")[0].gsub("[", "").gsub("]", ""))
  time = output[1].split(" ")[2]
  percentage = output[1].split(" ")[3]

  puts "[#{status}] #{track} [#{time} #{percentage}]"
rescue
  puts "(<fc=#dc322f>stopped</fc>)"
end
