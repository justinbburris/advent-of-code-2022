signal = File.read('signal.txt')

location = 1
packet = ''
signal.chars.each.with_index(1) do |c, i|
  packet += c
  location = i
  packet = packet[1..-1] if packet.length == 5
  return if packet.chars.uniq.length == 4
end

puts location
