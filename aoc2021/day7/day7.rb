# frozen_string_literal: true

input = File.open('input').read.split(',')
numbers = input.map(&:to_i)

def group(numbers)
  group = [0]
  numbers.max.times { group << 0 }
  numbers.each { |number| group[number] += 1 }
  group
end

def lowest_fuel(group)
  lowest_fuel = nil
  lowest_position = 0
  i = 0
  fuel_array = generate_fuel_array(group.length)
  while i < group.length
    current_fuel = 0
    group.each_with_index do |number, index|
      current_fuel += (number * fuel_cost(i, index, fuel_array))
      next if lowest_fuel.nil?
      break if current_fuel > lowest_fuel
    end
    if lowest_fuel.nil?
      lowest_fuel = current_fuel
      lowest_position = i
    elsif current_fuel < lowest_fuel
      lowest_fuel = current_fuel
      lowest_position = i
    end
    i += 1
  end
  [lowest_position, lowest_fuel]
end

def fuel_cost(pos1, pos2, fuel_array)
  steps = (pos1 - pos2).abs
  fuel_array[steps]
end

def generate_fuel_array(size)
  array = [0]
  i = 1
  while i <= size
    array << i + array[i - 1]
    i += 1
  end
  array
end



p lowest_fuel(group(numbers))
