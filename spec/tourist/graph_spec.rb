require_relative '../spec_helper'
require_relative '../../lib/tourist/graph'

describe Graph do
  before do
    @it = Graph.new
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

  describe "#add" do
    it "makes an entry for the given two vertices with its weight" do
      ->{ @it.edges.fetch(@vertices) }.must_raise KeyError
      @it.add(@v1, @v2, @weight)
      @it.edges.fetch(@vertices).must_include 12
    end

    it "can set two weights for the same route" do
      @it.add(@v1, @v2, 11)
      @it.add(@v1, @v2, 12)
      @it.edges.fetch(@vertices).must_equal [11, 12.0]
    end

    it "can create an edge wih default weight" do
      @it.add(:xx, :yy)
      @it.get(:xx, :yy).must_equal [1]
    end
  end # describe #add

  describe "#get" do
    it "gets the weight(s) for the given vertices, if present already" do
      @it.add(@v1, @v2, 100)
      @it.add(@v1, @v2, 1500)
      @it.get(@v1, @v2).must_equal [100, 1500]
    end

    it "fails for vertices with no entry in the matrix" do
      @it.edges.size.must_equal 0
      @it.add(@v1, @v2, @weight)
      @it.edges.size.must_equal 1
      ->{ @it.get(@v1, :c) }.must_raise NoEdgeError
    end
  end # describe #get

  describe "#get_min" do
    it "gets the minimum weight for the given route" do
      @it.add(@v1, @v2, 111)
      @it.add(@v1, @v2, 111.11)
      @it.get_min(@v1, @v2).must_equal 111
    end
  end # describe #get_min

  describe "#vertices" do
    it "gets the unordered list of all vertices in the graph" do
      @it.add(:a, :b, 100)
      @it.add(:c, :d, 200)
      @it.add(:e, :a, 400)
      @it.vertices.must_equal [:a, :c, :b, :d, :e].to_set
    end
  end

  describe "#adjacent?" do
    it "checks if two vertices are adjacent to each other or not" do
      @it.adjacent?(:x, :y).must_equal false
      @it.add(:x, :y, 1)
      @it.adjacent?(:x, :y).must_equal true
      @it.adjacent?(:y, :x).must_equal false
    end
  end

  describe "#neighbors" do
    it "returns all the neighbors of a given vertex" do
      @it.add(:a, :b, 100)
      @it.add(:c, :d, 200)
      @it.add(:e, :a, 400)
      @it.add(:a, :z, 900)
      @it.add(:z, :a, 980)
      @it.add(:z, :c, 880)
      @it.neighbors(:a).must_equal [:b, :z].to_set
      @it.neighbors(:z).must_equal [:c, :a].to_set
    end
  end

end # describe Graph
