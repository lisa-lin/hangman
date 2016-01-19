
class Game
	attr_accessor :secret_word, :board, :guess, :missed, :max_misses, :wrong_letters
	
	def initialize
		@secret_word = draw_word.split(//)
		@board = make_board
		@guess ||= "x"
		@missed = 0
		@max_misses = 7
		@wrong_letters = []
	end
	
	def draw_word
		dictionary = "5desk.txt"
		# Remove record separators from words and pick one between 5 and 12 characters
		secret_word = File.readlines(dictionary).sample.chomp.downcase until secret_word.to_s.length.between?(5, 12)
		secret_word
	end
	
	def make_board
		"_" * @secret_word.length
	end
	
	def start
		puts "Welcome to HANGMAN!"
		puts "I've chosen my word. Guess one letter per turn. You only get 7 incorrect guesses."
		puts @secret_word
		
		until @missed == @max_misses
			puts "Choose a letter"
			puts @board
			@guess = gets.chomp
			check_guess
		end
		
		game_over if @missed == @max_misses
	end

	def check_guess
		# Updates board if user's guess is correct
		@secret_word.each_with_index do |letter, lindex|
			if letter == @guess
          	@board[lindex] = @guess
        	end
    	end
    	# Increases missed count if secret word does not include user's guess
   		@missed += 1 unless (@secret_word.include? (@guess))
   		wrong_letters << @guess if @secret_word #does not include guess
   		puts "Wrong letters: #{wrong_letters.join(",")}"
   		misses_left = @max_misses - @missed
   		puts "You have #{misses_left} misses left."
  	end

	def game_over
		puts "Sorry, you're hanged! (X_X)" if @missed == @max_misses
		exit
	end
end

g = Game.new
g.start