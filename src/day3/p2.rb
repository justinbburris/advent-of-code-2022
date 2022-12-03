PRIORITIES = [*('a'..'z'), *('A'..'Z')].zip(1..52).to_h

priority = File.read('rucksacks.txt').split(/\n/).each_slice(3).sum do |rucksack_group|
  common = rucksack_group.pop.chars
  while rucksack_group.length.positive?
    common = common & rucksack_group.pop.chars
  end

  common.sum { |item| PRIORITIES[item] }
end

puts priority
