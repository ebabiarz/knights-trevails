class Graph
  attr_accessor :vertices, :vertices_array

  def initialize(size)
    @vertices = create_graph(size)
    @vertices_array
  end

  def create_graph(size)
    vertices_array = create_vertex_array(size)
    @vertices_array = vertices_array
    vertices = []

    vertices_array.each_index do |index|
      vertices[index] = Vertex.new(vertices_array[index])
    end

    vertices.each_index do |index|
      vertices[index].possible_moves = get_possible_moves(vertices_array[index], vertices_array)
    end

    return vertices
  end

  def get_possible_moves(vertex, vertices_array)
    possible_moves = []

    moves = [[(vertex[0] + 1), (vertex[1] + 2)]]
    moves << [(vertex[0] + 2), (vertex[1] + 1)]
    moves << [(vertex[0] - 1), (vertex[1] - 2)]
    moves << [(vertex[0] - 2), (vertex[1] - 1)]

    moves.each do |move|
      if vertices_array.index(move) != nil
        possible_moves.push(vertices_array.index(move))
      end
    end
    return possible_moves
  end

  def create_vertex_array(size, vertices = [], vertex = [0, 0])
    while vertex[0] <= size - 1
      while vertex[1] <= size - 1
        vertices.push(vertex.dup)
        vertex[1] += 1
      end

      vertex[0] += 1
      vertex[1] = 0
    end
    return vertices
  end

  def find(vertex, root = @vertices.length/2)
    left = root/2
    if (root/2) * 3 > @vertices.length - 1
      right = @vertices.length - 1
    else
      right = (root/2) * 3  
    end
    

    if vertex[0] == @vertices[root].position[0]
      if vertex[1] == @vertices[root].position[1]
        return root
      elsif vertex[1] < @vertices[root].position[1]
        offset = (@vertices[root].position[1] - vertex[1])
        find(vertex, root - offset)
      else
        offset = (vertex[1] - @vertices[root].position[1])
        find(vertex, root + offset)
      end
    elsif vertex[0] < @vertices[root].position[0]
      find(vertex, left)
    else
      find(vertex, right)
    end
  end
end