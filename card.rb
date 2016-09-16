class Card
  attr_reader :face_value, :revealed

  def initialize(face_value)
    @revealed = false
    @face_value = face_value.to_s
  end

  def display
    if revealed?
      "[#{face_value}]"
    else
      "[face down]"
    end
  end

  def revealed?
    @revealed
  end

  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def ==(other_card)
    return false unless other_card.is_a?(Card)

    self.face_value == other_card.face_value
  end
end
