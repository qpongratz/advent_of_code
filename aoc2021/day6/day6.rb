# frozen_string_literal: true

input = File.open('input').read.split(',')
numbers = input.map(&:to_i)

def group(numbers)
  group = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  numbers.each { |number| group[number] +=1 }
  group
end

def simulate(start_day, end_day, state)
  return state if start_day == end_day

  spawn = state.shift
  state[6] += spawn
  state << spawn
  simulate(start_day + 1, end_day, state)
end

starting_state = group(numbers)
end_state = simulate(0, 256, starting_state)
p end_state
p end_state.sum