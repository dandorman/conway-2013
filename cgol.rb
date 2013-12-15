require_relative './board_spec'
require_relative './conway_spec'

require "rspec"

describe "Conway's Game of Life" do
    it "should support the block still-life" do
        block_still_life = [
            [1,1], [1,2], [2,1], [2,2]
        ]
        board = Board.new
        board.seed block_still_life
        board2 = board.next
        block_still_life.each do |cell|
            expect(board2.cell(cell[0], cell[1]).alive?).to be_equal true
        end
        expect(board2.population).to be_equal 4
    end

    it "should support the blinker oscillator" do
        blinker_horizontal = [
            [1,1], [1,2], [1,3]
        ]
        blinker_vertical = [
            [0,2], [1,2], [2,2]
        ]
        board = Board.new
        board.seed blinker_horizontal
        board2 = board.next
        blinker_vertical.each do |cell|
            expect(board2.cell(cell[0], cell[1]).alive?).to be_equal true
        end
        expect(board2.population).to be_equal 3
    end
end
