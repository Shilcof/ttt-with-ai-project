require "pry"

module Players 
    class Computer < Player

        def move(board)
            puts "Computer is thinking"
            best_move = nil
            if board.cells.all?{|square| square == " "}
                1
            elsif self.token == "X"
                minimax(board, 10, true)[0]
            else
                minimax(board, 10, false)[0]
            end.to_s
        end

        def minimax(board, depth, maximizing)

            result = winner(board)
            result ||= tie(board)

            if result == "X" 
                [nil, 1 + depth]
            elsif result == "O"
                [nil, -1 - depth]
            elsif result == "tie"
                [nil, 0]               
            elsif maximizing 
                max_score = [nil, -1/0.0]
                empty_spaces(board).each do |square|
                    board.update_token(square, "X")             
                    score = minimax(board, depth - 1, false)    
                    board.remove(square)
                    max_score = [square, score[1]] if max_score[1] < score[1]
                end
                max_score
            else
                min_score = [nil, 1/0.0]
                empty_spaces(board).each do |square|
                    board.update_token(square, "O")             
                    score = minimax(board, depth - 1, true)
                    board.remove(square)
                    min_score = [square, score[1]] if min_score[1] > score[1]
                end
                min_score
            end
        end

        # ----------------- Helpers ------------------

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

        def empty_spaces(board)
            board.cells.collect.with_index{|square, i| square == " " ? i + 1 : nil}.compact
        end

        def winner(board)
            ["X","O"].detect do |token| 
                WIN_COMBINATIONS.any? { |combination| combination.all? { |cell| board.cells[cell] == token } }
            end
        end

        def tie(board)
            board.cells.select{|square| square == "X" || square == "O"}.size == 9 ? "tie" : nil
        end

    end
end