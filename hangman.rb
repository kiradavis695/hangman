require 'random-word'
# You may need to install this gem to run it? Not sure
# https://rubygems.org/gems/random-word/versions/1.3.0

class HangMan
  def initialize()
    # Generate random word
    RandomWord.exclude_list << /_/	# excludes phrases
    @word = RandomWord.nouns.next
    @misses = 0
  end

  def word
    @word
  end

  def length
    @word.length
  end

  def misses
    @misses
  end

  # increment misses
  def incMisses
    @misses = (@misses + 1)
  end

  def printHangman
      puts "____________"
      puts "|          |"
      puts "|          |"

    # Head
    if (misses == 0)
      puts "|"
      puts "|"
    else
      puts "|        /. .\\ "
      puts "|        \\_^_/ "
    end

    # Body (and arms)
    if (misses == 0 || misses == 1)
      puts "|"
      puts "|"
    elsif (misses == 2)
      puts "|          | "
      puts "|          | "
    elsif (misses == 3 || misses == 4)
      puts "|       ---|--- "
      puts "|          | "
    end

    # Legs
    if (misses == 4)
      puts "|         / \\ "
      puts "|        /   \\ "
    else
      puts "|"
      puts "|"
    end

      puts "|"
      puts "|__\n"
  end
end

# New HangMan object
h = HangMan.new

# Print hangman
h.printHangman

# Print underscores
# TODO: change this so that it updates when letters are guessed
for i in 1..h.length
  print "_ "
end

# Print prompt
puts "\n\nEnter a letter: \n"

# Ask for user input
input = gets.chomp  # chomp removes new line character
all? { |e|  }
# Once misses hit six you lose
until h.misses == 6

  # Check if input is actually a letter
  until input =~ /[[:alpha:]]/
    puts "Invalid input"
    puts "\n\nEnter a letter: \n"
    input = gets.chomp
  end
  # Check if letter is in word
    # Yes - change _ to letter
    # No - increment misses
  if h.word include input
    for i in 1..h.length
    if i == h.word.index(input) + 1
        print input
    else
        print "_"
    end
  else 
     for i in 1..h.length
       print "_"
  end
  # ask for input again
  # Check if user has lost

  # If lost, start new game?
  # Maybe count how many wins/losses?
end

# FOR DEBUGGING:
# puts h.word
# puts h.length
# puts h.misses
