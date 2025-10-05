class Vertex
  attr_accessor :position, :possible_moves, :previous_move

  def initialize(position, possible_moves)
    @position = position
    @possible_moves = possible_moves
    @previous_move = nil
  end
end