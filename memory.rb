#!/usr/bin/ruby
require_relative 'board'

class Game
  attr_reader :board, :prev_guess

  def choose_difficulty
    system("clear")
    puts "\nWelcome! Choose 'easy', 'medium', or 'hard'"
    print "> "
    level = gets.chomp

    case level
    when 'hard'
      size = 30
    when 'medium'
      size = 20
    else
      size = 10
    end
  end

  def initialize(size = choose_difficulty)
    @board = Board.new(size)
  end

  def play
    welcome_message

    until won?
      board.render

      pos1, pos2 = take_turn
      compare_guess(pos1, pos2)
    end

    winning_message
  end

  def won?
    board.won?
  end

  def compare_guess(pos1, pos2)
    unless @board[pos1] == @board[pos2]
      puts "\nCards did not match! Remember where they were..."
      sleep(2)

      @board[pos1].hide
      @board[pos2].hide
    end
  end

  def take_turn
    pos1 = get_play("first")
    make_guess(pos1)

    pos2 = get_play("second")
    make_guess(pos2)

    @board.render

    [pos1, pos2]
  end

  def get_play(guess_number)
    puts "\nGuess a #{guess_number} card to flip between 1 and #{board.grid.length}"
    guess = gets.chomp.to_i - 1
    until valid_move?(guess)
      puts "Invalid guess!"
      guess = get_play(guess_number)
    end

    guess
  end

  def valid_move?(guess)
    guess >= 0 && guess < board.grid.length
  end

  def make_guess(pos)
    @board.reveal(pos)
  end

  def welcome_message
    system("clear")
    puts "\nOld MacDonald has lost his animals!
    Can you help him find them?"
    sleep(2.5)
    system("clear")
  end

  def winning_message
    puts ""
    puts "Congratulations! Old MacDonald thanks you!"
    puts ""
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
