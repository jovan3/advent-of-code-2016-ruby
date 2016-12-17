@instructions = File.read('input').split(', ')

@dir_vectors = {:north => [0,1], :east => [1,0], :west => [-1,0], :south => [0,-1]}
@directions = [:north, :east, :south, :west]

@dir = :north
@location = [0,0]
@through_positions = [[0,0]]
@search_first = true

def vect_add(vect1, vect2)
  [vect1, vect2].transpose.map {|x| x.reduce(:+)}
end

def vect_mult(vector, scalar)
  vector.map {|item| item * scalar}
end

def parse_instruction(instruction)
  parsed = instruction.split(/(L|R)/)
  length = parsed.pop.to_i
  turn = parsed.pop
  return turn, length
end

def move_through_positions(new_dir_vector, length)
  positions = (1..length).map {|current_length| vect_add(@location, vect_mult(new_dir_vector, current_length)) }
end

def get_through_pos(new_dir_vector, length)
  through_positions = move_through_positions(new_dir_vector, length)
  through_positions.each do |pos|
    if @through_positions.include?(pos)
      @search_first = false
      puts "Distance " + pos.map {|item| item.abs}.reduce(:+).to_s
    end
  end if @search_first
  return through_positions
end

def move(instruction)
  turn, length = parse_instruction(instruction)
  @dir = @directions[(@directions.index(@dir) + (turn.eql?("L") ? -1 : 1)) % 4]
  new_dir_vector = @dir_vectors[@dir]
  through_positions = get_through_pos(new_dir_vector, length)
  @through_positions = @through_positions + through_positions
  @location = through_positions.last
end

@instructions.each {|instruction| move(instruction)}
