require_relative '../spec_helper'
require_relative '../../lib/tourist/graph_matrix'

describe GraphMatrix do
  before do
    @it = GraphMatrix.new
    @v1, @v2 = :a, :b
    @weight = 12
    @vertices = [@v1, @v2]
  end

  it "has the edges attribute" do
    @it.edges.class.must_equal Hash
  end

  it "initially has zero vertices and zero edges" do
    @it.vertices.count.must_equal 0
    @it.edges.count.must_equal 0
  end

  describe "#set" do
    it "makes an entry for the given two vertices with its weight" do
      ->{ @it.edges.fetch(@vertices) }.must_raise KeyError
      @it.set(@v1, @v2, @weight)
      @it.edges.fetch(@vertices).must_include 12
    end

    it "can set two weights for the same route" do
      @it.set(@v1, @v2, 11)
      @it.set(@v1, @v2, 12)
      @it.edges.fetch(@vertices).must_equal [11, 12.0]
    end
  end # describe #set

  describe "#get" do
    it "gets the weight(s) for the given vertices, if present already" do
      @it.set(@v1, @v2, 100)
      @it.set(@v1, @v2, 1500)
      @it.get(@v1, @v2).must_equal [100, 1500]
    end

    it "fails for vertices with no entry in the matrix" do
      @it.edges.size.must_equal 0
      @it.set(@v1, @v2, @weight)
      @it.edges.size.must_equal 1
      ->{ @it.get(@v1, :c) }.must_raise NoEdgeError
    end
  end # describe #get

  describe "#get_min" do
    it "gets the minimum weight for the given route" do
      @it.set(@v1, @v2, 111)
      @it.set(@v1, @v2, 111.11)
      @it.get_min(@v1, @v2).must_equal 111
    end
  end # describe #get_min

  describe "#vertices" do
    it "gets the unordered list of all vertices in the graph" do
      @it.set(:a, :b, 100)
      @it.set(:c, :d, 200)
      @it.set(:e, :a, 400)
      @it.vertices.must_equal [:a, :c, :b, :d, :e].to_set
    end
  end

  describe "#adjacent?" do
    it "checks if two vertices are adjacent to each other or not" do
      @it.adjacent?(:x, :y).must_equal false
      @it.set(:x, :y, 1)
      @it.adjacent?(:x, :y).must_equal true
      @it.adjacent?(:y, :x).must_equal false
    end
  end

  describe "#neighbors" do
    it "returns all the neighbors of a given vertex" do
      @it.set(:a, :b, 100)
      @it.set(:c, :d, 200)
      @it.set(:e, :a, 400)
      @it.set(:a, :z, 900)
      @it.set(:z, :a, 980)
      @it.set(:z, :c, 880)
      @it.neighbors(:a).must_equal [:b, :z].to_set
      @it.neighbors(:z).must_equal [:c, :a].to_set
    end
  end

end # describe GraphMatrix
