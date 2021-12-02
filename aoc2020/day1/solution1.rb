def solution1
  numbers = File.read('input.txt').split.map(&:to_i)
  numbers.each_index do |index| 
    remainder = 2020 - numbers[index]
    if numbers.include?(remainder)
      p "Solution 1: #{remainder * numbers[index]}"
      return
    end
  end
end


def solution2
  numbers = File.read('input.txt').split.map(&:to_i)
  numbers.each_with_index do |number, index| 
    remainder = 2020 - number
    numbers.each_with_index do |new_number, new_index|
      new_remainder = remainder - new_number
      if numbers.include?(new_remainder)
        p "Solution 2: #{new_number * number * new_remainder}"
        return
      end
    end
  end
end

solution1()
solution2()