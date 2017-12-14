require 'rspec'
require 'tdd'

describe Array do
  subject(:first_array) { Array.new }

  describe "#uniq" do
    it "returns same array with elements are unique" do
      first_array = [5,4,2]
      expect(first_array.my_uniq).to eq(first_array)
    end

    it "returns unique elements" do
      first_array = [5,5,5,2,4,4]
      expect(first_array.my_uniq).to eq([5,2,4])
    end

    it "does not call uniq method" do
      first_array = [5,4,2,1]
      expect(first_array).not_to receive(:uniq)
      first_array.my_uniq
    end
  end


  describe "#two_sum" do
    it "does not add an element to itself" do
      first_array = [0,1,2,4,-1,-2]
      expect(first_array.two_sum).to eq([[1,4],[2,5]])
    end
  end


end

  describe "#my_transpose" do
    subject(:an_array) { [[1, 2, 3 ],[4, 5, 6], [7, 8, 9]]}
    let(:result_array) { [[1, 4, 7], [2, 5, 8], [3, 6, 9]] }
    it "returns an array of the same length" do
      expect(my_transpose(an_array)).to eq(result_array)
    end
  end
