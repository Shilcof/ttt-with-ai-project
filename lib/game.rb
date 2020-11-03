require_relative "../config/environment"
require "pry"

class Game

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    attr_accessor :board, :player_1, :player_2

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        self.player_1 = player_1
        self.player_2 = player_2
        self.board = board
    end

    def current_player
        board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.detect do |combination| 
            ["X","O"].any? { |token| combination.all? { |cell| board.cells[cell] == token } }
        end
    end

    def draw?
        board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        ["X","O"].detect do |token| 
            WIN_COMBINATIONS.any? { |combination| combination.all? { |cell| board.cells[cell] == token } }
        end
    end

    def play
        board.display
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

    def turn
        input = current_player.move(board) 
        turn unless board.valid_move?(input)
        board.update(input, current_player)
        board.display
    end

end