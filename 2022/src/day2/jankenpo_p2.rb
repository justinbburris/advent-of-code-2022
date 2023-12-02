# Game Scores
# Play Scores
TRANSLATIONS = {
  'A' => 1,  # ROCK
  'B' => 10, # PAPER
  'C' => 20, # SISSORS
  'X' => 0,  # LOSS
  'Y' => 3,  # TIE
  'Z' => 6   # WIN
}

PLAYS = {
  1  => 3,
  4  => 1,
  7  => 2,

  10 => 1,
  13 => 2,
  16 => 3,

  20 => 2,
  23 => 3,
  26 => 1
}

strategy = File.read('elf_strat.txt').split(/\n/)

rounds = strategy.map do |round|
  theirs, result = round.split(' ')

  theirs = TRANSLATIONS[theirs]
  result = TRANSLATIONS[result]

  my_play = PLAYS[theirs+result]

  score = result + my_play
end

puts rounds.sum
