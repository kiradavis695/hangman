require 'random-word'
# You may need to install this gem to run it? Not sure
# https://rubygems.org/gems/random-word/versions/1.3.0

class HangMan
  def initialize()
    # Generate random word
    RandomWord.exclude_list << /_/	# excludes phrases
    @word = RandomWord.nouns.next
	@word_copy = @word
    @misses = 0
  end

  def word
    @word
  end
  
  def word_copy
    @word_copy
  end
  
  def setWord(word)
	@word = word
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
  if h.word.include? input
	 # Need loop for when word contains input char multiple times
     while h.word.include? input
		 wordCreated.insert(h.word.index(input),input)
		 wordCreated.slice!(h.word.index(input) + 1)
		 # replace letter in original word with _, so that we know it's been changed
		 # in the new word.
		 h.setWord(h.word.sub(input, "_"))				
	 end
  # No - increment misses
  else 
     h.incMisses
  end
  
  # Has user won yet?
  if (!wordCreated.include? "_")
	puts "You win!"
	break
  end

  # TODO: List all letters guessed.
  # TODO: If letter has been guessed, don't let user guess it again (give them a warning)?
  # TODO: If lost, start new game?
  # TODO: Maybe count how many wins/losses?
end

# If we break out of the loop above, game over
h.printHangman
puts "You lose! The word was: #{h.word_copy}"

# FOR DEBUGGING:
# puts h.word
# puts h.length
# puts h.misses