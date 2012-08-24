require 'debugger'
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

    #def dijkstra(source)
      #dist = previous = {}
      #graph.vertices.each do |v| # initializations
        #dist[v] = 1.0/0.0 # infinity
        #previous[v] = 1.0/0.0
      #end
      #dist[source] = 0 # distance to self is zero
      #q = graph.vertices
      #until q.empty? # main loop
        #u = dist.min[0]
        #q.delete u
        #break if dist[u] == 1.0/0.0
        ##graph.neighbors(u).each do |v|
        #for v in graph.neighbors(u)
          #debugger
          #alt = dist[u] + graph.get_edge_values(u, v).first.to_i
          #p "alt", alt
          #p "dist[v]"
          #p dist[v]
          #if alt < dist[v]
            #dist[v] = alt
            #previous[v] = u
            ## missing_step
          #end # if
        #end # for
      #end # until
      #dist
    #end

    def my_dijkstra(source)

    end

  end # class Run
end # module Tourist

if __FILE__ == $0
  p Tourist::Run.new.dijkstra 'A'
end
