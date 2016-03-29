# encoding: utf-8

# B: 96% ↑ (0:14)
# B: 20% ↓ (0:30)
# B: 100% ↔

acpi_output = %x[/usr/bin/acpi].split("\n").map { |output|
  output.split(' ').map{|i| i.gsub(',', '')}
}

status_symbols = {
  'Unknown'     => ":3",
  'Full'        => ":D",
  'Charging'    => ":)",
  'Discharging' => ":("
}

level_colors = {
  'red'         => (0..9),
  'yellow'      => (10..19),
  'green'       => (20..100)
}

outputs = acpi_output.each_with_index.map { |output, i|
  output_percentage = output[3].dup

  battery_level = case output_percentage.delete('%').to_i
                  when level_colors['red']
                    "<fc=#dc322f>#{output_percentage}</fc>"
                  when level_colors['yellow']
                    "<fc=#b58900>#{output_percentage}</fc>"
                  when level_colors['green']
                    "<fc=#859900>#{output_percentage}</fc>"
                  else
                    "<fc=#00FF00>#{output_percentage}</fc>"
                  end

  symbol = status_symbols[output[2]]

  time = if output[4]
           time_orig = output[4].split(':')
           "(#{time_orig[0]}:#{time_orig[1]})"
         else
           "(F)"
         end

  "Bat #{i}: #{battery_level} #{symbol} #{time}"
}

puts outputs.join(" | ")
