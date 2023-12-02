PRIORITIES = [*('a'..'z'), *('A'..'Z')].zip(1..52).to_h

priority = File.read('rucksacks.txt').split(/\n/).sum do |rucksack|
  compartment_size = rucksack.length / 2
  compartment1 = rucksack[0...compartment_size].chars
  compartment2 = rucksack[compartment_size..-1].chars

  (compartment1 & compartment2).sum { |item| PRIORITIES[item] }
end

puts priority
