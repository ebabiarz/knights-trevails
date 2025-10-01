class Vertex
  attr_accessor :position, :possible_moves

  def initialize(position, possible_moves = [])
    @position = position
    @possible_moves = possible_moves
  end
end