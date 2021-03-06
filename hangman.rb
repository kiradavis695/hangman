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
	@wordCreated = ""
	for i in 1..length
		@wordCreated << "_"
	end
	  @GuessWords = ""
  end

  def word			# getter method
    @word
  end
  
  def word=(word)	# setter method
	@word = word
  end
  
  def word_copy
    @word_copy
  end
  
  def wordCreated
	@wordCreated
  end

  def length
    @word.length
  end

  def misses
    @misses
  end
  def GuessWords
    @GuessWords
  end
		
  # increment misses
  def inc_misses
    @misses = (@misses + 1)
  end

  def print_hangman
	puts "____________"
	puts "|          |"
	puts "|          |"

	# Head
	if (@misses == 0)
	  puts "|"
	  puts "|"
	else
	  puts "|        /. .\\ "
	  puts "|        \\_^_/ "
	end

	# Body (and arms)
	if (@misses == 0 || @misses == 1)
	  puts "|"
	  puts "|"
	elsif (@misses == 2)
	  puts "|          | "
	  puts "|          | "
	elsif (@misses == 3)
	  puts "|       ---| "
	  puts "|          | "
	else
	  puts "|       ---|--- "
	  puts "|          | "
	end

	# Legs
	if (@misses == 5)
	  puts "|         /  "
	  puts "|        /    "
	elsif (@misses == 6)
	  puts "|         / \\ "
	  puts "|        /   \\ "
	else
	  puts "|"
	  puts "|"
	end

	puts "|"
	puts "|__\n"
  end
  
  def game_over
	if misses >= 6
		true
	elsif !@wordCreated.include? "_"
		true
	else
		false
	end
  end
end

# New HangMan object
h = HangMan.new

# While game isn't over, loop
until h.game_over

  # Print hangman
  h.print_hangman

  # Print underscores
  print h.wordCreated
	
  print "\n"
  #Print GuessedWord
  print "Guessed letters: "
  print h.GuessWords

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
# check if the word is already guessed or not	
if h.GuessWords.include? input
    print "You have already guessed this letter"
    print "\n"    
else
  if h.word.include? input
	 # Need loop for when word contains input char multiple times
	  h.GuessWords << input << "-"
     while h.word.include? input
		 h.wordCreated.insert(h.word.index(input),input)
		 h.wordCreated.slice!(h.word.index(input) + 1)
		 # replace letter in original word with _, so that we know it's been changed
		 # in the new word.
		 h.word=(h.word.sub(input, "_"))
	         #add to guess list
	 end
  # No - increment misses
  else 
     h.inc_misses
     #add to Guess list	  
     h.GuessWords << input << "-"
  end
end

  # TODO: If lost, start new game?
  # TODO: Maybe count how many wins/losses?
end

h.print_hangman

# Has user won?
if (!h.wordCreated.include? "_")
	puts "You win!"
	print "\n"
        #Print GuessedWord
	print "Guessed letters: "
        print h.GuessWords
	print "\n"
else
	puts "You lose! The word was: #{h.word_copy}"
	print "\n"
        #Print GuessedWord
	print "Guessed letters: "
        print h.GuessWords
	print "\n"
end 

# FOR DEBUGGING:
# puts h.word
# puts h.length
# puts h.misses
