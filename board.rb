require_relative 'card'
require 'colorize'

class Board
  CARD_FACES = %w(pig sheep cow chicken llama)
  CARD_FACES.map! { |card| card.center(9) }

  attr_reader :grid

  def initialize(size = 10)
    @grid = populate(size)
  end

  def populate(requested_size)
    grid = []
    until grid.size >= requested_size
      CARD_FACES.each do |card_face|
        card = Card.new(card_face)
        grid << card << card.dup
      end
    end

    grid.shuffle
  end

  def render
    system("clear")
    puts ""

    i = 0
    until i >= grid.size
      5.times do |j|
        case grid[i + j].revealed?
        when true
          print "#{grid[i + j].display} ".green
        else
          print "#{grid[i + j].display} "
        end
      end
      print "\b\n"
      i += 5
    end
  end

  def won?
      @grid.all? { |card| card.revealed? }
  end

  def reveal(guess_pos)
    grid[guess_pos].reveal unless grid[guess_pos].revealed?

    grid[guess_pos].face_value
  end

  def [](pos)
    @grid[pos]
  end
end
