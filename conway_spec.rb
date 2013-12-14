require "rspec"

class LivingCell
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def next
    board.neighbors > 1 ? LivingCell.new(board) : DeadCell.new(board)
  end
end

class DeadCell
  def initialize(board)
    @board = board
  end
end

describe LivingCell do
  let(:board) { double(:board) }

  describe "#next" do
    context "with 0 neighbors" do
      it "returns a dead cell" do
        cell = LivingCell.new(board)
        board.stub(neighbors: 0)
        expect(cell.next).to be_a DeadCell
      end
    end

    context "with 1 neighbors" do
      it "returns a dead cell" do
        cell = LivingCell.new(board)
        board.stub(neighbors: 2)
        expect(cell.next).to be_a LivingCell
      end
    end
  end
end
