overlapping = File.read('sections.txt').split(/\n/).sum do |pairs|
  pair1, pair2 = pairs.gsub('-', '..').split(',').map { |e| eval(e).to_a }

  (pair1 & pair2).length > 0 ? 1 : 0
end
puts overlapping
