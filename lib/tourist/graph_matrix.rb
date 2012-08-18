class GraphMatrix
  attr_accessor :matrix
  
  def initialize
    @matrix = {}
  end

  def set(v1, v2, weight)
    vertices = [v1, v2]
    @matrix[vertices] = weight
  end

  def get(v1, v2)
    matrix.fetch [v1, v2]
  rescue KeyError
    raise NoRouteError, "No route found between #{v1} and #{v2}!"
  end

end # class GraphMatrix

class NoRouteError < StandardError; end
