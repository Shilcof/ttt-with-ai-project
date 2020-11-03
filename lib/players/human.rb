module Players 
    class Human < Player

        def move(board)
            puts "Player #{self.token}, please enter an available square"
            gets.strip
        end

    end
end