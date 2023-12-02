fully_contained = File.read('sections.txt').split(/\n/).sum do |section_pair|
  pair1, pair2 = section_pair.gsub('-', '..').split(',').map { |e| eval(e).to_a }

  intersection = pair1 & pair2
  if pair1.length == intersection.length || pair2.length == intersection.length
    1
  else
    0
  end
end
puts fully_contained
