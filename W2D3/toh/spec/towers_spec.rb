require "rspec"
require "towers"

describe Towers do

  let (:tower1) { [[2], [1], [3]] }
  subject(:game) { Towers.new(tower1) }



  describe ("#move") do
    it "moves discs from position A to B" do
      game.move(1, 0)
      expect(tower1).to eq([[2,1], [], [3]])
    end

    it "raises error if moving bigger disc onto smaller" do
      expect{ game.move(0, 1) }.to raise_error('Invalid Move')
    end
  end

  describe ("#won?") do
    it "checks if the winning configuration exists" do
      tower1 = [[3,2,1],[],[]]
      expect(Towers.new(tower1).won?).to be true
    end

  end

end
