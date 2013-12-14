require "rspec"

class LivingCell
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def next
    DeadCell.new
  end
end

class DeadCell
end

describe LivingCell do
  let(:board) { double(:board) }

  describe "#next" do
    context "with 0 neighbors" do
      it "returns a dead cell" do
        cell = LivingCell.new(board)
        expect(cell.next).to be_a DeadCell
      end
    end

    context "with 1 neighbors" do
      it "returns a dead cell" do
        cell = LivingCell.new(board)
        expect(cell.next).to be_a DeadCell
      end
    end
  end
end
