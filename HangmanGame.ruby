$winning = 0
$losing = 0

file = File.open("words.txt")
$words = file.readlines.map(&:chomp)
file.close

$letters_used = {}
$index = rand($words.length())
$answer = $words[$index]
$is_playing = true
$guess_correct = false

def hangman()
  puts "|----"
  puts "   O"
  puts "  /|\\"
  puts "  / \\"
end

def blank_word(answer_length)
  blank = "-" * answer_length
  return blank
end

def main()
  guess = ""
  blank = blank_word($answer.length())

  while $is_playing
    puts "\e[H\e[2J"
    case $losing
    when 0
      puts "|----"
    when 1
      puts "|----"
      puts "   O"
    when 2
      puts "|----"
      puts "   O"
      puts "   |"
    when 3
      puts "|----"
      puts "   O"
      puts "  /|"
    when 4
      puts "|----"
      puts "   O"
      puts "  /|\\"
    when 5
      puts "|----"
      puts "   O"
      puts "  /|\\"
      puts "  /"
    end

    puts blank

    puts "Guess the word!"
    guess = gets.chomp()

    if $letters_used.key?(guess)
      puts "Letter already used..."
      next
    else
      $letters_used[guess] = true
    end

    for i in 0..$answer.length()
      if guess == $answer[i]
        blank[i] = guess
        $winning += 1
        $guess_correct = true
      end
    end

    if $guess_correct == false
      $losing += 1
    end

    if $winning == $answer.length()
      puts "Congratulations! You win!"
      puts $answer
      $is_playing = false
    end

    if $losing == 6
      hangman()
      $is_playing = false
    end

    $guess_correct = false

  end
end

main()
