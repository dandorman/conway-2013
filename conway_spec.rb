require "rspec"

class LivingCell
  def next
    DeadCell.new
  end
end

class DeadCell
end

describe LivingCell do
  describe "#next" do
    context "with 0 neighbors" do
      it "returns a dead cell" do
        cell = LivingCell.new
        expect(cell.next).to be_a DeadCell
      end
    end
  end
end
