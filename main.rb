require './lib/graph'
require './lib/vertex'

test = Graph.new(8)

test.knight_moves([0, 0], [3, 3])
test.knight_moves([0, 0], [7, 7])
test.knight_moves([3, 3], [4, 3])
