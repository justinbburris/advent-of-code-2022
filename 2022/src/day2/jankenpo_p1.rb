# Game Scores
S_WIN     = 6
S_LOSS    = 0
S_DRAW    = 3
# Play Scores
TRANSLATIONS = {
  'X' => 1, # ROCK
  'Y' => 2, # PAPER
  'Z' => 3, # SISSORS
  'A' => 1, # ROCK
  'B' => 2, # PAPER
  'C' => 3  # SISSORS
}

strategy = File.read('elf_strat.txt').split(/\n/)

rounds = strategy.map do |round|
  theirs, mine  = round.split(' ')
  theirs = TRANSLATIONS[theirs]
  mine   = TRANSLATIONS[mine]

  result = S_LOSS
  if theirs == mine
    result = S_DRAW
  elsif mine == 1 && theirs == 3
    result = S_WIN
  elsif mine == 2 && theirs == 1
    result = S_WIN
  elsif mine == 3 && theirs == 2
    result = S_WIN
  end

  score = mine + result
end

puts rounds.sum
