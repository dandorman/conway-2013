require "rspec"

class LivingCell
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def next
    (2..3).include?(board.neighbors(self)) ? LivingCell.new(board) : DeadCell.new(board)
  end

  def alive?
    true
  end
end

class DeadCell
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def next
    board.neighbors(self) == 3 ? LivingCell.new(board) : DeadCell.new(board)
  end

  def alive?
    false
  end
end

describe LivingCell do
  let(:board) { double(:board) }

  describe "#alive?" do
    it "is true" do
      expect(LivingCell.new(board)).to be_alive
    end
  end

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
        board.stub(neighbors: 1)
        expect(cell.next).to be_a DeadCell
      end
    end

    context "with 2 neighbors" do
      it "returns a living cell" do
        cell = LivingCell.new(board)
        board.stub(neighbors: 2)
        expect(cell.next).to be_a LivingCell
      end
    end

    context "with 3 neighbors" do
      it "returns a living cell" do
        cell = LivingCell.new(board)
        board.stub(neighbors: 3)
        expect(cell.next).to be_a LivingCell
      end
    end

    (4..8).each do |n|
      context "with #{n} neighbors" do
        it "returns a living cell" do
          cell = LivingCell.new(board)
          board.stub(neighbors: n)
          expect(cell.next).to be_a DeadCell
        end
      end
    end
  end
end

describe DeadCell do
  let(:board) { double(:board) }

  describe "#alive?" do
    it "is false" do
      expect(DeadCell.new(board)).to_not be_alive
    end
  end

  describe "#next" do
    context "with 0 neighbors" do
      it "returns a dead cell" do
        cell = DeadCell.new(board)
        board.stub(neighbors: 0)
        expect(cell.next).to be_a DeadCell
      end
    end

    context "with 1 neighbors" do
      it "returns a dead cell" do
        cell = DeadCell.new(board)
        board.stub(neighbors: 0)
        expect(cell.next).to be_a DeadCell
      end
    end

    context "with 3 neighbors" do
      it "returns a living cell" do
        cell = DeadCell.new(board)
        board.stub(neighbors: 3)
        expect(cell.next).to be_a LivingCell
      end
    end

    [4..8].each do |n|
      context "with #{n} neighbors" do
        it "returns a living cell" do
          cell = DeadCell.new(board)
          board.stub(neighbors: n)
          expect(cell.next).to be_a DeadCell
        end
      end
    end
  end
end
