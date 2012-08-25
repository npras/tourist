require 'set'

module Tourist
  class Graph
    attr_reader :edges

    def initialize
      @edges = {}
    end

    def add(v1, v2, weight = 1)
      edge = [v1, v2]
      @edges[edge] << weight
    rescue NoMethodError
      (@edges[edge] = []) << weight
    end

    def delete(v1, v2)
      edges.delete [v1, v2]
    end

    def get_edge_values(v1, v2)
      edges.fetch([v1, v2])
    rescue KeyError
      raise NoEdgeError, "No edge found between #{v1} and #{v2}!"
    end

    def get_min_edge_value(v1, v2)
      get_edge_values(v1, v2).min
    end

    def vertices
      edges.keys.flatten.uniq.to_set
    end

    def adjacent?(v1, v2)
      edges.keys.include? [v1, v2]
    end

    def neighbors(vertex)
      edges.map { |k, v|
        k[1] if k[0] == vertex
      }.compact.to_set
    end

    def neighbor_with_min_weight(v)
      neighbors(v).min_by { |neighbor| get_edge_values v, neighbor }
    end

  end # class Graph

  class NoEdgeError < StandardError; end
end # module Tourist
