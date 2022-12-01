f = File.read('input.txt')
sorted = f.split(/\n\n/).map do |cals|
  cals.split(/\n/).map(&:to_i).sum
end.sort
puts sorted.last
puts sorted[-3..-1].sum
