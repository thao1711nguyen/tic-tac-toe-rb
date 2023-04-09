require_relative "../game.rb"

describe Game do 

    describe '#initialize' do 
        subject(:new_game) { described_class.new }
        matcher :be_an_instance_of_Player do 
            match {|obj| obj.is_a?(Player) }
        end
        it "has one player X" do 
            expect(new_game.player_X).to be_an_instance_of_Player
        end
        it "has one player O" do 
            expect(new_game.player_O).to be_an_instance_of_Player
        end
        it "has one board" do 
            expect(new_game.board).to be_an_instance_of Board
        end
        it "count is equal to 1" do 
            expect(new_game.count).to eq(1)
        end
    end
    describe "#game_over?" do 
        subject(:game_end) { described_class.new }
        context "when there is a winner and count is less than 9" do 
            it 'returns true' do 
                game_end.instance_variable_set(:@count, 3)
                winner = 'X'
                expect(game_end.game_over?(winner)).to eq(true)
            end
        end
        context "when count is equal to 9 and there is no winner" do 
            it 'returns true' do 
                game_end.instance_variable_set(:@count, 9)
                winner = nil
                expect(game_end.game_over?(winner)).to eq(true)
            end
        end
        context "when there is no winner and count is less than 9" do 
            it "returns false" do 
                game_end.instance_variable_set(:@count, 3)
                winner = nil
                expect(game_end.game_over?(winner)).to eq(false)
            end
        end
    end
    describe "get_move" do 
        subject(:game_move) { described_class.new }
        let(:player_move) { instance_double(Player, name: 'X', move: []) }
        let(:board_move) { instance_double(Board, board: (1..9).to_a) }
        context "when user inputs a correct value at the beginning" do 
            before do 
                valid_input = '3'
                allow(game_move).to receive(:gets).and_return(valid_input)
                
            end
            it "completes loop and do not display error message" do
                error_message = "Error! Please enter a valid move!"
                expect(game_move).not_to receive(:puts).with(error_message)
                game_move.get_move(player_move)
            end
            it "add move to the player's move array" do 
                expect(player_move).to receive(:move).once
                game_move.get_move(player_move)
            end
        end
        context "when user inputs an incorrect value once, and then a valid input" do
            before do 
                valid_input = '3'
                invalid_input = 'a'
                error_message = "Error! Please enter a valid move!"
                allow(game_move).to receive(:gets).and_return(invalid_input, valid_input)
                allow(game_move).to receive(:puts).with("player #{player_move.name}, please make your move: ")
                allow(game_move).to receive(:puts).with("Error! Please enter a valid move!")
            end
            it  "completes loop and display error message once" do 
                error_message = "Error! Please enter a valid move!"
                expect(game_move).to receive(:puts).with(error_message).once
                game_move.get_move(player_move)
            end 
            it "add move to the player's move array 1 time" do 
                expect(player_move).to receive(:move).exactly(1).time
                game_move.get_move(player_move)
            end
        end
    end
    describe "who_wins?" do 
        subject(:game_win) { described_class.new }
        let(:winner) { instance_double(Player, name: 'X') }
        context "when there is a winner" do 
            before do 
                winner_move = [1,2,3]
                allow(winner).to receive(:move).and_return(winner_move)
            end
            it "returns winner's name" do 
                expect(game_win.who_wins?(winner)).to eq(winner.name)
            end
        end
        context "when there is no winner" do 
            before do 
                loser_move = [1,6,9]
                allow(winner).to receive(:move).and_return(loser_move)
            end
            it "returns nil" do 
                expect(game_win.who_wins?(winner)).to be_nil
            end
        end
    end 
end
