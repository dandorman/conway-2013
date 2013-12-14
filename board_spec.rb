require "rspec"

class Board
  def initialize(cells)
    @cells = cells
  end

  def cell(x, y)
    @cells[[x, y]]
  end

  def neighbors(cell)
    (x, y), _ = @cells.rassoc(cell)
    count = 0
    ((x - 1)..(x + 1)).each do |_x|
      ((y - 1)..(y + 1)).each do |_y|
        next if _x == x && _y == y
        cell = @cells[[_x, _y]]
        count += 1 if cell && cell.alive?
      end
    end
    count
  end

  def next
    new_cells = {}
    @cells.each do |coords, cell|
      new_cells[coords] = cell.next
    end
    Board.new(new_cells)
  end
end

describe Board do
  it "takes a hash of cells as seed data" do
    board = Board.new({[0,0] => :cell})
    expect(board.cell(0, 0)).to eq :cell
  end

  describe "#neighbors" do
    it "returns neighbor count" do
      cell = double(:cell, alive?: true)
      board = Board.new({[0,0] => cell})
      expect(board.neighbors(cell)).to be_zero
    end

    it "returns neighbor count" do
      cell = double(:cell, alive?: true)
      another_cell = double(:another_cell, alive?: true)
      board = Board.new({[0,0] => cell, [0, 1] => cell})
      expect(board.neighbors(cell)).to eq 1
    end
  end

  describe "#next" do
    it "returns a new board" do
      board = Board.new({})
      expect(board.next).to be_a Board
    end

    it "asks its cells for their next cell" do
      cell = double(:cell, next: (next_c = double(:next_cell)))
      board = Board.new({[0,0] => cell})
      expect(board.next.cell(0, 0)).to be next_c
    end
  end
end
