require "rspec"

class Cell
  def alive?
    true
  end
end

describe Cell do
  it "can be alive" do
    cell = Cell.new
    expect(cell).to be_alive
  end
end
