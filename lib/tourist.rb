require_relative "tourist/graph"
require 'debugger'
require 'pry'
require 'time'

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
        journey_hrs = get_journey_hrs(departure, arrival)
        #graph.add from, to, price
        graph.add from, to, journey_hrs
      end
    end

    def get_journey_hrs(departure, arrival)
      ( Time.parse(arrival) - Time.parse(departure) ) / ( 60 * 60 )
    end

    def dijkstra(source, destination)
      dist, prev = {}, {}
      vertices = graph.vertices
      vertices.each do |v|
        dist[v] = 1.0/0.0 
      end
      dist[source] = 0
      q = vertices

      while q.include? destination
        u = q.min_by { |v| dist[v] }
        q.delete u
        break if ( u == destination ) or ( dist[u] == 1.0/0.0 )

        graph.neighbors(u).each do |neighbor|
          alt = dist[u] + graph.get_min_edge_value(u, neighbor)
          if alt < dist[neighbor]
            dist[neighbor] = alt
            prev[neighbor] = u
          end
        end

      end # while

      path = []
      u = destination
      while prev[u]
        path.unshift u
        u = prev[u]
      end
      path.unshift source

      [ dist[destination], path.join(' -> ') ]
    end

  end # class Run
end # module Tourist

if __FILE__ == $0
  puts Tourist::Run.new.dijkstra 'A', 'Z'
end
