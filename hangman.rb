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
	elsif (misses == 3)
	  puts "|       ---| "
	  puts "|          | "
	else
	  puts "|       ---|--- "
	  puts "|          | "
	end

	# Legs
	if (misses == 5)
	  puts "|         /  "
	  puts "|        /    "
	elsif (misses == 6)
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

wordCreated = ""
for i in 1..h.length
	wordCreated << "_"
end

# Once misses hit six you lose
until h.misses == 6

	puts h.word
	# puts h.length
	puts h.misses

  # Print hangman
  h.printHangman

  # Print underscores
  print wordCreated

  # Print prompt
  puts "\n\nEnter a letter: \n"

  # Ask for user input
  input = gets.chomp  # chomp removes new line character

  # Check if input is actually ONE letter
  until (input =~ /[[:alpha:]]/ && (input.length == 1))
    puts "Invalid input"
    puts "\n\nEnter a letter: \n"
    input = gets.chomp
  end
  
  # all? { |e| }
  
  # Check if letter is in word
    # Yes - change _ to letter
    # No - increment misses
  # TODO: This only replaces first instance of letter, make it replace all
  if h.word.include? input
     wordCreated.insert(h.word.index(input),input)
     wordCreated.slice!(h.word.index(input) + 1)
  else 
     h.incMisses
  end
  
  # Has user won yet?
  if (!wordCreated.include? "_")
	puts "You win!"
	break
  end

  # If lost, start new game?
  # Maybe count how many wins/losses?
end

# If we break out of the loop above, game over
h.printHangman
puts "You lose!"

# FOR DEBUGGING:
# puts h.word
# puts h.length
# puts h.misses