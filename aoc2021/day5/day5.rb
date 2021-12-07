input = File.open('input').read.split("\n")

def setup_input(input)
  revised_input = input.map { |pair| pair.split(' -> ') }
  revised_input.each_with_index do |coordinate_pair, index|
    split_pairs = (coordinate_pair.map { |coordinate| coordinate.split(',') })
    split_pairs[0].map!(&:to_i)
    split_pairs[1].map!(&:to_i)
    revised_input[index] = split_pairs
  end
end

def horizontal_or_vertical?(coordinate_pair)
  coordinate_pair[0][0] == coordinate_pair[1][0] || coordinate_pair[0][1] == coordinate_pair[1][1]
end

# Function only designed to handle horizontal or vertical lines.
def intermediate_points(coordinate_pair)
  x_one = coordinate_pair[0][0]
  y_one = coordinate_pair[0][1]
  x_two = coordinate_pair[1][0]
  y_two = coordinate_pair[1][1]
  intermediate_points = []
  i = 0
  if x_one == x_two
    points = points(y_one, y_two)
    points.length.times do
      intermediate_points << [x_one, points[i]]
      i += 1
    end
  else
    points = points(x_one, x_two)
    points.length.times do
      intermediate_points << [points[i], y_one]
      i += 1
    end
  end
  intermediate_points
end

def points(point_one, point_two)
  (point_one..point_two).to_a.empty? ? (point_two..point_one).to_a : (point_one..point_two).to_a
end

def convert_coord_to_index(coordinate)
  x = coordinate[0]
  y = coordinate[1]
  x + (1000 * y)
end

def create_positional_array(size = 1000)
  y = 0
  positional_array = []
  while y < size
    x = 0
    while x < size
      positional_array << 0
      x += 1
    end
    y += 1
  end
  positional_array
end

def main_loop(coordinate_list)
  i = 0
  positional_array = create_positional_array
  while i < coordinate_list.length
    if horizontal_or_vertical?(coordinate_list[i])
      points = intermediate_points(coordinate_list[i])
      points.each do |point|
        index = convert_coord_to_index(point)
        positional_array[index] += 1
      end
    end
    i += 1
  end
  positional_array
end

def count_anomalies(array)
  count = 0
  array.each do |element|
    count += 1 if element > 1
  end
  count
end

parsed_input = setup_input(input)
answer_array = main_loop(parsed_input)
p count_anomalies(answer_array)
