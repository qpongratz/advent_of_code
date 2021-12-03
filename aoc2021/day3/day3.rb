# frozen_string_literal: true

input = File.open('input').read.split("\n")

length = input[0].length
gamma_rate = String.new
epsilon_rate = String.new
count = 0
length.times do
  one_count = 0
  zero_count = 0
  input.each do |binary_number|
    if binary_number[count] == '1'
      one_count += 1
    else
      zero_count += 1
    end
  end
  if one_count >= zero_count
    gamma_rate << '1'
    epsilon_rate << '0'
  else
    gamma_rate << '0'
    epsilon_rate << '1'
  end
  count += 1
end

def most_occuring(list, position)
  one_count = 0
  zero_count = 0
  list.each do |number|
    if number[position] == '1'
      one_count += 1
    else
      zero_count += 1
    end
  end
  one_count >= zero_count ? '1' : '0'
end

def least_occuring(list, position)
  one_count = 0
  zero_count = 0
  list.each do |number|
    if number[position] == '1'
      one_count += 1
    else
      zero_count += 1
    end
  end
  zero_count <= one_count ? '0' : '1'
end

def decimate(binary)
  digits = binary.digits
  decimal = 0
  i = 0
  while i < digits.length
    decimal += digits[i] * (2**i)
    i += 1
  end
  decimal
end

power_consumption = decimate(gamma_rate.to_i) * decimate(epsilon_rate.to_i)

puts "Gamma rate: #{gamma_rate}, Epsilon Rate: #{epsilon_rate}. Power Consumption: #{power_consumption}"

def commonator(position, list, most)
  return list[0] if list.length == 1

  key = generate_key(position, list, most)
  reduced_list = list.select { |element| element[position] == key }
  commonator(position + 1, reduced_list, most)
end

def generate_key(position, list, most)
  most ? most_occuring(list, position) : least_occuring(list, position)
end

oxygen_rate = commonator(0, input, true)
carbon_dioxyide_rate = commonator(0, input, false)
life_support_rate = decimate(oxygen_rate.to_i) * decimate(carbon_dioxyide_rate.to_i)

puts "Oxygen rate: #{oxygen_rate}, CO2 Rate: #{carbon_dioxyide_rate}. Life Support Rating: #{life_support_rate}"
