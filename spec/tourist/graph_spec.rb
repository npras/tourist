require_relative '../spec_helper'
require_relative '../../lib/tourist/graph'

describe Tourist::Graph do
  before do
    @it = Tourist::Graph.new
    @v1, @v2 = :a, :b
    @weight = 12
    @edge = [@v1, @v2]
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
      ->{ @it.edges.fetch(@edge) }.must_raise KeyError
      @it.add(@v1, @v2, @weight)
      @it.edges.fetch(@edge).must_include 12
    end

    it "can set two weights for the same route" do
      @it.add(@v1, @v2, 11)
      @it.add(@v1, @v2, 12)
      @it.edges.fetch(@edge).must_equal [11, 12.0]
    end

    it "can create an edge wih default weight" do
      @it.add(:xx, :yy)
      @it.get_edge_values(:xx, :yy).must_equal [1]
    end
  end # describe #add

  describe "#delete" do
    it "removes any existing edge between the given two vertices" do
      @it.add(@v1, @v2)
      @it.add(@v1, @v2, 234)
      @it.edges.fetch([@v1, @v2]).must_equal [1, 234]
      @it.delete(@v1, @v2)
      ->{ @it.edges.fetch([@v1, @v2]) }.must_raise KeyError
    end
  end

  describe "#get_edge_values" do
    it "gets the weight(s) for the given vertices, if present already" do
      @it.add(@v1, @v2, 100)
      @it.add(@v1, @v2, 1500)
      @it.get_edge_values(@v1, @v2).must_equal [100, 1500]
    end

    it "fails for vertices with no entry in the matrix" do
      @it.edges.size.must_equal 0
      @it.add(@v1, @v2, @weight)
      @it.edges.size.must_equal 1
      ->{ @it.get_edge_values(@v1, :c) }.must_raise Tourist::NoEdgeError
    end
  end # describe #get_edge_values


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

  describe "#neighbor_with_min_weight" do
    it "returns the neighbor with the minimum weight" do
      @it.add(:a, :b, 100)
      @it.add(:c, :d, 200)
      @it.add(:e, :a, 400)
      @it.add(:a, :z, 900)
      @it.add(:z, :a, 980)
      @it.add(:z, :c, 880)
      stub(@it).neighbors(:a) { [:b, :z] }
      @it.neighbor_with_min_weight(:a).must_equal :b
      stub(@it).neighbors(:z) { [:a, :c] }
      @it.neighbor_with_min_weight(:z).must_equal :c
    end
  end
end # describe Graph
