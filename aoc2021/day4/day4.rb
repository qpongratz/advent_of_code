# frozen_string_literal: true

def setup_boards(input)
  i = 1
  boards = []
  while i < input.length
    board = input[i].split("\n")
    formatted_board = board.map { |row| row.split.map(&:to_i) }
    boards << formatted_board.flatten
    i += 1
  end
  boards
end

def call_number(number, boards)
  boards.each do |board|
    position = board.index(number)
    board[position] = -1 unless position.nil?
  end
end

def check_winners(boards)
  boards.each do |board|
    return board if check_horizontals(board) || check_verticals(board)
  end
  nil
end

def check_horizontals(board)
  i = 0
  while i < 25
    return true if board[i, 5].all? { |element| element == -1 }

    i += 5
  end
  false
end

def check_verticals(board)
  i = 0
  while i < 5
    vertical = build_vertical(board, i)
    return true if vertical.all? { |element| element == -1 }

    i += 1
  end
  false
end

def build_vertical(board, num)
  vertical = []
  while num < 25
    vertical << board[num]
    num += 5
  end
  vertical
end

def play_game(boards, numbers, int)
  while int < numbers.length
    call_number(numbers[i], boards)
    winning_board = check_winners(boards)
    return calculate_board_score(winning_board) * numbers[i] unless winning_board.nil?

    int += 1
  end
end

def lose_game(boards, numbers)
  i = 0
  while i < numbers.length
    call_number(numbers[i], boards)
    eliminate_winners(boards)
    return play_game(boards, numbers, i) if boards.length == 1

    i += 1
  end
end

def eliminate_winners(boards)
  winning_board = check_winners(boards)
  until winning_board.nil?
    boards.delete(winning_board)
    winning_board = check_winners(boards)
  end
end

def calculate_board_score(board)
  board.reject(&:negative?).sum
end

def setup_numbers(input)
  input[0].split(',').map(&:to_i)
end

input = File.open('input').read.split("\n\n")
numbers = setup_numbers(input)
boards = setup_boards(input)
# Part one
p play_game(boards, numbers, 0)
# Part two
p lose_game(boards, numbers)
