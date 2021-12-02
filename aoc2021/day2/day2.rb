input = File.open('input').read.split("\n")
depth = 0
horizontal_position = 0
input.each do |instruction|
  value = instruction[-1].to_i
  case instruction
  when /^f/
    horizontal_position += value
  when /^d/
    depth += value
  else
    depth -= value
  end
end
puts "Part 1 - Horizontal: #{horizontal_position}, Depth: #{depth} and answer is #{horizontal_position * depth}."

depth = 0
horizontal_position = 0
aim = 0
input.each do |instruction|
  value = instruction[-1].to_i
  case instruction
  when /^f/
    horizontal_position += value
    depth += value * aim
  when /^d/
    aim += value
  else
    aim -= value
  end
end
puts "Part 2 - Horizontal: #{horizontal_position}, Depth: #{depth} and answer is #{horizontal_position * depth}."
