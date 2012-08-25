require 'debugger'
require 'pry'
require_relative "tourist/graph"

module Tourist
  class Run
    InputFile = 'data/ip.txt'

    attr_reader :graph

    def initialize
      @graph = Tourist::Graph.new
      graphify
    end

    def graphify
      File.foreach(InputFile) do |line|
        from, to, departure, arrival, price = *line.split
        graph.add from, to, price
      end
    end

    def dijkstra(source, destination)
      dist = {}
      vertices = graph.vertices
      vertices.each { |v| dist[v] = 1.0/0.0 }
      dist[source] = 0
      q = vertices

      while q.include? destination
        u = q.min_by { |v| dist[v] }
        q.delete u
        break if ( u == destination ) or ( dist[u] == 1.0/0.0 )

        graph.neighbors(u).each do |neighbor|
          next unless q.include? neighbor
          alt = dist[u] + graph.get_edge_values(u, neighbor).first.to_f
          if alt < dist[neighbor]
            dist[neighbor] = alt
          end
        end

      end # while

      dist[destination]
    end

  end # class Run
end # module Tourist

if __FILE__ == $0
  p Tourist::Run.new.dijkstra 'A', 'Z'
end
