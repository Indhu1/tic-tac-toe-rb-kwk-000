# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |space|
      space == "X" || space == "O" ? count+=1 : count+=0
  end
  return count
end

def current_player(board)
  player=""
  turn_count(board) % 2==0 ? player = "X": player = "O"
  return player
end

def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     #puts win_combination
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]

     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
     end
     if position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
     end
   end
   return false
end

def full?(board)
  value= true
  board.each do |positions|
    if positions == " " || positions == nil
      return false
    end
  end
  value
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if over?(board) && !draw?(board)
    return board[won?(board)[1]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board).class == Array
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
