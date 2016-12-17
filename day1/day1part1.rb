@instructions = File.read('input').split(', ')

@dir_vectors = {:north => [0,1], :east => [1,0], :west => [-1,0], :south => [0,-1]}
@directions = [:north, :east, :south, :west]

@dir = :north
@location = [0,0]

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

def move(instruction)
  turn, length = parse_instruction(instruction)
  @dir = @directions[(@directions.index(@dir) + (turn.eql?("L") ? -1 : 1)) % 4]
  new_dir_vector = @dir_vectors[@dir]
  @location = vect_add(@location, vect_mult(new_dir_vector, length))
end

@instructions.each {|instruction| move(instruction)}
puts @location.reduce(:+)
