layout, instructions = File.read('crates.txt').split(/\n\n/)
crates = layout.split(/\n/)[0...-1].map do |c|
  c.chars.each_slice(4).map { |x| x.join.gsub(/\[|\]| /, '') }
end

crate_map = crates.reverse.each_with_object({}) do |crates, map|
  crates.each.with_index(1) do |crate, i|
    map[i.to_s] ||= []
    map[i.to_s] << crate if crate != ''
  end
end

instructions.split(/\n/).each do |instruction|
  _, count, _, start, _, stop = instruction.split(' ')

  count.to_i.times do
    moving_crate = crate_map[start].pop
    crate_map[stop] << moving_crate
  end
end

crate_map.map { |(column, stack)| stack[-1] }.join
