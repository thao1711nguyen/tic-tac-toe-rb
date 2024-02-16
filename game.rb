class Player
  attr_accessor :move
  attr_reader :name
  def initialize(name)
    @name = name
    @move = []
  end
end
class Board
  attr_accessor :board
  def initialize(board=(1..9).to_a)
    @board = board
  end
  def display
    @board.each_with_index do |value, index|
      if (index + 1) % 3 == 0
        puts value
      else
        print value.to_s + '   '
      end
    end
  end
  def change_board(player)
    board.each_with_index do |item, index|
      next unless item.to_i.between?(1, 9)
      board[index] = player.name if player.move.include?(item)
    end
  end
end
class Game 
  attr_accessor :count
  attr_reader :player_O, :player_X, :board
  def initialize
    @player_X = Player.new('X')
    @player_O = Player.new('O')
    @board = Board.new
    @count = 1
  end
  def game_over?(winner)
    !winner.nil? || @count == 9
  end
  def play
    winner = nil
    loop do 
      @board.display
      if count.odd? 
        player = @player_X
      else 
        player = @player_O
      end
      get_move(player)
      winner = who_wins?(player) if count > 4
      @board.change_board(player)
      break if game_over?(winner)
      @count += 1
    end
    @board.display
    annouce_result(winner)
  end
  
  
  def get_move(player)
    loop do 
      puts "player #{player.name}, please make your move: "
      move = gets.chomp.to_i 
      if @board.board.any?(move)
        player.move << move
        break 
      end
      puts "Error! Please enter a valid move!"
    end
  end

  def who_wins?(player)
    winner_moves = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9],
      [1, 4, 7], [2, 5, 8], [3, 6, 9],
      [1, 5, 9], [3, 5, 7]
    ]
    winner_moves.each do |winner_move|
      result = winner_move - player.move
      if result.empty?
        return player
      elsif winner_moves.last.eql? winner_move
        return nil
      end
    end
  end
  private
  def annouce_result(winner)
    if winner.nil?
      puts 'You tied!'
    else 
      puts "Congratulation player #{winner.name}! You won!"
    end
  end
end
new_game = Game.new
new_game.play


    

  

  

 

  


