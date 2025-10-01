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

  def find(vertex, first = 0, last = (@vertices.length - 1))
    if first > last
      return nil
    end

    count += 1
    mid = (first + last)/2

    if vertex[0] == @vertices[mid].position[0]
      if vertex[1] == @vertices[mid].position[1]
        return mid
      elsif vertex[1] < @vertices[mid].position[1]
        find(vertex, first, mid - 1)
      else
        find(vertex, mid + 1, last)
      end
    elsif vertex[0] < @vertices[mid].position[0]
      find(vertex, first, mid - 1)
    else
      find(vertex, mid + 1, last)
    end
  end

end