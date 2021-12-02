input = File.open('input')
data = input.read.split.map(&:to_i)
increases = 0
triple_increases = 0
data.each_with_index do |number, index|
  next if index.zero?
  next unless data[index - 1] < number

  increases += 1
end
p "Number of increases: #{increases}"
data.each_with_index do |number, index|
  next if [0, 1, 2].include? index

  first_number = data[index - 1] + data[index - 2] + data[index - 3]
  second_number = number + data[index - 1] + data[index - 2]

  next unless second_number > first_number

  triple_increases += 1
end
p "Number of triples: #{triple_increases}"
