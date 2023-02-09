# display the board: a function accept an array
# return the board
# function game
# initialize a count variable that count the move and equal to 0
# WHILE count is less than or equal to 9
# increment count by 1
# IF count is an odd
# then the player is X
# replace the number that player X chooses with X
# display the board
# ELSE
# then the player is O
# same like above
# IF count is bigger or equal to 5
# check the winner
# IF we have the winner
# break out of loop
# return the winner
# function: check winner? that takes PLAYER_MOVE (a hash ) as an argument
# initialize a winner_move 2D array consisting winning combinations (8)
# initialize a move array that equals the value (an array) of PLAYER_MOVE
# FOR EACH array of winner_move
# subtract it with move
# IF the resulted array is empty
# return the winner (the key of PLAYER_MOVE)
# ELSE
# return empty string stands for no

# win: 3 on a line
# after 3 move of the first player, check winner
# tie: no winner && no move to make

def display_board(board)
  board.each_with_index do |value, index|
    if (index + 1) % 3 == 0
      puts value
    else
      print value.to_s + '   '
    end
  end
end

def game
  count = 0
  board = (1..9).to_a
  player_move = { 'X' => [],
                  'O' => [] }
  while count <= 9
    display_board(board)
    count += 1
    name = if count.odd?
             'X'
           else
             'O'
           end
    move = instruct(name)
    player_move[name].push(move)
    board = change_board(board, name, move)
    if count >= 5
      result = check_winner(player_move, name)
      if count == 9 && result.empty?
        return 'You tie!'
      elsif !result.empty?
        display_board(board)
        return result
      end
    end
  end
end

def instruct(name)
  puts "player #{name}, please make your move: "
  move = gets.chomp.to_i
  
end

def change_board(board, name, move)
  board.each do |item|
    board[move - 1] = name if item == move
  end
  board # check if board is removed, can this function return board?
end

def check_winner(player_move, player)
  winner_move = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]
  move = player_move[player]
  winner_move.each do |item|
    result = item - move
    if result.empty? 
      return "Congratulation, player #{player}! You win!" 
    else 
      return ''
    end
  end
end

puts game
