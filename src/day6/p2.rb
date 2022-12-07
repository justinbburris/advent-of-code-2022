signal = File.read('signal.txt')

packet = ''
location = signal.chars.each.with_index(1) do |c, i|
  packet += c
  packet = packet[1..-1] if packet.length == 15
  break i if packet.chars.uniq.length == 14
end

# sliding window solution
location = (0..signal.length).each_with_object(14) do |i, location|
  location = i + 14
  break location if signal[i...location].chars.uniq.length == 14
end
