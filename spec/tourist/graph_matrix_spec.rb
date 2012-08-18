require_relative '../spec_helper'
require_relative '../../lib/tourist/graph_matrix'

describe GraphMatrix do
  before do
    @it = GraphMatrix.new
    @v1, @v2 = :a, :b
    @weight = 12
    @vertices = [@v1, @v2]
  end

  it "has the matrix attribute" do
    @it.matrix.class.must_equal Hash
  end

  describe "#set" do
    it "makes an entry for the given two vertices with its weight" do
      ->{ @it.matrix.fetch(@vertices) }.must_raise KeyError
      @it.set(@v1, @v2, @weight)
      @it.matrix.fetch(@vertices).must_equal 12
    end
  end # describe #set

  describe "#get" do
    it "gets the weight for the given vertices, if present already" do
      @it.set(@v1, @v2, @weight)
      @it.get(@v1, @v2).must_equal @weight
    end

    it "fails for vertices with no entry in the matrix" do
      @it.matrix.size.must_equal 0
      @it.set(@v1, @v2, @weight)
      @it.matrix.size.must_equal 1
      ->{ @it.get(@v1, :c) }.must_raise NoRouteError
    end
  end # describe #get
end # describe GraphMatrix
