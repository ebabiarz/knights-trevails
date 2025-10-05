class Graph
  attr_accessor :vertices, :vertices_array

  def initialize(size)
    @vertices = create_graph(size)
    @vertices_array
  end

  def add_previous_moves(current_vertex, moves)
    if current_vertex.previous_move == nil
      return moves
    else
      moves.unshift(@vertices[current_vertex.previous_move].position)
      add_previous_moves(@vertices[current_vertex.previous_move], moves)
      return moves
    end
  end

  def knight_moves(start_point, end_point, current_vertex = @vertices[find(start_point)], previous_moves = [@vertices.index(current_vertex)], moves = [], queue = [])
    if start_point == end_point
      moves.unshift(current_vertex.position)
      add_previous_moves(current_vertex, moves)
      clear_previous_moves
      give_response(moves)
    else
      current_vertex.possible_moves.each do |move|
        if previous_moves.include?(move) == false
          queue.push(@vertices[move])
          @vertices[move].previous_move = @vertices.index(current_vertex)
          previous_moves.push(move)
        end
      end

      next_vertex = queue.shift
      knight_moves(next_vertex.position, end_point, next_vertex, previous_moves, moves, queue)  
    end
  end

  def give_response(moves)
    puts "You made it in #{moves.length} moves! Here's your path:"
    moves.each do |move|
      p move
    end
  end

  def clear_previous_moves
    @vertices.each do |vertex|
      vertex.previous_move = nil
    end
  end

  def create_graph(size)
    vertices_array = create_vertex_array(size)
    @vertices_array = vertices_array
    vertices = []

    vertices_array.each_index do |index|
      vertices[index] = Vertex.new(vertices_array[index], add_possible_moves(vertices_array[index], vertices_array))
    end

    return vertices
  end

  def get_possible_moves(vertex, vertices_array)

    moves = [[(vertex[0] + 1), (vertex[1] + 2)]]
    moves << [(vertex[0] + 1), (vertex[1] - 2)]
    moves << [(vertex[0] - 1), (vertex[1] - 2)]
    moves << [(vertex[0] - 1), (vertex[1] + 2)]
    moves << [(vertex[0] + 2), (vertex[1] + 1)]
    moves << [(vertex[0] + 2), (vertex[1] - 1)]
    moves << [(vertex[0] - 2), (vertex[1] - 1)]
    moves << [(vertex[0] - 2), (vertex[1] + 1)]

    return moves
  end

  def add_possible_moves(vertex, vertices_array)
    possible_moves = []

    moves = get_possible_moves(vertex, vertices_array)

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