require './lib/graph'
require './lib/vertex'

test = Graph.new(8)

test.vertices.each_index do |index|
  puts "Index: #{index}"
  p test.vertices[index]
  puts ""
end

# puts test.find([7, 0])
# puts test.find([5, 1])