require 'set'

class GraphMatrix
  attr_reader :matrix
  
  def initialize
    @matrix = {}
  end

  def set(v1, v2, weight)
    vertices = [v1, v2]
    @matrix[vertices] << weight
  rescue NoMethodError
    # initializing the key to an array for the first entry
    (@matrix[vertices] = []) << weight
  end

  def get(v1, v2)
    matrix.fetch [v1, v2]
  rescue KeyError
    raise NoRouteError, "No route found between #{v1} and #{v2}!"
  end

  def get_min(v1, v2)
    get(v1, v2).min
  end

  def vertices
    @matrix.keys.flatten.uniq.to_set
  end

  def adjacent?(v1, v2)
    @matrix.keys.include? [v1, v2]
  end

end # class GraphMatrix

class NoRouteError < StandardError; end
